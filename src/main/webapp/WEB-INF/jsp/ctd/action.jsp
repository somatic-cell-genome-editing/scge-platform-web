<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 7/29/2024
  Time: 9:44 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container">
<div class="row" style="width: 100%">
    <div class="col-12 col-md-4">
        <form>
            <button class="btn btn-primary btn-sm responsive " type="submit">View </button>
        </form>
    </div>
    <div class="col-12 col-md-5">
<%--        <form action="/platform/data/ind/upload">--%>
        <button class="btn btn-success btn-sm responsive"  id="btn<%=sectionCode.trim()%>" data-toggle="modal" data-target="#upload<%=sectionCode.trim()%>" >Upload </button>

    </div>
    <div class="col-12 col-md-3">
        <form>
            <button class="btn btn-warning btn-sm responsive " type="submit" >Sample</button>
        </form>
    </div>

</div>
    <div class="modal" id="upload<%=sectionCode.trim()%>" tabindex="-1">
        <%@include file="uploadForm.jsp"%>
    </div>

</div>
