package edu.mcw.scge.service.es.clinicalTrials;

import edu.mcw.scge.service.es.ESClient;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.DisMaxQueryBuilder;
import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
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
            "targetGeneOrVariant", "mechanismOfAction", "targetTissueOrCell", "phases","standardAges", "therapyRoute"
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
        q.add(QueryBuilders.matchAllQuery());
        return q;
    }

}
