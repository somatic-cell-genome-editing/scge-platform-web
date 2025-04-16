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
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
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
    <script src="/platform/js/search/autocomplete.js"></script>
</head>

<body>
<%@include file="feedbackForm.jsp"%>

<%@include file="navbarTop.jsp"%>
<%@include file="navbar.jsp"%>



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

<%--<footer class="footer">--%>
<%--    <div class="container text-center">--%>
<%--        <small><a  onclick="openForm()" href="javascript:void(0)" style="text-decoration: none"><i class="fa fa-phone" aria-hidden="true"></i>Contact Us</a>&nbsp;--%>
<%--            &nbsp;|&nbsp;--%>
<%--            <a href="https://creativecommons.org/licenses/by/4.0/" >License CC BY 4.0</a></small><br>--%>
<%--        <small>Copyright &copy; This website is hosted by the SCGE Platform | Copyright 2024 SCGE | All Rights Reserved</small>--%>
<%--    </div>--%>
<%--</footer>--%>
<footer class="text-white pt-4" style="background-color: rgb(27, 128, 182)">
    <div class="container">
        <div class="row">

            <!-- About Us -->
            <div class="col-md-4">
<%--                <h5>About Us</h5>--%>
<%--                <p>Translational Coordination and Dissemination Center (TCDC) is to support the SCGE Consortium and work cooperatively with all initiatives, projects, and members to facilitate the objectives of the entire SCGE Consortium. The Medical College of Wisconsin (MCW) TCDC will create the infrastructure to develop policies, track progress within the consortium, communicate within and beyond the consortium, develop outreach and educational activities to support the process of moving pre-clinical studies through the regulatory process, into clinical trials, and eventually to the patient. To disseminate data and resources developed within the SCGE Consortium, the SCGE Platform will be assembled to store, query, visualize, and analyze the outcomes of the SCGE initiatives. The MCW TCDC team will facilitate the administrative and management activities to support the overall success of the program.</p>--%>
            </div>

            <!-- Quick Links -->
            <div class="col-md-4">
                <h5>Quick Links</h5>
                <ul class="list-unstyled">
                    <li><a href="/platform/home" class="text-white">Home</a></li>
                    <li><a href="https://scge.mcw.edu/phase-2-tcdc/" class="text-white">About TCDC</a></li>
                    <li><a href="https://scge.mcw.edu/contact/" class="text-white">Contact</a></li>
                </ul>
            </div>

            <!-- Social Media -->
            <div class="col-md-4">
                <h5>Follow Us</h5>
                <a class="text-light p-2" href="https://twitter.com/somaticediting" target="_blank" title="twitter"><i class="fa-brands fa-x-twitter"></i></a>

                <a class="text-light p-2" href="https://www.linkedin.com/company/somatic-cell-genome-editing-consortium/about/" target="_blank" title="LinkedIn"><i class="fab fa-linkedin mr-1"></i></a>
                    <a class="text-light p-2" href="https://www.youtube.com/channel/UCnMSf_YZdv1gIuqPmB6vrYw" target="_blank" title="YouTube"><i class="fab fa-youtube mr-1"></i></a>
            </div>

        </div>

        <!-- Copyright -->
        <div class="text-center py-3 mt-3 border-top">
            Copyright &copy; This website is hosted by the SCGE Platform | Copyright 2024 SCGE | All Rights Reserved
        </div>
    </div>
<%--  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">--%>
<%--    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>--%>
<%--    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script> <link rel="stylesheet" href="https://cdn.jsdelivr.net/chartist.js/latest/chartist.min.css">--%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script> <link rel="stylesheet" href="https://cdn.jsdelivr.net/chartist.js/latest/chartist.min.css">

</footer>

</body>
</html>
