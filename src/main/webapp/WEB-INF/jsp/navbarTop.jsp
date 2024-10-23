<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 1/5/2024
  Time: 1:00 PM
  To change this template use File | Settings | File Templates.
--%>
<nav class="navbar navbar-expand-lg flex-md-nowrap  shadow" style="background-color: rgb(27, 128, 182)" >
  <div class="container-fluid">

    <button class="navbar-toggler btn-sm" type="button" data-toggle="collapse" data-target="#navbarResponsiveTop" aria-controls="navbarResponsiveTop" aria-expanded="false" aria-label="Toggle navigation">
      <!--span class="navbar-toggler-icon"></span-->
      <span style="color:white"><i class="fa fa-user" aria-hidden="true"></i></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarResponsiveTop">
<%--        <ul class="navbar-nav mr-auto" >--%>
<%--        <li class="nav-item collapse-social-icons-dropdown"><a class="nav-link text-light" href=""><i class="fab fa-facebook mr-1"></i></a></li>--%>
<%--        <li class="nav-item collapse-social-icons-dropdown"><a class="nav-link text-light" href=""><i class="fab fa-instagram mr-1"></i></a></li>--%>
<%--        <li class="nav-item collapse-social-icons-dropdown"><a class="nav-link text-light" href=""><i class="fa-brands fa-x-twitter"></i></a></li>--%>
<%--        <li class="nav-item collapse-social-icons-dropdown"><a class="nav-link text-light" href=""><i class="fab fa-linkedin mr-1"></i></a></li>--%>
<%--        <li class="nav-item collapse-social-icons-dropdown"><a class="nav-link text-light" href=""><i class="fab fa-youtube mr-1"></i></a></li>--%>
<%--        </ul>--%>
        <ul class="navbar-nav ml-auto" style="padding-right: 2%">






          <c:choose>
            <c:when test="${userAttributes.get('name')!=null}">
          <li class="nav-item text-nowrap" style="padding-right: 2%"><a href="/platform/dashboard"> <button class="btn btn-primary btn-sm">My Dashboard</button></a></li>
          <li class="nav-item"><img class="rounded-circle" src="${userAttributes.get('picture')}" width="40" alt=""></li>
          <li class="nav-item text-nowrap">   <span class="text-light" >&nbsp;${userAttributes.get('name')}&nbsp;&nbsp;</span></li>
                <li class="nav-item" >   <a href="/platform/logout" title="Sign out"><button class="btn btn-light btn-sm">Logout</button></a></li>

            </c:when>
            <c:otherwise>
                <li class="nav-item" >  <a href="/platform/login.jsp" title="Consortium Member Sign In"><button class="btn btn-light btn-sm">Login</button></a></li>
            </c:otherwise>
          </c:choose>


      </ul>
    </div>
  </div>
</nav>

