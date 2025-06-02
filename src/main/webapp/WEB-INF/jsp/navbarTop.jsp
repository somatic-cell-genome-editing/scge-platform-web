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

<nav class="navbar navbar-expand-lg navbar-dark justify-content-end" style="background-color: rgb(27, 128, 182)">
    <div class="container-fluid justify-content-end">
        <!-- Brand Logo -->

        <!--Toggle Button for Mobile -->
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavTop">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Links -->
        <div class="collapse navbar-collapse justify-content-end" id="navbarNavTop">
            <ul class="navbar-nav mr-auto" >
                <%--        <li class="nav-item collapse-social-icons-dropdown"><a class="nav-link text-light" href=""><i class="fab fa-facebook mr-1"></i></a></li>--%>
                <%--        <li class="nav-item collapse-social-icons-dropdown"><a class="nav-link text-light" href=""><i class="fab fa-instagram mr-1"></i></a></li>--%>
                <li class="nav-item collapse-social-icons-dropdown"><a class="nav-link text-light" href="https://twitter.com/somaticediting" target="_blank"><i class="fa-brands fa-x-twitter"></i></a></li>
                <li class="nav-item collapse-social-icons-dropdown"><a class="nav-link text-light" href="https://www.linkedin.com/company/somatic-cell-genome-editing-consortium/about/" target="_blank"><i class="fab fa-linkedin mr-1"></i></a></li>
                <li class="nav-item collapse-social-icons-dropdown"><a class="nav-link text-light" href="https://www.youtube.com/channel/UCnMSf_YZdv1gIuqPmB6vrYw" target="_blank"><i class="fab fa-youtube mr-1"></i></a></li>

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