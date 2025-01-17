package edu.mcw.scge.service.es.clinicalTrials;

import edu.mcw.scge.services.ESClient;
import edu.mcw.scge.services.SCGEContext;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.index.query.*;
import org.elasticsearch.search.aggregations.AggregationBuilder;
import org.elasticsearch.search.aggregations.AggregationBuilders;
import org.elasticsearch.search.aggregations.BucketOrder;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.elasticsearch.search.sort.SortOrder;
import org.springframework.util.StringUtils;

import java.io.IOException;
import java.util.*;

public class ClinicalTrialsService {

    public static List<String> aggregationFields= Arrays.asList("status","indication", "sponsor"
            ,"sponsorClass", "therapyType", "vectorType",
            "deliverySystem","routeOfAdministration","drugProductType","editorType",
            "targetGeneOrVariant", "mechanismOfAction", "targetTissueOrCell", "phases","standardAges", "therapyRoute","locations"
    );
    public static Map<String, String> fieldDisplayNames= new HashMap<>();
    static{
            for(String field:aggregationFields) {
                String dispalyName=String.join(" ", field.split("(?<!(^|[A-Z]))(?=[A-Z])|(?<!^)(?=[A-Z][a-z])"));
                fieldDisplayNames.put(field, StringUtils.capitalize(dispalyName));
            }

    }
    public static Map<String, String> facetDefinitions= new HashMap<>();
    static{
        facetDefinitions.put("status", "Indicates the current recruitment status or the expanded access status");
        facetDefinitions.put("indication", "The disease, disorder, syndrome, illness, or injury that is being studied");
        facetDefinitions.put("sponsor", "The organization or person who initiates the study and who has authority and control over the study");
        facetDefinitions.put("sponsorClass","Describes the organization that provides support for the clinical study");
        facetDefinitions.put("therapyType", "Describes the nature of the gene therapy");
        facetDefinitions.put("vectorType","Gives additional specifics (if known) about delivery system (e.g. AAV serotype)");
        facetDefinitions.put("deliverySystem","Describes the nature of the drug substance or process that is used to deliver the editor or corrected gene");
        facetDefinitions.put("routeOfAdministration","How the drug product is introduced to the body");
        facetDefinitions.put("drugProductType","Describes the nature of the drug product");
        facetDefinitions.put("editorType","For gene editing type therapies, the protein that will perform the gene correction");
        facetDefinitions.put("targetGeneOrVariant","The symbol of the gene that is corrected or replaced by the drug compound");
        facetDefinitions.put("mechanismOfAction","Simplified description of how the drug product works");
        facetDefinitions.put("targetTissueOrCell", "Lists target cells if the therapy is directed at a particular cell type (either by ex-vivo enrichment, or tissue-specific regulatory elements)");
        facetDefinitions.put("phases","The stage of the clinical trial, determined based on the studies' objective");
        facetDefinitions.put("standardAges", "Variable on whether trial accepts patients who are adults, pediatric (<18 years of age) or both");
        facetDefinitions.put("therapyRoute","Describes whether the gene therapy is introduced to cells in-vivo or ex-vivo");
        facetDefinitions.put("locations","List of countries that contain at least 1 clinical trial site");

    }

    public SearchResponse getSearchResults(String searchTerm,String category, Map<String, List<String>> filtersMap) throws IOException {
        String searchIndex= SCGEContext.getESIndexName();
        SearchSourceBuilder srb=new SearchSourceBuilder();
        srb.query(this.buildBoolQuery(searchTerm, category));
        for(String fieldName:ClinicalTrialsService.aggregationFields) {
            srb.aggregation(buildAggregations(fieldName));
        }
        srb.size(10000);
        try {
            srb.sort("sponsor.keyword", SortOrder.ASC);
        }catch (Exception e){
            e.printStackTrace();
        }
        if(filtersMap!=null && filtersMap.size()>0)
            srb.postFilter(filter(filtersMap));

        SearchRequest searchRequest=new SearchRequest(searchIndex);
        searchRequest.source(srb);

        SearchResponse sr= ESClient.getClient().search(searchRequest, RequestOptions.DEFAULT);
        return sr;

    }
    public BoolQueryBuilder filter(Map<String, List<String>> filters){
        BoolQueryBuilder q=new BoolQueryBuilder();
        DisMaxQueryBuilder dqb=new DisMaxQueryBuilder();
        for(String filter:filters.keySet()) {
            List<String> filterValues=filters.get(filter);
            dqb.add(QueryBuilders.termsQuery(filter + ".keyword", filterValues.toArray()));
        }
        q.must(dqb);
        return q;
    }
    public BoolQueryBuilder buildBoolQuery( String searchTerm, String category){
        BoolQueryBuilder q=new BoolQueryBuilder();
        q.must(buildQuery(searchTerm));
        if(category!=null && !category.equals("")){
            q.filter(QueryBuilders.termQuery("category.keyword", category));
        }
        return q;
    }

    public AggregationBuilder buildAggregations(String fieldName){
        AggregationBuilder builder = null;
        builder= AggregationBuilders.terms(fieldName).field(fieldName + ".keyword").size(1000).order(BucketOrder.key(true));
         return builder;
    }

    public QueryBuilder buildQuery(String term){
        DisMaxQueryBuilder q=new DisMaxQueryBuilder();


        if(term!=null && !term.equals("")) {
            String searchTerm=term.toLowerCase().trim();
            if(searchTerm.toLowerCase().contains(" and ")){
                String searchString=String.join(" ", searchTerm.toLowerCase().split(" and "));
                q.add(QueryBuilders.multiMatchQuery(searchString)
                        .type(MultiMatchQueryBuilder.Type.CROSS_FIELDS)
                        .operator(Operator.AND)
                        .analyzer("stop")

                );

                q.add(QueryBuilders.multiMatchQuery(searchString)
                        .type(MultiMatchQueryBuilder.Type.CROSS_FIELDS)
                        .type(MultiMatchQueryBuilder.Type.PHRASE)
                        .analyzer("stop")
                        .boost(1000)
                );

            }else if(searchTerm.toLowerCase().contains(" or ")){
                String searchString=String.join(" ", searchTerm.toLowerCase().split(" or "));
                q.add(QueryBuilders.multiMatchQuery(searchString)
                        .type(MultiMatchQueryBuilder.Type.CROSS_FIELDS)
                        .operator(Operator.OR)
                        .analyzer("stop")

                );

            }else if(!searchTerm.toLowerCase().contains(" and ") && searchTerm.toLowerCase().contains(" ") ) {
                q.add(QueryBuilders.multiMatchQuery(searchTerm)
                        .type(MultiMatchQueryBuilder.Type.CROSS_FIELDS)
                        .operator(Operator.AND)

                );
                q.add(QueryBuilders.multiMatchQuery(searchTerm)
                        .type(MultiMatchQueryBuilder.Type.CROSS_FIELDS)
                        .operator(Operator.AND)
                        .type(MultiMatchQueryBuilder.Type.PHRASE)
                        .analyzer("stop")
                        .boost(1000)
                );

            }else { if (isNumeric(searchTerm)) {
//                q.add(QueryBuilders.termQuery("nctId", searchTerm));
            } else {
                q.add(QueryBuilders.multiMatchQuery(searchTerm)
                        .type(MultiMatchQueryBuilder.Type.CROSS_FIELDS)
                        .type(MultiMatchQueryBuilder.Type.PHRASE)
//                        .analyzer("stop")
                );
                q.add(QueryBuilders.multiMatchQuery(searchTerm)
                        .type(MultiMatchQueryBuilder.Type.CROSS_FIELDS)
                        .operator(Operator.AND)
//                        .analyzer("stop")
                );
            }
            }

        }else{
            q.add(QueryBuilders.matchAllQuery());
        }
        return q;
    }
    public boolean isNumeric(String searchTerm){
        try{
            if(Long.parseLong(searchTerm)>0)
                return true;
        }catch (Exception e){}
        return false;
    }
    public static List<String> searchFields(){
        return Arrays.asList(
                "nctId," +
                      
                        "interventionName," +
                        "     sponsor," +
                        "     sponsorClass," +
                        "     indication," +
                        "     phase," +
                        "     location," +
                        "     eligibilitySex," +



                        "     standardAge," +



                        "     studyStatus," +



                        "     browseConditionTerms," +
                        "     nCTNumber," +
                        "     targetGeneOrVariant," +
                        "     therapyType," +
                        "     therapyRoute," +
                        "     mechanismOfAction," +
                        "     routeOfAdministration," +
                        "     drugProductType," +
                        "     targetTissueOrCell," +
                        "     deliverySystem," +
                        "     vectorType," +
                        "     editorType," +
                        "     recentUpdates," +
                        "     compoundName," +
                        "   externalLinks," +
                        "     patents," +
                        " phases," +
                        "   status," +
                        "  standardAges," +
                        "   locations;"
                
                
        );
    }
}
