<%--
  Created by IntelliJ IDEA.
  User: akundurthi
  Date: 10/8/2024
  Time: 8:52 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <link href="/platform/css/ctdEditHome.css" rel="stylesheet">

    <%
        String result = (String) session.getAttribute("result");
        if(result != null) {
    %>
    <script>
        alert('<%= result %>');
        <% session.removeAttribute("result"); %>
    </script>
    <% } %>

<h1 class="clinical-title">Clinical Trials Editor</h1>
<h5 class="clinical-subtitle">Add a new Clinical Trial</h5>
<form class="clinical-form" action="/platform/clinicalTrialEdit/add" method="get">
    <label for="nctId" class="clinical-label">Enter NCTID:</label>
    <input type="text" id="nctId" name="nctId" class="clinical-input" required>
    <input type="submit" value="Submit" class="clinical-submit">
</form>
<br>

