<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html lang="en">
<head>
    <%@include file="/common/googleAnalytics.jsp"%>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>SCGE Platform</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script> <link rel="stylesheet" href="https://cdn.jsdelivr.net/chartist.js/latest/chartist.min.css">
    <script src="https://cdn.jsdelivr.net/chartist.js/latest/chartist.min.js"></script>

    <link href="https://fonts.googleapis.com/css?family=Playfair+Display:700,900" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet" type="text/css"/>
    <link href="/platform/common/css/sticky-footer-navbar.css" rel="stylesheet">
    <script
            src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"
            integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="
            crossorigin="anonymous"></script>
    <link href="/platform/common/tablesorter-master/dist/css/filter.formatter.min.css" rel="stylesheet" type="text/css"/>
    <link href="/platform/common/tablesorter-master/dist/css/theme.jui.min.css" rel="stylesheet" type="text/css"/>
    <link href="/platform/common/tablesorter-master/dist/css/theme.blue.css" rel="stylesheet" type="text/css"/>
    <link href="/platform/common/tablesorter-master/dist/css/theme.default.min.css">

    <script src="/platform/common/tablesorter-master/dist/js/tablesorter.js"> </script>
    <script src="/platform/common/tablesorter-master/dist/js/tablesorter.widgets.js"></script>
    <script src="/platform/common/tablesorter-master/dist/js/widgets/widget-scroller.min.js"></script>
<%--    <script src="/platform/common/tablesorter-master/dist/js/widgets/widget-uitheme.min.js"></script>--%>

    <script src="/platform/js/scge.js"></script>
    <link href="/platform/css/base.css" type="text/css" rel="stylesheet">

</head>

<body>
<%@include file="feedbackForm.jsp"%>
<div style="font-size:12px; color:white; background-color: rgb(27, 128, 182); width:100%;padding-left:15px;padding-top:4px; padding-bottom:2px;">

</div>
<%@include file="navbarTop.jsp"%>
<%@include file="navbar.jsp"%>


<%--<div class="container-fluid">--%>
<%--    <header class="blog-header py-3">--%>
<%--        <div class="row justify-content-between align-items-center">--%>
<%--            <div class="col-8 pt-1 m-auto">--%>
<%--                <!-- Icon -->--%>
<%--                <div class="fadeIn first">--%>

<%--                    <h2 class="navbar-brand"><img src="/platform/images/scge-logo-png-1.png" border="0"  alt="SCGE"/>&nbsp;Somatic Cell Genome Editing Platform</h2>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <div class="col-4 d-flex  align-items-center m-auto">--%>
<%--                <form id="searchForm" class="input-group md-form form-sm form-2 pl-0 d-flex justify-content-center mx-4 mt-2" action="/platform/data/search/results">--%>
<%--                    <div class="input-group md-form form-sm form-2 pl-0">--%>

<%--                        <input class="form-control amber-border" id="commonSearchTerm" name="searchTerm" type="text" placeholder="Search SCGE Platform" aria-label="Search">--%>
<%--                        <div class="input-group-append">--%>
<%--            <span class="input-group-text amber lighten-3" id="basic-text1" onclick="$('#searchForm').submit()"><i class="fas fa-search text-grey"--%>
<%--                                                                                                                   aria-hidden="true"></i></span>--%>
<%--                        </div>--%>


<%--                    </div>--%>
<%--                    <small class="form-text text-dark" style="font-size: 11px;">Examples:&nbsp;<a class="text-dark" style="font-size: 11px;" href="">Epithelium</a>, <a class="text-dark" href="" style="font-size: 11px;" >CRISPR</a>,--%>
<%--                        <a class="text-dark" style="font-size: 11px;" href="" >AAV</a>, <a class="text-dark" style="font-size: 11px;" href="" >Ai9</a>--%>
<%--                    </small>--%>
<%--                </form>--%>


<%--            </div>--%>
<%--        </div>--%>
<%--    </header>--%>
<%--</div>--%>

<div id="main" class="container-fluid">
    <div class="container-fluid">
        <div class="d-flex flex-column flex-md-row align-items-center px-md-4 mb-3 bg-white border-bottom">
            <h5 class="my-0 mr-md-auto font-weight-normal"></h5>
            <nav class="my-2 my-md-0 mr-md-3">
<%--                        <a class="p-2 text-dark" href="/platform">Home</a>--%>
                <%--        <a class="p-2 text-dark" href="#">Features</a>--%>
                <%--        <a class="p-2 text-dark" href="#">About Us</a>--%>
                <a class="p-2 text-dark" href="/platform/home">Home</a>
                <a class="p-2 text-dark" href="/platform/data/search/ClinicalTrial">Gene Therapy Trial Browser</a>
<%--                <a class="p-2 text-dark" href="/platform/data/ind/templates">Templates & Forms</a>--%>
<%--                <a class="p-2 text-dark" href="/platform/data/ind/forms">Guidance</a>--%>

            </nav>
        </div>
    </div>
    <div class="" style=";padding-top: 0">
        <div>
            <div style="margin-top: 0;padding-top:0;margin-bottom:10%">
                <c:if test="${page!=null}">
                    <c:import url="${page}.jsp" />
                </c:if>
            </div>
        </div>
    </div>

</div>

<footer class="footer">
    <div class="container text-center">
        <small><a  onclick="openForm()" href="javascript:void(0)" style="text-decoration: none"><i class="fa fa-phone" aria-hidden="true"></i>Contact Us</a>&nbsp;
            &nbsp;|&nbsp;
            <a href="https://creativecommons.org/licenses/by/4.0/" >License CC BY 4.0</a></small><br>
        <small>Copyright &copy; This website is hosted by the SCGE Platform | Copyright 2024 SCGE | All Rights Reserved</small>
    </div>
</footer>
</body>
</html>
