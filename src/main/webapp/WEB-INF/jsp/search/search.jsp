<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 2/14/2025
  Time: 3:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<form id="searchForm" class="form-inline my-2 my-lg-0 " action="/platform/data/search/">
  <div class="input-group md-form form-sm form-2 pl-0">

    <input class="form-control form-control-sm form-container-sm amber-border" id="commonSearchTerm" name="searchTerm" type="text" placeholder="Search SCGE Platform.." aria-label="Search" required maxlength="100">
    <div class="input-group-append">
            <button class="input-group-text  lighten-3 btn btn-light btn-sm" id="basic-text1" type="submit"><i class="fas fa-search text-grey" aria-hidden="true"></i></button>
    </div>
  </div>
</form>