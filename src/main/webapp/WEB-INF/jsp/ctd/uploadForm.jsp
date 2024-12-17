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
            <form:form method="post" enctype="multipart/form-data" action="/platform/data/store/" modelAttribute="storageProperties" >
                <input type="hidden" value="<%=sectionCode%>" name="sectionCode"/>
                <form:input type="hidden"  path="applicationId" />
                <form:input type="hidden"  path="sponsorName" />
                <input type="hidden" name="module" value="<%=module%>"/>

                <div class="row">
                    <div class="col-5">Section Title</div>
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
                    <div class="col-6">:&nbsp;${storageProperties.applicationId}</div>
                </div>
                <div class="row">
                    <div class="col-5">Sponsor</div>
                    <div class="col-6">:&nbsp;${storageProperties.sponsorName}</div>
                </div>
                <div class="row">
                    <div class="col-5">Access Tier</div>
                    <div class="col-6"><select class="form-select" aria-label="Default select example">
                        <option value="1" selected>1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                    </select></div>
                </div>
                <br>
                <div class="form-floating">
                    <label for="comments<%=sectionCode.trim()%>">Comments</label>
                    <textarea class="form-control" placeholder="Leave a comment here" id="comments<%=sectionCode.trim()%>" style="height: 100px"></textarea>

                </div>

                <br>
                <div>

                    <table>
                        <tr><td>File to upload:</td><td><input type="file" name="file" /></td></tr>
                        <tr><td></td><td><input type="submit" value="Upload" /></td></tr>
                    </table>

                </div>
            </form:form>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal" >Close</button>
            <%--            <button type="button" class="btn btn-primary" onclick="uploadFile('<%=module%>','<%=sectionCode.trim()%>','file<%=sectionCode.trim()%>')">Upload</button>--%>





        </div>
    </div>
</div>