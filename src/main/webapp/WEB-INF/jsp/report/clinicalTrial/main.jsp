<%--
  Created by IntelliJ IDEA.
  User: akundurthi
  Date: 10/10/2024
  Time: 9:28 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="edu.mcw.scge.services.SCGEContext" %>
<%@ page import="edu.mcw.scge.configuration.Access" %>
<%@ page import="edu.mcw.scge.datamodel.*" %>
<%@ page import="org.apache.commons.text.StringEscapeUtils" %>
<%@ page import="java.io.Serializable" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Clinical Trial Report</title>
    <link rel="stylesheet" href="/platform/css/clinicalReport.css" type="text/css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@400&display=swap" rel="stylesheet">
</head>
<body>
<%
   ClinicalTrialRecord clinicalTrialData = (ClinicalTrialRecord) request.getAttribute("clinicalTrialData");
    List<ClinicalTrialExternalLink> clinicalExtLinkData = (List<ClinicalTrialExternalLink>) request.getAttribute("clinicalExtLinkData");
    List<Alias>aliasData = (List<Alias>) request.getAttribute("aliasData");
    List<ClinicalTrialAdditionalInfo>fdaInfo = (List<ClinicalTrialAdditionalInfo>) request.getAttribute("fdaInfo");
//    String successMessage = (String)session.getAttribute("successMessage");
    Access access= new Access();
    Person p = null;
    try {
        p = access.getUser(request.getSession());
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<%--This result attribute comes from ClinicalTrialEditController, and when clinicalTrialEdit/home/ is accessed--%>
<%
    String result = (String) session.getAttribute("result");
    if(result != null) {
%>
<script>
    alert('<%= result %>');
    <% session.removeAttribute("result"); %>
</script>
<% } %>

<div style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 1.5rem;">
    <h3 style="color: #003366; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-weight: 700; font-size: 1.8rem; margin: 0; padding-bottom: 1rem; border-bottom: 3px solid #0066cc; flex-grow: 1;">
        Gene Therapy Trial Report
    </h3>
    <% if (request.getServerName().equals("localhost") || request.getServerName().equals("dev.scge.mcw.edu") || request.getServerName().equals("stage.scge.mcw.edu") )
    {
        if (request.getServerName().equals("localhost") ||p!=null && access.isAdmin(p) && !SCGEContext.isProduction()) {
    %>
    <a style="margin-left: 1rem; margin-bottom: 1rem;" href="/platform/data/report/clinicalTrials/<%=clinicalTrialData.getNctId()%>?edit=true" class="btn btn-primary">Edit</a>
    <%}}%>
</div>
<%
    boolean isEditMode = ((request.getServerName().equals("localhost") || request.getServerName().equals("dev.scge.mcw.edu") || request.getServerName().equals("stage.scge.mcw.edu"))&&request.getParameter("edit") != null && request.getParameter("edit").equals("true"));
%>
<div class="sidenav" id="navbar">
    <!-- Dynamic links will be added here -->
</div>
<div class="ctReportBody">
    <form class="ctReportForm" method="post" action="/platform/clinicalTrialEdit/report/<%=clinicalTrialData.getNctId()%>/edit">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="hidden" name="nctId" value="<%=clinicalTrialData.getNctId()%>"/>
        <div class="dynamic-heading" id="summary"><h3 class="ctSubHeading">Summary</h3></div>
        <h2 class="brief-title"><%= clinicalTrialData.getBriefTitle() != null ? clinicalTrialData.getBriefTitle() : "" %></h2>
        <hr>
        <table class="ctReportTable">
            <tr>
                <td class="label">
                    NCTID
                </td>
                <td>
                    <%=clinicalTrialData.getNctId()%>&nbsp;<a style="color: #1a80b6; font-weight: 600; text-decoration: none; border-bottom: 1px solid #1a80b6;" href="https://www.clinicaltrials.gov/study/<%=clinicalTrialData.getNctId()%>" target="_blank">(View at clinicaltrials.gov)</a>
                </td>
            </tr>
            <%if(isEditMode){%>
            <tr>
                <td class="label">
                    Record&nbsp;Status
                </td>
                <td>
                    <select name="recordStatus" style="width: 11%" class="form-control">
                        <option value="Active" <%=clinicalTrialData.getRecordStatus()!=null&&clinicalTrialData.getRecordStatus().equalsIgnoreCase("Active")?"selected":""%>>Active</option>
                        <option value="Inactive" <%=clinicalTrialData.getRecordStatus()!=null&&clinicalTrialData.getRecordStatus().equalsIgnoreCase("Inactive")?"selected":""%>>Inactive</option>
                    </select>
                </td>
            </tr>
            <% } %>
            <tr>
                <td class="label">
                    Description
                </td>

                <td>
                    <div class="readonly-field description-field collapsed" id="descriptionText"><%= clinicalTrialData.getDescription() != null ? clinicalTrialData.getDescription() : "" %></div>
                    <a href="javascript:void(0);" class="toggle-link" id="toggleDescription" style="display: none;">(Show More)</a>
                </td>

            </tr>
            <tr>
                <td class="label">
                    Development&nbsp;Status
                </td>
                <td>
                    <% if(isEditMode) { %>
                    <textarea name="developmentStatus" class="form-control" rows="1"><%=clinicalTrialData.getDevelopmentStatus()!=null?clinicalTrialData.getDevelopmentStatus():""%></textarea>
                    <% } else { %>
                    <strong><%=clinicalTrialData.getDevelopmentStatus()!=null?clinicalTrialData.getDevelopmentStatus():""%></strong>
                    <% } %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Indication
                </td>
                <td>
                    <% if(isEditMode) { %>
                    <textarea name="indication" class="form-control" rows="1"><%= clinicalTrialData.getIndication()!= null ? StringEscapeUtils.escapeHtml4(clinicalTrialData.getIndication()) : "" %></textarea>
                    <% } else { %>
                    <%= clinicalTrialData.getIndication() != null ? clinicalTrialData.getIndication() : "" %>
                    <% } %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Disease&nbsp;Ontology&nbsp;Term
                </td>
                <td>
                    <% if(isEditMode) { %>
                    <textarea name="indicationDOID" class="form-control" rows="1"><%=clinicalTrialData.getIndicationDOID()!=null?clinicalTrialData.getIndicationDOID():""%></textarea>
                    <% } else { %>
                    <%
                        String doidString = clinicalTrialData.getIndicationDOID()!=null?clinicalTrialData.getIndicationDOID():"";
                        if (doidString != null && !doidString.isEmpty()) {
                            String[] doids = doidString.split("[/,;]+\\s*");
                            StringBuilder formattedDoids = new StringBuilder();
                            for (int i = 0; i < doids.length; i++) {
                                String doid = doids[i].trim();
                                String doidNumber = doid.startsWith("DOID:") ? doid.substring(5) : doid;
                                formattedDoids
                                        .append(" <a href=\"https://www.disease-ontology.org/term/DOID:").append(doidNumber)
                                        .append("\" target=\"_blank\">DOID:").append(doidNumber).append("</a>");
                                if (i < doids.length - 1) {
                                    formattedDoids.append("; ");
                                }
                            }
                    %>
                    <%=formattedDoids.toString()%>
                    <% } else { %>

                    <% } %>
                    <% } %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Compound&nbsp;Name
                </td>
                <td>
                    <% if(isEditMode) { %>
                    <textarea name="compoundName" class="form-control" rows="1"><%= clinicalTrialData.getCompoundName() != null ? StringEscapeUtils.escapeHtml4(clinicalTrialData.getCompoundName()) : "" %></textarea>
                    <% } else { %>
                    <%= clinicalTrialData.getCompoundName() != null ? clinicalTrialData.getCompoundName() : "" %>
                    <% } %>
                </td>
            </tr>
            <%
                boolean hasExistingAlias = (aliasData != null && !aliasData.isEmpty());
                Alias existingAlias = hasExistingAlias ? aliasData.get(0) : new Alias();
            %>

            <% if(isEditMode) { %>
            <tr>
                <td class="label">
                    Compound&nbsp;Alias
                </td>

                <td>
                    <input type="hidden" name="aliasNctId" value="<%= clinicalTrialData.getNctId() %>">
                    <input type="hidden" name="aliasFieldName" value="compound">
                    <% if(hasExistingAlias) { %>
                    <input type="hidden" name="aliasKey" value="<%= existingAlias.getKey() %>">
                    <% } %>
                    <textarea name="aliasValue" class="form-control" rows="1"><%= hasExistingAlias && existingAlias.getAlias() != null ? StringEscapeUtils.escapeHtml4(existingAlias.getAlias()) : "" %></textarea>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Alias&nbsp;Type
                </td>

                <td>
                    <textarea name="aliasType" placeholder="For example, proper name or proprietary name etc" class="form-control" rows="1"><%= hasExistingAlias && existingAlias.getAliasTypeLC() != null ? existingAlias.getAliasTypeLC() : "" %></textarea>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Alias&nbsp;Notes
                </td>

                <td>
                    <textarea name="aliasNotes" class="form-control" rows="1"><%= hasExistingAlias && existingAlias.getNotes() != null ? StringEscapeUtils.escapeHtml4(existingAlias.getNotes()) : "" %></textarea>
                </td>
            </tr>
            <% } else { %>
            <% if(hasExistingAlias && existingAlias.getAlias() != null && !existingAlias.getAlias().isEmpty()) { %>
            <tr>
                <td class="label">
                    Compound&nbsp;Alias
                </td>

                <td>
                    <%= existingAlias.getAlias() %>
                </td>
            </tr>
            <% } %>
<%--            <% if(hasExistingAlias && existingAlias.getAliasTypeLC() != null && !existingAlias.getAliasTypeLC().isEmpty()) { %>--%>
<%--            <tr>--%>
<%--                <td class="label">--%>
<%--                    Alias&nbsp;Type--%>
<%--                </td>--%>

<%--                <td>--%>
<%--                    <%= existingAlias.getAliasTypeLC() %>--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--            <% } %>--%>
<%--            <% if(hasExistingAlias && existingAlias.getNotes() != null && !existingAlias.getNotes().isEmpty()) { %>--%>
<%--            <tr>--%>
<%--                <td class="label">--%>
<%--                    Alias&nbsp;Notes--%>
<%--                </td>--%>

<%--                <td>--%>
<%--                    <%= existingAlias.getNotes() %>--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--            <% } %>--%>
            <% } %>
            <% if(isEditMode || (clinicalTrialData.getCompoundDescription() != null && !clinicalTrialData.getCompoundDescription().isEmpty())) { %>
            <tr>
                <td class="label">
                    Compound&nbsp;Description
                </td>
                <td>
                    <% if(isEditMode) { %>
                    <textarea name="compoundDescription" class="form-control" rows="1"><%= clinicalTrialData.getCompoundDescription() != null ? StringEscapeUtils.escapeHtml4(clinicalTrialData.getCompoundDescription()) : "" %></textarea>
                    <% } else { %>
                    <%= clinicalTrialData.getCompoundDescription() %>
                    <% } %>
                </td>
            </tr>
            <% } %>
            <tr>
                <td class="label">
                    Sponsor
                </td>

                <td>
                    <%=clinicalTrialData.getSponsor()!=null?clinicalTrialData.getSponsor():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Funder&nbsp;Type
                </td>

                <td>
                    <%=clinicalTrialData.getSponsorClass()!=null?clinicalTrialData.getSponsorClass().equalsIgnoreCase("NIH")?"NIH":clinicalTrialData.getSponsorClass():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Recruitment&nbsp;Status
                </td>
                <%
                    String status = clinicalTrialData.getStudyStatus();
                    boolean recStatus = "Recruiting".equalsIgnoreCase(status)||"Not yet recruiting".equalsIgnoreCase(status);
                    String cssClass = recStatus?"status-recruiting":"status-other";
                %>
<%--                <td>--%>
<%--                    <div class="status-container <%=cssClass%>">--%>
<%--                    <%=clinicalTrialData.getStudyStatus()!=null?clinicalTrialData.getStudyStatus():""%>--%>
<%--                    </div>--%>
<%--                </td>--%>
                <td>
                    <div style="display: flex; align-items: center; gap: 8px;">
                        <div class="status-container <%=cssClass%>">
                            <%=clinicalTrialData.getStudyStatus()!=null?clinicalTrialData.getStudyStatus():""%>
                        </div>
                        <%if("Recruiting".equalsIgnoreCase(status)){%>
                        <a style="color: #1a80b6; font-weight: 600; text-decoration: none; border-bottom: 1px solid #1a80b6;"
                           href="https://www.clinicaltrials.gov/study/<%=clinicalTrialData.getNctId()%>#contacts-and-locations"
                           target="_blank">
                            (Click here for study contact information)
                        </a>
                        <%}%>
                    </div>
                </td>
            </tr>
            <% if(clinicalTrialData.getEnrorllmentCount() != 0) { %>
            <tr>
                <td class="label">
                    Enrollment&nbsp;Count
                </td>
                <td>
                    <%
                        String enrollmentType = clinicalTrialData.getEnrollmentType()!=null?clinicalTrialData.getEnrollmentType():"";
                        String enrollmentCount = Integer.toString(clinicalTrialData.getEnrorllmentCount());
                    %>
                    <%=!(enrollmentType.isEmpty())?enrollmentCount+" ("+enrollmentType+")":enrollmentCount%>
                </td>
            </tr>
            <% } %>
            <tr>
                <td class="label">Results&nbsp;Posted</td>
                <td>
                    <% if(clinicalTrialData.getWithHasResults() != null) { %>
                    <% if(clinicalTrialData.getWithHasResults().equals("True")) { %>
                    <a style="color: #1a80b6; font-weight: 600; text-decoration: none; border-bottom: 1px solid #1a80b6;" href="https://www.clinicaltrials.gov/study/<%= clinicalTrialData.getNctId() %>?tab=results" target="_blank">View&nbsp;Results</a>
                    <% } else { %>
                    <%= clinicalTrialData.getWithHasResults().equalsIgnoreCase("False")?"Not Available":"" %>
                    <% } %>
                    <% } else { %>
                    <% } %>
                </td>
            </tr>
        </table>

        <div class="dynamic-heading" id="therapy-info"><h3 class="ctSubHeading">Therapy&nbsp;Information</h3></div>
        <hr>
        <table class="ctReportTable">
            <tr>
                <td class="label">
                    Target&nbsp;Gene/Variant
                </td>

                <td>
                    <% if(isEditMode) { %>
                    <textarea name="targetGeneOrVariant" class="form-control" rows="1"><%=clinicalTrialData.getTargetGeneOrVariant()!=null?StringEscapeUtils.escapeHtml4(clinicalTrialData.getTargetGeneOrVariant()):""%></textarea>
                    <% } else { %>
                    <%=clinicalTrialData.getTargetGeneOrVariant()!=null?clinicalTrialData.getTargetGeneOrVariant():""%>
                    <% } %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Therapy&nbsp;Type
                </td>

                <td>
                    <% if(isEditMode) { %>
                    <textarea name="therapyType" class="form-control" rows="1"><%=clinicalTrialData.getTherapyType()!=null?StringEscapeUtils.escapeHtml4(clinicalTrialData.getTherapyType()):""%></textarea>
                    <% } else { %>
                    <%=clinicalTrialData.getTherapyType()!=null?clinicalTrialData.getTherapyType():""%>
                    <% } %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Therapy&nbsp;Route
                </td>

                <td>
                    <% if(isEditMode) { %>
                    <textarea name="therapyRoute" class="form-control" rows="1"><%=clinicalTrialData.getTherapyRoute()!=null?StringEscapeUtils.escapeHtml4(clinicalTrialData.getTherapyRoute()):""%></textarea>
                    <% } else { %>
                    <%=clinicalTrialData.getTherapyRoute()!=null?clinicalTrialData.getTherapyRoute():""%>
                    <% } %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Mechanism&nbsp;of&nbsp;Action
                </td>

                <td>
                    <% if(isEditMode) { %>
                    <textarea name="mechanismOfAction" class="form-control" rows="1"><%=clinicalTrialData.getMechanismOfAction()!=null?StringEscapeUtils.escapeHtml4(clinicalTrialData.getMechanismOfAction()):""%></textarea>
                    <% } else { %>
                    <%=clinicalTrialData.getMechanismOfAction()!=null?clinicalTrialData.getMechanismOfAction():""%>
                    <% } %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Route&nbsp;of&nbsp;Administration
                </td>

                <td>
                    <% if(isEditMode) { %>
                    <textarea name="routeOfAdministration" class="form-control" rows="1"><%=clinicalTrialData.getRouteOfAdministration()!=null?StringEscapeUtils.escapeHtml4(clinicalTrialData.getRouteOfAdministration()):""%></textarea>
                    <% } else { %>
                    <%=clinicalTrialData.getRouteOfAdministration()!=null?clinicalTrialData.getRouteOfAdministration():""%>
                    <% } %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Drug&nbsp;Product&nbsp;Type
                </td>

                <td>
                    <% if(isEditMode) { %>
                    <textarea name="drugProductType" class="form-control" rows="1"><%=clinicalTrialData.getDrugProductType()!=null?StringEscapeUtils.escapeHtml4(clinicalTrialData.getDrugProductType()):""%></textarea>
                    <% } else { %>
                    <%=clinicalTrialData.getDrugProductType()!=null?clinicalTrialData.getDrugProductType():""%>
                    <% } %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Target&nbsp;Tissue/Cell
                </td>

                <td>
                    <% if(isEditMode) { %>
                    <textarea name="targetTissueOrCell" class="form-control" rows="1"><%=clinicalTrialData.getTargetTissueOrCell()!=null?StringEscapeUtils.escapeHtml4(clinicalTrialData.getTargetTissueOrCell()):""%></textarea>
                    <% } else { %>
                    <%=clinicalTrialData.getTargetTissueOrCell()!=null?clinicalTrialData.getTargetTissueOrCell():""%>
                    <% } %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Delivery&nbsp;System
                </td>

                <td>
                    <% if(isEditMode) { %>
                    <textarea name="deliverySystem" class="form-control" rows="1"><%=clinicalTrialData.getDeliverySystem()!=null?StringEscapeUtils.escapeHtml4(clinicalTrialData.getDeliverySystem()):""%></textarea>
                    <% } else { %>
                    <%=clinicalTrialData.getDeliverySystem()!=null?clinicalTrialData.getDeliverySystem():""%>
                    <% } %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Vector&nbsp;Type
                </td>

                <td>
                    <% if(isEditMode) { %>
                    <textarea name="vectorType" class="form-control" rows="1"><%=clinicalTrialData.getVectorType()!=null?StringEscapeUtils.escapeHtml4(clinicalTrialData.getVectorType()):""%></textarea>
                    <% } else { %>
                    <%=clinicalTrialData.getVectorType()!=null?clinicalTrialData.getVectorType():""%>
                    <% } %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Editor&nbsp;Type
                </td>

                <td>
                    <% if(isEditMode) { %>
                    <textarea name="editorType" class="form-control" rows="1"><%=clinicalTrialData.getEditorType()!=null?StringEscapeUtils.escapeHtml4(clinicalTrialData.getEditorType()):""%></textarea>
                    <% } else { %>
                    <%=clinicalTrialData.getEditorType()!=null?clinicalTrialData.getEditorType():""%>
                    <% } %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Dose&nbsp;1
                </td>

                <td>
                    <% if(isEditMode) { %>
                    <textarea name="dose1" class="form-control" rows="1"><%=clinicalTrialData.getDose1()!=null?clinicalTrialData.getDose1():""%></textarea>
                    <% } else { %>
                    <%=clinicalTrialData.getDose1()!=null?clinicalTrialData.getDose1():""%>
                    <% } %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Dose&nbsp;2
                </td>

                <td>
                    <% if(isEditMode) { %>
                    <textarea name="dose2" class="form-control" rows="1"><%=clinicalTrialData.getDose2()!=null?clinicalTrialData.getDose2():""%></textarea>
                    <% } else { %>
                    <%=clinicalTrialData.getDose2()!=null?clinicalTrialData.getDose2():""%>
                    <% } %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Dose&nbsp;3
                </td>

                <td>
                    <% if(isEditMode) { %>
                    <textarea name="dose3" class="form-control" rows="1"><%=clinicalTrialData.getDose3()!=null?clinicalTrialData.getDose3():""%></textarea>
                    <% } else { %>
                    <%=clinicalTrialData.getDose3()!=null?clinicalTrialData.getDose3():""%>
                    <% } %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Dose&nbsp;4
                </td>

                <td>
                    <% if(isEditMode) { %>
                    <textarea name="dose4" class="form-control" rows="1"><%=clinicalTrialData.getDose4()!=null?clinicalTrialData.getDose4():""%></textarea>
                    <% } else { %>
                    <%=clinicalTrialData.getDose4()!=null?clinicalTrialData.getDose4():""%>
                    <% } %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Dose&nbsp;5
                </td>

                <td>
                    <% if(isEditMode) { %>
                    <textarea name="dose5" class="form-control" rows="1"><%=clinicalTrialData.getDose5()!=null?clinicalTrialData.getDose5():""%></textarea>
                    <% } else { %>
                    <%=clinicalTrialData.getDose5()!=null?clinicalTrialData.getDose5():""%>
                    <% } %>
                </td>
            </tr>
        </table>

        <div class="dynamic-heading" id="study-record-dates"><h3 class="ctSubHeading">Study&nbsp;Record&nbsp;Dates</h3></div>
        <hr>
        <table class="ctReportTable">
            <tr>
                <td class="label">
                    Current&nbsp;Stage
                </td>

                <td>
                    <%=clinicalTrialData.getPhase()!=null?clinicalTrialData.getPhase():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Submit&nbsp;Date
                </td>

                <td>
                    <%=clinicalTrialData.getFirstSubmitDate()!=null?clinicalTrialData.getFirstSubmitDate():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Completion&nbsp;Date
                </td>

                <td>
                    <%=clinicalTrialData.getEstimatedCompleteDate()!=null?clinicalTrialData.getEstimatedCompleteDate():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Last&nbsp;Update
                </td>

                <td>
                    <%=clinicalTrialData.getLastUpdatePostDate()!=null?clinicalTrialData.getLastUpdatePostDate():""%>
                </td>
            </tr>
        </table>

        <div class="dynamic-heading" id="participation-criteria"><h3 class="ctSubHeading">Participation&nbsp;Criteria</h3></div>
        <hr>
        <table class="ctReportTable">
            <tr>
                <td class="label">
                    Eligible&nbsp;Age
                </td>
                <%
                    String minAge = clinicalTrialData.getElibilityMinAge();
                    String maxAge = clinicalTrialData.getElibilityMaxAge();

                    String age = (minAge != null && maxAge != null) ? minAge + " - " + maxAge
                            : (minAge != null) ? ">=" + minAge
                            : (maxAge != null) ? "<=" + maxAge
                            : null;
                %>

                <td>
                    <%=age!=null?age:""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Standard&nbsp;Ages
                </td>

                <td>
                    <%=clinicalTrialData.getStandardAge()!=null?clinicalTrialData.getStandardAge():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Sexes&nbsp;Eligible&nbsp;for&nbsp;Study
                </td>

                <td>
                    <%=clinicalTrialData.getEligibilitySex()!=null?clinicalTrialData.getEligibilitySex():""%>
                </td>
            </tr>
        </table>

        <div class="dynamic-heading" id="location"><h3 class="ctSubHeading">Locations</h3></div>
        <hr>
        <table class="ctReportTable">
            <tr>
                <td class="label">
                    No.of&nbsp;Trial&nbsp;Sites
                </td>

                <td>
                    <%=clinicalTrialData.getNumberOfLocations()!=0?clinicalTrialData.getNumberOfLocations():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Locations
                </td>

                <td>
                    <%=clinicalTrialData.getLocation()!=null?clinicalTrialData.getLocation():""%>
                </td>
            </tr>
        </table>

        <div class="dynamic-heading" id="regulatory-info"><h3 class="ctSubHeading">Regulatory&nbsp;Information</h3></div>
        <hr>
        <table class="ctReportTable">
            <tr>
                <td class="label">
                    Has&nbsp;US&nbsp;IND
                </td>

                <td>
                    <%=clinicalTrialData.getIsFDARegulated()!=null?clinicalTrialData.getIsFDARegulated():""%>
                </td>
            </tr>
            <tr>
                <td class="label">FDA&nbsp;Designations</td>
                <td>
                    <%
                        if(isEditMode) {
                            List<String> propertyValues = (List<String>) request.getAttribute("propertyValues");
                            if (propertyValues != null && !propertyValues.isEmpty()) {
                    %>
                    <div class="fda-designations-container">
                        <%
                            for (String propertyValue : propertyValues) {
                                boolean isChecked = false;
                                if (fdaInfo != null) {
                                    for (ClinicalTrialAdditionalInfo info : fdaInfo) {
                                        if (info.getPropertyValue().equals(propertyValue)) {
                                            isChecked = true;
                                            break;
                                        }
                                    }
                                }
                        %>
                        <div class="checkbox-item">
                            <input type="checkbox" id="fdaDesignation_<%= propertyValue.replaceAll("\\s+", "_") %>"
                                   name="fdaDesignation" value="<%= propertyValue %>"
                                <%= isChecked ? "checked" : "" %>>
                            <label for="fdaDesignation_<%= propertyValue.replaceAll("\\s+", "_") %>"><%= propertyValue %></label>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    <%
                        }
                    } else {
                        StringBuilder fdaDesignations = new StringBuilder();
                        if(fdaInfo != null) {
                            for(int i = 0; i < fdaInfo.size(); i++) {
                                ClinicalTrialAdditionalInfo info = fdaInfo.get(i);
                                if(i > 0) {
                                    fdaDesignations.append(", ");
                                }
                                fdaDesignations.append(info.getPropertyValue());
                            }
                        }
                    %>
                    <%= fdaDesignations.toString() %>
                    <%
                        }
                    %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Recent&nbsp;Updates
                </td>
                <td>
                    <% if(isEditMode) { %>
<%--                    <textarea name="recentUpdates" class="form-control" rows="1"><%=clinicalTrialData.getRecentUpdates()!=null?clinicalTrialData.getRecentUpdates():""%></textarea>--%>
                    <textarea name="recentUpdates" class="form-control" rows="1"><%=clinicalTrialData.getRecentUpdates()!=null? StringEscapeUtils.escapeHtml4(clinicalTrialData.getRecentUpdates()):""%></textarea>
                    <% } else { %>
                    <%=clinicalTrialData.getRecentUpdates()!=null?clinicalTrialData.getRecentUpdates():""%>
                    <% } %>
                </td>
            </tr>
        </table>

        <%-- External Links Section --%>
        <%if(isEditMode){%>
        <div class="dynamic-heading" id="resources">
            <h3 class="ctSubHeading">Resources/Links</h3>
        </div>
        <hr>
        <input type="hidden" name="patents"value="<%=clinicalTrialData.getPatents()!=null?clinicalTrialData.getPatents():""%>">
<%--        <table class="ctReportTable">--%>
<%--            <tr>--%>
<%--                <td class="label">--%>
<%--                    Patents--%>
<%--                </td>--%>
<%--                <td>--%>
<%--                    <textarea placeholder="(Enter the multiple patents separated by ';')" name="patents" class="form-control" rows="1"><%=clinicalTrialData.getPatents()!=null?clinicalTrialData.getPatents():""%></textarea>--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--        </table>--%>
<%--        <%if(isEditMode||clinicalExtLinkData != null && clinicalExtLinkData.size() > 0){%>--%>
        <div class="external-links-editor">
            <table class="ext-links-table">
                <colgroup>
                    <col />
                    <col />
                    <col />
                    <col />
                </colgroup>
                <thead>
                <tr>
                    <th>Link Type</th>
                    <th>Link Name</th>
                    <th>Link URL</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <% for(ClinicalTrialExternalLink cext : clinicalExtLinkData) {
                    if(cext.getType()!=null&&!cext.getType().equalsIgnoreCase("Grant")){
                    %>
                <tr id="link-<%=cext.getId()%>">
                    <input type="hidden" name="linkId" value="<%=cext.getId()%>">
                    <input type="hidden" name="deleteLink" id="deleteFlag-<%=cext.getId()%>" value="" disabled>
                    <td>
                        <select name="extLink" class="form-control">
<%--                            <option value="Grant" <%=cext.getType()!=null&&cext.getType().equalsIgnoreCase("Grant")?"selected":""%>>Grant</option>--%>
                            <option value="Protocol" <%=cext.getType()!=null&&cext.getType().equalsIgnoreCase("Protocol")?"selected":""%>>Protocol</option>
                            <option value="Preclinical Publications" <%=cext.getType()!=null&&cext.getType().equalsIgnoreCase("Preclinical Publications")?"selected":""%>>Preclinical Publications</option>
                            <option value="News and Press Releases" <%=cext.getType()!=null&&cext.getType().equalsIgnoreCase("News and Press Releases")?"selected":""%>>News and Press Releases</option>
                            <option value="Clinical Publications" <%=cext.getType()!=null&&cext.getType().equalsIgnoreCase("Clinical Publications")?"selected":""%>>Clinical Publications</option>
                            <option value="Related NCTID" <%=cext.getType()!=null&&cext.getType().equalsIgnoreCase("Related NCTID")?"selected":""%>>Related NCTID</option>
                        </select>
                    </td>
                    <td><textarea name="linkName" class="form-control" rows="1"><%=cext.getName()!=null?StringEscapeUtils.escapeHtml4(cext.getName()):""%></textarea></td>
                    <td><textarea name="link" class="form-control" rows="1"><%=cext.getLink()!=null?cext.getLink():""%></textarea></td>
                    <td><button type="button" class="btn btn-danger" onclick="deleteExtLink(<%=cext.getId()%>)">Delete</button></td>
                </tr>
                <% } %>
                <% } %>
                </tbody>
            </table>
            <div style=" margin-top: 15px;">
                <button type="button" class="btn btn-primary" onclick="addNewLink()">Add External Link</button>
            </div>
        </div>
<%--        <% } %>--%>
        <%}else{%>
        <% if (clinicalExtLinkData != null && clinicalExtLinkData.size() > 0||(!clinicalTrialData.getPatents().isEmpty()&&clinicalTrialData.getPatents()!=null)) { %>
        <div class="dynamic-heading" id="resources">
            <h3 class="ctSubHeading">Resources/Links</h3>
        </div>
        <hr>
        <%if(!clinicalTrialData.getPatents().isEmpty()&&clinicalTrialData.getPatents()!=null){
//            String[] patents = clinicalTrialData.getPatents().split(";");
        %>
<%--        <h5 class="link-type-heading">Patents</h5>--%>
<%--        <ul class="external-links-list">--%>
<%--            <%for(String patent:patents){%>--%>
<%--            <%if(patent.trim()!=null&&!patent.trim().isEmpty()){%>--%>
<%--            <li><%=patent.trim()%></li>--%>
<%--            <%}%>--%>
<%--            <%}%>--%>
<%--        </ul>--%>
        <%}%>
        <%
            String currentLinkType = "";
            for (int i = 0; i < clinicalExtLinkData.size(); i++) {
                ClinicalTrialExternalLink cte = clinicalExtLinkData.get(i);
                if (cte.getType() != null && cte.getType().equalsIgnoreCase("Grant")) {
                    continue;
                }
                // Check if the current link_type is different from the previous
                if (!cte.getType().equals(currentLinkType)) {
                    // If it's not the first group, close the previous list
                    if (!currentLinkType.equals("")) { %>
        </ul>
        <% }
            currentLinkType = cte.getType(); %>
        <h5 class="link-type-heading"><%= currentLinkType %></h5>
        <ul class="external-links-list">
            <% }
                String linkName = cte.getName();
                String linkURL = cte.getLink();

                // Determine how to display the link
                if (linkName != null && !linkName.trim().isEmpty()) {
                    if (linkURL != null && !linkURL.trim().isEmpty()) { %>
            <li><a href="<%= linkURL %>" target="_blank"><%= linkName %></a></li>
            <% } else { %>
            <li><%= linkName %></li>
            <% }
            } else {
                // If link_name doesn't exist, display the link URL or a placeholder
                if (linkURL != null && !linkURL.trim().isEmpty()) { %>
            <li><a href="<%= linkURL %>" target="_blank"><%= linkURL %></a></li>
            <% } else { %>
            <li>No Link Available</li>
            <% }
            }
            }
                // Close the last list
                if (!currentLinkType.equals("")) { %>
        </ul>
        <% }
        %>
        <% } else { %>
        <div class="dynamic-heading" id="Resources">
            <h4 style="color: #94a3b8; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">Resources/Links</h4>
        </div>
        <hr>
        <table class="ctReportTable">
            <tr>
                <td class="label">Resources/Links</td>
                <td>
                    <p>No External Links Available.</p>
                </td>
            </tr>
        </table>
        <% } %>
        <% } %>

        <% if(isEditMode) { %>
        <div style="margin-top: 20px; text-align: center;">
            <button type="submit" class="btn btn-primary" onclick="return validateForm()" >Save Changes</button>
            <a href="/platform/data/report/clinicalTrials/<%=clinicalTrialData.getNctId()%>" class="btn btn-secondary">Cancel</a>
        </div>
        <% } %>
    </form>
</div>

<script src="/platform/js/clinicalTrialReport/clinicalTrialReport.js"></script>
<script>

    document.addEventListener('DOMContentLoaded', function() {
        <% if (session.getAttribute("showAlert") != null) { %>
        alert("Changes saved successfully!");
        <% session.removeAttribute("showAlert"); %>
        <% } %>
    });

</script>
</body>
</html>
