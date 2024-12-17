<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 7/30/2024
  Time: 9:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
   // Application application1= (Application) request.getAttribute("application");
    boolean readonly= (boolean) request.getAttribute("readonly");
//    int applicationId=application1.getApplicationId();
//    String sponsor=application1.getSponsorName();

%>
<div class="container">
    <%@include file="adminstrativeInfo.jsp"%>

<%if(readonly){%>
<div class="">
    <div class="card">
        <h5 class="card-header">View/Upload Common Technical Document (CTD) requirements</h5>
        <div class="card-body">
            <div class="table-responsive">
                <%@include file="ctdTable.jsp"%>
            </div>
            <%--                            <a href="#" class="btn btn-block btn-light">View all</a>--%>
        </div>
    </div>
</div>

<%}%>
</div>