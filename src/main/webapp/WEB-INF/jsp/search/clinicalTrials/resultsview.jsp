<%@ page import="org.elasticsearch.search.SearchHit" %>
<%@ page import="org.elasticsearch.action.search.SearchResponse" %>
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
    SearchResponse sr= (SearchResponse) request.getAttribute("sr");
    SearchHit[] hitsArray=sr.getHits().getHits();
    List<SearchHit> hits=new ArrayList<>();
    if(hitsArray!=null && hitsArray.length>0) {
        hits = (Arrays.asList(hitsArray));
    }
    Map<String, List<String>> filterMap= (Map<String, List<String>>) request.getAttribute("filterMap");
    List<String> filtersSelected= (List<String>) request.getAttribute("filtersSelected");
    request.setAttribute("filtersSelected", filtersSelected);
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
%>
<script>
    var filterMap='<%=gson.toJson(filterMap)%>'
    var json=JSON.parse(filterMap)
</script>
<div class="jumbotron">
<%
    if(category!=null && !category.equals("")){%>
    <h3>Clinical Trials - Gene Therapy Trial Browser</h3>
    <p>The Gene Therapy Trial Browser represents a unique publicly accessible, free database for the benefit of users seeking information on gene therapy development. The information within integrates various sources, including clinicaltrials.gov, publications, sponsor press releases, patent applications, and more to give a comprehensive overview of the gene therapy clinical trial landscape.
    </p>

<%}else{%>
    <h3>SCGE Platform - General Search Results</h3>
<%}%>

</div>

<div class="container-fluid">
    <div class="disclaimer-card">
        <small><strong>Disclaimer:</strong> The information on this dashboard has been collected for the convenience of patients and researchers. <b>The SCGE team are not medical doctors and cannot provide medical advice. Please discuss with your provider the risks/benefits of participating in a clinical trial, and do not send us your personal medical information.</b> The information contained within this table does not make use of any confidential or privileged information-all data is collected from publicly available sources. The SCGE makes no comment as to the efficacy and safety of the items listed, as these are not known at the time of publication. For the most up to date information, or to inquire about enrollment, please refer to <a href="https://clinicaltrials.gov/">clinicaltrials.gov</a> or the Sponsor's website for contact information.</small>

    </div>

    <!-- Clinical Trials Daily Digest Section -->
    <%
        // Get trials updated in the last 7 days with recordStatus = 'Active'
        java.time.LocalDate today = java.time.LocalDate.now();
        java.time.LocalDate sevenDaysAgo = today.minusDays(7);
        java.time.format.DateTimeFormatter dateFormatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd");

        List<Map<String, Object>> recentUpdates = new ArrayList<>();
        for(SearchHit hit : hits) {
            Map<String, Object> source = hit.getSourceAsMap();

//            // Filter for Active record status only
//            String recordStatus = source.get("recordStatus") != null ? source.get("recordStatus").toString() : "";
//            if(!"Active".equalsIgnoreCase(recordStatus)) {
//                continue;
//            }

            String lastUpdate = source.get("recordModifiedDate") != null ? source.get("recordModifiedDate").toString() : null;
            if(lastUpdate != null && !lastUpdate.isEmpty()) {
                try {
                    java.time.LocalDate updateDate = java.time.LocalDate.parse(lastUpdate, dateFormatter);
                    if(!updateDate.isBefore(sevenDaysAgo)) {
                        recentUpdates.add(source);
                    }
                } catch(Exception e) {
                    // Skip entries with invalid date format
                }
            }
        }
        // Sort by date descending and limit to 5
        recentUpdates.sort((a, b) -> {
            String dateA = a.get("recordModifiedDate") != null ? a.get("recordModifiedDate").toString() : "";
            String dateB = b.get("recordModifiedDate") != null ? b.get("recordModifiedDate").toString() : "";
            return dateB.compareTo(dateA);
        });
        int maxDigestItems = Math.min(5, recentUpdates.size());
    %>
    <% if(maxDigestItems > 0) { %>
    <div class="daily-digest-card">
        <div class="digest-header" onclick="toggleDigest()" style="cursor: pointer;">
            <i class="fa fa-newspaper-o"></i>
            <h4>Clinical Trials Daily Digest</h4>
            <span class="digest-badge"><%=maxDigestItems%> Recent Update<%=maxDigestItems > 1 ? "s" : ""%></span>
            <span class="digest-toggle"><i id="digestToggleIcon" class="fa fa-chevron-down"></i></span>
        </div>
        <div id="digestContent" class="digest-collapsible collapsed">
        <p class="digest-subtitle">Clinical trials with updates in the last 7 days</p>
        <div class="digest-items">
            <%
                for(int i = 0; i < maxDigestItems; i++) {
                Map<String, Object> item = recentUpdates.get(i);
                String nctId = item.get("nctId") != null ? item.get("nctId").toString() : "";
                String indication = item.get("indication") != null ? item.get("indication").toString() : "N/A";
                String sponsor = item.get("sponsor") != null ? item.get("sponsor").toString() : "N/A";
                String updateDate = item.get("recordModifiedDate") != null ? item.get("recordModifiedDate").toString() : "";
                String recentUpdateNote = item.get("recentUpdates") != null ? item.get("recentUpdates").toString() : "";
                List<String> statusList = item.get("status") != null ? (List<String>) item.get("status") : new ArrayList<>();
                String status = statusList.size() > 0 ? statusList.get(0) : "N/A";
                    List<ClinicalTrialFieldChange> updatedFields=null;
                    try {
                        updatedFields=clinicalTrailDAO.getFieldChangesByNctId(nctId);

                    } catch (Exception e) {
                        throw new RuntimeException(e);
                    }

            %>
            <div class="digest-item">
                <div class="digest-item-header">
                    <a href="/platform/data/report/clinicalTrials/<%=nctId%>" target="_blank" class="digest-nct-link"><%=nctId%></a>
                    <span class="digest-date"><i class="fa fa-calendar"></i> <%=updateDate%></span>
                </div>
                <div class="digest-item-body">
                    <div class="digest-indication" title="<%=indication%>"><%=indication.length() > 80 ? indication.substring(0, 80) + "..." : indication%></div>
                    <div class="digest-meta">
                        <span class="digest-sponsor"><i class="fa fa-building"></i> <%=sponsor%></span>
                        <span class="digest-status status-<%=status.toLowerCase().replace(" ", "-")%>"><%=status%></span>
                        <%
                            if(updatedFields!=null && updatedFields.size()>0){%>
                        <span class="digest-sponsor"><i class="fa fa-building"></i> Updates:</span>
                        <% boolean first=true;
                            for(ClinicalTrialFieldChange update:updatedFields){
                            if(!update.getFieldName().equalsIgnoreCase("last_update_post_date")){
                                if(first){
                                    first=false;
                        %>
                        <%=update.getFieldName()%> from "<%=update.getOldValue()%>" -> "<%=update.getNewValue()%>"<small class="text-muted">(By <%=update.getUpdateBy()%>)</small>
                        <%}else{%>
                       | <%=update.getFieldName()%> from <%=update.getOldValue()%> -> <%=update.getNewValue()%><small class="text-muted">(By <%=update.getUpdateBy()%>)</small>
                        <%}}}}%>
                    </div>
                    <% if(recentUpdateNote != null && !recentUpdateNote.isEmpty() && !recentUpdateNote.equals("null")) { %>
                    <div class="digest-update-note"><i class="fa fa-info-circle"></i> <%=recentUpdateNote.length() > 150 ? recentUpdateNote.substring(0, 150) + "..." : recentUpdateNote%></div>
                    <% } %>
                </div>
            </div>
            <% } %>
        </div>
        <% if(recentUpdates.size() > 5) { %>
        <div class="digest-footer">
            <span class="digest-more-info"><i class="fa fa-info-circle"></i> <%=recentUpdates.size() - 5%> more trial(s) updated recently. Use filters or search to find them.</span>
        </div>
        <% } %>
        </div><!-- end digestContent -->
    </div>
    <script>
        function toggleDigest() {
            var content = document.getElementById('digestContent');
            var icon = document.getElementById('digestToggleIcon');
            if (content.classList.contains('collapsed')) {
                content.classList.remove('collapsed');
                icon.classList.remove('fa-chevron-down');
                icon.classList.add('fa-chevron-up');
            } else {
                content.classList.add('collapsed');
                icon.classList.remove('fa-chevron-up');
                icon.classList.add('fa-chevron-down');
            }
        }
    </script>
    <% } %>

  <div class="row" style="margin-top: 1.5rem;">
    <!-- BEGIN SEARCH RESULT -->
    <div class="col-md-12">
      <div class="grid search">
        <div class="grid-body">
          <div class="row">
            <!-- BEGIN FILTERS -->

            <div class="col-md-2">

                <%@include file="facets.jsp"%>

            </div>

            <!-- END FILTERS -->
            <!-- BEGIN RESULT -->
            <div class="col-md-10">
                <div class="row results-count-section align-items-center">
                    <div class="col-lg-3 col-md-6 col-12 mb-2 mb-lg-0"> <span>Showing all  <strong><%=hits.size()%></strong> results <%=searchTerm%><%=dCategory%></span></div>
                    <%
                        if(hits.size()>0){
                    %>
                    <div class="col-lg-6 col-md-6 col-12 d-flex justify-content-end action-buttons mb-2 mb-lg-0">
                        <div class="row">

                            <div class="col">
                                <%
                                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
                                    LocalDateTime now = LocalDateTime.now();

                                %>

                                <div id="fileCitation" style="display:none;">SCGE Platform Gene Therapy Clinical Trials downloaded on: <%=dtf.format(now)%>; Please cite the Somatic Cell Genome Editing Consortium Platform when using publicly accessible data in formal presentation or publication.</div>
                                <div class="btn-group" role="group">
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
                    <div class="col-lg-3 col-md-12 mb-2 mb-lg-0">
                        <%
                            if(category!=null && !category.equals("")){%>
                        <%@include file="../searchByCategory.jsp"%>
                        <%}%>
                    </div>
                </div>

    <%@include file="filtersApplied.jsp"%>
    <div class="padding"></div>
                <!-- BEGIN TABLE RESULT -->
              <div style="width:100%">
                  <%
                      if(hits.size()==0){%>
                          <div class="no-results-message">
                              <h4>No results found</h4>
                          </div>
                      <%}else{%>
               <%@include file="resultsTable.jsp"%>
                  <%}%>
              </div>

            </div>
            <!-- END RESULT -->
          </div>
        </div>
      </div>
    </div>
    <!-- END SEARCH RESULT -->
  </div>
</div>
<div style="padding-top:2%;padding-bottom:  5%">
</div>
<script>
    function download(){
        $("#myTable").tableToCSV();
    }
</script>