<%@ page import="org.elasticsearch.search.SearchHit" %>
<%@ page import="org.elasticsearch.action.search.SearchResponse" %>
<%@ page import="com.google.gson.Gson" %>

<%@ page import="java.util.*" %><%--
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


<%
    Gson gson=new Gson();
    SearchResponse sr= (SearchResponse) request.getAttribute("sr");
    SearchHit[] hitsArray=sr.getHits().getHits();
    List<SearchHit> hits=(Arrays.asList(hitsArray));
    Map<String, List<String>> filterMap= (Map<String, List<String>>) request.getAttribute("filterMap");
    List<String> filtersSelected= (List<String>) request.getAttribute("filtersSelected");
    request.setAttribute("filtersSelected", filtersSelected);

%>

<script>
    var filterMap='<%=gson.toJson(filterMap)%>'
    var json=JSON.parse(filterMap)
</script>
<%--<%--%>
<%--    if(hits.size()==0){%>--%>
<%--        <h4>0 results found for term <%=request.getAttribute("searchTerm")%></h4>--%>
<%--    <%}else{%>--%>

<div style="background-color: whitesmoke;padding: 20px" class="jumbotron page-header">
    <h3 style="color: #1a80b6; font-family: 'Roboto Slab', serif; font-weight: 400;">Clinical Trials - Gene Therapy Trial Browser</h3>
    <p>The Gene Therapy Trial Browser represents a unique publicly accessible, free database for the benefit of users seeking information on gene therapy development. The information within integrates various sources, including clinicaltrials.gov, publications, sponsor press releases, patent applications, and more to give a comprehensive overview of the gene therapy clinical trial landscape.
    </p>
</div>

<div class="container-fluid">

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
<%--              <h4><i class="fa fa-file-o"></i> Result</h4>--%>

<%--              <hr>--%>
    <div class="row">
        <div class="col"> <span>Showing all  <%=hits.size()%> results ...</span></div>
        <br>
        <div class="col-2 d-flex justify-content-end gap-2">
<%--            <div style="width: 40%;">--%>
                <div class="input-group"><button class="btn btn-sm btn-info text-nowrap" data-toggle="modal" data-target="#definitionsModal">Help Doc&nbsp;&nbsp;<i class="fa fa-question-circle" aria-hidden="true" style="color:whitesmoke"></i></button></div>
<%--                </div>--%>
    <% if (request.getServerName().equals("localhost") || request.getServerName().equals("dev.scge.mcw.edu") || request.getServerName().equals("stage.scge.mcw.edu") ) { %>
    <a href="/platform/clinicalTrialEdit/home/" class="btn btn-primary">
        Add
    </a>
    <%}%>

            <%@include file="../../definitions/modal.jsp"%>
            </div>
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

<small><strong>Disclaimer:</strong> The information on this dashboard has been collected for the convenience of patients and researchers. Please discuss with your provider the risks/benefits of participating in a clinical trial.
    The SCGE makes no comment as to the efficacy and safety of the items listed, as these are not known at the time of publication.
    For the most up to date information, please refer to clinicaltrials.gov or the Sponsor's website.

    The information contained within this table does not make use of any confidential or privileged information-all data is collected from publicly available sources.</small>
<%--<%}%>--%>