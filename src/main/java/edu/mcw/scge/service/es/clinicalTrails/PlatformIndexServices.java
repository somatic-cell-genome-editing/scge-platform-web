package edu.mcw.scge.service.es.clinicalTrails;


import edu.mcw.scge.service.es.ESClient;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.index.query.*;

import org.elasticsearch.search.builder.SearchSourceBuilder;


import java.io.IOException;
import java.util.*;

public class PlatformIndexServices {

    public SearchResponse getSearchResults(String searchTerm) throws IOException {
        String searchIndex = "scge_platform_search_dev";
        SearchSourceBuilder srb=new SearchSourceBuilder();
        srb.query(this.buildBoolQuery(searchTerm));

        srb.size(10000);
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

    public QueryBuilder buildQuery(String term){
        DisMaxQueryBuilder q=new DisMaxQueryBuilder();
        q.add(QueryBuilders.matchAllQuery());
        return q;
    }


}
