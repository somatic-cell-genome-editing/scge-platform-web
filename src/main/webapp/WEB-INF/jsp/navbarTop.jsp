<%@ page import="org.springframework.security.core.userdetails.memory.UserAttribute" %>
<%@ page import="java.util.Map" %>
<%@ page import="edu.mcw.scge.configuration.UserService" %>
<%@ page import="edu.mcw.scge.configuration.Access" %>
<%@ page import="org.checkerframework.checker.units.qual.A" %>
<%@ page import="org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken" %>
<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 1/5/2024
  Time: 1:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%
    Map userAttributes = (Map) request.getSession().getAttribute("userAttributes");;

%>

<style>
    /* Top Navbar Styling */
    .navbar-top {
        background: linear-gradient(135deg, rgb(27, 128, 182) 0%, rgb(20, 100, 150) 100%) !important;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        padding: 8px 0;
    }

    .navbar-top .nav-link {
        color: rgba(255, 255, 255, 0.95) !important;
        transition: color 0.3s ease, transform 0.2s ease;
        font-size: 0.9rem;
        padding: 6px 12px;
    }

    .navbar-top .nav-link:hover {
        color: #ffffff !important;
        transform: translateY(-1px);
    }

    /* Social Media Icons in Top Navbar - Match Home Page Style */
    .navbar-top .collapse-social-icons-dropdown {
        padding: 0 5px;
    }

    .navbar-top .collapse-social-icons-dropdown .nav-link {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 35px;
        height: 35px;
        border-radius: 50%;
        background: rgba(248, 249, 250, 0.2);
        color: #ffffff;
        transition: all 0.3s ease;
        font-size: 1rem;
        padding: 0;
    }

    .navbar-top .collapse-social-icons-dropdown .nav-link:hover {
        background: #0066cc;
        color: #ffffff;
        transform: translateY(-3px);
        box-shadow: 0 4px 8px rgba(0, 102, 204, 0.4);
    }

    .navbar-top .btn-warning {
        background-color: #ffc107;
        border: none;
        font-weight: 600;
        transition: all 0.3s ease;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    }

    .navbar-top .btn-warning:hover {
        background-color: #ffb300;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
    }

    .navbar-top .btn-light {
        background-color: #ffffff;
        color: rgb(27, 128, 182);
        border: none;
        font-weight: 600;
        transition: all 0.3s ease;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    }

    .navbar-top .btn-light:hover {
        background-color: #f8f9fa;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
    }

    .navbar-top .rounded-circle {
        border: 2px solid #ffffff;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        transition: transform 0.3s ease;
    }

    .navbar-top .rounded-circle:hover {
        transform: scale(1.1);
    }

    /* Responsive adjustments */
    @media (max-width: 991px) {
        .navbar-top {
            padding: 12px 0;
        }

        .navbar-top .nav-link {
            padding: 8px 12px;
        }
    }
</style>

<nav class="navbar navbar-expand-lg navbar-dark justify-content-end navbar-top" style="background-color: rgb(27, 128, 182)">
    <div class="container-fluid justify-content-end">
        <!-- Brand Logo -->

        <!--Toggle Button for Mobile -->
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavTop">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Links -->
        <div class="collapse navbar-collapse justify-content-end" id="navbarNavTop">
            <ul class="navbar-nav mr-auto" >
                <%--        <li class="nav-item collapse-social-icons-dropdown"><a class="nav-link" href=""><i class="fab fa-facebook"></i></a></li>--%>
                <%--        <li class="nav-item collapse-social-icons-dropdown"><a class="nav-link" href=""><i class="fab fa-instagram"></i></a></li>--%>
                <li class="nav-item collapse-social-icons-dropdown"><a class="nav-link" href="https://twitter.com/somaticediting" target="_blank" title="Twitter"><i class="fa-brands fa-x-twitter"></i></a></li>
                <li class="nav-item collapse-social-icons-dropdown"><a class="nav-link" href="https://www.linkedin.com/company/somatic-cell-genome-editing-consortium/about/" target="_blank" title="LinkedIn"><i class="fab fa-linkedin"></i></a></li>
                <li class="nav-item collapse-social-icons-dropdown"><a class="nav-link" href="https://www.youtube.com/channel/UCnMSf_YZdv1gIuqPmB6vrYw" target="_blank" title="YouTube"><i class="fab fa-youtube"></i></a></li>

            </ul>
            <ul class="navbar-nav ml-auto justify-content-end">
                <li class="nav-item text-nowrap"><a class="nav-link" href="https://scge.mcw.edu">SCGE Consortium Home</a></li>
                <li class="nav-item text-nowrap"><a class="nav-link" href="https://scge.mcw.edu/phase-2-tcdc/">About SCGE TCDC</a></li>
                <li class="nav-item text-nowrap"><a class="nav-link" href="https://scge.mcw.edu/contact/">Contact Us</a></li>
                <li class="nav-item text-nowrap"><a class="nav-link" href="https://creativecommons.org/licenses/by/4.0/">License</a></li>

                <li class="nav-item">&nbsp;</li>
                <li class="nav-item text-nowrap">
                    <% if (request.getServerName().equals("localhost") || request.getServerName().equals("dev.scge.mcw.edu") || request.getServerName().equals("stage.scge.mcw.edu") )
                    {if(userAttributes!=null && userAttributes.get("name")!=null){%>
                
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item text-nowrap" style="padding-right: 2%"><a href="/platform/dashboard"> <button class="btn btn-sm btn-warning">My Dashboard</button></a></li>
                        <li class="nav-item"><img class="rounded-circle " width="40" height="40" src='<%=userAttributes.get("picture")%>' alt=""></li>
                        <li class="nav-item text-nowrap text-light"  style="padding-right: 2%"><%=userAttributes.get("name")%></li>
                        <li class="nav-item" ><a href="/platform/logout" title="Sign out"><button class="btn btn-light btn-sm"><i class="fa fa-sign-out" aria-hidden="true"></i>&nbsp;Logout</button></a></li>
                    </ul>
                       <% }else{%>
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item"><a href="/platform/login.jsp" title="Consortium Member Sign In"><button class="btn btn-light btn-sm" >Login</button></a></li>
                    </ul>
                       <%}%>

                    <%}%>
                </li>
            </ul>
        </div>
    </div>
</nav>