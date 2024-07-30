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
            <h5 class="modal-title" id="upload<%=sectionCode.trim()%>">Upload Document</h5>
            <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
            <div class="row">
                <div class="col-5">Document Title</div>
                <div class="col">:&nbsp;<%=sectionName%></div>
            </div>
            <div class="row">
                <div class="col-5">Section</div>
                <div class="col-6">:&nbsp;<%=sectionCode.replaceAll("_",".")%></div>
            </div>
            <div class="row">
                <div class="col-5">Module</div>
                <div class="col-6">:&nbsp;<%=module%></div>
            </div>
            <div class="row">
                <div class="col-5">Application ID</div>
                <div class="col-6">:&nbsp;12345</div>
            </div>
            <div class="row">
                <div class="col-5">Sponsor</div>
                <div class="col-6">:&nbsp;XXXX</div>
            </div><br>
            <div class="form-floating">
                <label for="floatingTextarea2">Comments</label>
                <textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 100px"></textarea>

            </div>
            <br>
                <div class="form-group">
                    <label for="exampleFormControlFile1">File input</label>
                    <input type="file" class="form-control-file" id="exampleFormControlFile1">
                </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal" >Close</button>
            <button type="button" class="btn btn-primary">Upload</button>
        </div>
    </div>
</div>