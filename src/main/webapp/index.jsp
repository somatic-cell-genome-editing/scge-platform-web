<%--<%@ page import="edu.mcw.scge.configuration.SecurityConfiguration" %>--%>
<%--<%--%>
<%--    if (SecurityConfiguration.REQUIRE_AUTHENTICATION) {--%>
<%--%>--%>
<%--    <jsp:include page="login.jsp" />--%>
<%--<%--%>
<%--    }else {--%>
<%--%>--%>
<%--<% request.setAttribute("page", "WEB-INF/jsp/home");%>--%>
<%--<%response.sendRedirect("home");%>--%>
<%--<% } %>--%>
<%@include file="WEB-INF/jsp/header.jsp"%>

<!-- Site Outage Message Banner -->
<%
    if(SCGEContext.isProduction()){%>
        <%@include file="WEB-INF/jsp/disclaimer.jsp"%>
    <%}%>
<%@include file="WEB-INF/jsp/home.jsp"%>
<%@include file="WEB-INF/jsp/footer.jsp"%>
