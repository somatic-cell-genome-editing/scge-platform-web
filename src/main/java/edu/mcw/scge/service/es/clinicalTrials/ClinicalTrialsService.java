package edu.mcw.scge.service.es.clinicalTrials;

import edu.mcw.scge.dao.implementation.DefinitionDAO;
import edu.mcw.scge.datamodel.Definition;
import edu.mcw.scge.datamodel.web.ClinicalTrials;
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


    public static Map<String, String> fieldDisplayNames= new HashMap<>();
    static{
            for(String field: ClinicalTrials.facets) {
                String displayName=String.join(" ", field.split("(?<!(^|[A-Z]))(?=[A-Z])|(?<!^)(?=[A-Z][a-z])"));
                if(displayName.toLowerCase().startsWith("fda")) {
                  String name=  displayName.substring(0,3).toUpperCase()+displayName.substring(3);
                    fieldDisplayNames.put(field, StringUtils.capitalize(name));
                }else  if(displayName.equalsIgnoreCase("status")) {
                    String name=  "Recruitment Status";
                    fieldDisplayNames.put(field, StringUtils.capitalize(name));
                }
                else{
                    fieldDisplayNames.put(field, StringUtils.capitalize(displayName));
                }
            }

    }
    public static Map<String, String> facetDefinitions= new HashMap<>();
    static{
        DefinitionDAO definitionDAO=new DefinitionDAO();
        try {
            List<Definition> definitions=definitionDAO.getDefinitionsByCategory("Table Column Header");
            for(Definition d:definitions){
                facetDefinitions.put(d.getTerm(), d.getDefinition());
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }

    public SearchResponse getSearchResults(String searchTerm,String category, Map<String, List<String>> filtersMap) throws IOException {
        String searchIndex= SCGEContext.getESIndexName();
        SearchSourceBuilder srb=new SearchSourceBuilder();
        srb.query(this.buildBoolQuery(searchTerm, category));
        for(String fieldName:ClinicalTrials.facets) {
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
        for(String filter:filters.keySet()) {
            List<String> filterValues=filters.get(filter);
            q.filter().add(QueryBuilders.termsQuery(filter + ".keyword", filterValues.toArray()));
        }
      //  q.must(dqb);
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


        if(term!=null && !term.equals("") && !term.equals("null")) {
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
