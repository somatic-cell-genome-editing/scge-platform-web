<%--
  Created by IntelliJ IDEA.
  User: akundurthi
  Date: 10/10/2024
  Time: 9:28 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="edu.mcw.scge.services.SCGEContext" %>
<%@ page import="edu.mcw.scge.configuration.Access" %>
<%@ page import="edu.mcw.scge.datamodel.*" %>
<%@ page import="org.apache.commons.text.StringEscapeUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <link rel="stylesheet" href="/platform/css/clinicalReport.css" type="text/css">

<%
   ClinicalTrialRecord clinicalTrialData = (ClinicalTrialRecord) request.getAttribute("clinicalTrialData");
    List<ClinicalTrialExternalLink> clinicalExtLinkData = (List<ClinicalTrialExternalLink>) request.getAttribute("clinicalExtLinkData");
    List<Alias>aliasData = (List<Alias>) request.getAttribute("aliasData");
    List<ClinicalTrialAdditionalInfo>fdaInfo = (List<ClinicalTrialAdditionalInfo>) request.getAttribute("fdaInfo");
    Map<String, ClinicalTrialFieldChange> fieldChanges = (Map<String, ClinicalTrialFieldChange>) request.getAttribute("fieldChanges");
    Map<Integer, ClinicalTrialFieldChange> extLinkChanges = (Map<Integer, ClinicalTrialFieldChange>) request.getAttribute("extLinkChanges");
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
            <% if(isEditMode) {
                boolean recordStatusChanged = fieldChanges != null && fieldChanges.containsKey("record_status");
                ClinicalTrialFieldChange recordStatusChange = recordStatusChanged ? fieldChanges.get("record_status") : null;
            %>
            <tr class="<%= recordStatusChanged ? "curator-updated" : "" %>">
                <td class="label">
                    Record&nbsp;Status
                    <% if(recordStatusChanged) { %>
                    <span class="change-info-icon" data-old="<%= recordStatusChange.getOldValue() != null ? recordStatusChange.getOldValue() : "" %>" data-new="<%= recordStatusChange.getNewValue() != null ? recordStatusChange.getNewValue() : "" %>" data-updated="<%= recordStatusChange.getChangedAt() != null ? recordStatusChange.getChangedAt() : "" %>" data-by="<%= recordStatusChange.getUpdateBy() != null ? recordStatusChange.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <select name="recordStatus" style="width: 11%" class="form-control">
                        <option value="Active" <%=clinicalTrialData.getRecordStatus()!=null&&clinicalTrialData.getRecordStatus().equalsIgnoreCase("Active")?"selected":""%>>Active</option>
                        <option value="Inactive" <%=clinicalTrialData.getRecordStatus()!=null&&clinicalTrialData.getRecordStatus().equalsIgnoreCase("Inactive")?"selected":""%>>Inactive</option>
                        <option value="Draft" <%=clinicalTrialData.getRecordStatus()!=null&&clinicalTrialData.getRecordStatus().equalsIgnoreCase("Draft")?"selected":""%>>Draft</option>
                        <option value="Provisional" <%=clinicalTrialData.getRecordStatus()!=null&&clinicalTrialData.getRecordStatus().equalsIgnoreCase("Provisional")?"selected":""%>>Provisional</option>
                        <option value="NotForCuration" <%=clinicalTrialData.getRecordStatus()!=null&&clinicalTrialData.getRecordStatus().equalsIgnoreCase("NotForCuration")?"selected":""%>>NotForCuration</option>
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
            <% if(isEditMode) {
                boolean devStatusChanged = fieldChanges != null && fieldChanges.containsKey("development_status");
                ClinicalTrialFieldChange devStatusChange = devStatusChanged ? fieldChanges.get("development_status") : null;
            %>
            <tr class="<%= devStatusChanged ? "curator-updated" : "" %>">
                <td class="label">
                    Development&nbsp;Status
                    <% if(devStatusChanged) { %>
                    <span class="change-info-icon" data-old="<%= devStatusChange.getOldValue() != null ? devStatusChange.getOldValue() : "" %>" data-new="<%= devStatusChange.getNewValue() != null ? devStatusChange.getNewValue() : "" %>" data-updated="<%= devStatusChange.getChangedAt() != null ? devStatusChange.getChangedAt() : "" %>" data-by="<%= devStatusChange.getUpdateBy() != null ? devStatusChange.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <textarea name="developmentStatus" class="form-control" rows="1"><%=clinicalTrialData.getDevelopmentStatus()!=null?clinicalTrialData.getDevelopmentStatus():""%></textarea>
                </td>
            </tr>
            <% } else { %>
            <tr>
                <td class="label">Development&nbsp;Status</td>
                <td><strong><%=clinicalTrialData.getDevelopmentStatus()!=null?clinicalTrialData.getDevelopmentStatus():""%></strong></td>
            </tr>
            <% } %>
            <% if(isEditMode) {
                boolean indicationChanged = fieldChanges != null && fieldChanges.containsKey("indication");
                ClinicalTrialFieldChange indicationChange = indicationChanged ? fieldChanges.get("indication") : null;
            %>
            <tr class="<%= indicationChanged ? "curator-updated" : "" %>">
                <td class="label">
                    Indication
                    <% if(indicationChanged) { %>
                    <span class="change-info-icon" data-old="<%= indicationChange.getOldValue() != null ? indicationChange.getOldValue() : "" %>" data-new="<%= indicationChange.getNewValue() != null ? indicationChange.getNewValue() : "" %>" data-updated="<%= indicationChange.getChangedAt() != null ? indicationChange.getChangedAt() : "" %>" data-by="<%= indicationChange.getUpdateBy() != null ? indicationChange.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <textarea name="indication" class="form-control" rows="1"><%= clinicalTrialData.getIndication()!= null ? StringEscapeUtils.escapeHtml4(clinicalTrialData.getIndication()) : "" %></textarea>
                </td>
            </tr>
            <% } else { %>
            <tr>
                <td class="label">Indication</td>
                <td><%= clinicalTrialData.getIndication() != null ? clinicalTrialData.getIndication() : "" %></td>
            </tr>
            <% } %>
            <% if(isEditMode) {
                boolean doidChanged = fieldChanges != null && fieldChanges.containsKey("indication_doid");
                ClinicalTrialFieldChange doidChange = doidChanged ? fieldChanges.get("indication_doid") : null;
            %>
            <tr class="<%= doidChanged ? "curator-updated" : "" %>">
                <td class="label">
                    Disease&nbsp;Ontology&nbsp;Term
                    <% if(doidChanged) { %>
                    <span class="change-info-icon" data-old="<%= doidChange.getOldValue() != null ? doidChange.getOldValue() : "" %>" data-new="<%= doidChange.getNewValue() != null ? doidChange.getNewValue() : "" %>" data-updated="<%= doidChange.getChangedAt() != null ? doidChange.getChangedAt() : "" %>" data-by="<%= doidChange.getUpdateBy() != null ? doidChange.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <textarea name="indicationDOID" class="form-control" rows="1"><%=clinicalTrialData.getIndicationDOID()!=null?clinicalTrialData.getIndicationDOID():""%></textarea>
                </td>
            </tr>
            <% } else { %>
            <tr>
                <td class="label">Disease&nbsp;Ontology&nbsp;Term</td>
                <td>
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
            <%
                boolean hasExistingAlias = (aliasData != null && !aliasData.isEmpty());
                Alias existingAlias = hasExistingAlias ? aliasData.get(0) : new Alias();
            %>
            <% if(isEditMode) {
                boolean compoundNameChanged = fieldChanges != null && fieldChanges.containsKey("compound_name");
                ClinicalTrialFieldChange compoundNameChange = compoundNameChanged ? fieldChanges.get("compound_name") : null;
            %>
            <tr class="<%= compoundNameChanged ? "curator-updated" : "" %>">
                <td class="label">
                    Compound&nbsp;Name
                    <% if(compoundNameChanged) { %>
                    <span class="change-info-icon" data-old="<%= compoundNameChange.getOldValue() != null ? compoundNameChange.getOldValue() : "" %>" data-new="<%= compoundNameChange.getNewValue() != null ? compoundNameChange.getNewValue() : "" %>" data-updated="<%= compoundNameChange.getChangedAt() != null ? compoundNameChange.getChangedAt() : "" %>" data-by="<%= compoundNameChange.getUpdateBy() != null ? compoundNameChange.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <textarea name="compoundName" class="form-control" rows="1"><%= clinicalTrialData.getCompoundName() != null ? StringEscapeUtils.escapeHtml4(clinicalTrialData.getCompoundName()) : "" %></textarea>
                </td>
            </tr>
            <% } else { %>
            <tr>
                <td class="label">Compound&nbsp;Name</td>
                <td><%= clinicalTrialData.getCompoundName() != null ? clinicalTrialData.getCompoundName() : "" %></td>
            </tr>
            <% } %>

            <% if(isEditMode) {
                boolean aliasValueChanged = fieldChanges != null && fieldChanges.containsKey("alias_value");
                ClinicalTrialFieldChange aliasValueChange = aliasValueChanged ? fieldChanges.get("alias_value") : null;
            %>
            <tr class="<%= aliasValueChanged ? "curator-updated" : "" %>">
                <td class="label">
                    Compound&nbsp;Alias
                    <% if(aliasValueChanged) { %>
                    <span class="change-info-icon" data-old="<%= aliasValueChange.getOldValue() != null ? aliasValueChange.getOldValue() : "" %>" data-new="<%= aliasValueChange.getNewValue() != null ? aliasValueChange.getNewValue() : "" %>" data-updated="<%= aliasValueChange.getChangedAt() != null ? aliasValueChange.getChangedAt() : "" %>" data-by="<%= aliasValueChange.getUpdateBy() != null ? aliasValueChange.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
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
            <%
                boolean aliasTypeChanged = fieldChanges != null && fieldChanges.containsKey("alias_type");
                ClinicalTrialFieldChange aliasTypeChange = aliasTypeChanged ? fieldChanges.get("alias_type") : null;
            %>
            <tr class="<%= aliasTypeChanged ? "curator-updated" : "" %>">
                <td class="label">
                    Alias&nbsp;Type
                    <% if(aliasTypeChanged) { %>
                    <span class="change-info-icon" data-old="<%= aliasTypeChange.getOldValue() != null ? aliasTypeChange.getOldValue() : "" %>" data-new="<%= aliasTypeChange.getNewValue() != null ? aliasTypeChange.getNewValue() : "" %>" data-updated="<%= aliasTypeChange.getChangedAt() != null ? aliasTypeChange.getChangedAt() : "" %>" data-by="<%= aliasTypeChange.getUpdateBy() != null ? aliasTypeChange.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <textarea name="aliasType" placeholder="For example, proper name or proprietary name etc" class="form-control" rows="1"><%= hasExistingAlias && existingAlias.getAliasTypeLC() != null ? existingAlias.getAliasTypeLC() : "" %></textarea>
                </td>
            </tr>
            <%
                boolean aliasNotesChanged = fieldChanges != null && fieldChanges.containsKey("alias_notes");
                ClinicalTrialFieldChange aliasNotesChange = aliasNotesChanged ? fieldChanges.get("alias_notes") : null;
            %>
            <tr class="<%= aliasNotesChanged ? "curator-updated" : "" %>">
                <td class="label">
                    Alias&nbsp;Notes
                    <% if(aliasNotesChanged) { %>
                    <span class="change-info-icon" data-old="<%= aliasNotesChange.getOldValue() != null ? aliasNotesChange.getOldValue() : "" %>" data-new="<%= aliasNotesChange.getNewValue() != null ? aliasNotesChange.getNewValue() : "" %>" data-updated="<%= aliasNotesChange.getChangedAt() != null ? aliasNotesChange.getChangedAt() : "" %>" data-by="<%= aliasNotesChange.getUpdateBy() != null ? aliasNotesChange.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
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
            <% if(isEditMode) {
                boolean compoundDescChanged = fieldChanges != null && fieldChanges.containsKey("compound_description");
                ClinicalTrialFieldChange compoundDescChange = compoundDescChanged ? fieldChanges.get("compound_description") : null;
            %>
            <tr class="<%= compoundDescChanged ? "curator-updated" : "" %>">
                <td class="label">
                    Compound&nbsp;Description
                    <% if(compoundDescChanged) { %>
                    <span class="change-info-icon" data-old="<%= compoundDescChange.getOldValue() != null ? compoundDescChange.getOldValue() : "" %>" data-new="<%= compoundDescChange.getNewValue() != null ? compoundDescChange.getNewValue() : "" %>" data-updated="<%= compoundDescChange.getChangedAt() != null ? compoundDescChange.getChangedAt() : "" %>" data-by="<%= compoundDescChange.getUpdateBy() != null ? compoundDescChange.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <textarea name="compoundDescription" class="form-control" rows="1"><%= clinicalTrialData.getCompoundDescription() != null ? StringEscapeUtils.escapeHtml4(clinicalTrialData.getCompoundDescription()) : "" %></textarea>
                </td>
            </tr>
            <% } else if(clinicalTrialData.getCompoundDescription() != null && !clinicalTrialData.getCompoundDescription().isEmpty()) { %>
            <tr>
                <td class="label">Compound&nbsp;Description</td>
                <td><%= clinicalTrialData.getCompoundDescription() %></td>
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
            <% if(isEditMode) {
                boolean targetGeneChanged = fieldChanges != null && fieldChanges.containsKey("target_gene");
                ClinicalTrialFieldChange targetGeneChange = targetGeneChanged ? fieldChanges.get("target_gene") : null;
            %>
            <tr class="<%= targetGeneChanged ? "curator-updated" : "" %>">
                <td class="label">
                    Target&nbsp;Gene/Variant
                    <% if(targetGeneChanged) { %>
                    <span class="change-info-icon" data-old="<%= targetGeneChange.getOldValue() != null ? targetGeneChange.getOldValue() : "" %>" data-new="<%= targetGeneChange.getNewValue() != null ? targetGeneChange.getNewValue() : "" %>" data-updated="<%= targetGeneChange.getChangedAt() != null ? targetGeneChange.getChangedAt() : "" %>" data-by="<%= targetGeneChange.getUpdateBy() != null ? targetGeneChange.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <textarea name="targetGeneOrVariant" class="form-control" rows="1"><%=clinicalTrialData.getTargetGeneOrVariant()!=null?StringEscapeUtils.escapeHtml4(clinicalTrialData.getTargetGeneOrVariant()):""%></textarea>
                </td>
            </tr>
            <% } else { %>
            <tr>
                <td class="label">Target&nbsp;Gene/Variant</td>
                <td><%=clinicalTrialData.getTargetGeneOrVariant()!=null?clinicalTrialData.getTargetGeneOrVariant():""%></td>
            </tr>
            <% } %>
            <% if(isEditMode) {
                boolean therapyTypeChanged = fieldChanges != null && fieldChanges.containsKey("therapy_type");
                ClinicalTrialFieldChange therapyTypeChange = therapyTypeChanged ? fieldChanges.get("therapy_type") : null;
            %>
            <tr class="<%= therapyTypeChanged ? "curator-updated" : "" %>">
                <td class="label">
                    Therapy&nbsp;Type
                    <% if(therapyTypeChanged) { %>
                    <span class="change-info-icon" data-old="<%= therapyTypeChange.getOldValue() != null ? therapyTypeChange.getOldValue() : "" %>" data-new="<%= therapyTypeChange.getNewValue() != null ? therapyTypeChange.getNewValue() : "" %>" data-updated="<%= therapyTypeChange.getChangedAt() != null ? therapyTypeChange.getChangedAt() : "" %>" data-by="<%= therapyTypeChange.getUpdateBy() != null ? therapyTypeChange.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <textarea name="therapyType" class="form-control" rows="1"><%=clinicalTrialData.getTherapyType()!=null?StringEscapeUtils.escapeHtml4(clinicalTrialData.getTherapyType()):""%></textarea>
                </td>
            </tr>
            <% } else { %>
            <tr>
                <td class="label">Therapy&nbsp;Type</td>
                <td><%=clinicalTrialData.getTherapyType()!=null?clinicalTrialData.getTherapyType():""%></td>
            </tr>
            <% } %>
            <% if(isEditMode) {
                boolean therapyRouteChanged = fieldChanges != null && fieldChanges.containsKey("therapy_route");
                ClinicalTrialFieldChange therapyRouteChange = therapyRouteChanged ? fieldChanges.get("therapy_route") : null;
            %>
            <tr class="<%= therapyRouteChanged ? "curator-updated" : "" %>">
                <td class="label">
                    Therapy&nbsp;Route
                    <% if(therapyRouteChanged) { %>
                    <span class="change-info-icon" data-old="<%= therapyRouteChange.getOldValue() != null ? therapyRouteChange.getOldValue() : "" %>" data-new="<%= therapyRouteChange.getNewValue() != null ? therapyRouteChange.getNewValue() : "" %>" data-updated="<%= therapyRouteChange.getChangedAt() != null ? therapyRouteChange.getChangedAt() : "" %>" data-by="<%= therapyRouteChange.getUpdateBy() != null ? therapyRouteChange.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <textarea name="therapyRoute" class="form-control" rows="1"><%=clinicalTrialData.getTherapyRoute()!=null?StringEscapeUtils.escapeHtml4(clinicalTrialData.getTherapyRoute()):""%></textarea>
                </td>
            </tr>
            <% } else { %>
            <tr>
                <td class="label">Therapy&nbsp;Route</td>
                <td><%=clinicalTrialData.getTherapyRoute()!=null?clinicalTrialData.getTherapyRoute():""%></td>
            </tr>
            <% } %>
            <% if(isEditMode) {
                boolean moaChanged = fieldChanges != null && fieldChanges.containsKey("mechanism_of_action");
                ClinicalTrialFieldChange moaChange = moaChanged ? fieldChanges.get("mechanism_of_action") : null;
            %>
            <tr class="<%= moaChanged ? "curator-updated" : "" %>">
                <td class="label">
                    Mechanism&nbsp;of&nbsp;Action
                    <% if(moaChanged) { %>
                    <span class="change-info-icon" data-old="<%= moaChange.getOldValue() != null ? moaChange.getOldValue() : "" %>" data-new="<%= moaChange.getNewValue() != null ? moaChange.getNewValue() : "" %>" data-updated="<%= moaChange.getChangedAt() != null ? moaChange.getChangedAt() : "" %>" data-by="<%= moaChange.getUpdateBy() != null ? moaChange.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <textarea name="mechanismOfAction" class="form-control" rows="1"><%=clinicalTrialData.getMechanismOfAction()!=null?StringEscapeUtils.escapeHtml4(clinicalTrialData.getMechanismOfAction()):""%></textarea>
                </td>
            </tr>
            <% } else { %>
            <tr>
                <td class="label">Mechanism&nbsp;of&nbsp;Action</td>
                <td><%=clinicalTrialData.getMechanismOfAction()!=null?clinicalTrialData.getMechanismOfAction():""%></td>
            </tr>
            <% } %>
            <% if(isEditMode) {
                boolean roaChanged = fieldChanges != null && fieldChanges.containsKey("route_of_administration");
                ClinicalTrialFieldChange roaChange = roaChanged ? fieldChanges.get("route_of_administration") : null;
            %>
            <tr class="<%= roaChanged ? "curator-updated" : "" %>">
                <td class="label">
                    Route&nbsp;of&nbsp;Administration
                    <% if(roaChanged) { %>
                    <span class="change-info-icon" data-old="<%= roaChange.getOldValue() != null ? roaChange.getOldValue() : "" %>" data-new="<%= roaChange.getNewValue() != null ? roaChange.getNewValue() : "" %>" data-updated="<%= roaChange.getChangedAt() != null ? roaChange.getChangedAt() : "" %>" data-by="<%= roaChange.getUpdateBy() != null ? roaChange.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <textarea name="routeOfAdministration" class="form-control" rows="1"><%=clinicalTrialData.getRouteOfAdministration()!=null?StringEscapeUtils.escapeHtml4(clinicalTrialData.getRouteOfAdministration()):""%></textarea>
                </td>
            </tr>
            <% } else { %>
            <tr>
                <td class="label">Route&nbsp;of&nbsp;Administration</td>
                <td><%=clinicalTrialData.getRouteOfAdministration()!=null?clinicalTrialData.getRouteOfAdministration():""%></td>
            </tr>
            <% } %>
            <% if(isEditMode) {
                boolean drugProductTypeChanged = fieldChanges != null && fieldChanges.containsKey("drug_product_type");
                ClinicalTrialFieldChange drugProductTypeChange = drugProductTypeChanged ? fieldChanges.get("drug_product_type") : null;
            %>
            <tr class="<%= drugProductTypeChanged ? "curator-updated" : "" %>">
                <td class="label">
                    Drug&nbsp;Product&nbsp;Type
                    <% if(drugProductTypeChanged) { %>
                    <span class="change-info-icon" data-old="<%= drugProductTypeChange.getOldValue() != null ? drugProductTypeChange.getOldValue() : "" %>" data-new="<%= drugProductTypeChange.getNewValue() != null ? drugProductTypeChange.getNewValue() : "" %>" data-updated="<%= drugProductTypeChange.getChangedAt() != null ? drugProductTypeChange.getChangedAt() : "" %>" data-by="<%= drugProductTypeChange.getUpdateBy() != null ? drugProductTypeChange.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <textarea name="drugProductType" class="form-control" rows="1"><%=clinicalTrialData.getDrugProductType()!=null?StringEscapeUtils.escapeHtml4(clinicalTrialData.getDrugProductType()):""%></textarea>
                </td>
            </tr>
            <% } else { %>
            <tr>
                <td class="label">Drug&nbsp;Product&nbsp;Type</td>
                <td><%=clinicalTrialData.getDrugProductType()!=null?clinicalTrialData.getDrugProductType():""%></td>
            </tr>
            <% } %>
            <% if(isEditMode) {
                boolean targetTissueChanged = fieldChanges != null && fieldChanges.containsKey("target_tissue");
                ClinicalTrialFieldChange targetTissueChange = targetTissueChanged ? fieldChanges.get("target_tissue") : null;
            %>
            <tr class="<%= targetTissueChanged ? "curator-updated" : "" %>">
                <td class="label">
                    Target&nbsp;Tissue/Cell
                    <% if(targetTissueChanged) { %>
                    <span class="change-info-icon" data-old="<%= targetTissueChange.getOldValue() != null ? targetTissueChange.getOldValue() : "" %>" data-new="<%= targetTissueChange.getNewValue() != null ? targetTissueChange.getNewValue() : "" %>" data-updated="<%= targetTissueChange.getChangedAt() != null ? targetTissueChange.getChangedAt() : "" %>" data-by="<%= targetTissueChange.getUpdateBy() != null ? targetTissueChange.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <textarea name="targetTissueOrCell" class="form-control" rows="1"><%=clinicalTrialData.getTargetTissueOrCell()!=null?StringEscapeUtils.escapeHtml4(clinicalTrialData.getTargetTissueOrCell()):""%></textarea>
                </td>
            </tr>
            <% } else { %>
            <tr>
                <td class="label">Target&nbsp;Tissue/Cell</td>
                <td><%=clinicalTrialData.getTargetTissueOrCell()!=null?clinicalTrialData.getTargetTissueOrCell():""%></td>
            </tr>
            <% } %>
            <% if(isEditMode) {
                boolean deliverySystemChanged = fieldChanges != null && fieldChanges.containsKey("delivery_system");
                ClinicalTrialFieldChange deliverySystemChange = deliverySystemChanged ? fieldChanges.get("delivery_system") : null;
            %>
            <tr class="<%= deliverySystemChanged ? "curator-updated" : "" %>">
                <td class="label">
                    Delivery&nbsp;System
                    <% if(deliverySystemChanged) { %>
                    <span class="change-info-icon" data-old="<%= deliverySystemChange.getOldValue() != null ? deliverySystemChange.getOldValue() : "" %>" data-new="<%= deliverySystemChange.getNewValue() != null ? deliverySystemChange.getNewValue() : "" %>" data-updated="<%= deliverySystemChange.getChangedAt() != null ? deliverySystemChange.getChangedAt() : "" %>" data-by="<%= deliverySystemChange.getUpdateBy() != null ? deliverySystemChange.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <textarea name="deliverySystem" class="form-control" rows="1"><%=clinicalTrialData.getDeliverySystem()!=null?StringEscapeUtils.escapeHtml4(clinicalTrialData.getDeliverySystem()):""%></textarea>
                </td>
            </tr>
            <% } else { %>
            <tr>
                <td class="label">Delivery&nbsp;System</td>
                <td><%=clinicalTrialData.getDeliverySystem()!=null?clinicalTrialData.getDeliverySystem():""%></td>
            </tr>
            <% } %>
            <% if(isEditMode) {
                boolean vectorTypeChanged = fieldChanges != null && fieldChanges.containsKey("vector_type");
                ClinicalTrialFieldChange vectorTypeChange = vectorTypeChanged ? fieldChanges.get("vector_type") : null;
            %>
            <tr class="<%= vectorTypeChanged ? "curator-updated" : "" %>">
                <td class="label">
                    Vector&nbsp;Type
                    <% if(vectorTypeChanged) { %>
                    <span class="change-info-icon" data-old="<%= vectorTypeChange.getOldValue() != null ? vectorTypeChange.getOldValue() : "" %>" data-new="<%= vectorTypeChange.getNewValue() != null ? vectorTypeChange.getNewValue() : "" %>" data-updated="<%= vectorTypeChange.getChangedAt() != null ? vectorTypeChange.getChangedAt() : "" %>" data-by="<%= vectorTypeChange.getUpdateBy() != null ? vectorTypeChange.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <textarea name="vectorType" class="form-control" rows="1"><%=clinicalTrialData.getVectorType()!=null?StringEscapeUtils.escapeHtml4(clinicalTrialData.getVectorType()):""%></textarea>
                </td>
            </tr>
            <% } else { %>
            <tr>
                <td class="label">Vector&nbsp;Type</td>
                <td><%=clinicalTrialData.getVectorType()!=null?clinicalTrialData.getVectorType():""%></td>
            </tr>
            <% } %>
            <% if(isEditMode) {
                boolean editorTypeChanged = fieldChanges != null && fieldChanges.containsKey("editor_type");
                ClinicalTrialFieldChange editorTypeChange = editorTypeChanged ? fieldChanges.get("editor_type") : null;
            %>
            <tr class="<%= editorTypeChanged ? "curator-updated" : "" %>">
                <td class="label">
                    Editor&nbsp;Type
                    <% if(editorTypeChanged) { %>
                    <span class="change-info-icon" data-old="<%= editorTypeChange.getOldValue() != null ? editorTypeChange.getOldValue() : "" %>" data-new="<%= editorTypeChange.getNewValue() != null ? editorTypeChange.getNewValue() : "" %>" data-updated="<%= editorTypeChange.getChangedAt() != null ? editorTypeChange.getChangedAt() : "" %>" data-by="<%= editorTypeChange.getUpdateBy() != null ? editorTypeChange.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <textarea name="editorType" class="form-control" rows="1"><%=clinicalTrialData.getEditorType()!=null?StringEscapeUtils.escapeHtml4(clinicalTrialData.getEditorType()):""%></textarea>
                </td>
            </tr>
            <% } else { %>
            <tr>
                <td class="label">Editor&nbsp;Type</td>
                <td><%=clinicalTrialData.getEditorType()!=null?clinicalTrialData.getEditorType():""%></td>
            </tr>
            <% } %>
            <% if(isEditMode) {
                boolean dose1Changed = fieldChanges != null && fieldChanges.containsKey("dose_1");
                ClinicalTrialFieldChange dose1Change = dose1Changed ? fieldChanges.get("dose_1") : null;
            %>
            <tr class="<%= dose1Changed ? "curator-updated" : "" %>">
                <td class="label">
                    Dose&nbsp;1
                    <% if(dose1Changed) { %>
                    <span class="change-info-icon" data-old="<%= dose1Change.getOldValue() != null ? dose1Change.getOldValue() : "" %>" data-new="<%= dose1Change.getNewValue() != null ? dose1Change.getNewValue() : "" %>" data-updated="<%= dose1Change.getChangedAt() != null ? dose1Change.getChangedAt() : "" %>" data-by="<%= dose1Change.getUpdateBy() != null ? dose1Change.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <textarea name="dose1" class="form-control" rows="1"><%=clinicalTrialData.getDose1()!=null?clinicalTrialData.getDose1():""%></textarea>
                </td>
            </tr>
            <% } else { %>
            <tr>
                <td class="label">Dose&nbsp;1</td>
                <td><%=clinicalTrialData.getDose1()!=null?clinicalTrialData.getDose1():""%></td>
            </tr>
            <% } %>
            <% if(isEditMode) {
                boolean dose2Changed = fieldChanges != null && fieldChanges.containsKey("dose_2");
                ClinicalTrialFieldChange dose2Change = dose2Changed ? fieldChanges.get("dose_2") : null;
            %>
            <tr class="<%= dose2Changed ? "curator-updated" : "" %>">
                <td class="label">
                    Dose&nbsp;2
                    <% if(dose2Changed) { %>
                    <span class="change-info-icon" data-old="<%= dose2Change.getOldValue() != null ? dose2Change.getOldValue() : "" %>" data-new="<%= dose2Change.getNewValue() != null ? dose2Change.getNewValue() : "" %>" data-updated="<%= dose2Change.getChangedAt() != null ? dose2Change.getChangedAt() : "" %>" data-by="<%= dose2Change.getUpdateBy() != null ? dose2Change.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <textarea name="dose2" class="form-control" rows="1"><%=clinicalTrialData.getDose2()!=null?clinicalTrialData.getDose2():""%></textarea>
                </td>
            </tr>
            <% } else { %>
            <tr>
                <td class="label">Dose&nbsp;2</td>
                <td><%=clinicalTrialData.getDose2()!=null?clinicalTrialData.getDose2():""%></td>
            </tr>
            <% } %>
            <% if(isEditMode) {
                boolean dose3Changed = fieldChanges != null && fieldChanges.containsKey("dose_3");
                ClinicalTrialFieldChange dose3Change = dose3Changed ? fieldChanges.get("dose_3") : null;
            %>
            <tr class="<%= dose3Changed ? "curator-updated" : "" %>">
                <td class="label">
                    Dose&nbsp;3
                    <% if(dose3Changed) { %>
                    <span class="change-info-icon" data-old="<%= dose3Change.getOldValue() != null ? dose3Change.getOldValue() : "" %>" data-new="<%= dose3Change.getNewValue() != null ? dose3Change.getNewValue() : "" %>" data-updated="<%= dose3Change.getChangedAt() != null ? dose3Change.getChangedAt() : "" %>" data-by="<%= dose3Change.getUpdateBy() != null ? dose3Change.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <textarea name="dose3" class="form-control" rows="1"><%=clinicalTrialData.getDose3()!=null?clinicalTrialData.getDose3():""%></textarea>
                </td>
            </tr>
            <% } else { %>
            <tr>
                <td class="label">Dose&nbsp;3</td>
                <td><%=clinicalTrialData.getDose3()!=null?clinicalTrialData.getDose3():""%></td>
            </tr>
            <% } %>
            <% if(isEditMode) {
                boolean dose4Changed = fieldChanges != null && fieldChanges.containsKey("dose_4");
                ClinicalTrialFieldChange dose4Change = dose4Changed ? fieldChanges.get("dose_4") : null;
            %>
            <tr class="<%= dose4Changed ? "curator-updated" : "" %>">
                <td class="label">
                    Dose&nbsp;4
                    <% if(dose4Changed) { %>
                    <span class="change-info-icon" data-old="<%= dose4Change.getOldValue() != null ? dose4Change.getOldValue() : "" %>" data-new="<%= dose4Change.getNewValue() != null ? dose4Change.getNewValue() : "" %>" data-updated="<%= dose4Change.getChangedAt() != null ? dose4Change.getChangedAt() : "" %>" data-by="<%= dose4Change.getUpdateBy() != null ? dose4Change.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <textarea name="dose4" class="form-control" rows="1"><%=clinicalTrialData.getDose4()!=null?clinicalTrialData.getDose4():""%></textarea>
                </td>
            </tr>
            <% } else { %>
            <tr>
                <td class="label">Dose&nbsp;4</td>
                <td><%=clinicalTrialData.getDose4()!=null?clinicalTrialData.getDose4():""%></td>
            </tr>
            <% } %>
            <% if(isEditMode) {
                boolean dose5Changed = fieldChanges != null && fieldChanges.containsKey("dose_5");
                ClinicalTrialFieldChange dose5Change = dose5Changed ? fieldChanges.get("dose_5") : null;
            %>
            <tr class="<%= dose5Changed ? "curator-updated" : "" %>">
                <td class="label">
                    Dose&nbsp;5
                    <% if(dose5Changed) { %>
                    <span class="change-info-icon" data-old="<%= dose5Change.getOldValue() != null ? dose5Change.getOldValue() : "" %>" data-new="<%= dose5Change.getNewValue() != null ? dose5Change.getNewValue() : "" %>" data-updated="<%= dose5Change.getChangedAt() != null ? dose5Change.getChangedAt() : "" %>" data-by="<%= dose5Change.getUpdateBy() != null ? dose5Change.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <textarea name="dose5" class="form-control" rows="1"><%=clinicalTrialData.getDose5()!=null?clinicalTrialData.getDose5():""%></textarea>
                </td>
            </tr>
            <% } else { %>
            <tr>
                <td class="label">Dose&nbsp;5</td>
                <td><%=clinicalTrialData.getDose5()!=null?clinicalTrialData.getDose5():""%></td>
            </tr>
            <% } %>
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
            <%
                boolean fdaDesignationChanged = fieldChanges != null && fieldChanges.containsKey("fda_designation");
                ClinicalTrialFieldChange fdaDesignationChange = fdaDesignationChanged ? fieldChanges.get("fda_designation") : null;
            %>
            <tr>
                <td class="label">
                    FDA&nbsp;Designations
                    <% if(isEditMode && fdaDesignationChanged) { %>
                    <span class="change-info-icon" data-old="<%= fdaDesignationChange.getOldValue() != null ? fdaDesignationChange.getOldValue() : "" %>" data-new="<%= fdaDesignationChange.getNewValue() != null ? fdaDesignationChange.getNewValue() : "" %>" data-updated="<%= fdaDesignationChange.getChangedAt() != null ? fdaDesignationChange.getChangedAt() : "" %>" data-by="<%= fdaDesignationChange.getUpdateBy() != null ? fdaDesignationChange.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
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
            <% if(isEditMode) {
                boolean recentUpdatesChanged = fieldChanges != null && fieldChanges.containsKey("recent_updates");
                ClinicalTrialFieldChange recentUpdatesChange = recentUpdatesChanged ? fieldChanges.get("recent_updates") : null;
            %>
            <tr class="<%= recentUpdatesChanged ? "curator-updated" : "" %>">
                <td class="label">
                    Recent&nbsp;Updates
                    <% if(recentUpdatesChanged) { %>
                    <span class="change-info-icon" data-old="<%= recentUpdatesChange.getOldValue() != null ? recentUpdatesChange.getOldValue() : "" %>" data-new="<%= recentUpdatesChange.getNewValue() != null ? recentUpdatesChange.getNewValue() : "" %>" data-updated="<%= recentUpdatesChange.getChangedAt() != null ? recentUpdatesChange.getChangedAt() : "" %>" data-by="<%= recentUpdatesChange.getUpdateBy() != null ? recentUpdatesChange.getUpdateBy() : "" %>">🔄</span>
                    <% } %>
                </td>
                <td>
                    <textarea name="recentUpdates" class="form-control" rows="1"><%=clinicalTrialData.getRecentUpdates()!=null? StringEscapeUtils.escapeHtml4(clinicalTrialData.getRecentUpdates()):""%></textarea>
                </td>
            </tr>
            <% } else { %>
            <tr>
                <td class="label">Recent&nbsp;Updates</td>
                <td><%=clinicalTrialData.getRecentUpdates()!=null?clinicalTrialData.getRecentUpdates():""%></td>
            </tr>
            <% } %>
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
                        boolean extLinkChanged = extLinkChanges != null && extLinkChanges.containsKey(cext.getId());
                        ClinicalTrialFieldChange extLinkChange = extLinkChanged ? extLinkChanges.get(cext.getId()) : null;
                    %>
                <tr id="link-<%=cext.getId()%>" class="<%= extLinkChanged ? "curator-updated" : "" %>">
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
                    <td>
                        <button type="button" class="btn btn-danger" onclick="deleteExtLink(<%=cext.getId()%>)">Delete</button>
                        <% if(extLinkChanged) { %>
                        <span class="change-info-icon" data-old="<%= extLinkChange.getOldValue() != null ? extLinkChange.getOldValue() : "" %>" data-new="<%= extLinkChange.getNewValue() != null ? extLinkChange.getNewValue() : "" %>" data-updated="<%= extLinkChange.getChangedAt() != null ? extLinkChange.getChangedAt() : "" %>" data-by="<%= extLinkChange.getUpdateBy() != null ? extLinkChange.getUpdateBy() : "" %>">🔄</span>
                        <% } %>
                    </td>
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
        <% if (clinicalExtLinkData != null && clinicalExtLinkData.size() > 0||(clinicalTrialData.getPatents()!=null && !clinicalTrialData.getPatents().isEmpty())) { %>
        <div class="dynamic-heading" id="resources">
            <h3 class="ctSubHeading">Resources/Links</h3>
        </div>
        <hr>
        <%if(clinicalTrialData.getPatents()!=null&&!clinicalTrialData.getPatents().isEmpty()){
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

        // Initialize change info popovers from data attributes
        initChangePopovers();
    });

    // Format link values with bold labels
    function formatLinkValue(value) {
        if (!value) return '';
        return value
            .replace(/LinkType:/g, '<strong>LinkType:</strong>')
            .replace(/LinkName:/g, '<strong>LinkName:</strong>')
            .replace(/LinkUrl:/g, '<strong>LinkUrl:</strong>');
    }

    // Initialize popovers for elements with data-change attributes
    function initChangePopovers() {
        document.querySelectorAll('.change-info-icon[data-old]').forEach(function(icon) {
            var popover = document.createElement('div');
            popover.className = 'change-popover';
            var oldVal = formatLinkValue(icon.dataset.old || '');
            var newVal = formatLinkValue(icon.dataset.new || '');
            popover.innerHTML =
                '<div class="change-popover-header">📝 Field Updated</div>' +
                '<div class="change-popover-row"><span class="change-popover-label">Previous:</span>' +
                '<span class="change-popover-value change-popover-old">' + oldVal + '</span></div>' +
                '<div class="change-popover-row"><span class="change-popover-label">Current:</span>' +
                '<span class="change-popover-value change-popover-new">' + newVal + '</span></div>' +
                '<div class="change-popover-row"><span class="change-popover-label">Updated at:</span>' +
                '<span class="change-popover-value">' + (icon.dataset.updated || '') + '</span></div>' +
                '<div class="change-popover-row"><span class="change-popover-label">Updated by:</span>' +
                '<span class="change-popover-value">' + (icon.dataset.by || '') + '</span></div>';
            icon.parentNode.insertBefore(popover, icon.nextSibling);

            // Click to toggle popover visibility
            icon.addEventListener('click', function() {
                document.querySelectorAll('.change-popover.show').forEach(function(p) {
                    if (p !== popover) p.classList.remove('show');
                });
                popover.classList.toggle('show');
            });
        });
    }

    // Close popover when clicking outside
    document.addEventListener('click', function(event) {
        if (!event.target.closest('.change-info-icon') && !event.target.closest('.change-popover')) {
            document.querySelectorAll('.change-popover').forEach(function(p) {
                p.classList.remove('show');
            });
        }
    });

</script>

