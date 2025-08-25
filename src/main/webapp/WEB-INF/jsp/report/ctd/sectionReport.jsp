<%@ page import="edu.mcw.scge.datamodel.ctd.Section" %>
<%@ page import="org.apache.commons.lang.StringUtils" %><%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 8/22/2025
  Time: 3:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Section section= (Section) request.getAttribute("section");
    String indCheckbox="";
    String marketingCheckbox="";
    if(section.getRequiredForInitialIND()!=null && section.getRequiredForInitialIND().equalsIgnoreCase("yes"))
        indCheckbox+="checked";
    if(section.getRequiredForMarketingApplicationOnly()!=null && section.getRequiredForMarketingApplicationOnly().equalsIgnoreCase("yes"))
        marketingCheckbox+="checked";
%>
<div class="container my-5">
    <h2 class="mb-4">CTD Section <%=section.getSectionCode()%> Report</h2>

    <div class="card mb-4">
        <div class="card-header">Summary</div>
        <div class="card-body">

            <div class="row">
                <div class="col-sm-4 font-weight-bold">Section Name:</div>
                <div class="col-sm-8"><%=section.getSectionName()%></div>
            </div>

            <div class="row mb-1">
                <div class="col-sm-4 font-weight-bold">Section Code:</div>
                <div class="col-sm-8"><%=section.getSectionCode()%></div>
            </div>

            <div class="row mb-1">
                <div class="col-sm-4 font-weight-bold">Module Number:</div>
                <div class="col-sm-8"><%=section.getModuleCode()%></div>
            </div>

            <div class="row mb-1">
                <div class="col-sm-4 font-weight-bold">Description:</div>
                <div class="col-sm-8"><%=StringUtils.capitalize(section.getSectionDescription())%></div>
            </div>


            <%
                if(section.getSubmissionTiming()!=null && !section.getSubmissionTiming().equals("")){
            %>
            <div class="row mb-1">
                <div class="col-sm-4 font-weight-bold">Submission Timing</div>
                <div class="col-sm-8"><%=StringUtils.capitalize(section.getSubmissionTiming())%></div>
            </div>
            <%}%>

            <div class="row mb-1">
                <div class="col-sm-4 font-weight-bold">Last Updated:</div>
                <div class="col-sm-8">August 22, 2025 - 04:45 PM</div>
            </div>
            </div>
        </div>

    <div class="card mb-4">
        <div class="card-header">  Required with submission of type</div>
        <div class="card-body">
            <!-- Question 1 -->
            <div class="form-group">
                <label style="margin-right:1%">1. Initial IND:</label>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox" name="q1[]" id="q1_yes" value="yes">
                    <label class="form-check-label" for="q1_yes">Yes</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox" name="q1[]" id="q1_no" value="no">
                    <label class="form-check-label" for="q1_no">No</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox" name="q1[]" id="q1_maybe" value="maybe">
                    <label class="form-check-label" for="q1_maybe">Maybe</label>
                </div>
            </div>

            <!-- Question 2 -->
            <div class="form-group">
                <label style="margin-right:1%">2. Marketing:</label>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox" name="q2[]" id="q2_yes" value="yes">
                    <label class="form-check-label" for="q2_yes">Yes</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox" name="q2[]" id="q2_no" value="no">
                    <label class="form-check-label" for="q2_no">No</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox" name="q2[]" id="q2_maybe" value="maybe">
                    <label class="form-check-label" for="q2_maybe">Maybe</label>
                </div>
            </div>
        </div>

    </div>

    <!-- Another Section -->
    <div class="card">
        <div class="card-header">Resources</div>
        <div class="card-body">


            <div class="row mb-3">
                <div class="col-sm-4 font-weight-bold">Templates:</div>
                <div class="col-sm-8"></div>
            </div>

            <div class="row mb-3">
                <div class="col-sm-4 font-weight-bold">Example:</div>
                <div class="col-sm-8"></div>
            </div>
            <div class="row mb-3">
                <div class="col-sm-4 font-weight-bold">Instructions:</div>
                <div class="col-sm-8"></div>
            </div>
            <div class="row mb-3">
                <div class="col-sm-4 font-weight-bold">External Links:</div>
                <div class="col-sm-8"></div>
            </div>

        </div>
    </div>

</div>

