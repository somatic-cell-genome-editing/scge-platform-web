<%@ page import="edu.mcw.scge.datamodel.Person" %>
<%@ page import="edu.mcw.scge.configuration.Access" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
<%--    <link rel="icon" href="/docs/4.0/assets/img/favicons/favicon.ico">--%>

    <title>SCGE Platform</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.0/examples/blog/">

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Custom styles for this template -->
    <link href="https://fonts.googleapis.com/css?family=Playfair+Display:700,900" rel="stylesheet">
<%--    <link href="blog.css" rel="stylesheet">--%>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" rel="stylesheet" type="text/css"/>
    <link href="/platform/common/css/sticky-footer-navbar.css" rel="stylesheet">

</head>

<body>
<%
    Access access = new Access();
    Person person = access.getUser(request.getSession());
%>
<div style="font-size:12px; color:white; background-color: black; width:100%;padding-left:15px;padding-top:4px; padding-bottom:2px;">
    <div style="text-align:right; color:white;padding-right:12px;">
        <a href="https://scge.mcw.edu" style="color:white;">SCGE Consortium Home</a>&nbsp;&nbsp;
        |&nbsp;&nbsp;<a style="color:white;" href="">About SCGE Platform</a>&nbsp;&nbsp;
        |&nbsp;&nbsp;<a style="color:white;" onclick="openForm()" href="javascript:void(0)">Contact Us</a>&nbsp;&nbsp;
        |&nbsp;&nbsp;<a style="color:white;" href="">Citing the SCGE Platform</a>&nbsp;&nbsp;
        |&nbsp;&nbsp;<a style="color:white;" href="https://creativecommons.org/licenses/by/4.0/">License</a>&nbsp;&nbsp;
    </div>
</div>
<%@include file="navbarTop.jsp"%>

<%--<nav class="navbar navbar-expand-lg navbar-light  rounded" style="background-color: #e3f2fd; text-align: right">--%>
<%--&lt;%&ndash;    <a class="navbar-brand" href="#">Navbar</a>&ndash;%&gt;--%>
<%--    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample09" aria-controls="navbarsExample09" aria-expanded="false" aria-label="Toggle navigation">--%>
<%--        <span class="navbar-toggler-icon"></span>--%>
<%--    </button>--%>

<%--    <div class="collapse navbar-collapse" id="navbarsExample09">--%>
<%--        <ul class="navbar-nav mr-auto">--%>
<%--            <li class="nav-item active">--%>
<%--                <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>--%>
<%--            </li>--%>
<%--            <li class="nav-item">--%>
<%--                <a class="nav-link" href="#">Link</a>--%>
<%--            </li>--%>
<%--            <li class="nav-item">--%>
<%--                <a class="nav-link disabled" href="#">Disabled</a>--%>
<%--            </li>--%>
<%--            <li class="nav-item dropdown">--%>
<%--                <a class="nav-link dropdown-toggle" href="http://example.com" id="dropdown09" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Dropdown</a>--%>
<%--                <div class="dropdown-menu" aria-labelledby="dropdown09">--%>
<%--                    <a class="dropdown-item" href="#">Action</a>--%>
<%--                    <a class="dropdown-item" href="#">Another action</a>--%>
<%--                    <a class="dropdown-item" href="#">Something else here</a>--%>
<%--                </div>--%>
<%--            </li>--%>
<%--        </ul>--%>

<%--    <a class="btn btn-sm btn-outline-secondary" href="#">Login</a>--%>

<%--    </div>--%>
<%--</nav>--%>
<div class="container">
    <header class="blog-header py-3">
        <div class="row justify-content-between align-items-center">
            <div class="col-8 pt-1 m-auto">
                <!-- Icon -->
                <div class="fadeIn first">

                    <h2 class="navbar-brand"><img src="/platform/images/scge-logo-png-1.png" border="0" width="100" height="100" alt="SCGE"/>Somatic Cell Genome Editing Platform</h2>
                </div>
            </div>

            <div class="col-4 d-flex  align-items-center m-auto">
                <form id="searchForm" class="input-group md-form form-sm form-2 pl-0 d-flex justify-content-center mx-4 mt-2" action="/platform/data/search/results">
                    <div class="input-group md-form form-sm form-2 pl-0">

                        <input class="form-control amber-border" id="commonSearchTerm" name="searchTerm" type="text" placeholder="Search SCGE Toolkit" aria-label="Search">
                        <div class="input-group-append">
            <span class="input-group-text amber lighten-3" id="basic-text1" onclick="$('#searchForm').submit()"><i class="fas fa-search text-grey"
                                                                                                                   aria-hidden="true"></i></span>
                        </div>


                    </div>
                    <small class="form-text text-dark" style="font-size: 11px;">Examples:&nbsp;<a class="text-dark" style="font-size: 11px;" href="/platform/data/search/results?searchTerm=Epithelium">Epithelium</a>, <a class="text-dark" href="/platform/data/search/results?searchTerm=CRISPR" style="font-size: 11px;" >CRISPR</a>,
                        <a class="text-dark" style="font-size: 11px;" href="/platform/data/search/results?searchTerm=AAV" >AAV</a>, <a class="text-dark" style="font-size: 11px;" href="/platform/data/search/results?searchTerm=Ai9" >Ai9</a>
                    </small>
                </form>


            </div>
        </div>
    </header>
</div>
<div class="container">
<div class="d-flex flex-column flex-md-row align-items-center px-md-4 mb-3 bg-white border-bottom box-shadow">
    <h5 class="my-0 mr-md-auto font-weight-normal"></h5>
    <nav class="my-2 my-md-0 mr-md-3">
        <a class="p-2 text-dark" href="/platform">Home</a>
        <a class="p-2 text-dark" href="#">Features</a>
        <a class="p-2 text-dark" href="#">About Us</a>
        <a class="p-2 text-dark" href="#">Forms</a>
    </nav>
</div>
</div>
<div id="main" class="container">
    <div class="" style="margin-top: 0;padding-top: 0">
        <div class="container-fluid">

            <c:if test="${projectDescription!=null}">
                <hr>
            </c:if>

            <div style="margin-top: 0;padding-top:0">

                <c:if test="${page!=null}">

                    <c:import url="${page}.jsp" />
                </c:if>
            </div>
        </div>
    </div>

</div>


<%--<footer class="blog-footer">--%>
<%--    <p>--%>
<%--        <a href="#">Back to top</a>--%>
<%--    </p>--%>
<%--</footer>--%>
<footer class="footer">
    <div class="container text-center">
        <small><a  onclick="openForm()" href="javascript:void(0)" style="text-decoration: none"><i class="fa fa-phone" aria-hidden="true"></i>Contact Us</a>&nbsp;
            &nbsp;|&nbsp;
            <a href="https://creativecommons.org/licenses/by/4.0/" >License CC BY 4.0</a></small><br>
        <small>Copyright &copy; This website is hosted by the SCGE Platform | Copyright 2024 SCGE | All Rights Reserved</small>
    </div>
</footer>
<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script src="../../assets/js/vendor/holder.min.js"></script>
<script>
    Holder.addTheme('thumb', {
        bg: '#55595c',
        fg: '#eceeef',
        text: 'Thumbnail'
    });
</script>
</body>
</html>
