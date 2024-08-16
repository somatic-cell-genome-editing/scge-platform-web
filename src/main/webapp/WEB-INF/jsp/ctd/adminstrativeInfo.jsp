<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 7/29/2024
  Time: 10:04 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="card">
    <div class="card-header">
        <h2>New IND Application</h2>
    </div>
    <div class="card-body">
    <form:form action="/platform/data/store/application" method="post" modelAttribute="storageProperties">
    <div class="row">
        <div class="form-group col-md-6">
            <label for="applicationId">Application ID</label>
            <form:input type="text" class="form-control" id="applicationId" name="applicationId"  placeholder="Application ID" path="applicationId"  />
        </div>
        <div class="form-group col-md-6">
            <label for="applicationType">Application Type</label>
            <input type="text" class="form-control" id="applicationType" placeholder="Initial IND" disabled>
        </div>
    </div>

        <div class="row">
            <div class="form-group col-md-6">
                <label for="sponsorName">Sponsor Name</label>
                <form:input type="text" class="form-control" id="sponsorName" name="sponsorName"  placeholder="Sponsor Name" path="sponsorName"/>
            </div>
            <div class="form-group col-md-6">
                <label for="inputEmail4">Email</label>
                <input type="email" class="form-control" id="inputEmail4" placeholder="Email">
            </div>

        </div>
        <div class="form-group">
            <label for="inputAddress">Product Name</label>
            <input type="text" class="form-control" id="inputAddress" placeholder="Product Name">
        </div>
        <div class="form-group">
            <label for="inputAddress2">Indication</label>
            <input type="text" class="form-control" id="inputAddress2" placeholder="Indication">
        </div>
    <div class="form-group">
        <label for="routeOfAdministration">Route of Administration</label>
        <input type="text" class="form-control" id="routeOfAdministration" placeholder="Route of Administration">
    </div>
    <div class="form-group">
        <label for="pharmaceutical_formulation">Pharmaceutical Formulation</label>
        <input type="text" class="form-control" id="pharmaceutical_formulation" placeholder="Pharmaceutical Formulation">
    </div>
    <div class="form-group">
        <label for="manufacturer_name">Manufacturer Name</label>
        <input type="text" class="form-control" id="manufacturer_name" placeholder="Manufacturer Name">
    </div>
    <div class="form-group">
        <label for="referenceStandard">Reference Standard</label>
        <input type="text" class="form-control" id="referenceStandard" placeholder="Reference Standard">
    </div>
    <div class="form-group">
        <label for="dosageStrength">Dosage Strength</label>
        <input type="text" class="form-control" id="dosageStrength" placeholder="Dosage Strength">
    </div>
        <div class="row">
            <div class="form-group col-md-6">
                <label for="inputCity">Application Number</label>
                <input type="text" class="form-control" id="inputCity">
            </div>
            <div class="form-group col-md-4">
                <label for="submissionDate">Submission Date</label>
                <input type="text" class="form-control" id="submissionDate">

            </div>

        </div>
<%--        <div class="form-group">--%>
<%--            <div class="form-check">--%>
<%--                <input class="form-check-input" type="checkbox" id="gridCheck">--%>
<%--                <label class="form-check-label" for="gridCheck">--%>
<%--                    Initial IND--%>
<%--                </label>--%>
<%--            </div>--%>
<%--        </div>--%>
    <div class="form-group">
        <label for="exampleFormControlTextarea1">Description</label>
        <textarea class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
    </div><br>
    <div class="row">
        <div class="col-1">
        <button type="submit" class="btn btn-primary btn-sm">Submit</button>
        </div>
        <div class="col-3">
<%--            <button  class="btn btn-primary btn-sm"><a href="/platform/data/ind/initStorage" style="color: whitesmoke">Upload Documents</a></button>--%>
            <button  class="btn btn-primary btn-sm" type="submit">Upload Documents</button>

        </div>
    </div>
   <br>

</form:form>
</div></div>