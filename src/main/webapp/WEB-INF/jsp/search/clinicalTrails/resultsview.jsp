<%@ page import="java.util.Arrays" %>
<%@ page import="org.elasticsearch.search.SearchHit" %>
<%@ page import="org.elasticsearch.action.search.SearchResponse" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="org.elasticsearch.search.aggregations.Aggregations" %>
<%@ page import="org.elasticsearch.search.aggregations.bucket.terms.Terms" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.stream.Collectors" %><%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 3/26/2024
  Time: 2:59 PM
  To change this template use File | Settings | File Templates.
--%>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<style>
  included, to get the result that you can see in the preview selection

  body{margin-top:20px;
    background:#eee;
  }


  .grid {
    position: relative;
    width: 100%;
    background: #fff;
    /*color: #666666;*/
    border-radius: 2px;
    margin-bottom: 25px;
    box-shadow: 0px 1px 4px rgba(0, 0, 0, 0.1);
  }

  .grid .grid-body {
    padding: 15px 20px 15px 20px;
    font-size: 0.9em;
    /*line-height: 1.9em;*/
  }


  .search table tr:hover {
    cursor: pointer;
  }



  /*.search table tr td img {*/
  /*  width: 50px;*/
  /*  height: 50px;*/
  /*}*/


</style>
<h1>Clinical Trails</h1>
<div class="container-fluid">
  <%
    SearchResponse sr= (SearchResponse) request.getAttribute("sr");
    Terms orgAggregations=sr.getAggregations().get("organization");
    Terms statAggregations=sr.getAggregations().get("status");
    Terms conditionAggregations=sr.getAggregations().get("condition");

    SearchHit[] hitsArray=sr.getHits().getHits();
    List<SearchHit> hits=(Arrays.asList(hitsArray));%>

  <div class="row">
    <!-- BEGIN SEARCH RESULT -->
    <div class="col-md-12">
      <div class="grid search">
        <div class="grid-body">
          <div class="row">
            <!-- BEGIN FILTERS -->
            <div class="col-md-3">
              <h2 class="grid-title"><i class="fa fa-filter"></i> Filters</h2>
              <hr>
              <h4>By STATUS:</h4>


                <%for(Terms.Bucket bkt:statAggregations.getBuckets()){%>
              <div class="checkbox">
                <label><input type="checkbox" class="icheck"> <%=bkt.getKey()%>&nbsp;(<%=bkt.getDocCount()%>)</label>
              </div>
              <%}%>


              <!-- END FILTER BY CATEGORY -->

              <div class="padding"></div><br>
              <!-- BEGIN FILTER BY CATEGORY -->
              <h4>By Sponsor:</h4>
                <div style="height: 300px;overflow-y: auto">
              <%for(Terms.Bucket bkt:orgAggregations.getBuckets()){%>

              <div class="checkbox">
                <label><input type="checkbox" class="icheck"> <%=bkt.getKey()%>&nbsp;(<%=bkt.getDocCount()%>)</label>
              </div>
              <%}%>
                </div>

              <div class="padding"></div><br>
              <!-- BEGIN FILTER BY CATEGORY -->
              <h4>By Condition:</h4>
                <div style="height: 300px;overflow-y: auto">

                <%for(Terms.Bucket bkt:conditionAggregations.getBuckets()){%>
              <div class="checkbox">
                <label><input type="checkbox" class="icheck"> <%=bkt.getKey()%>&nbsp;(<%=bkt.getDocCount()%>)</label>
              </div>
              <%}%>
                </div>
            </div>
            <!-- END FILTERS -->
            <!-- BEGIN RESULT -->
            <div class="col-md-9">
              <h2><i class="fa fa-file-o"></i> Result</h2>
              <hr>
              <p>Showing all  <%=hits.size()%> results matching <strong>Intervention:BIOLOGICAL</strong>&nbsp;|&nbsp;<strong>Condition: Gene Therapy</strong></p>

              <div class="padding"></div>
                <!-- BEGIN TABLE RESULT -->
              <div >
                <table class="table table-hover table-sm">
                  <caption align="top">Clinical Trails -BIOLOGICAL INTERVENTIONS - Summary</caption>
                  <thead>
                  <tr><th>NCTID</th>
                    <%--            <th>Org StudyId</th>--%>
<%--                    <th>Organization</th>--%>
<%--                    <th>briefTitle</th>--%>
                    <th>Intervention</th>
<%--                    <th>Conditions</th>--%>
                    <th>Phases</th>
                    <th>Start_Date</th>
                    <th>Completion</th>
                    <th>Submit_Date</th>
                    <th>Last_Update</th>
                    <th>Status</th>
                    <th>Has Results</th>
                  </tr>
                  </thead>
                  <tbody>
                  <%for(SearchHit hit:hits){
                    Map<String, Object> sourceFields=hit.getSourceAsMap();
                    Map<String, Object> protocolSection= (Map<String, Object>) sourceFields.get("protocolSection");
                    Map<String, Object> identificationModule= (Map<String, Object>) protocolSection.get("identificationModule");
                    Map idMap= (Map) identificationModule.get("orgStudyIdInfo");
                    Map orgMap= (Map) identificationModule.get("organization");

                    Map<String, Object> statusModule= (Map<String, Object>) protocolSection.get("statusModule");
                    Map startDate = (Map) statusModule.get("startDateStruct");
                    Map completionDate= (Map) statusModule.get("completionDateStruct");
                    Map lastUpdatePostDate= (Map) statusModule.get("lastUpdatePostDateStruct");

                    Map expandedAccess= (Map) statusModule.get("expandedAccessInfo");
                    Map<String, Object> conditionsModule= (Map<String, Object>) protocolSection.get("conditionsModule");
                    String conditions=((List<String>)conditionsModule.get("conditions")).stream().collect(Collectors.joining(", "));

                    Map<String, Object> armsInterventionsModule= (Map<String, Object>) protocolSection.get("armsInterventionsModule");
                    List<Map> interventions= (List<Map>) armsInterventionsModule.get("interventions");

                    Map<String, Object> designModule= (Map<String, Object>) protocolSection.get("designModule");
                    List<String> phases= (List<String>) designModule.get("phases");
                    if(phases!=null){
                  %>
                  <tr><td><strong><a href="https://www.clinicaltrials.gov/study/<%=identificationModule.get("nctId")%>"><%=identificationModule.get("nctId")%></a></strong>
                        <%if(expandedAccess!=null && expandedAccess.get("nctId")!=null){%>
                      <br>Expanded Access: <strong><a href="https://www.clinicaltrials.gov/study/<%=expandedAccess.get("nctId")%>"><%=expandedAccess.get("nctId")%></a></strong>
                        <%}%>
                  </td>
                    <%--            <td><%=idMap.get("id")%></td>--%>
<%--                    <td><%=orgMap.get("fullName")%></td>--%>
<%--                    <td><%=identificationModule.get("briefTitle")%></td>--%>
                    <td><%=interventions.get(0).get("description")%></td>
<%--                    <td><%=conditions%></td>--%>
                    <td><%=String.join(", ", phases)%></td>
                    <td><%=startDate.get("date")%></td>

                    <td><% if(completionDate!=null){%>
                      <%=completionDate.get("date")%>
                      <%}%>
                    </td>


                    <td><%=statusModule.get("lastUpdateSubmitDate")%></td>
                    <td><%=lastUpdatePostDate.get("date")%></td>

                    <td><%=statusModule.get("overallStatus")%></td>
                    <td><%=sourceFields.get("hasResults")%></td>
                  </tr>

                  <%}}%>
                  </tbody>
                </table>
              </div>
              <!-- END TABLE RESULT -->

              <!-- BEGIN PAGINATION -->
              <nav aria-label="Page navigation example">
                <ul class="pagination">
                  <li class="page-item"><a class="page-link" href="#">Previous</a></li>
                  <li class="page-item"><a class="page-link" href="#">1</a></li>
                  <li class="page-item"><a class="page-link" href="#">2</a></li>
                  <li class="page-item"><a class="page-link" href="#">3</a></li>
                  <li class="page-item"><a class="page-link" href="#">Next</a></li>
                </ul>
              </nav>
              <!-- END PAGINATION -->
            </div>
            <!-- END RESULT -->
          </div>
        </div>
      </div>
    </div>
    <!-- END SEARCH RESULT -->
  </div>
</div>