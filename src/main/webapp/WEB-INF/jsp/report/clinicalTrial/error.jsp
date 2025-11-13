<%--
  Created by IntelliJ IDEA.
  User: akundurthi
  Date: 10/10/2024
  Time: 9:27 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="/platform/css/ctReportError.css" rel="stylesheet">
<div class="error-container">
    <h1>Oops! Something Went Wrong.</h1>
    <p>
        <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "An unexpected error has occurred. Please try again later." %>
    </p>
</div>

