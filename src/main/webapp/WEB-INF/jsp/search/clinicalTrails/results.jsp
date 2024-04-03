<%@ page import="org.elasticsearch.action.search.SearchResponse" %>
<%@ page import="org.elasticsearch.search.SearchHit" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="com.fasterxml.jackson.core.JsonParser" %>
<%@ page import="java.util.stream.Collectors" %><%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 3/25/2024
  Time: 4:45 PM
  To change this template use File | Settings | File Templates.
--%>

<% Gson gson=new Gson();
    ObjectMapper mapper=new ObjectMapper();
    SearchResponse sr= (SearchResponse) request.getAttribute("sr");
    SearchHit[] hitsArray=sr.getHits().getHits();
    List<SearchHit> hits=(Arrays.asList(hitsArray));%>
<h1>Clinical Trails <%=hits.size()%></h1>
<div class="container-fluid">
    <table class="table table-sm">
        <caption align="top">Clinical Trails -BIOLOGICAL INTERVENTIONS - Summary</caption>
        <thead>
        <tr><th>NCTID</th>
<%--            <th>Org StudyId</th>--%>
            <th>Organization</th><th>briefTitle</th><th>Intervention</th><th>Conditions</th><th>Phases</th>
        <th>Start</th><th>Completion</th><th>Submit Date</th><th>Last Update</th><th>Status</th><th>Has Results</th></tr>
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

        Map<String, Object> conditionsModule= (Map<String, Object>) protocolSection.get("conditionsModule");
        String conditions=((List<String>)conditionsModule.get("conditions")).stream().collect(Collectors.joining(", "));

        Map<String, Object> armsInterventionsModule= (Map<String, Object>) protocolSection.get("armsInterventionsModule");
        List<Map> interventions= (List<Map>) armsInterventionsModule.get("interventions");

        Map<String, Object> designModule= (Map<String, Object>) protocolSection.get("designModule");
        List<String> phases= (List<String>) designModule.get("phases");
        if(phases!=null){
    %>
        <tr><td><%=identificationModule.get("nctId")%></td>
<%--            <td><%=idMap.get("id")%></td>--%>
            <td><%=orgMap.get("fullName")%></td>
            <td><%=identificationModule.get("briefTitle")%></td>
            <td><%=interventions.get(0).get("description")%></td>
            <td><%=conditions%></td>
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