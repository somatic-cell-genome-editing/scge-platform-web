package edu.mcw.scge.service.es.clinicalTrials;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.elasticsearch._types.ElasticsearchException;
import co.elastic.clients.elasticsearch._types.ErrorCause;
import co.elastic.clients.elasticsearch._types.FieldValue;
import co.elastic.clients.elasticsearch._types.SortOrder;
import co.elastic.clients.elasticsearch._types.aggregations.Aggregation;
import co.elastic.clients.elasticsearch._types.aggregations.StringTermsAggregate;
import co.elastic.clients.elasticsearch._types.aggregations.StringTermsBucket;
import co.elastic.clients.elasticsearch._types.query_dsl.BoolQuery;
import co.elastic.clients.elasticsearch._types.query_dsl.DisMaxQuery;
import co.elastic.clients.elasticsearch._types.query_dsl.Operator;
import co.elastic.clients.elasticsearch._types.query_dsl.Query;
import co.elastic.clients.elasticsearch._types.query_dsl.TextQueryType;
import co.elastic.clients.elasticsearch.core.SearchRequest;
import co.elastic.clients.elasticsearch.core.SearchResponse;
import co.elastic.clients.elasticsearch.core.search.Hit;
import co.elastic.clients.util.NamedValue;
import org.apache.lucene.analysis.en.EnglishMinimalStemmer;
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
import java.util.HashSet;
import java.util.LinkedHashMap;
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
            }else if (field.trim().equalsIgnoreCase("sponsorClass")) {
                fieldDisplayNames.put(field, "Funder Type");
            }else if (field.trim().equalsIgnoreCase("routesOfAdministration")) {
                fieldDisplayNames.put(field, "Route Of Administration");
            }else if (field.trim().equalsIgnoreCase("mechanismOfActions")) {
                fieldDisplayNames.put(field, "Mechanism Of Action");
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

    /**
     * Full-result-set distributions for the graphical Overview tab. Unlike the
     * paginated table (which only holds one page of hits), this aggregates over
     * every document matching the current search term + category + filters, so
     * the charts describe the entire result set rather than the visible page.
     *
     * The facet filters are applied as REAL query filters here (not a
     * post_filter), so the bucket totals reflect exactly the filtered result set
     * the user is viewing and sum to the "Showing X of Y results" total.
     *
     * Returns friendly-key -> (label -> count), each map ordered by count desc.
     */
    public Map<String, LinkedHashMap<String, Integer>> getOverviewDistributions(
            String searchTerm, String category, Map<String, List<String>> filtersMap) throws IOException {

        // Friendly response key -> ES aggregatable (keyword) field name.
        LinkedHashMap<String, String> fields = new LinkedHashMap<>();
        fields.put("therapy", "therapyType");
        fields.put("phase", "phases");
        fields.put("status", "status");
        fields.put("sponsor", "sponsorClass");
        fields.put("vector", "vectorType");
        fields.put("indication", "indications");
        fields.put("age", "standardAges");

        Map<String, LinkedHashMap<String, Integer>> result = new LinkedHashMap<>();
        for (String key : fields.keySet()) {
            result.put(key, new LinkedHashMap<>());
        }

        ElasticsearchClient client = ESClient.getClient();
        final Map<String, List<String>> safeFilters =
                (filtersMap == null) ? new HashMap<>() : filtersMap;

        Query query = Query.of(q -> q.bool(b -> b
                .must(buildBoolQuery(searchTerm, category, safeFilters))
                .must(filter(safeFilters))));

        Map<String, Aggregation> aggsMap = new HashMap<>();
        for (String esField : fields.values()) {
            aggsMap.put(esField, buildAggregation(esField));
        }

        SearchRequest.Builder srb = new SearchRequest.Builder()
                .index(SCGEContext.getESIndexName())
                .query(query)
                .size(0)
                .trackTotalHits(t -> t.enabled(true))
                .aggregations(aggsMap);

        SearchResponse<Map> sr;
        try {
            sr = client.search(srb.build(), Map.class);
        } catch (ElasticsearchException ex) {
            System.err.println("[ClinicalTrialsService.getOverviewDistributions] ES error: " + describeError(ex));
            throw ex;
        }

        for (Map.Entry<String, String> e : fields.entrySet()) {
            String key = e.getKey();
            String esField = e.getValue();
            if (sr.aggregations() == null || sr.aggregations().get(esField) == null) {
                continue;
            }
            StringTermsAggregate agg = sr.aggregations().get(esField).sterms();
            LinkedHashMap<String, Integer> counts = new LinkedHashMap<>();
            for (StringTermsBucket bkt : agg.buckets().array()) {
                String label = bkt.key().stringValue();
                if (label == null || label.trim().isEmpty()) {
                    continue;
                }
                counts.put(label, (int) bkt.docCount());
            }
            LinkedHashMap<String, Integer> sorted = new LinkedHashMap<>();
            counts.entrySet().stream()
                    .sorted((a, b) -> Integer.compare(b.getValue(), a.getValue()))
                    .forEach(en -> sorted.put(en.getKey(), en.getValue()));
            result.put(key, sorted);
        }

        return result;
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
        // Also match nctId directly so typing a trial ID (e.g. "NCT07681778")
        // surfaces that trial, even though nctId is not part of the suggest terms.
        SearchResponse<Map> sr = client.search(s -> s
                        .index(SCGEContext.getESIndexName())
                        .size(50)
                        .source(src -> src.filter(f -> f.includes("suggest", "nctId")))
                        .query(q -> q
                                .multiMatch(mm -> mm
                                        .query(term)
                                        .type(TextQueryType.BoolPrefix)
                                        .fields("suggest", "suggest._2gram", "suggest._3gram", "nctId")
                                )
                        ),
                Map.class);

        String typed = term.toLowerCase().trim();
        for (Hit<Map> hit : sr.hits().hits()) {
            Map source = hit.source();
            if (source == null) {
                continue;
            }
            collectMatches(source.get("suggest"), typed, autocompleteList);
            collectMatches(source.get("nctId"), typed, autocompleteList);
        }

        // ES orders whole documents, and a single document's suggest array is
        // emitted in raw array order, so an exact match can land below longer
        // incidental matches (e.g. "Viral Infectious Diseases" ahead of
        // "Infectious Diseases"). Re-rank the collected terms against what the
        // user actually typed. The sort is stable, so ES relevance still breaks
        // ties within a rank.
        List<String> ranked = new ArrayList<>(autocompleteList);
        ranked.sort((a, b) -> {
            int byRank = Integer.compare(suggestionRank(a, typed), suggestionRank(b, typed));
            if (byRank != 0) {
                return byRank;
            }
            // Prefer the more concise term when both match equally well.
            return Integer.compare(a.length(), b.length());
        });

        // Collapse singular/plural duplicates (e.g. "Lentiviral Infection" and
        // "Lentiviral Infections") so only one form shows in the dropdown. The
        // first-seen form wins, so the best-ranked form above survives.
        Set<String> deduped = new LinkedHashSet<>();
        Set<String> seenKeys = new HashSet<>();
        for (String suggestion : ranked) {
            if (seenKeys.add(singularKey(suggestion))) {
                deduped.add(suggestion);
            }
        }
        return deduped;
    }

    /**
     * Scores how well a suggestion matches the typed text, lowest first:
     * 0 exact, 1 starts with, 2 typed text begins a later word, 3 matches
     * mid-word. Keeps the term the user is literally typing at the top of the
     * dropdown instead of letting longer incidental matches outrank it.
     */
    private int suggestionRank(String suggestion, String typed) {
        String candidate = suggestion.toLowerCase().trim();
        if (candidate.equals(typed)) {
            return 0;
        }
        if (candidate.startsWith(typed)) {
            return 1;
        }
        int at = candidate.indexOf(typed);
        if (at > 0 && !Character.isLetterOrDigit(candidate.charAt(at - 1))) {
            return 2;
        }
        return 3;
    }

    // Plural-only stemmer (-s/-es/-ies -> singular). Stateless; safe to share.
    private static final EnglishMinimalStemmer PLURAL_STEMMER = new EnglishMinimalStemmer();

    /**
     * Normalizes a phrase for singular/plural de-duplication by lower-casing and
     * stemming each word to its singular form (e.g. "infections"->"infection",
     * "studies"->"study", "boxes"->"box"), so both forms collapse to one entry.
     */
    private String singularKey(String phrase) {
        StringBuilder key = new StringBuilder();
        for (String word : phrase.toLowerCase().trim().split("\\s+")) {
            if (word.isEmpty()) {
                continue;
            }
            char[] chars = word.toCharArray();
            int len = PLURAL_STEMMER.stem(chars, chars.length);
            key.append(chars, 0, len).append(' ');
        }
        return key.toString().trim();
    }

    /**
     * Adds every value in {@code value} (a String or a List of Strings) that
     * contains the typed text (case-insensitive) into {@code out}. The matched
     * document may carry many terms; only the ones the user is typing toward
     * are surfaced.
     */
    private void collectMatches(Object value, String typed, Set<String> out) {
        if (value == null) {
            return;
        }
        if (value instanceof List) {
            for (Object o : (List<?>) value) {
                if (o != null) {
                    String suggestion = String.valueOf(o);
                    if (suggestion.toLowerCase().contains(typed)) {
                        out.add(suggestion);
                    }
                }
            }
        } else {
            String suggestion = String.valueOf(value);
            if (suggestion.toLowerCase().contains(typed)) {
                out.add(suggestion);
            }
        }
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
                        .analyzer("default"))));
                dq.queries(Query.of(q -> q.multiMatch(m -> m
                        .query(searchString)
                        .type(TextQueryType.Phrase)
                        .analyzer("default")
                        .boost(1000f))));
                dq.queries(prefixQuery(searchString, Operator.And));
            } else if (searchTerm.contains(" or ")) {
                String searchString = String.join(" ", searchTerm.split(" or "));
                dq.queries(Query.of(q -> q.multiMatch(m -> m
                        .query(searchString)
                        .type(TextQueryType.CrossFields)
                        .operator(Operator.Or)
                        .analyzer("default"))));
                dq.queries(prefixQuery(searchString, Operator.Or));
            } else if (searchTerm.contains(" ")) {
                dq.queries(Query.of(q -> q.multiMatch(m -> m
                        .query(searchTerm)
                        .type(TextQueryType.CrossFields)
                        .operator(Operator.And))));
                dq.queries(Query.of(q -> q.multiMatch(m -> m
                        .query(searchTerm)
                        .type(TextQueryType.Phrase)
                        .operator(Operator.And)
                        .analyzer("default")
                        .boost(1000f))));
                dq.queries(prefixQuery(searchTerm, Operator.And));
            } else {
                if (!isNumeric(searchTerm)) {
                    dq.queries(Query.of(q -> q.multiMatch(m -> m
                            .query(searchTerm)
                            .type(TextQueryType.Phrase))));
                    dq.queries(Query.of(q -> q.multiMatch(m -> m
                            .query(searchTerm)
                            .type(TextQueryType.CrossFields)
                            .operator(Operator.And))));
                    dq.queries(prefixQuery(searchTerm, Operator.And));
                }
            }
        } else {
            dq.queries(Query.of(q -> q.matchAll(ma -> ma)));
        }

        return Query.of(q -> q.disMax(dq.build()));
    }

    /**
     * Word-prefix clause for the search dis_max. The other clauses only match
     * whole analyzed tokens, so a partial word the user is still typing toward
     * (e.g. "cardio" for "cardiovascular") matched nothing at all and the search
     * returned 0 results even though the autocomplete dropdown offered the term.
     *
     * bool_prefix treats every term but the last as an ordinary term match and
     * the last one as a prefix, which is the same semantics the autocomplete in
     * {@link #getAutocompleteList(String)} already uses. The low boost keeps
     * prefix-only hits ranked beneath real token/phrase matches — dis_max scores
     * on the best-matching clause, so exact matches still lead the results.
     */
    private Query prefixQuery(String searchTerm, Operator operator) {
        return Query.of(q -> q.multiMatch(m -> m
                .query(searchTerm)
                .type(TextQueryType.BoolPrefix)
                .operator(operator)
                .boost(0.1f)));
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
