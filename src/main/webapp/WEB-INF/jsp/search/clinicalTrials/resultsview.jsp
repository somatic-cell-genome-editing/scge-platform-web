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

<script>
    var filterMap='<%=gson.toJson(filterMap)%>'
    var json=JSON.parse(filterMap)
</script>
<div style="background-color: whitesmoke;padding: 10px; " class="jumbotron">
<%
    if(category!=null && !category.equals("")){%>
    <h3 style="color: #1a80b6">Clinical Trials - Gene Therapy Trial Browser</h3>
    <p>The Gene Therapy Trial Browser represents a unique publicly accessible, free database for the benefit of users seeking information on gene therapy development. The information within integrates various sources, including clinicaltrials.gov, publications, sponsor press releases, patent applications, and more to give a comprehensive overview of the gene therapy clinical trial landscape.
    </p>

<%}else{%>
    <h3 style="color: #1a80b6;">SCGE Platform - General Search Results</h3>
<%}%>

</div>

<div class="container-fluid">
    <div>
        <small><strong>Disclaimer:</strong> The information on this dashboard has been collected for the convenience of patients and researchers. The information contained within this table does not make use of any confidential or privileged information-all data is collected from publicly available sources. The SCGE team are not medical doctors and cannot provide medical advice. The SCGE makes no comment as to the efficacy and safety of the items listed, as these are not known at the time of publication. Please discuss with your provider the risks/benefits of participating in a clinical trial, and do not send us your personal medical information. For the most up to date information, or to inquire about enrollment, please refer to <a href="https://clinicaltrials.gov/">clinicaltrials.gov</a> or the Sponsor's website for contact information.</small>

    </div>
    <div class="d-flex justify-content-end">
        <%
            if(category!=null && !category.equals("")){%>

        <%@include file="../searchByCategory.jsp"%>
        <%}%>
    </div>
   <br>
  <div class="row">
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
                <div class="row">
                    <div class="col-6"> <span>Showing all  <%=hits.size()%> results ... <%=searchTerm%><%=dCategory%></span></div>
                    <%
                        if(hits.size()>0){
                    %>
                    <div class="col-6 d-flex justify-content-end">
                        <div class="row">

                            <div class="col">
                                <%
                                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
                                    LocalDateTime now = LocalDateTime.now();

                                %>

                                <div id="fileCitation" style="display:none;">SCGE Platform Gene Therapy Clinical Trials downloaded on: <%=dtf.format(now)%>; Please cite the Somatic Cell Genome Editing Consortium Platform when using publicly accessible data in formal presentation or publication.</div>
                                <div class="btn-group" role="group">
                                    <button type="button" class="btn btn-sm btn-primary text-nowrap"  onclick="download()">Export table to (.CSV) file</button>
                                    <button type="button" class="btn btn-info btn-sm text-nowrap" data-toggle="modal" data-target="#definitionsModal">Help Doc&nbsp;&nbsp;<i class="fa fa-question-circle" aria-hidden="true" style="color:whitesmoke"></i></button>
                                    <%@include file="modal.jsp"%>
                                    <% if (request.getServerName().equals("localhost") || request.getServerName().equals("dev.scge.mcw.edu") || request.getServerName().equals("stage.scge.mcw.edu") ) { %>
                                    <%try {if (p!=null && access.isAdmin(p) && !SCGEContext.isProduction()) {%>&nbsp;&nbsp;
                                    <a style="margin-left: 20px" href="/platform/clinicalTrialEdit/home/" ><button type="button" class="btn btn-warning btn-sm">Add</button></a>
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
              <div style="width:100%">
                  <%
                      if(hits.size()==0){%>
                          <h4>0 results found <!--for term <%--=request.getAttribute("searchTerm")--%>--></h4>
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