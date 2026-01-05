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
import org.elasticsearch.search.suggest.Suggest;
import org.elasticsearch.search.suggest.SuggestBuilder;
import org.elasticsearch.search.suggest.completion.CompletionSuggestionBuilder;
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
                }else  if(field.equalsIgnoreCase("status")) {
                    String name=  "Recruitment Status";
                    fieldDisplayNames.put(field, StringUtils.capitalize(name));
                }else  if(field.equalsIgnoreCase("withHasResults")) {
                    String name=  "Results Posted";
                    fieldDisplayNames.put(field, name);
                }else if(field.equalsIgnoreCase("eligibilitySex")){
                    String name=  "Sexes Eligible for Study";
                    fieldDisplayNames.put(field, name);
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

    public SearchResponse getSearchResults(String searchTerm, String category, Map<String, List<String>> filtersMap, int page, int pageSize) throws IOException {
        String searchIndex= SCGEContext.getESIndexName();
        SearchSourceBuilder srb=new SearchSourceBuilder();
        BoolQueryBuilder q=this.buildBoolQuery(searchTerm, category, filtersMap);
        srb.query(q);
        for(String fieldName:ClinicalTrials.facets) {
            srb.aggregation(buildAggregations(fieldName));
        }
        // Pagination: calculate offset and set page size
        srb.from(page * pageSize);
        srb.size(pageSize);
        srb.trackTotalHits(true); // Ensure total hits are tracked for pagination
        try {
            srb.sort("recordModifiedDate", SortOrder.DESC);
        }catch (Exception e){
            e.printStackTrace();
        }
        if(filtersMap!=null && filtersMap.size()>0)
            srb.postFilter(filter(filtersMap));

        SearchRequest searchRequest=new SearchRequest(searchIndex);
        searchRequest.source(srb);
       return ESClient.getClient().search(searchRequest, RequestOptions.DEFAULT);


    }
    public Set<String> getAutocompleteList(String term) throws IOException {
        Set<String> autocompleteList=new HashSet<>();
        CompletionSuggestionBuilder suggestionBuilder=new CompletionSuggestionBuilder("suggest");
        suggestionBuilder.text(term);
        //   suggestionBuilder.prefix(term, Fuzziness.TWO);
        suggestionBuilder.size(10000);
        SearchSourceBuilder srb=new SearchSourceBuilder();
        srb.suggest(new SuggestBuilder().addSuggestion("autocomplete-suggest", suggestionBuilder));

        SearchRequest searchRequest=new SearchRequest(SCGEContext.getESIndexName());
        searchRequest.source(srb);
        SearchResponse sr= ESClient.getClient().search(searchRequest, RequestOptions.DEFAULT);

        if(sr!=null){
            // Process the response
            sr.getSuggest().getSuggestion("autocomplete-suggest").getEntries().stream().map(Suggest.Suggestion.Entry::getOptions)
                    .forEach(options -> {
                        options.forEach(option -> {
                            autocompleteList.add(String.valueOf(option.getText()));
                        });
                    });

        }
        return autocompleteList;
    }
    public BoolQueryBuilder filter(Map<String, List<String>> filters){
        BoolQueryBuilder q=new BoolQueryBuilder();
        for(String filter:filters.keySet()) {
            List<String> filterValues=filters.get(filter);
            if(filterValues.size()>0)
            q.filter().add(QueryBuilders.termsQuery(filter + ".keyword", filterValues.toArray()));
        }
      //  q.must(dqb);
        return q;
    }
    public BoolQueryBuilder buildBoolQuery( String searchTerm, String category, Map<String, List<String>> filtersMap){
        BoolQueryBuilder q=new BoolQueryBuilder();
        q.must(buildQuery(searchTerm));
        if(category!=null && !category.equals("")){
            q.filter(QueryBuilders.termQuery("category.keyword", category));
        }
        q.filter(QueryBuilders.termsQuery("recordStatus.keyword", filtersMap.get("recordStatus")));
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

    /**
     * Get recent updates for daily digest (last 7 days)
     */
    public SearchResponse getRecentUpdatesForDigest(String category, Map<String, List<String>> filtersMap) throws IOException {
        String searchIndex = SCGEContext.getESIndexName();
        SearchSourceBuilder srb = new SearchSourceBuilder();

        // Build query with date range for last 7 days
        BoolQueryBuilder q = new BoolQueryBuilder();
        q.must(QueryBuilders.matchAllQuery());

        if (category != null && !category.equals("")) {
            q.filter(QueryBuilders.termQuery("category.keyword", category));
        }

        // Filter for records modified in last 7 days
        q.filter(QueryBuilders.rangeQuery("recordModifiedDate")
                .gte("now-7d/d")
                .lte("now/d"));
        if (filtersMap != null && filtersMap.size() > 0) {
           q.filter(QueryBuilders.termsQuery("recordStatus.keyword", filtersMap.get("recordStatus")));
        }


        srb.query(q);
        srb.size(10000); // Get all updates from past 7 days, display limited in UI
        srb.sort("recordModifiedDate", SortOrder.DESC);


        SearchRequest searchRequest = new SearchRequest(searchIndex);
        searchRequest.source(srb);
        return ESClient.getClient().search(searchRequest, RequestOptions.DEFAULT);
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
