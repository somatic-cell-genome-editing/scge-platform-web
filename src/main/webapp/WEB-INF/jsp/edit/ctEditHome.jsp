<%--
  Created by IntelliJ IDEA.
  User: akundurthi
  Date: 10/8/2024
  Time: 8:52 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Clinical Trial</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        .clinical-title {
            background: #2865a3;
            color: white;
            padding: 10px 20px;
            border-radius: 10px;
            margin: 20px auto;
        }

        .clinical-form {
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            margin: 50px auto;
        }
        .clinical-title, .clinical-subtitle {
            text-align: center;
        }
        .clinical-label,.clinical-input, .clinical-submit {
            display: block;
            width: 100%;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        .clinical-input {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .clinical-submit {
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .clinical-submit:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<h1 class="clinical-title">Clinical Trials Editor</h1>
<h5 class="clinical-subtitle">Add a new Clinical Trial</h5>
<form class="clinical-form" action="" method="get">
    <label for="nctid" class="clinical-label">Enter NCTID:</label>
    <input type="text" id="nctid" name="nctid" class="clinical-input" required>
    <input type="submit" value="Submit" class="clinical-submit">
</form>
<br>
</body>
</html>
