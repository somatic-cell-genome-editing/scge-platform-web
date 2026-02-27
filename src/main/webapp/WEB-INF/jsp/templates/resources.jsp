<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.mcw.scge.datamodel.ctd.CTDResource" %>
<%@ page import="java.util.*" %>

<%
    Map<Integer, Map<String, List<CTDResource>>> moduleResources =
        (Map<Integer, Map<String, List<CTDResource>>>) request.getAttribute("moduleResources");
    List<CTDResource> generalResources =
        (List<CTDResource>) request.getAttribute("generalResources");
    Map<String, String> sectionNames =
        (Map<String, String>) request.getAttribute("sectionNames");
%>

<link href="/platform/css/resources.css" rel="stylesheet" type="text/css"/>

<div class="page-header">
    <h3>General Resources For Formatting An IND</h3>
    <p style="margin: 5px 0 0 0; color: #666;">Templates, and examples organized by CTD module and section</p>
</div>

<div class="resources-container" style="position: relative;">

    <!-- AI Assistant Help Text -->
    <div style="position: absolute; top: 0; right: 0; text-align: center; font-size: 16px; color: #333; white-space: nowrap;">
        Need help finding a specific document?<br/>
        Click <a href="/assistant/chat" target="_blank" style="color: #2196F3; text-decoration: none; font-weight: 500;">here</a> for AI assistant
    </div>

    <!-- Back link -->
    <div style="margin-bottom: 15px;">
        <a href="/platform/data/ind/templates" style="color: #0066cc; text-decoration: none; font-weight: 500;">
            <i class="fa-solid fa-arrow-left"></i>&nbsp; Back to IND Application
        </a>
    </div>

    <!-- Module Tabs -->
    <ul class="nav nav-tabs" id="moduleTabs" role="tablist">
        <% for (int module = 1; module <= 5; module++) { %>
            <li class="nav-item">
                <a class="nav-link <%= (module == 1) ? "active" : "" %>" id="module<%=module%>-tab"
                   data-tab-target="#module<%=module%>" href="#module<%=module%>">
                    Module <%=module%>
                </a>
            </li>
        <% } %>
        <li class="nav-item">
            <a class="nav-link" id="general-tab"
               data-tab-target="#general" href="#general">
                General Resources
            </a>
        </li>
    </ul>

    <!-- Tab Content -->
    <div class="tab-content" id="moduleTabContent">

        <% for (int module = 1; module <= 5; module++) { %>
            <div class="tab-pane fade <%= (module == 1) ? "show active" : "" %>" id="module<%=module%>" role="tabpanel" aria-labelledby="module<%=module%>-tab">
                <%
                    Map<String, List<CTDResource>> sections = moduleResources.get(module);
                    if (sections == null || sections.isEmpty()) {
                %>
                    <div class="empty-module">No resources available for Module <%=module%>.</div>
                <% } else { %>
                    <table class="table table-striped table-hover resource-table">
                        <thead>
                            <tr>
                                <th>Resource Name</th>
                                <th>Description</th>
                                <th>Type</th>
                                <th>Source</th>
                                <th>Date Issued</th>
                                <th>Download</th>
                            </tr>
                        </thead>
                        <tbody>
                    <%
                        for (Map.Entry<String, List<CTDResource>> sectionEntry : sections.entrySet()) {
                            String sectionCode = sectionEntry.getKey();
                            List<CTDResource> resources = sectionEntry.getValue();
                            String sectionName = sectionNames.get(sectionCode);
                    %>
                            <% for (CTDResource resource : resources) { %>
                                <tr>
                                    <td>
                                        <% if (resource.getResourceUrl() != null && !resource.getResourceUrl().isEmpty() && !"null".equals(resource.getResourceUrl())) { %>
                                            <a href="<%=resource.getResourceUrl()%>" target="_blank" rel="noopener noreferrer"><%=resource.getResourceName()%></a>
                                        <% } else { %>
                                            <%=resource.getResourceName()%>
                                        <% } %>
                                    </td>
                                    <td class="description-cell"><%=resource.getResourceDescription() != null && !"null".equals(resource.getResourceDescription()) ? resource.getResourceDescription() : ""%></td>
                                    <td><span class="type-badge type-<%=resource.getType() != null ? resource.getType().toLowerCase() : ""%>"><%=resource.getType() != null && !"null".equals(resource.getType()) ? resource.getType() : ""%></span></td>
                                    <td><%=resource.getSource() != null && !"null".equals(resource.getSource()) ? resource.getSource() : ""%></td>
                                    <td class="date-cell"><%=resource.getDateIssued() != null && !"null".equals(resource.getDateIssued()) ? resource.getDateIssued() : ""%></td>
                                    <td>
                                        <% if (resource.getFilePath() != null && !resource.getFilePath().isEmpty() && !"null".equals(resource.getFilePath())) { %>
                                            <a href="/platform/public/download/module?path='<%=resource.getFilePath()%>'&filename=<%=resource.getResourceDescription() != null && !"null".equals(resource.getResourceDescription()) ? resource.getResourceDescription() : resource.getResourceName()%>" class="btn btn-sm btn-outline-primary" target="_blank"><i class="fa-solid fa-download"></i></a>
                                        <% } %>
                                    </td>
                                </tr>
                            <% } %>
                    <%  } %>
                        </tbody>
                    </table>
                <% } %>
            </div>
        <% } %>

        <!-- General Resources Tab -->
        <div class="tab-pane fade" id="general" role="tabpanel" aria-labelledby="general-tab">
            <% if (generalResources == null || generalResources.isEmpty()) { %>
                <div class="empty-module">No general resources available.</div>
            <% } else { %>
                <table class="table table-striped table-hover resource-table">
                    <thead>
                        <tr>
                            <th>Resource Name</th>
                            <th>Description</th>
                            <th>Type</th>
                            <th>Source</th>
                            <th>Date Issued</th>
                            <th>Download</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (CTDResource resource : generalResources) { %>
                            <tr>
                                <td>
                                    <% if (resource.getResourceUrl() != null && !resource.getResourceUrl().isEmpty() && !"null".equals(resource.getResourceUrl())) { %>
                                        <a href="<%=resource.getResourceUrl()%>" target="_blank" rel="noopener noreferrer"><%=resource.getResourceName()%></a>
                                    <% } else { %>
                                        <%=resource.getResourceName()%>
                                    <% } %>
                                </td>
                                <td class="description-cell"><%=resource.getResourceDescription() != null && !"null".equals(resource.getResourceDescription()) ? resource.getResourceDescription() : ""%></td>
                                <td><span class="type-badge type-<%=resource.getType() != null ? resource.getType().toLowerCase() : ""%>"><%=resource.getType() != null && !"null".equals(resource.getType()) ? resource.getType() : ""%></span></td>
                                <td><%=resource.getSource() != null && !"null".equals(resource.getSource()) ? resource.getSource() : ""%></td>
                                <td class="date-cell"><%=resource.getDateIssued() != null && !"null".equals(resource.getDateIssued()) ? resource.getDateIssued() : ""%></td>
                                <td>
                                    <% if (resource.getFilePath() != null && !resource.getFilePath().isEmpty() && !"null".equals(resource.getFilePath())) { %>
                                        <a href="/platform/public/download/module?path='<%=resource.getFilePath()%>'&filename=<%=resource.getResourceDescription() != null && !"null".equals(resource.getResourceDescription()) ? resource.getResourceDescription() : resource.getResourceName()%>" class="btn btn-sm btn-outline-primary" target="_blank"><i class="fa-solid fa-download"></i></a>
                                    <% } %>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        $('#moduleTabs a.nav-link').on('click', function(e) {
            e.preventDefault();
            // Deactivate all tabs and panes
            $('#moduleTabs a.nav-link').removeClass('active');
            $('#moduleTabContent .tab-pane').removeClass('show active');
            // Activate clicked tab and its pane
            $(this).addClass('active');
            $($(this).data('tab-target')).addClass('show active');
        });

        // Activate tab from URL hash (e.g. #general-tab)
        var hash = window.location.hash;
        if (hash) {
            var $tab = $('#moduleTabs a' + hash);
            if ($tab.length) {
                $tab.trigger('click');
            }
        }
    });
</script>
