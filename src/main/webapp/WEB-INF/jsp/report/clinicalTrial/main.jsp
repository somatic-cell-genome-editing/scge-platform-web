<%--
  Created by IntelliJ IDEA.
  User: akundurthi
  Date: 10/10/2024
  Time: 9:28 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.mcw.scge.datamodel.ClinicalTrialRecord" %>
<%@ page import="edu.mcw.scge.datamodel.ClinicalTrialExternalLink" %>
<%@ page import="java.util.List" %>
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
%>

<%--<h4 class="mainTitle">--%>
<%--    <span class="report-label">Gene Therapy Trial Report:</span>--%>
<%--    <span class="brief-title"><%= clinicalTrialData.getBriefTitle() != null ? clinicalTrialData.getBriefTitle() : "" %></span>--%>
<%--</h4>--%>
<h3 style="color: #1a80b6; font-family: 'Roboto Slab', serif; font-weight: 400;">
    Gene Therapy Trial Report
</h3>
<div class="sidenav" id="navbar">
    <!-- Dynamic links will be added here -->
</div>
<div class="ctReportBody">
    <form class="ctReportForm">
        <input type="hidden" value="<%=clinicalTrialData.getNctId()%>"/>
        <div class="dynamic-heading" id="summary"><h3 class="ctSubHeading">Summary</h3></div>
        <h2 class="brief-title"><%= clinicalTrialData.getBriefTitle() != null ? clinicalTrialData.getBriefTitle() : "" %></h2>
        <hr>
        <table class="ctReportTable">
            <tr>
                <td class="label">
                    NCTID
                </td>
                <td>
                    <%=clinicalTrialData.getNctId()%>&nbsp;<a style="color: #1E90FF;font-weight: 600" href="https://www.clinicaltrials.gov/study/<%=clinicalTrialData.getNctId()%>" target="_blank">(View at clinicaltrials.gov)</a>
                </td>
            </tr>
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
                    Indication
                </td>
                <td>
                    <%=clinicalTrialData.getIndication()!=null?clinicalTrialData.getIndication():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Compound&nbsp;Name
                </td>
                <td>
                    <%= clinicalTrialData.getCompoundName() != null ? clinicalTrialData.getCompoundName() : "" %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Sponsor
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getSponsor()!=null?clinicalTrialData.getSponsor():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getSponsor()!=null?clinicalTrialData.getSponsor():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Funder&nbsp;Type
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getSponsorClass()!=null?clinicalTrialData.getSponsorClass():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getSponsorClass()!=null?clinicalTrialData.getSponsorClass().equalsIgnoreCase("NIH")?"NIH":clinicalTrialData.getSponsorClass():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Status
                </td>
                <%
                    String status = clinicalTrialData.getStudyStatus();
                    boolean recStatus = "Recruiting".equalsIgnoreCase(status)||"Not yet recruiting".equalsIgnoreCase(status);
                    String cssClass = recStatus?"status-recruiting":"status-other";
                %>
                <td>
                    <div class="status-container <%=cssClass%>">
                    <%=clinicalTrialData.getStudyStatus()!=null?clinicalTrialData.getStudyStatus():""%>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Enrollment&nbsp;Count
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getEnrorllmentCount()!=0?clinicalTrialData.getEnrorllmentCount():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getEnrorllmentCount()!=0?clinicalTrialData.getEnrorllmentCount():""%>
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
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getTargetGeneOrVariant()!=null?clinicalTrialData.getTargetGeneOrVariant():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getTargetGeneOrVariant()!=null?clinicalTrialData.getTargetGeneOrVariant():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Therapy&nbsp;Type
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getTherapyType()!=null?clinicalTrialData.getTherapyType():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getTherapyType()!=null?clinicalTrialData.getTherapyType():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Therapy&nbsp;Route
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getTherapyRoute()!=null?clinicalTrialData.getTherapyRoute():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getTherapyRoute()!=null?clinicalTrialData.getTherapyRoute():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Mechanism&nbsp;of&nbsp;Action
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getMechanismOfAction()!=null?clinicalTrialData.getMechanismOfAction():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getMechanismOfAction()!=null?clinicalTrialData.getMechanismOfAction():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Route&nbsp;of&nbsp;Administration
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getRouteOfAdministration()!=null?clinicalTrialData.getRouteOfAdministration():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getRouteOfAdministration()!=null?clinicalTrialData.getRouteOfAdministration():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Drug&nbsp;Product&nbsp;Type
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getDrugProductType()!=null?clinicalTrialData.getDrugProductType():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getDrugProductType()!=null?clinicalTrialData.getDrugProductType():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Target&nbsp;Tissue/Cell
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getTargetTissueOrCell()!=null?clinicalTrialData.getTargetTissueOrCell():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getTargetTissueOrCell()!=null?clinicalTrialData.getTargetTissueOrCell():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Delivery&nbsp;System
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getDeliverySystem()!=null?clinicalTrialData.getDeliverySystem():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getDeliverySystem()!=null?clinicalTrialData.getDeliverySystem():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Vector&nbsp;Type
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getVectorType()!=null?clinicalTrialData.getVectorType():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getVectorType()!=null?clinicalTrialData.getVectorType():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Editor&nbsp;Type
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getEditorType()!=null?clinicalTrialData.getEditorType():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getEditorType()!=null&&!clinicalTrialData.getEditorType().equalsIgnoreCase("none")?clinicalTrialData.getEditorType():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Dose&nbsp;1
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getDose1()!=null?clinicalTrialData.getDose1():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getDose1()!=null?clinicalTrialData.getDose1():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Dose&nbsp;2
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getDose2()!=null?clinicalTrialData.getDose2():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getDose2()!=null?clinicalTrialData.getDose2():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Dose&nbsp;3
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getDose3()!=null?clinicalTrialData.getDose3():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getDose3()!=null?clinicalTrialData.getDose3():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Dose&nbsp;4
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getDose4()!=null?clinicalTrialData.getDose4():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getDose4()!=null?clinicalTrialData.getDose4():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Dose&nbsp;5
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getDose5()!=null?clinicalTrialData.getDose5():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getDose5()!=null?clinicalTrialData.getDose5():""%>
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
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getPhase()!=null?clinicalTrialData.getPhase():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getPhase()!=null?clinicalTrialData.getPhase():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Submit&nbsp;Date
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getFirstSubmitDate()!=null?clinicalTrialData.getFirstSubmitDate():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getFirstSubmitDate()!=null?clinicalTrialData.getFirstSubmitDate():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Completion&nbsp;Date
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getEstimatedCompleteDate()!=null?clinicalTrialData.getEstimatedCompleteDate():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getEstimatedCompleteDate()!=null?clinicalTrialData.getEstimatedCompleteDate():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Last&nbsp;Update
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getLastUpdatePostDate()!=null?clinicalTrialData.getLastUpdatePostDate():""%>" readonly />--%>
<%--                </td>--%>
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
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=age!=null?age:""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=age!=null?age:""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Standard&nbsp;Ages
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getStandardAge()!=null?clinicalTrialData.getStandardAge():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getStandardAge()!=null?clinicalTrialData.getStandardAge():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Eligible&nbsp;Sex
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getEligibilitySex()!=null?clinicalTrialData.getEligibilitySex():""%>" readonly />--%>
<%--                </td>--%>
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
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getNumberOfLocations()!=0?clinicalTrialData.getNumberOfLocations():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getNumberOfLocations()!=0?clinicalTrialData.getNumberOfLocations():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Locations
                </td>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getLocation()!=null?clinicalTrialData.getLocation():""%>" readonly />--%>
<%--                </td>--%>
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
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getIsFDARegulated()!=null?clinicalTrialData.getIsFDARegulated():""%>" readonly />--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getIsFDARegulated()!=null?clinicalTrialData.getIsFDARegulated():""%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    Recent&nbsp;Updates
                </td>
<%--                <td>--%>
<%--                    <div class="readonly-field description-field"><%=clinicalTrialData.getRecentUpdates()!=null?clinicalTrialData.getRecentUpdates():""%></div>--%>
<%--                </td>--%>
                <td>
                    <%=clinicalTrialData.getRecentUpdates()!=null?clinicalTrialData.getRecentUpdates():""%>
                </td>
            </tr>
<%--            <tr>--%>
<%--                <td class="label">--%>
<%--                    Patents--%>
<%--                </td>--%>
<%--                <td>--%>
<%--                    <input type="text" class="readonly-field" value="<%=clinicalTrialData.getPatents()!=null?clinicalTrialData.getPatents():""%>" readonly />--%>
<%--                </td>--%>
<%--            </tr>--%>
        </table>

        <%-- External Links Section --%>
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
            <h4 style="color:grey;">Resources/Links</h4>
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

    </form>
</div>

<script src="/platform/js/clinicalTrialReport/clinicalTrialReport.js"></script>
</body>
</html>
