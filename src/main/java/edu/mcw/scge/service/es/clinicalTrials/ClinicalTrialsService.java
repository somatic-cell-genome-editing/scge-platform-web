package edu.mcw.scge.service.es.clinicalTrials;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.elasticsearch._types.ElasticsearchException;
import co.elastic.clients.elasticsearch._types.ErrorCause;
import co.elastic.clients.elasticsearch._types.FieldValue;
import co.elastic.clients.elasticsearch._types.SortOrder;
import co.elastic.clients.elasticsearch._types.aggregations.Aggregation;
import co.elastic.clients.elasticsearch._types.query_dsl.BoolQuery;
import co.elastic.clients.elasticsearch._types.query_dsl.DisMaxQuery;
import co.elastic.clients.elasticsearch._types.query_dsl.Operator;
import co.elastic.clients.elasticsearch._types.query_dsl.Query;
import co.elastic.clients.elasticsearch._types.query_dsl.TextQueryType;
import co.elastic.clients.elasticsearch.core.SearchRequest;
import co.elastic.clients.elasticsearch.core.SearchResponse;
import co.elastic.clients.elasticsearch.core.search.Hit;
import co.elastic.clients.util.NamedValue;
import edu.mcw.scge.dao.implementation.DefinitionDAO;
import edu.mcw.scge.datamodel.Definition;
import edu.mcw.scge.datamodel.web.ClinicalTrials;
import edu.mcw.scge.services.ESClient;
import edu.mcw.scge.services.SCGEContext;
import org.springframework.util.StringUtils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class ClinicalTrialsService {

    public static Map<String, String> fieldDisplayNames = new HashMap<>();
    static {
        for (String field : ClinicalTrials.facets) {
            String displayName = String.join(" ", field.split("(?<!(^|[A-Z]))(?=[A-Z])|(?<!^)(?=[A-Z][a-z])"));
            if (displayName.toLowerCase().startsWith("fda")) {
                String name = displayName.substring(0, 3).toUpperCase() + displayName.substring(3);
                fieldDisplayNames.put(field, StringUtils.capitalize(name));
            } else if (field.equalsIgnoreCase("status")) {
                fieldDisplayNames.put(field, StringUtils.capitalize("Recruitment Status"));
            } else if (field.equalsIgnoreCase("withHasResults")) {
                fieldDisplayNames.put(field, "Results Posted");
            } else if (field.equalsIgnoreCase("eligibilitySex")) {
                fieldDisplayNames.put(field, "Sexes Eligible for Study");
            } else if (field.equalsIgnoreCase("therapyType")) {
                fieldDisplayNames.put(field, "Therapeutic Modality");
            } else if (field.trim().equalsIgnoreCase("deliverySystem")) {
                fieldDisplayNames.put(field, "Gene Delivery System");
            }else {
                fieldDisplayNames.put(field, StringUtils.capitalize(displayName));
            }
        }
    }

    public static Map<String, String> facetDefinitions = new HashMap<>();
    static {
        DefinitionDAO definitionDAO = new DefinitionDAO();
        try {
            List<Definition> definitions = definitionDAO.getDefinitionsByCategory("Table Column Header");
            for (Definition d : definitions) {
                facetDefinitions.put(d.getTerm(), d.getDefinition());
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public SearchResponse<Map> getSearchResults(String searchTerm, String category,
                                                 Map<String, List<String>> filtersMap,
                                                 int page, int pageSize) throws IOException {
        String searchIndex = SCGEContext.getESIndexName();
        ElasticsearchClient client = ESClient.getClient();

        Query query = buildBoolQuery(searchTerm, category, filtersMap);

        Map<String, Aggregation> aggsMap = new HashMap<>();
        for (String fieldName : ClinicalTrials.facets) {
            aggsMap.put(fieldName, buildAggregation(fieldName));
        }

        SearchRequest.Builder srb = new SearchRequest.Builder()
                .index(searchIndex)
                .query(query)
                .from(page * pageSize)
                .size(pageSize)
                .trackTotalHits(t -> t.enabled(true))
                .aggregations(aggsMap)
                .sort(s -> s.field(f -> f.field("recordModifiedDate").order(SortOrder.Desc)));

        if (filtersMap != null && !filtersMap.isEmpty()) {
            srb.postFilter(filter(filtersMap));
        }

        try {
            return client.search(srb.build(), Map.class);
        } catch (ElasticsearchException ex) {
            System.err.println("[ClinicalTrialsService.getSearchResults] ES error: " + describeError(ex));
            throw ex;
        }
    }

    public Set<String> getAutocompleteList(String term) throws IOException {
        // Preserve insertion order and de-dupe suggestion terms.
        Set<String> autocompleteList = new LinkedHashSet<>();
        if (term == null || term.trim().isEmpty()) {
            return autocompleteList;
        }
        ElasticsearchClient client = ESClient.getClient();

        // "Search as you type": query the search_as_you_type field and its shingle
        // subfields with a bool_prefix multi_match, which matches word-prefixes
        // anywhere in the indexed text as the user types.
        SearchResponse<Map> sr = client.search(s -> s
                        .index(SCGEContext.getESIndexName())
                        .size(50)
                        .source(src -> src.filter(f -> f.includes("suggest")))
                        .query(q -> q
                                .multiMatch(mm -> mm
                                        .query(term)
                                        .type(TextQueryType.BoolPrefix)
                                        .fields("suggest", "suggest._2gram", "suggest._3gram")
                                )
                        ),
                Map.class);

        String typed = term.toLowerCase().trim();
        for (Hit<Map> hit : sr.hits().hits()) {
            Map source = hit.source();
            if (source == null) {
                continue;
            }
            Object suggestVal = source.get("suggest");
            if (suggestVal instanceof List) {
                for (Object o : (List<?>) suggestVal) {
                    if (o == null) {
                        continue;
                    }
                    String suggestion = String.valueOf(o);
                    // The matched document may carry many suggest terms; only surface
                    // the ones the user is actually typing toward.
                    if (suggestion.toLowerCase().contains(typed)) {
                        autocompleteList.add(suggestion);
                    }
                }
            } else if (suggestVal != null) {
                String suggestion = String.valueOf(suggestVal);
                if (suggestion.toLowerCase().contains(typed)) {
                    autocompleteList.add(suggestion);
                }
            }
        }
        return autocompleteList;
    }

    public Query filter(Map<String, List<String>> filters) {
        BoolQuery.Builder b = new BoolQuery.Builder();
        for (String field : filters.keySet()) {
            List<String> values = filters.get(field);
            if (values != null && !values.isEmpty()) {
                List<FieldValue> fieldValues = new ArrayList<>();
                for (String v : values) {
                    fieldValues.add(FieldValue.of(v));
                }
                b.filter(f -> f.terms(t -> t
                        .field(field + ".keyword")
                        .terms(tv -> tv.value(fieldValues))));
            }
        }
        return Query.of(q -> q.bool(b.build()));
    }

    public Query buildBoolQuery(String searchTerm, String category, Map<String, List<String>> filtersMap) {
        BoolQuery.Builder b = new BoolQuery.Builder();
        b.must(buildQuery(searchTerm));

        if (category != null && !category.equals("")) {
            b.filter(f -> f.term(t -> t.field("category.keyword").value(category)));
        }

        if (filtersMap != null && !filtersMap.isEmpty()
                && filtersMap.get("recordStatus") != null
                && !filtersMap.get("recordStatus").isEmpty()) {
            List<FieldValue> fieldValues = new ArrayList<>();
            for (String s : filtersMap.get("recordStatus")) {
                fieldValues.add(FieldValue.of(s));
            }
            b.filter(f -> f.terms(t -> t
                    .field("recordStatus.keyword")
                    .terms(tv -> tv.value(fieldValues))));
        }

        return Query.of(q -> q.bool(b.build()));
    }

    public Aggregation buildAggregation(String fieldName) {
        return Aggregation.of(a -> a.terms(t -> t
                .field(fieldName + ".keyword")
                .size(1000)
                .order(List.of(NamedValue.of("_key", SortOrder.Asc)))
        ));
    }

    public Query buildQuery(String term) {
        DisMaxQuery.Builder dq = new DisMaxQuery.Builder();

        if (term != null && !term.equals("") && !term.equals("null")) {
            String searchTerm = term.toLowerCase().trim();

            if (searchTerm.contains(" and ")) {
                String searchString = String.join(" ", searchTerm.split(" and "));
                dq.queries(Query.of(q -> q.multiMatch(m -> m
                        .query(searchString)
                        .type(TextQueryType.CrossFields)
                        .operator(Operator.And)
                        .analyzer("stop"))));
                dq.queries(Query.of(q -> q.multiMatch(m -> m
                        .query(searchString)
                        .type(TextQueryType.Phrase)
                        .analyzer("stop")
                        .boost(1000f))));
            } else if (searchTerm.contains(" or ")) {
                String searchString = String.join(" ", searchTerm.split(" or "));
                dq.queries(Query.of(q -> q.multiMatch(m -> m
                        .query(searchString)
                        .type(TextQueryType.CrossFields)
                        .operator(Operator.Or)
                        .analyzer("stop"))));
            } else if (searchTerm.contains(" ")) {
                dq.queries(Query.of(q -> q.multiMatch(m -> m
                        .query(searchTerm)
                        .type(TextQueryType.CrossFields)
                        .operator(Operator.And))));
                dq.queries(Query.of(q -> q.multiMatch(m -> m
                        .query(searchTerm)
                        .type(TextQueryType.Phrase)
                        .operator(Operator.And)
                        .analyzer("stop")
                        .boost(1000f))));
            } else {
                if (!isNumeric(searchTerm)) {
                    dq.queries(Query.of(q -> q.multiMatch(m -> m
                            .query(searchTerm)
                            .type(TextQueryType.Phrase))));
                    dq.queries(Query.of(q -> q.multiMatch(m -> m
                            .query(searchTerm)
                            .type(TextQueryType.CrossFields)
                            .operator(Operator.And))));
                }
            }
        } else {
            dq.queries(Query.of(q -> q.matchAll(ma -> ma)));
        }

        return Query.of(q -> q.disMax(dq.build()));
    }

    public boolean isNumeric(String searchTerm) {
        try {
            if (Long.parseLong(searchTerm) > 0)
                return true;
        } catch (Exception e) {
        }
        return false;
    }

    /**
     * Get recent updates for daily digest.
     * Stage: last 7 days (daily ingestion).
     * Production: last 14 days (weekly release cycle).
     */
    public SearchResponse<Map> getRecentUpdatesForDigest(String category,
                                                          Map<String, List<String>> filtersMap) throws IOException {
        String searchIndex = SCGEContext.getESIndexName();
        ElasticsearchClient client = ESClient.getClient();

        int lookbackDays = SCGEContext.isProduction() ? 14 : 7;

        BoolQuery.Builder b = new BoolQuery.Builder();
        b.must(m -> m.matchAll(ma -> ma));

        if (category != null && !category.equals("")) {
            b.filter(f -> f.term(t -> t.field("category.keyword").value(category)));
        }

        // recordModifiedDate is mapped as a long (epoch millis), not a date —
        // compute the window bounds in Java instead of relying on ES date math.
        long nowMs = System.currentTimeMillis();
        long startMs = nowMs - lookbackDays * 24L * 60L * 60L * 1000L;
        b.filter(f -> f.range(r -> r.longNumber(n -> n
                .field("recordModifiedDate")
                .gte(startMs)
                .lte(nowMs))));

        if (filtersMap != null && !filtersMap.isEmpty()
                && filtersMap.get("recordStatus") != null
                && !filtersMap.get("recordStatus").isEmpty()) {
            List<FieldValue> fieldValues = new ArrayList<>();
            for (String s : filtersMap.get("recordStatus")) {
                fieldValues.add(FieldValue.of(s));
            }
            b.filter(f -> f.terms(t -> t
                    .field("recordStatus.keyword")
                    .terms(tv -> tv.value(fieldValues))));
        }

        BoolQuery boolQuery = b.build();

        try {
            return client.search(s -> s
                            .index(searchIndex)
                            .query(q -> q.bool(boolQuery))
                            .size(10000)
                            .sort(so -> so.field(f -> f.field("recordModifiedDate").order(SortOrder.Desc))),
                    Map.class);
        } catch (ElasticsearchException ex) {
            System.err.println("[ClinicalTrialsService.getRecentUpdatesForDigest] ES error: " + describeError(ex));
            throw ex;
        }
    }

    /** Walk an ElasticsearchException's cause chain and shard failures into a readable string. */
    private static String describeError(ElasticsearchException ex) {
        StringBuilder sb = new StringBuilder();
        if (ex.response() != null && ex.response().error() != null) {
            describeCause(ex.response().error(), sb, 0);
        } else {
            sb.append(ex.getMessage());
        }
        return sb.toString();
    }

    private static void describeCause(ErrorCause cause, StringBuilder sb, int depth) {
        String indent = "  ".repeat(depth);
        sb.append("\n").append(indent)
                .append("type=").append(cause.type())
                .append(", reason=").append(cause.reason());
        if (cause.metadata() != null && !cause.metadata().isEmpty()) {
            sb.append("\n").append(indent).append("metadata=").append(cause.metadata());
        }
        if (cause.causedBy() != null) {
            sb.append("\n").append(indent).append("causedBy:");
            describeCause(cause.causedBy(), sb, depth + 1);
        }
        if (cause.rootCause() != null && !cause.rootCause().isEmpty()) {
            sb.append("\n").append(indent).append("rootCause:");
            cause.rootCause().forEach(rc -> describeCause(rc, sb, depth + 1));
        }
    }

    public static List<String> searchFields() {
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
