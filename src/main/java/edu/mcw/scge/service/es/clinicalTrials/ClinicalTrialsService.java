package edu.mcw.scge.service.es.clinicalTrials;

import edu.mcw.scge.service.es.ESClient;
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
import java.util.stream.Collectors;

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

    public SearchResponse getSearchResults(String searchTerm, Map<String, List<String>> filtersMap) throws IOException {
        String searchIndex = "scge_platform_ctapi_search_dev";
                //"scge_platform_search_dev";
        SearchSourceBuilder srb=new SearchSourceBuilder();
        srb.query(this.buildBoolQuery(searchTerm, filtersMap));
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
    public BoolQueryBuilder buildBoolQuery( String searchTerm, Map<String,  List<String>> filterMap){
        BoolQueryBuilder q=new BoolQueryBuilder();
        q.must(buildQuery(searchTerm));

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
                q.add(QueryBuilders.multiMatchQuery(searchTerm, searchFields().toArray(new String[0]))
                        .type(MultiMatchQueryBuilder.Type.CROSS_FIELDS)
                        .type(MultiMatchQueryBuilder.Type.PHRASE)
                        .analyzer("stop")
                );
                q.add(QueryBuilders.multiMatchQuery(searchTerm, searchFields().toArray(new String[0]))
                        .type(MultiMatchQueryBuilder.Type.CROSS_FIELDS)
                        .operator(Operator.AND)
                        .analyzer("stop")
                );
            }
            }

            q.add(QueryBuilders.termQuery("symbol.custom", searchTerm).boost(1000));
            q.add(QueryBuilders.termQuery("name.custom", searchTerm).boost(1000));
            q.add(QueryBuilders.termQuery("pi", searchTerm).boost(1000));

            q.add(QueryBuilders.matchPhraseQuery("symbol", searchTerm).boost(400));
            q.add(QueryBuilders.matchPhraseQuery("name", searchTerm).boost(400));

            q.add(QueryBuilders.matchPhrasePrefixQuery("symbol.custom", searchTerm).boost(100));
            q.add(QueryBuilders.matchPhrasePrefixQuery("name.custom", searchTerm).boost(100));



            q.add(QueryBuilders.matchPhrasePrefixQuery("pi", searchTerm).boost(500));
            q.add(QueryBuilders.matchPhraseQuery("pi", searchTerm).boost(200));
            q.add(QueryBuilders.termQuery("currentGrantNumber.keyword", searchTerm));
            q.add(QueryBuilders.termQuery("formerGrantNumbers.keyword", searchTerm));
            q.add(QueryBuilders.termQuery("description", searchTerm));
            q.add(QueryBuilders.termQuery("articleIds.id.keyword", searchTerm).caseInsensitive(true));
            q.add(QueryBuilders.termQuery("authorList.lastName.keyword", searchTerm).caseInsensitive(true));
            q.add(QueryBuilders.termQuery("authorList.firstName.keyword", searchTerm).caseInsensitive(true));





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
