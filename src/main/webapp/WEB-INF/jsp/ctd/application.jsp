<%@ page import="edu.mcw.scge.datamodel.Application" %><%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 7/30/2024
  Time: 9:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Application application1= (Application) request.getAttribute("application");
    boolean readonly= (boolean) request.getAttribute("readonly");
    String docLocationURI="/platform/data/store/files/"+application1.getApplicationId()+"/"+ application1.getSponsorName()+"/" ;
%>
<div class="container">
    <%@include file="adminstrativeInfo.jsp"%>
</div>
<%if(readonly){%>
<%@include file="ctdTable.jsp"%>
<%}%>
