<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 6/2/2025
  Time: 10:19 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <%@include file="/common/googleAnalytics.jsp"%>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <%
        String title="";
        if(request.getAttribute("title")!=null){
            title+=" - " +request.getAttribute("title");
        }

    %>
    <title>SCGE Platform <%=title%></title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <%--    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script> <link rel="stylesheet" href="https://cdn.jsdelivr.net/chartist.js/latest/chartist.min.css">--%>
    <script src="https://cdn.jsdelivr.net/chartist.js/latest/chartist.min.js"></script>

    <link href="https://fonts.googleapis.com/css?family=Playfair+Display:700,900" rel="stylesheet">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet" type="text/css"/>
    <link href="/platform/common/css/sticky-footer-navbar.css" rel="stylesheet">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <link href="/platform/common/tablesorter-master/dist/css/filter.formatter.min.css" rel="stylesheet" type="text/css"/>
    <link href="/platform/common/tablesorter-master/dist/css/theme.jui.min.css" rel="stylesheet" type="text/css"/>
    <link href="/platform/common/tablesorter-master/dist/css/theme.blue.css" rel="stylesheet" type="text/css"/>
    <link href="/platform/common/tablesorter-master/dist/css/theme.default.min.css">

    <script src="/platform/common/tablesorter-master/dist/js/tablesorter.js"> </script>
    <script src="/platform/common/tablesorter-master/dist/js/tablesorter.widgets.js"></script>
    <script src="/platform/common/tablesorter-master/dist/js/widgets/widget-scroller.min.js"></script>
    <%--    <script src="/platform/common/tablesorter-master/dist/js/widgets/widget-uitheme.min.js"></script>--%>


    <link href="/platform/css/base.css" type="text/css" rel="stylesheet">
    <script src="/platform/js/search/autocomplete.js"></script>
</head>

<body>
<%@include file="feedbackForm.jsp"%>

<%@include file="navbarTop.jsp"%>
<%@include file="navbar.jsp"%>

<%@include file="cookieNotice.jsp"%>

<!-- Site Outage Message Banner -->
<%--    <%--%>
<%--    if(SCGEContext.isProduction()){--%>
<%--%>--%>
<%--<%@include file="outage.jsp"%>--%>
<%--<%}%>--%>