<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 7/29/2024
  Time: 9:44 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container">
    <div class="btn-group" role="group" aria-label="Basic example">

        <button class="btn btn-primary btn-sm responsive " type="submit">Template <i class="fas fa-file-download"></i></button>
        <button class="btn btn-success btn-sm responsive"  id="btn<%=sectionCode.trim()%>" data-toggle="modal" data-target="#upload<%=sectionCode.trim()%>" >Upload <i class="fa-solid fa-upload"></i></button>
        <button class="btn btn-warning btn-sm responsive " type="submit" >Sample</button>

    </div>


    <div class="modal" id="upload<%=sectionCode.trim()%>" tabindex="-1">
        <%@include file="uploadForm.jsp"%>
    </div>

</div>
