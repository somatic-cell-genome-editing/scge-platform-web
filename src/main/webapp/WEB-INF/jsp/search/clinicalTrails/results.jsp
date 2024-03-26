<%@ page import="org.elasticsearch.action.search.SearchResponse" %>
<%@ page import="org.elasticsearch.search.SearchHit" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %><%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 3/25/2024
  Time: 4:45 PM
  To change this template use File | Settings | File Templates.
--%>
<h1>Clinical Trails</h1>
<% SearchResponse sr= (SearchResponse) request.getAttribute("sr");
    SearchHit[] hitsArray=sr.getHits().getHits();
    List<SearchHit> hits=(Arrays.asList(hitsArray));

    for(SearchHit hit:hits){
        Map<String, Object> sourceFields=hit.getSourceAsMap();
        for(String key:sourceFields.keySet()){%>
            <p><%=key%></p>
           <%
               if(sourceFields.get(key) instanceof Map){
               Map<String, Object> object= (Map<String, Object>) sourceFields.get(key);
               for(String objectKey:object.keySet()){%>
                <p style="color:red">&nbsp;&nbsp;<%=objectKey%></p>
            <%}}%>

        <%}}%>