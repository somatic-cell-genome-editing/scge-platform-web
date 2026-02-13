<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link href="/platform/css/resources.css" rel="stylesheet" type="text/css"/>

<div class="page-header">
    <h3>IND Resources</h3>
    <p style="margin: 5px 0 0 0; color: #666;">Regulations, guidance documents, templates, and examples organized by CTD module and section</p>
</div>

<div class="resources-container">

    <!-- Back link -->
    <div style="margin-bottom: 15px;">
        <a href="/platform/data/ind/templates" style="color: #0066cc; text-decoration: none; font-weight: 500;">
            <i class="fa-solid fa-arrow-left"></i>&nbsp; Back to IND Application
        </a>
    </div>

    <!-- Module Tabs -->
    <ul class="nav nav-tabs" id="moduleTabs" role="tablist">
        <c:forEach var="module" begin="1" end="5">
            <li class="nav-item">
                <a class="nav-link ${module == 1 ? 'active' : ''}" id="module${module}-tab"
                   data-tab-target="#module${module}" href="#module${module}">
                    Module ${module}
                </a>
            </li>
        </c:forEach>
        <li class="nav-item">
            <a class="nav-link" id="general-tab"
               data-tab-target="#general" href="#general">
                General Resources
            </a>
        </li>
    </ul>

    <!-- Tab Content -->
    <div class="tab-content" id="moduleTabContent">

        <c:forEach var="module" begin="1" end="5">
            <div class="tab-pane fade ${module == 1 ? 'show active' : ''}" id="module${module}" role="tabpanel" aria-labelledby="module${module}-tab">
                <c:set var="sections" value="${moduleResources[module]}" />
                <c:choose>
                    <c:when test="${empty sections}">
                        <div class="empty-module">No resources available for Module ${module}.</div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="sectionEntry" items="${sections}">
                            <div class="section-block">
                                <div class="section-header">
                                    <span class="section-code">${sectionEntry.key}</span>
                                    <c:if test="${not empty sectionNames[sectionEntry.key]}">
                                        <span class="section-name">${sectionNames[sectionEntry.key]}</span>
                                    </c:if>
                                    <span class="resource-count">${fn:length(sectionEntry.value)} resource<c:if test="${fn:length(sectionEntry.value) != 1}">s</c:if></span>
                                </div>
                                <table class="table table-striped table-hover resource-table">
                                    <thead>
                                        <tr>
                                            <th>Resource Name</th>
                                            <th>Description</th>
                                            <th>Type</th>
                                            <th>Source</th>
                                            <th>Date Issued</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="resource" items="${sectionEntry.value}">
                                            <tr>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty resource.resourceUrl and resource.resourceUrl != 'null'}">
                                                            <a href="${resource.resourceUrl}" target="_blank" rel="noopener noreferrer">${resource.resourceName}</a>
                                                        </c:when>
                                                        <c:otherwise>${resource.resourceName}</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="description-cell">${resource.resourceDescription}</td>
                                                <td><span class="type-badge type-${fn:toLowerCase(resource.type)}">${resource.type}</span></td>
                                                <td>${resource.source}</td>
                                                <td class="date-cell">${resource.dateIssued}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:forEach>

        <!-- General Resources Tab -->
        <div class="tab-pane fade" id="general" role="tabpanel" aria-labelledby="general-tab">
            <c:choose>
                <c:when test="${empty generalResources}">
                    <div class="empty-module">No general resources available.</div>
                </c:when>
                <c:otherwise>
                    <div class="section-block">
                        <div class="section-header">
                            <span class="section-name">Resources applicable across all CTD modules</span>
                            <span class="resource-count">${fn:length(generalResources)} resource<c:if test="${fn:length(generalResources) != 1}">s</c:if></span>
                        </div>
                        <table class="table table-striped table-hover resource-table">
                            <thead>
                                <tr>
                                    <th>Resource Name</th>
                                    <th>Description</th>
                                    <th>Type</th>
                                    <th>Source</th>
                                    <th>Date Issued</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="resource" items="${generalResources}">
                                    <tr>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty resource.resourceUrl and resource.resourceUrl != 'null'}">
                                                    <a href="${resource.resourceUrl}" target="_blank" rel="noopener noreferrer">${resource.resourceName}</a>
                                                </c:when>
                                                <c:otherwise>${resource.resourceName}</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="description-cell">${resource.resourceDescription}</td>
                                        <td><span class="type-badge type-${fn:toLowerCase(resource.type)}">${resource.type}</span></td>
                                        <td>${resource.source}</td>
                                        <td class="date-cell">${resource.dateIssued}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
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
    });
</script>
