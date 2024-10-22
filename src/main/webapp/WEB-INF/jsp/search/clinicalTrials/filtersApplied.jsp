<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 10/21/2024
  Time: 1:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%if(filtersSelected!=null && filtersSelected.size()>0){
  boolean first=true;
%>
<strong>Remove Filters:</strong>

<%for(String filter: filtersSelected){
//  List<String> values=filterMap.get(key);

    if(first){first=false;
%>
<%--&nbsp;<span style="color:darkorange; font-weight: bold"><%=filter%></span>--%>
<button class="btn btn-light btn-sm " value="<%=filter%>" onclick="removeFilter('<%=filter.replace("'","\\'")%>')" ><%=filter%>&nbsp;<i class="fa fa-times-circle" style="font-size:15px;color:red" ></i></button>

  <% }else{%>
  <span style="font-weight: bold">&nbsp;|&nbsp;</span><button class="btn btn-light btn-sm " value="<%=filter%>" onclick="removeFilter(encodeURI('<%=filter%>'))" ><%=filter%>&nbsp;<i class="fa fa-times-circle" style="font-size:15px;color:red" ></i></button>

<% }
%>

<%}}%>
