package edu.mcw.scge.service.es.clinicalTrails;


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

    public SearchResponse getSearchResults(String searchTerm) throws IOException {
        String searchIndex = "scge_platform_search_dev";
        SearchSourceBuilder srb=new SearchSourceBuilder();
        srb.query(this.buildBoolQuery(searchTerm));
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
        SearchRequest searchRequest=new SearchRequest(searchIndex);
        searchRequest.source(srb);

        SearchResponse sr= ESClient.getClient().search(searchRequest, RequestOptions.DEFAULT);
        return sr;

    }
    public BoolQueryBuilder buildBoolQuery( String searchTerm){
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
