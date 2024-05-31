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


import java.io.IOException;
import java.util.*;

public class PlatformIndexServices {

    public SearchResponse getSearchResults(String searchTerm, Map<String,  List<String>> filtersMap) throws IOException {
        String searchIndex = "scge_platform_search_dev";
        SearchSourceBuilder srb=new SearchSourceBuilder();
        srb.query(this.buildBoolQuery(searchTerm, filtersMap));
//        srb.aggregation(buildAggregations("protocolSection.identificationModule.organization.fullName"));
//        srb.aggregation(buildAggregations("protocolSection.statusModule.overallStatus"));

        srb.aggregation(buildAggregations("organization"));
        srb.aggregation(buildAggregations("status"));
        srb.aggregation(buildAggregations("condition"));

        srb.size(10000);
        try {
            srb.sort("protocolSection.identificationModule.organization.fullName.keyword", SortOrder.ASC);
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
                q.must(QueryBuilders.termsQuery("protocolSection.statusModule.overallStatus" + ".keyword", filterValues.toArray()));
            if (filter.equalsIgnoreCase("organization"))
                q.must(QueryBuilders.termsQuery("protocolSection.identificationModule.organization.fullName" + ".keyword", filterValues.toArray()));

            if (filter.equalsIgnoreCase("condition"))
                q.must(QueryBuilders.termsQuery("protocolSection.conditionsModule.conditions" + ".keyword", filterValues.toArray()));
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
            builder=AggregationBuilders.terms(fieldName).field("protocolSection.identificationModule.organization.fullName" + ".keyword") .size(1000).order(BucketOrder.key(true));
        if(fieldName.equalsIgnoreCase("status"))
            builder=AggregationBuilders.terms(fieldName).field("protocolSection.statusModule.overallStatus" + ".keyword") .order(BucketOrder.key(true));
        if(fieldName.equalsIgnoreCase("condition"))
            builder=AggregationBuilders.terms(fieldName).field("protocolSection.conditionsModule.conditions" + ".keyword").size(1000) .order(BucketOrder.key(true));

        return builder;
    }

    public QueryBuilder buildQuery(String term){
        DisMaxQueryBuilder q=new DisMaxQueryBuilder();
        q.add(QueryBuilders.matchAllQuery());
        return q;
    }


}
