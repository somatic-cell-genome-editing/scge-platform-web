<%--
  Created by IntelliJ IDEA.
  User: akundurthi
  Date: 10/10/2024
  Time: 9:27 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Error - Clinical Trial Report</title>
    <style>
        .error-container {
            background-color: #f5c6cb;
            border: 1px solid #f1b0b7;
            padding: 30px;
            border-radius: 5px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .error-container h1 {
            margin-top: 0;
            font-size: 24px;
        }

        .error-container p {
            font-size: 16px;
            margin: 20px 0;
        }

    </style>
</head>
<body>
<div class="error-container">
    <h1>Oops! Something Went Wrong.</h1>
    <p>
        <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "An unexpected error has occurred. Please try again later." %>
    </p>
</div>
</body>
</html>

