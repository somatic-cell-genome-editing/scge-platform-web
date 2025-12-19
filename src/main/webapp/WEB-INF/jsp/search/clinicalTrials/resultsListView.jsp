<%@ page import="java.util.stream.Collectors" %>
<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 12/19/2025
  Time: 10:00 AM
  List View for Clinical Trials Results
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="results-list-view">
    <% for(SearchHit hit : hits) {
        Map<String, Object> sourceFields = hit.getSourceAsMap();
        String nctId = sourceFields.get("nctId") != null ? sourceFields.get("nctId").toString() : "";
        String indication = sourceFields.get("indication") != null ? sourceFields.get("indication").toString() : "N/A";
        String sponsor = sourceFields.get("sponsor") != null ? sourceFields.get("sponsor").toString() : "N/A";
        String sponsorClass = sourceFields.get("sponsorClass") != null ? sourceFields.get("sponsorClass").toString() : "";
        String compoundName = sourceFields.get("compoundName") != null ? sourceFields.get("compoundName").toString() : "";
        String therapyType = sourceFields.get("therapyType") != null ? sourceFields.get("therapyType").toString() : "";
        String targetGene = sourceFields.get("targetGeneOrVariant") != null ? sourceFields.get("targetGeneOrVariant").toString() : "";
        String vectorType = sourceFields.get("vectorType") != null ? sourceFields.get("vectorType").toString() : "";
        String deliverySystem = sourceFields.get("deliverySystem") != null ? sourceFields.get("deliverySystem").toString() : "";
        String mechanismOfAction = sourceFields.get("mechanismOfAction") != null ? sourceFields.get("mechanismOfAction").toString() : "";
        String firstSubmitDate = sourceFields.get("firstSubmitDate") != null ? sourceFields.get("firstSubmitDate").toString() : "";
        String lastUpdateDate = sourceFields.get("lastUpdatePostDate") != null ? sourceFields.get("lastUpdatePostDate").toString() : "";
        String recordModifiedDate = sourceFields.get("recordModifiedDate") != null ? sourceFields.get("recordModifiedDate").toString() : "";
        String enrollmentCount = sourceFields.get("enrorllmentCount") != null ? sourceFields.get("enrorllmentCount").toString() : "";
        String numberOfLocations = sourceFields.get("numberOfLocations") != null ? sourceFields.get("numberOfLocations").toString() : "";

        List<String> phases = sourceFields.get("phases") != null ? (List<String>) sourceFields.get("phases") : new ArrayList<>();
        String phase = phases.stream().collect(Collectors.joining(", "));

        List<String> statuses = sourceFields.get("status") != null ? (List<String>) sourceFields.get("status") : new ArrayList<>();
        String status = statuses.size() > 0 ? statuses.get(0) : "N/A";

        List<String> fdaDesignations = sourceFields.get("fdaDesignations") != null ? (List<String>) sourceFields.get("fdaDesignations") : new ArrayList<>();
        String fdaDesignation = fdaDesignations.stream().collect(Collectors.joining(", "));

        List<String> locationsList = sourceFields.get("locations") != null ? (List<String>) sourceFields.get("locations") : new ArrayList<>();
        String locations = locationsList.stream().limit(3).collect(Collectors.joining(", "));
        if(locationsList.size() > 3) {
            locations += " + " + (locationsList.size() - 3) + " more";
        }
    %>
    <div class="list-view-card">
        <div class="list-view-header">
            <div class="list-view-title">
                <a href="/platform/data/report/clinicalTrials/<%=nctId%>" target="_blank" class="list-view-nct-link"><%=nctId%></a>
                <span class="list-view-status status-<%=status.toLowerCase().replace(" ", "-").replace(",", "")%>"><%=status%></span>
                <% if(!phase.isEmpty()) { %>
                <span class="list-view-phase"><%=phase%></span>
                <% } %>
            </div>
            <div class="list-view-actions">
                <a href="/platform/data/report/clinicalTrials/<%=nctId%>" target="_blank" class="btn btn-sm btn-primary">View Report</a>
            </div>
        </div>

        <div class="list-view-indication"><%=indication%></div>

        <div class="list-view-body">
            <div class="list-view-row">
                <div class="list-view-field">
                    <span class="list-view-label">Sponsor</span>
                    <span class="list-view-value"><%=sponsor%><% if(!sponsorClass.isEmpty() && !sponsorClass.equals("null")) { %> <small>(<%=sponsorClass%>)</small><% } %></span>
                </div>
                <% if(!compoundName.isEmpty() && !compoundName.equals("null")) { %>
                <div class="list-view-field">
                    <span class="list-view-label">Compound</span>
                    <span class="list-view-value"><%=compoundName%></span>
                </div>
                <% } %>
                <% if(!therapyType.isEmpty() && !therapyType.equals("null")) { %>
                <div class="list-view-field">
                    <span class="list-view-label">Therapy Type</span>
                    <span class="list-view-value"><%=therapyType%></span>
                </div>
                <% } %>
            </div>

            <div class="list-view-row">
                <% if(!targetGene.isEmpty() && !targetGene.equals("null")) { %>
                <div class="list-view-field">
                    <span class="list-view-label">Target Gene</span>
                    <span class="list-view-value"><%=targetGene%></span>
                </div>
                <% } %>
                <% if(!vectorType.isEmpty() && !vectorType.equals("null")) { %>
                <div class="list-view-field">
                    <span class="list-view-label">Vector Type</span>
                    <span class="list-view-value"><%=vectorType%></span>
                </div>
                <% } %>
                <% if(!deliverySystem.isEmpty() && !deliverySystem.equals("null")) { %>
                <div class="list-view-field">
                    <span class="list-view-label">Delivery System</span>
                    <span class="list-view-value"><%=deliverySystem%></span>
                </div>
                <% } %>
            </div>

            <% if(!mechanismOfAction.isEmpty() && !mechanismOfAction.equals("null")) { %>
            <div class="list-view-row">
                <div class="list-view-field full-width">
                    <span class="list-view-label">Mechanism of Action</span>
                    <span class="list-view-value"><%=mechanismOfAction%></span>
                </div>
            </div>
            <% } %>

            <% if(!fdaDesignation.isEmpty()) { %>
            <div class="list-view-row">
                <div class="list-view-field full-width">
                    <span class="list-view-label">FDA Designations</span>
                    <span class="list-view-value"><%=fdaDesignation%></span>
                </div>
            </div>
            <% } %>
        </div>

        <div class="list-view-footer">
            <div class="list-view-meta">
                <% if(!firstSubmitDate.isEmpty() && !firstSubmitDate.equals("null")) { %>
                <span><i class="fa fa-calendar"></i> First Submitted: <%=firstSubmitDate%></span>
                <% } %>
<%--                <% if(!lastUpdateDate.isEmpty() && !lastUpdateDate.equals("null")) { %>--%>
<%--                <span><i class="fa fa-refresh"></i> Last Update Post Date: <%=lastUpdateDate%></span>--%>
<%--                <% } %>--%>
                <% if(!recordModifiedDate.isEmpty() && !recordModifiedDate.equals("null")) { %>
                <span><i class="fa fa-refresh"></i> Last Modified Date: <%=recordModifiedDate%></span>
                <% } %>
                <% if(!enrollmentCount.isEmpty() && !enrollmentCount.equals("null")) { %>
                <span><i class="fa fa-users"></i> Enrollment: <%=enrollmentCount%></span>
                <% } %>
                <% if(!locations.isEmpty()) { %>
                <span><i class="fa fa-map-marker"></i> <%=locations%></span>
                <% } %>
            </div>
        </div>
    </div>
    <% } %>
</div>
