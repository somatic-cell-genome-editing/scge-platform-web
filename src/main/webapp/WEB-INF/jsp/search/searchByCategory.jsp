<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 2/17/2025
  Time: 1:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<form id="searchFormByCategory" class="form-inline " action="/platform/data/search/<%=category%>">
  <div class="input-group md-form form-sm pl-0">

    <input class="form-control form-control-sm form-container-sm amber-border" id="commonSearchTermByCategory" name="searchTerm" type="text" placeholder="Search in GT Trials.." aria-label="SearchCategory" required maxlength="100">
    <div class="input-group-append">
      <button class="input-group-text  lighten-3 btn btn-light" id="basic-text-category" type="submit"><i class="fas fa-search text-grey" aria-hidden="true"></i></button>
    </div>
  </div>
</form>