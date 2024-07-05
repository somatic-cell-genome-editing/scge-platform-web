<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 1/5/2024
  Time: 1:00 PM
  To change this template use File | Settings | File Templates.
--%>
<nav class="navbar navbar-expand-lg flex-md-nowrap  shadow" style="background-color: black" >
  <div class="container-fluid">

    <button class="navbar-toggler btn-sm" type="button" data-toggle="collapse" data-target="#navbarResponsiveTop" aria-controls="navbarResponsiveTop" aria-expanded="false" aria-label="Toggle navigation">
      <!--span class="navbar-toggler-icon"></span-->
      <span style="color:white"><i class="fa fa-user" aria-hidden="true"></i></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarResponsiveTop">
      <ul class="navbar-nav ml-auto" style="padding-right: 2%">



        <li class="nav-item text-nowrap my-2 my-sm-0" style="padding-right: 1%">

          <c:choose>
            <c:when test="${userAttributes.get('name')!=null}">
             <a href="/platform/dashboard"> <button class="btn btn-primary btn-sm">My Dashboard</button></a>
              &nbsp;&nbsp;<img class="rounded-circle" src="${userAttributes.get('picture')}" width="24">
              <span class="text-light" >&nbsp;${userAttributes.get('name')}&nbsp;&nbsp;</span>
              <a href="/platform/logout" title="Sign out"><button class="btn btn-primary btn-sm">Logout</button></a>

            </c:when>
            <c:otherwise>
              <a href="/platform/login.jsp" title="Consortium Member Sign In"><button class="btn btn-primary btn-sm">Login</button></a>
            </c:otherwise>
          </c:choose>

        </li>
      </ul>
    </div>
  </div>
</nav>

