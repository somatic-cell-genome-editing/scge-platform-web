<%@ page import="org.elasticsearch.search.SearchHit" %>
<%@ page import="org.elasticsearch.action.search.SearchResponse" %>
<%@ page import="com.google.gson.Gson" %>

<%@ page import="java.util.*" %>
<%@ page import="edu.mcw.scge.services.SCGEContext" %>
<%@ page import="edu.mcw.scge.datamodel.Person" %>
<%@ page import="edu.mcw.scge.configuration.Access" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 3/26/2024
  Time: 2:59 PM
  To change this template use File | Settings | File Templates.
--%>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<link href="/platform/css/resultTable.css" rel="stylesheet" type="text/css"/>
<link href="/platform/css/referencesModal.css" rel="stylesheet" type="text/css"/>
<link href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@400&display=swap" rel="stylesheet">
<script src="/platform/js/scge.js"></script>
<script src="/platform/common/js/jquery.tabletoCSV.js"> </script>
<%
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
<style>
    /* Modern Header Section */
    .jumbotron {
        background: white !important;
        padding: 2rem !important;
        margin-bottom: 1.5rem;
        border: 1px solid #e2e8f0;
        border-radius: 8px;
    }

    .jumbotron h3 {
        color: #003366 !important;
        font-size: 1.8rem;
        font-weight: 700;
        margin-bottom: 1rem;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        padding-bottom: 15px;
        border-bottom: 3px solid #0066cc;
    }

    .jumbotron p {
        color: #495057;
        font-size: 1rem;
        line-height: 1.8;
        margin: 0;
    }

    /* Modern Disclaimer Section */
    .disclaimer-card {
        background: #fff7ed;
        border: 1px solid #fed7aa;
        border-left: 4px solid #f97316;
        border-radius: 8px;
        padding: 1.25rem 1.5rem;
        margin-bottom: 1.5rem;
        position: relative;
    }

    .disclaimer-card::before {
        content: '\26A0';
        position: absolute;
        left: 1rem;
        top: 1.25rem;
        font-size: 1.25rem;
        color: #f97316;
    }

    .disclaimer-card small {
        color: #78350f;
        line-height: 1.6;
        display: block;
        font-size: 0.875rem;
        padding-left: 2rem;
    }

    .disclaimer-card strong {
        color: #9a3412;
        font-weight: 700;
        text-transform: uppercase;
        font-size: 0.8rem;
        letter-spacing: 0.5px;
        display: inline-block;
        margin-bottom: 0.25rem;
    }

    .disclaimer-card b {
        color: #9a3412;
        font-weight: 600;
    }

    .disclaimer-card a {
        color: #1a80b6;
        text-decoration: none;
        font-weight: 600;
        border-bottom: 1px solid #1a80b6;
        transition: color 0.2s;
    }

    .disclaimer-card a:hover {
        color: #0891b2;
        border-bottom-color: #0891b2;
    }

    /* Card Shadows */
    .jumbotron,
    .disclaimer-card {
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
    }

    /* Results Count Section */
    .results-count-section {
        background: white;
        padding: 1rem 1.25rem;
        border-radius: 8px;
        margin-bottom: 1rem;
        border: 1px solid #e2e8f0;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
    }

    .results-count-section span {
        color: #475569;
        font-size: 0.95rem;
        font-weight: 500;
    }

    /* Search Box Styling */
    #searchFormByCategory {
        width: 100%;
    }

    #searchFormByCategory .input-group {
        width: 100%;
    }

    #categorySearchTerm {
        border: 1px solid #cbd5e1;
        border-radius: 6px 0 0 6px;
        font-size: 0.875rem;
        padding: 0.5rem 0.75rem;
        height: auto;
    }

    #categorySearchTerm:focus {
        border-color: #1a80b6;
        box-shadow: 0 0 0 3px rgba(26, 128, 182, 0.1);
    }

    #categorySearchTerm::placeholder {
        color: #94a3b8;
    }

    #basic-text-category {
        background: #1a80b6;
        color: white;
        border: 1px solid #1a80b6;
        border-radius: 0 6px 6px 0;
        padding: 0.5rem 0.75rem;
        transition: all 0.2s;
    }

    #basic-text-category:hover {
        background: #0891b2;
        border-color: #0891b2;
    }

    #basic-text-category i {
        color: white !important;
    }

    /* Export and Help Buttons */
    .action-buttons .btn {
        border-radius: 6px;
        font-weight: 600;
        font-size: 0.875rem;
        padding: 0.5rem 1rem;
        transition: all 0.2s;
        border: none;
        text-transform: none;
    }

    .action-buttons .btn-primary {
        background: #1a80b6;
    }

    .action-buttons .btn-primary:hover {
        background: #0891b2;
        transform: translateY(-1px);
        box-shadow: 0 4px 8px rgba(26, 128, 182, 0.3);
    }

    .action-buttons .btn-info {
        background: #06b6d4;
    }

    .action-buttons .btn-info:hover {
        background: #0891b2;
        transform: translateY(-1px);
        box-shadow: 0 4px 8px rgba(6, 182, 212, 0.3);
    }

    .action-buttons .btn-warning {
        background: #f59e0b;
        color: white;
    }

    .action-buttons .btn-warning:hover {
        background: #d97706;
        transform: translateY(-1px);
        box-shadow: 0 4px 8px rgba(245, 158, 11, 0.3);
    }

    /* No Results Message */
    .no-results-message {
        text-align: center;
        padding: 3rem 2rem;
        background: white;
        border-radius: 8px;
        border: 1px solid #e2e8f0;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
    }

    .no-results-message h4 {
        color: #64748b;
        font-weight: 600;
        font-size: 1.25rem;
        margin: 0;
    }

    /* Grid Body Container */
    .grid-body {
        background: transparent;
    }

    .grid-body .col-md-2 {
        background: white;
        padding: 1.25rem;
        border-radius: 8px;
        border: 1px solid #e2e8f0;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
    }

    .grid-body .col-md-10 {
        padding-left: 1.5rem;
    }

    /* Filter Citation Text */
    #fileCitation {
        font-size: 0.875rem;
        color: #64748b;
        line-height: 1.5;
    }

    /* Spacing Improvements */
    .padding {
        height: 1rem;
    }

    /* Responsive Adjustments */
    @media (max-width: 768px) {
        .jumbotron h3 {
            font-size: 1.5rem;
        }

        .jumbotron p {
            font-size: 0.9rem;
        }

        .results-count-section {
            flex-direction: column;
            gap: 0.5rem;
        }

        .results-count-section .col-lg-3,
        .results-count-section .col-lg-6 {
            margin-bottom: 0.5rem;
        }

        .action-buttons {
            justify-content: center !important;
        }

        .action-buttons .btn {
            font-size: 0.8rem;
            padding: 0.4rem 0.8rem;
        }

        .grid-body .col-md-2 {
            margin-bottom: 1rem;
        }

        .grid-body .col-md-10 {
            padding-left: 15px;
        }

        #categorySearchTerm {
            font-size: 0.8rem;
        }
    }

    /* Print Support */
    @media print {
        .disclaimer-card {
            page-break-inside: avoid;
        }

        .action-buttons,
        #searchFormByCategory {
            display: none;
        }
    }
</style>
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
                                    <a href="/platform/clinicalTrialEdit/home/" ><button type="button" class="btn btn-warning btn-sm">Add</button></a>
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