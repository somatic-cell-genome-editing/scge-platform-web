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
        <h2>IND Application</h2>
    </div>
    <div class="card-body">
        <form:form action="/platform/ind/application/create/" method="post" modelAttribute="application">
            <div class="row">
                <div class="form-group col-sm-6">
                    <label for="applicationId">Application ID</label>
                    <form:input  type="text" class="form-control" id="applicationId" name="applicationId"  placeholder="Application ID" path="applicationId" readonly="true" />
                </div>
                <div class="form-group col-sm-6">
                    <label for="applicationType">Application Type</label>
                    <form:input type="text" class="form-control" id="applicationType" placeholder="Initial IND" path="applicationType" readonly="<%=readonly%>"/>
                </div>
            </div>

            <div class="row">
                <div class="form-group col-sm-6">
                    <label for="sponsorName">Sponsor Name</label>
                    <form:input type="text" class="form-control" id="sponsorName" name="sponsorName"  placeholder="Sponsor Name" path="sponsorName" readonly="<%=readonly%>"/>
                </div>
                <div class="form-group col-sm-6">
                    <label for="inputEmail4">Email</label>
                    <input type="email" class="form-control" id="inputEmail4" placeholder="Email" readonly="<%=readonly%>"/>
                </div>

            </div>
            <div class="row">
                <div class="form-group col-sm-4">
                    <label for="inputAddress">Product Name</label>
                    <form:input type="text" class="form-control" id="inputAddress" placeholder="Product Name" path="productName" readonly="<%=readonly%>"/>
                </div>
                <div class="form-group col-sm-4">
                    <label for="inputAddress2">Indication</label>
                    <form:input type="text" class="form-control" id="inputAddress2" placeholder="Indication" path="indication" readonly="<%=readonly%>"/>
                </div>
                <div class="form-group col-sm-4">
                    <label for="routeOfAdministration">Route of Administration</label>
                    <form:input type="text" class="form-control" id="routeOfAdministration" placeholder="Route of Administration" path="routeOfAdministration" readonly="<%=readonly%>"/>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-sm-3">
                    <label for="pharmaceutical_formulation">Pharmaceutical Formulation</label>
                    <form:input type="text" class="form-control" id="pharmaceutical_formulation" placeholder="Pharmaceutical Formulation" path="pharmaceuticalFormulation" readonly="<%=readonly%>"/>
                </div>
                <div class="form-group col-sm-3">
                    <label for="manufacturer_name">Manufacturer Name</label>
                    <form:input type="text" class="form-control" id="manufacturer_name" placeholder="Manufacturer Name" path="manufacturerName" readonly="<%=readonly%>"/>
                </div>
                <div class="form-group col-sm-3">
                    <label for="referenceStandard">Reference Standard</label>
                    <form:input type="text" class="form-control" id="referenceStandard" placeholder="Reference Standard" path="referenceStandard" readonly="<%=readonly%>"/>
                </div>
                <div class="form-group col-sm-3">
                    <label for="dosageStrength">Dosage Strength</label>
                    <form:input type="text" class="form-control" id="dosageStrength" placeholder="Dosage Strength" path="dosageStrength" readonly="<%=readonly%>"/>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-md-6">
                    <label for="inputCity">Application Number</label>
                    <form:input type="text" class="form-control" id="inputCity" path="applicationNumber" readonly="<%=readonly%>"/>
                </div>
                <div class="form-group col-md-4">
                    <label for="submissionDate">Submission Date</label>
                    <form:input type="text" class="form-control" id="submissionDate" path="submissionDate" readonly="<%=readonly%>"/>

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
                <form:textarea class="form-control" id="exampleFormControlTextarea1" rows="3" path="description" readonly="<%=readonly%>"/>
            </div><br>
            <%
                if(!readonly){
            %>
            <div class="row">
                <div class="col-1">
                    <button type="submit" class="btn btn-primary btn-sm">Submit</button>
                </div>
                    <%--        <div class="col-3">--%>
                    <%--&lt;%&ndash;            <button  class="btn btn-primary btn-sm"><a href="/platform/data/ind/initStorage" style="color: whitesmoke">Upload Documents</a></button>&ndash;%&gt;--%>
                    <%--            <button  class="btn btn-primary btn-sm" type="submit">Upload Documents</button>--%>

                    <%--        </div>--%>
            </div>
            <%}%>
        </form:form>
    </div></div>