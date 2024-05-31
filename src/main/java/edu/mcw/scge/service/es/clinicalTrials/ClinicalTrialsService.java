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

import java.io.IOException;
import java.util.List;
import java.util.Map;

public class ClinicalTrialsService {
    public SearchResponse getSearchResults(String searchTerm, Map<String, List<String>> filtersMap) throws IOException {
        String searchIndex = "scge_platform_search_test";
        SearchSourceBuilder srb=new SearchSourceBuilder();
        srb.query(this.buildBoolQuery(searchTerm, filtersMap));

        srb.aggregation(buildAggregations("organization"));
        srb.aggregation(buildAggregations("status"));
        srb.aggregation(buildAggregations("condition"));

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
            if (filter.equalsIgnoreCase("status"))
                q.must(QueryBuilders.termsQuery("status" + ".keyword", filterValues.toArray()));
            if (filter.equalsIgnoreCase("organization"))
                q.must(QueryBuilders.termsQuery("sponsor" + ".keyword", filterValues.toArray()));

            if (filter.equalsIgnoreCase("condition"))
                q.must(QueryBuilders.termsQuery("indication" + ".keyword", filterValues.toArray()));
        }
        return q;
    }
    public BoolQueryBuilder buildBoolQuery( String searchTerm, Map<String,  List<String>> filterMap){
        BoolQueryBuilder q=new BoolQueryBuilder();
        q.must(buildQuery(searchTerm));

        return q;
    }

    public AggregationBuilder buildAggregations(String fieldName){
        AggregationBuilder builder=null;
        if(fieldName.equalsIgnoreCase("organization"))
            builder= AggregationBuilders.terms(fieldName).field("sponsor" + ".keyword") .size(1000).order(BucketOrder.key(true));
        if(fieldName.equalsIgnoreCase("status"))
            builder=AggregationBuilders.terms(fieldName).field("status" + ".keyword") .order(BucketOrder.key(true));
        if(fieldName.equalsIgnoreCase("condition"))
            builder=AggregationBuilders.terms(fieldName).field("indication" + ".keyword").size(1000) .order(BucketOrder.key(true));

        return builder;
    }

    public QueryBuilder buildQuery(String term){
        DisMaxQueryBuilder q=new DisMaxQueryBuilder();
        q.add(QueryBuilders.matchAllQuery());
        return q;
    }

}
