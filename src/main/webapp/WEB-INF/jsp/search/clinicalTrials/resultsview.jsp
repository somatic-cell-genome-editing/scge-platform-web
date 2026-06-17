<%@ page import="co.elastic.clients.elasticsearch.core.search.Hit" %>
<%@ page import="co.elastic.clients.elasticsearch.core.SearchResponse" %>
<%@ page import="com.google.gson.Gson" %>

<%@ page import="java.util.*" %>
<%@ page import="edu.mcw.scge.services.SCGEContext" %>
<%@ page import="edu.mcw.scge.datamodel.Person" %>
<%@ page import="edu.mcw.scge.configuration.Access" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="edu.mcw.scge.datamodel.ClinicalTrialFieldChange" %>
<%@ page import="edu.mcw.scge.dao.implementation.ClinicalTrailDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 3/26/2024
  Time: 2:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<link href="/platform/css/resultTable.css" rel="stylesheet" type="text/css"/>
<link href="/platform/css/referencesModal.css" rel="stylesheet" type="text/css"/>
<link href="/platform/css/clinicalTrialsResultsview.css" rel="stylesheet" type="text/css"/>
<link href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@400&display=swap" rel="stylesheet">
<script src="/platform/js/scge.js"></script>
<script src="/platform/common/js/jquery.tabletoCSV.js"> </script>
<%
    ClinicalTrailDAO clinicalTrailDAO=new ClinicalTrailDAO();
    Gson gson=new Gson();
    SearchResponse<Map> sr= (SearchResponse<Map>) request.getAttribute("sr");
    List<Hit<Map>> hits=new ArrayList<>();
    if(sr!=null && sr.hits()!=null && sr.hits().hits()!=null) {
        hits = sr.hits().hits();
    }
    Map<String, List<String>> filterMap= (Map<String, List<String>>) request.getAttribute("filterMap");
    List<String> filtersSelected= (List<String>) request.getAttribute("filtersSelected");
    request.setAttribute("filtersSelected", filtersSelected);

    // Pagination attributes
    int currentPage = request.getAttribute("currentPage") != null ? (Integer) request.getAttribute("currentPage") : 0;
    int pageSize = request.getAttribute("pageSize") != null ? (Integer) request.getAttribute("pageSize") : 100;
    long totalHits = request.getAttribute("totalHits") != null ? (Long) request.getAttribute("totalHits") : hits.size();
    int totalPages = request.getAttribute("totalPages") != null ? (Integer) request.getAttribute("totalPages") : 1;
    int startRecord = currentPage * pageSize + 1;
    int endRecord = (int) Math.min((currentPage + 1) * pageSize, totalHits);

    String category= "";
    String dCategory="";
    String searchTerm="";
    if(request.getAttribute("category")!=null){
        category= (String) request.getAttribute("category");
        dCategory+=" in "+request.getAttribute("category")+"s";
    }
    if(request.getParameter("searchTerm")!=null && !Objects.equals(request.getParameter("searchTerm"), "null")){
        searchTerm+="of \""+request.getParameter("searchTerm")+"\"";
    }
    Access access= new Access();
    Person p = null;
    try {
        p = access.getUser(request.getSession());
    } catch (Exception e) {
        e.printStackTrace();
    }
    // Get digest hits from controller (all updates from past 7 days)
    List<Hit<Map>> digestHitsArray = (List<Hit<Map>>) request.getAttribute("digestHits");
    List<Map<String, Object>> recentUpdates = new ArrayList<>();

    if(digestHitsArray != null) {
        for(Hit<Map> hit : digestHitsArray) {
            recentUpdates.add((Map<String, Object>) hit.source());
        }
    }

    int totalUpdates = recentUpdates.size();
    int divSize=12;
    int digestColSize=0;
    if(totalUpdates>0){
        divSize=9;
        digestColSize=3;
    }
%>
<script>
    var filterMap='<%=gson.toJson(filterMap)%>'
    var json=JSON.parse(filterMap)
</script>
<div class="container-fluid">
    <div class="row main-layout-row">
        <!-- Left Column: Header + Results -->
        <div class="col-lg-<%=divSize%> col-md-12 results-content-col">
            <div class="jumbotron">
                <%
                    if(category!=null && !category.equals("")){%>
                <div class="header-title-row">
                    <h3>Clinical Trials - Gene Therapy Trial Browser</h3>
                    <div class="header-search">
                        <%@include file="../searchByCategory.jsp"%>
                    </div>
                </div>
                <p>The Gene Therapy Trial Browser represents a unique publicly accessible, free database for the benefit of users seeking information on gene therapy development. The information within integrates various sources, including clinicaltrials.gov, publications, sponsor press releases, patent applications, and more to give a comprehensive overview of the gene therapy clinical trial landscape.</p>
                <%}else{%>
                <h3>SCGE Platform - General Search Results</h3>
                <%}%>
            </div>

            <!-- BEGIN SEARCH RESULT -->
            <div class="grid search">
              <div class="grid-body">
                <div class="row">
                  <!-- BEGIN RESULT -->
                  <div class="col-md-12">
                <%
                    int activeFilterCount = 0;
                    if(filtersSelected!=null){
                        for(String f: filtersSelected){ if(!f.equalsIgnoreCase("Active")) activeFilterCount++; }
                    }
                %>
                <div class="row results-count-section align-items-center">
                    <div class="col-lg-6 col-md-6 col-12 mb-2 mb-lg-0">
                        <span class="results-count-text">
                        <% if(totalHits > 0) { %>
                        Showing <strong><%=startRecord%>-<%=endRecord%></strong> of <strong><%=totalHits%></strong> results <%=searchTerm%><%=dCategory%>
                        <% } else { %>
                        Showing <strong>0</strong> results <%=searchTerm%><%=dCategory%>
                        <% } %>
                        </span>
                    </div>
                    <%
                        if(hits.size()>0){
                    %>
                    <div class="col-lg-6 col-md-6 col-12 d-flex justify-content-start action-buttons mb-2 mb-lg-0">
                        <div class="row">

                            <div class="col">
                                <%
                                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
                                    LocalDateTime now = LocalDateTime.now();

                                %>

                                <div id="fileCitation" style="display:none;">SCGE Platform Gene Therapy Clinical Trials downloaded on: <%=dtf.format(now)%>; Please cite the Somatic Cell Genome Editing Consortium Platform when using publicly accessible data in formal presentation or publication.</div>
                                <div class="action-btn-group d-flex flex-wrap" role="group">
                                    <button type="button" class="btn btn-sm btn-outline-primary text-nowrap filters-open-btn" data-toggle="modal" data-target="#filtersModal">
                                        <i class="fa fa-filter"></i> Filters<% if(activeFilterCount>0){ %> <span class="filters-count-badge"><%=activeFilterCount%></span><% } %>
                                    </button>
                                    <button type="button" class="btn btn-sm btn-primary text-nowrap"  onclick="download()">Export to CSV</button>
                                    <button type="button" class="btn btn-info btn-sm text-nowrap" data-toggle="modal" data-target="#definitionsModal">Help Doc&nbsp;&nbsp;<i class="fa fa-question-circle" aria-hidden="true"></i></button>
                                    <%@include file="modal.jsp"%>
                                    <% if (request.getServerName().equals("localhost") || request.getServerName().equals("dev.scge.mcw.edu") || request.getServerName().equals("stage.scge.mcw.edu") ) { %>
                                    <%try {if (p!=null && access.isAdmin(p) && !SCGEContext.isProduction()) {%>
                                    <a href="/platform/clinicalTrialEdit/home" ><button type="button" class="btn btn-warning btn-sm">Add</button></a>
                                    <%}} catch (Exception e) {e.printStackTrace();}}%>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%}%>
                </div>

    <%@include file="filtersApplied.jsp"%>
    <div class="padding"></div>
                <!-- BEGIN TABLE RESULT -->
              <div class="results-fill-wrapper" style="width:100%">
                  <%
                      if(hits.size()==0){%>
                          <div class="no-results-message">
                              <h4>No results found</h4>
                          </div>
                      <%}else{%>
                <!-- View Tabs -->
                <ul class="nav nav-tabs results-view-tabs" id="resultsViewTabs" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" id="table-view-tab" data-toggle="tab" href="#tableView" role="tab" aria-controls="tableView" aria-selected="true">
                            <i class="fa fa-table"></i> Table View
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="list-view-tab" data-toggle="tab" href="#listView" role="tab" aria-controls="listView" aria-selected="false">
                            <i class="fa fa-list"></i> List View
                        </a>
                    </li>
                </ul>
                <div class="tab-content" id="resultsViewTabContent">
                    <!-- Table View Tab -->
                    <div class="tab-pane fade show active" id="tableView" role="tabpanel" aria-labelledby="table-view-tab">
               <%@include file="resultsTable.jsp"%>
                    </div>
                    <!-- List View Tab -->
                    <div class="tab-pane fade" id="listView" role="tabpanel" aria-labelledby="list-view-tab">
                        <%@include file="resultsListView.jsp"%>
                    </div>
                </div>

                <!-- PAGINATION CONTROLS -->
                <% if(totalPages > 1) { %>
                <nav aria-label="Page navigation" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <!-- Previous button -->
                        <li class="page-item <%=currentPage == 0 ? "disabled" : ""%>">
                            <a class="page-link" href="javascript:void(0);" onclick="goToPage(<%=currentPage - 1%>)" aria-label="Previous">
                                <span aria-hidden="true">&laquo; Previous</span>
                            </a>
                        </li>

                        <!-- Page numbers -->
                        <%
                            int startPage = Math.max(0, currentPage - 2);
                            int endPage = Math.min(totalPages - 1, currentPage + 2);

                            if(startPage > 0) {
                        %>
                            <li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="goToPage(0)">1</a></li>
                            <% if(startPage > 1) { %>
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                            <% } %>
                        <% } %>

                        <% for(int i = startPage; i <= endPage; i++) { %>
                            <li class="page-item <%=i == currentPage ? "active" : ""%>">
                                <a class="page-link" href="javascript:void(0);" onclick="goToPage(<%=i%>)"><%=i + 1%></a>
                            </li>
                        <% } %>

                        <% if(endPage < totalPages - 1) { %>
                            <% if(endPage < totalPages - 2) { %>
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                            <% } %>
                            <li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="goToPage(<%=totalPages - 1%>)"><%=totalPages%></a></li>
                        <% } %>

                        <!-- Next button -->
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
                <!-- END PAGINATION CONTROLS -->

                  <%}%>
              </div>

            </div>
            <!-- END RESULT -->
          </div>
        </div>
      </div>
      <!-- END SEARCH RESULT -->
    </div>
    <!-- Right Column: Daily Digest (sidebar alongside jumbotron + results) -->
    <%
        if(totalUpdates>0){
    %>
    <div class="col-lg-<%=digestColSize%> col-md-12 digest-sidebar-col">
        <%@include file="dailyDigest.jsp"%>
    </div>
    <%}%>
  </div>

  <!-- Footer disclaimer (always visible at the bottom of the page) -->
  <div class="disclaimer-card disclaimer-footer">
      <small><strong>Disclaimer:</strong> The information on this dashboard has been collected for the convenience of patients and researchers. <b>The SCGE team are not medical doctors and cannot provide medical advice. Please discuss with your provider the risks/benefits of participating in a clinical trial, and do not send us your personal medical information.</b> The information contained within this table does not make use of any confidential or privileged information-all data is collected from publicly available sources. The SCGE makes no comment as to the efficacy and safety of the items listed, as these are not known at the time of publication. For the most up to date information, or to inquire about enrollment, please refer to <a href="https://clinicaltrials.gov/">clinicaltrials.gov</a> or the Sponsor's website for contact information.</small>
  </div>
</div>

<!-- DISCLAIMER MODAL (auto-opens on page load) -->
<div class="modal fade disclaimer-modal" id="disclaimerModal" tabindex="-1" role="dialog" aria-labelledby="disclaimerModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="disclaimerModalLabel"><i class="fa fa-exclamation-triangle"></i> Disclaimer</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <p><strong>Disclaimer:</strong> The information on this dashboard has been collected for the convenience of patients and researchers. <b>The SCGE team are not medical doctors and cannot provide medical advice. Please discuss with your provider the risks/benefits of participating in a clinical trial, and do not send us your personal medical information.</b> The information contained within this table does not make use of any confidential or privileged information-all data is collected from publicly available sources. The SCGE makes no comment as to the efficacy and safety of the items listed, as these are not known at the time of publication. For the most up to date information, or to inquire about enrollment, please refer to <a href="https://clinicaltrials.gov/">clinicaltrials.gov</a> or the Sponsor's website for contact information.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- END DISCLAIMER MODAL -->

<!-- FILTERS MODAL -->
<div class="modal fade filters-modal" id="filtersModal" tabindex="-1" role="dialog" aria-labelledby="filtersModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-scrollable" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="filtersModalLabel"><i class="fa fa-filter"></i> Filter Results</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <%@include file="facets.jsp"%>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="applyFiltersAndClose()">Done</button>
            </div>
        </div>
    </div>
</div>
<!-- END FILTERS MODAL -->

<div style="padding-bottom: 1rem;"></div>
<script>
    function download(){
        $("#myTable").tableToCSV();
    }

    // Default to List View on smaller screens (Bootstrap lg breakpoint: <992px)
    $(function () {
        if (window.matchMedia("(max-width: 991.98px)").matches) {
            $('#list-view-tab').tab('show');
            // Collapse the daily digest by default on small screens
            $('#dailyDigestSidebar').addClass('is-collapsed');
        }
        // Auto-open the disclaimer popup only if the user hasn't dismissed it
        // already this browser session (pagination reloads the page, so without
        // this guard the popup would re-appear on every page).
        try {
            if (sessionStorage.getItem('ctDisclaimerDismissed') !== '1') {
                $('#disclaimerModal').modal('show');
            }
        } catch (e) {
            $('#disclaimerModal').modal('show');
        }
        $('#disclaimerModal').on('hidden.bs.modal', function () {
            try { sessionStorage.setItem('ctDisclaimerDismissed', '1'); } catch (e) {}
        });
    });

    // Toggle a collapsible section (disclaimer / daily digest)
    function toggleCollapsibleSection(id) {
        var el = document.getElementById(id);
        if (el) { el.classList.toggle('is-collapsed'); }
    }

    // Pagination navigation function
    function goToPage(pageNum) {
        if(pageNum < 0 || pageNum >= <%=totalPages%>) return;

        // Get current URL and parameters
        var url = new URL(window.location.href);
        var params = url.searchParams;

        // Update the page parameter
        params.set('page', pageNum);

        // Preserve pageSize if not default
        if(!params.has('pageSize')) {
            params.set('pageSize', '<%=pageSize%>');
        }

        // Navigate to the new URL
        window.location.href = url.pathname + '?' + params.toString();
    }
</script>