<%@ page import="co.elastic.clients.elasticsearch.core.search.Hit" %>
<%@ page import="co.elastic.clients.elasticsearch.core.SearchResponse" %>
<%@ page import="edu.mcw.scge.service.es.clinicalTrials.ClinicalTrialsService" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%--
  General search results: every category in the index listed together in the
  main content area, with a category sidebar beside them.

  Rendering is per hit, keyed on the "category" field, so a category added to
  the index later falls through to a generic card instead of being squeezed
  into the clinical-trial layout.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<link href="/platform/css/clinicalTrialsResultsview.css" rel="stylesheet" type="text/css"/>
<link href="/platform/css/generalSearchResults.css" rel="stylesheet" type="text/css"/>
<link href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@400&display=swap" rel="stylesheet">
<script src="/platform/js/scge.js"></script>
<%!
    /** HTML-escapes a value; a missing field renders as an empty string, never "null". */
    private static String esc(Object value) {
        if (value == null) return "";
        String text = value.toString().trim();
        if (text.equalsIgnoreCase("null")) return "";
        return text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
                   .replace("\"", "&quot;").replace("'", "&#39;");
    }

    /** Raw (unescaped) field value, for tests like isEmpty() rather than output. */
    private static String raw(Object value) {
        if (value == null) return "";
        String text = value.toString().trim();
        return text.equalsIgnoreCase("null") ? "" : text;
    }

    private static String urlEnc(String value) {
        return value == null ? "" : URLEncoder.encode(value, StandardCharsets.UTF_8);
    }

    /**
     * A date carried in _source is whatever the indexer wrote: epoch millis for
     * the regulatory documents (Jackson serializes java.util.Date as a number),
     * an ISO string for the trials. Render both as yyyy-MM-dd.
     */
    private static String formatDate(Object value) {
        String text = raw(value);
        if (text.isEmpty()) return "";
        try {
            return new SimpleDateFormat("yyyy-MM-dd").format(new Date(Long.parseLong(text)));
        } catch (NumberFormatException notEpochMillis) {
            return text.length() >= 10 ? text.substring(0, 10) : text;
        }
    }

    private static String formatFileSize(Object value) {
        String text = raw(value);
        if (text.isEmpty()) return "";
        long bytes;
        try {
            bytes = Long.parseLong(text);
        } catch (NumberFormatException e) {
            return "";
        }
        if (bytes < 1024) return bytes + " B";
        if (bytes < 1024 * 1024) return Math.round(bytes / 1024d) + " KB";
        return String.format("%.1f MB", bytes / (1024d * 1024d));
    }
%>
<%
    SearchResponse<Map> sr = (SearchResponse<Map>) request.getAttribute("sr");
    List<Hit<Map>> hits = new ArrayList<>();
    if (sr != null && sr.hits() != null && sr.hits().hits() != null) {
        hits = sr.hits().hits();
    }

    int currentPage = request.getAttribute("currentPage") != null ? (Integer) request.getAttribute("currentPage") : 0;
    int pageSize = request.getAttribute("pageSize") != null ? (Integer) request.getAttribute("pageSize") : 100;
    long totalHits = request.getAttribute("totalHits") != null ? (Long) request.getAttribute("totalHits") : hits.size();
    int totalPages = request.getAttribute("totalPages") != null ? (Integer) request.getAttribute("totalPages") : 1;
    int startRecord = currentPage * pageSize + 1;
    int endRecord = (int) Math.min((currentPage + 1) * pageSize, totalHits);

    String searchTerm = request.getAttribute("searchTerm") != null ? raw(request.getAttribute("searchTerm")) : "";
    String selectedCategory = raw(request.getAttribute("selectedCategory"));
    LinkedHashMap<String, Long> categoryCounts =
            (LinkedHashMap<String, Long>) request.getAttribute("categoryCounts");
    if (categoryCounts == null) {
        categoryCounts = new LinkedHashMap<>();
    }
    long allCategoriesCount = 0;
    for (Long count : categoryCounts.values()) {
        allCategoriesCount += count;
    }
%>
<div class="container-fluid gs-results">
    <div class="jumbotron">
        <div class="header-title-row">
            <h3>SCGE Platform - General Search Results</h3>
            <div class="header-search">
                <%@include file="searchBox.jsp"%>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Left Column: category sidebar -->
        <div class="col-lg-3 col-md-4 col-12">
            <%@include file="categorySidebar.jsp"%>
        </div>

        <!-- Right Column: every result, listed -->
        <div class="col-lg-9 col-md-8 col-12">
            <div class="row results-count-section align-items-center">
                <div class="col-12">
                    <span class="results-count-text">
                    <% if (totalHits > 0) { %>
                        Showing <strong><%=startRecord%>-<%=endRecord%></strong> of <strong><%=totalHits%></strong> results
                    <% } else { %>
                        Showing <strong>0</strong> results
                    <% } %>
                    <% if (!searchTerm.isEmpty()) { %>for &quot;<%=esc(searchTerm)%>&quot;<% } %>
                    <% if (!selectedCategory.isEmpty()) { %>
                        in <strong><%=esc(ClinicalTrialsService.categoryDisplayName(selectedCategory))%></strong>
                    <% } %>
                    </span>
                </div>
            </div>

            <% if (hits.isEmpty()) { %>
                <div class="no-results-message">
                    <h4>No results found</h4>
                </div>
            <% } else { %>
                <%@include file="resultsList.jsp"%>

                <% if (totalPages > 1) { %>
                <nav aria-label="Page navigation" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <li class="page-item <%=currentPage == 0 ? "disabled" : ""%>">
                            <a class="page-link" href="javascript:void(0);" onclick="goToPage(<%=currentPage - 1%>)" aria-label="Previous">
                                <span aria-hidden="true">&laquo; Previous</span>
                            </a>
                        </li>
                        <%
                            int startPage = Math.max(0, currentPage - 2);
                            int endPage = Math.min(totalPages - 1, currentPage + 2);
                            if (startPage > 0) {
                        %>
                            <li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="goToPage(0)">1</a></li>
                            <% if (startPage > 1) { %>
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                            <% } %>
                        <% } %>
                        <% for (int i = startPage; i <= endPage; i++) { %>
                            <li class="page-item <%=i == currentPage ? "active" : ""%>">
                                <a class="page-link" href="javascript:void(0);" onclick="goToPage(<%=i%>)"><%=i + 1%></a>
                            </li>
                        <% } %>
                        <% if (endPage < totalPages - 1) { %>
                            <% if (endPage < totalPages - 2) { %>
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                            <% } %>
                            <li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="goToPage(<%=totalPages - 1%>)"><%=totalPages%></a></li>
                        <% } %>
                        <li class="page-item <%=currentPage >= totalPages - 1 ? "disabled" : ""%>">
                            <a class="page-link" href="javascript:void(0);" onclick="goToPage(<%=currentPage + 1%>)" aria-label="Next">
                                <span aria-hidden="true">Next &raquo;</span>
                            </a>
                        </li>
                    </ul>
                    <div class="text-center text-muted">
                        <small>Page <%=currentPage + 1%> of <%=totalPages%></small>
                    </div>
                </nav>
                <% } %>
            <% } %>
        </div>
    </div>
</div>
<div style="padding-bottom: 1rem;"></div>
<script>
    // Paging keeps the search term, the chosen category and the page size.
    function goToPage(pageNum) {
        if (pageNum < 0 || pageNum >= <%=totalPages%>) return;
        var url = new URL(window.location.href);
        url.searchParams.set('page', pageNum);
        if (!url.searchParams.has('pageSize')) {
            url.searchParams.set('pageSize', '<%=pageSize%>');
        }
        window.location.href = url.pathname + '?' + url.searchParams.toString();
    }
</script>
