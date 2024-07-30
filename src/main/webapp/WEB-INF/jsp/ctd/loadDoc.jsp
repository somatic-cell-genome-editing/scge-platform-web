<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 7/29/2024
  Time: 11:58 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header" >
            <h5 class="modal-title" id="upload<%=sectionCode.trim()%>">Modal title</h5>
            <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
            <h1>Section <%=sectionCode%></h1>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal" >Close</button>
            <button type="button" class="btn btn-primary">Save changes</button>
        </div>
    </div>
</div>