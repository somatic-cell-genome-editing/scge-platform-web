<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 7/29/2024
  Time: 9:44 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container">
<div class="row" style="width: 100%">
    <div class="col-12 col-md-4">
        <form>
            <button class="btn btn-primary btn-sm responsive " type="submit">View </button>
        </form>
    </div>
    <div class="col-12 col-md-5">
<%--        <form action="/platform/data/ind/upload">--%>
        <button class="btn btn-success btn-sm responsive "   onclick="uploadDocument($(this),'<%=sectionCode.trim()%>')" >Upload </button>

    </div>
    <div class="col-12 col-md-3">
        <form>
            <button class="btn btn-warning btn-sm responsive " type="submit" >Sample</button>
        </form>
    </div>

</div>
    <div class="modal" id="uploadModal<%=sectionCode.trim()%>" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Modal title</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <h1>Section <%=sectionCode%></h1>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>

    </div>
</div>
<script>
    function uploadDocument(_this, sectionId){
        alert(sectionId)
        console.log("SECTION ID:" +sectionId)
        var id='#uploadModal'+sectionId
        console.log("UPLOAD ID:"+ id)
        $(id).toggle();
    }
</script>