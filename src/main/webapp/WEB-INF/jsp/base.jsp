<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%@include file="header.jsp"%>

<!-- Site Outage Message Banner -->
<%
    if(SCGEContext.isProduction()){%>
<%@include file="disclaimer.jsp"%>
<%}%>

<div  id="main" class="container-fluid" style="padding-top: 0;">
    <div class="container-fluid" style=";padding-top: 0;margin-top: 10px">
        <div>
            <div style="margin-top: 0;padding-top:0;">

                <c:if test="${page!=null}">
                    <c:import url="${page}.jsp" />
                </c:if>
            </div>
        </div>
    </div>

</div>
<%@include file="footer.jsp"%>


