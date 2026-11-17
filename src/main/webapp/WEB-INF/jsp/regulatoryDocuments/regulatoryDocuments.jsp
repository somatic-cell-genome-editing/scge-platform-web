<%--
  SCGE Shared Regulatory Documents.

  Every program, document and publication on this page comes from the
  regulatory_* tables (see db/regulatory_documents_schema.sql), loaded by
  DocumentsController into "diseaseAreas". Curating the page is an INSERT -
  there is nothing here to edit when a program or a document is added.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link href="/platform/css/regulatoryDocuments.css" rel="stylesheet" type="text/css"/>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3">
            <div class="sidebar-content">
                <h5>Contents</h5>
                <c:forEach var="area" items="${diseaseAreas}">
                    <c:forEach var="program" items="${area.programs}">
                        <%-- A program with neither documents nor publications has
                             nothing for the sidebar to link to. --%>
                        <c:if test="${program.listedInSidebar}">
                            <div class="sidebar-program">
                                <h6>
                                    <c:choose>
                                        <c:when test="${not empty program.programUrl}">
                                            <a href="${fn:escapeXml(program.programUrl)}" target="_blank"><c:out value="${program.sidebarName}"/></a>
                                        </c:when>
                                        <c:otherwise><c:out value="${program.sidebarName}"/></c:otherwise>
                                    </c:choose>
                                </h6>

                                <c:if test="${not empty program.documents}">
                                    <ul class="sidebar-docs-list">
                                        <c:forEach var="document" items="${program.documents}">
                                            <c:url var="documentUrl" value="/public/download/regulatory">
                                                <c:param name="documentName" value="${document.fileName}"/>
                                            </c:url>
                                            <li><a href="${fn:escapeXml(documentUrl)}" target="_blank"><c:out value="${document.label}"/></a></li>
                                        </c:forEach>
                                    </ul>
                                </c:if>

                                <c:if test="${not empty program.publications}">
                                    <div class="sidebar-publications">
                                        <button class="sidebar-pub-toggle" onclick="toggleSidebarPublications('${fn:escapeXml(program.sidebarPublicationsId)}')">
                                            <i class="fas fa-file-alt"></i>
                                            <span>Publications (${fn:length(program.publications)})</span>
                                            <i class="fas fa-chevron-down sidebar-toggle-icon"></i>
                                        </button>
                                        <div class="sidebar-pub-content" id="${fn:escapeXml(program.sidebarPublicationsId)}">
                                            <div class="publications-container">
                                                <h5 class="publications-title">
                                                    <i class="fas fa-file-alt"></i> <c:out value="${program.programName}"/> Publications
                                                </h5>
                                                <ul class="publications-list">
                                                    <c:forEach var="publication" items="${program.publications}">
                                                        <li>
                                                            <a href="${fn:escapeXml(publication.url)}" target="_blank"><c:out value="${publication.displayTitle}"/></a>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:forEach>
            </div>
        </div>

        <!-- Main Content -->
        <div class="col-md-9">
            <div class="main-content-area">
                <h1 class="page-title">SCGE Shared Regulatory Documents</h1>

                <div class="intro-text">
                    <p>
                        The Somatic Cell Genome Editing (SCGE) Consortium is an NIH Common Fund program created to accelerate translational research in genome editing. A primary goal is to disseminate documents generated through regulatory interactions between the U.S. Food and Drug Administration (FDA) and consortium projects to help the rare disease communities and the providers and researchers that serve them.
                    </p>
                </div>

                <!-- Gantt Chart Table -->
                <table class="gantt-table">
                    <thead>
                        <tr>
                            <th style="width: 140px;">Disease Area</th>
                            <th style="width: 180px;">Program</th>
                            <th>Lead<br>Optimization</th>
                            <th class="phase-column">INTERACT<br>Meeting</th>
                            <th class="phase-column">Pre-IND<br>Meeting</th>
                            <th class="phase-column">IND Enabling<br>Studies</th>
                            <th class="phase-column">Clinical Trial<br>Initiated</th>
                            <th style="width: 80px;">Publications</th>
                            <th style="width: 80px;">Regulatory Documents</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="area" items="${diseaseAreas}">
                        <c:forEach var="program" items="${area.programs}" varStatus="programStatus">
                        <tr>
                            <c:if test="${programStatus.first}">
                            <%-- One icon cell per disease area, spanning its programs. The
                                 page script bumps the rowspan as panels are opened. --%>
                            <td rowspan="${area.rowSpan}" class="disease-area-cell">
                                <div class="disease-icon-container">
                                    <div class="disease-icon ${fn:escapeXml(area.cssClass)}">
                                        <c:choose>
                                            <c:when test="${not empty area.iconImage}">
                                                <img src="${fn:escapeXml(area.iconImage)}" alt="<c:out value="${area.name}"/>"/>
                                            </c:when>
                                            <c:when test="${not empty area.iconClass}">
                                                <i class="${fn:escapeXml(area.iconClass)}"></i>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                    <div class="disease-label"><c:out value="${area.name}"/></div>
                                </div>
                            </td>
                            </c:if>

                            <td class="program-name">
                                <c:choose>
                                    <c:when test="${not empty program.programUrl}">
                                        <a href="${fn:escapeXml(program.programUrl)}" target="_blank"><c:out value="${program.programName}"/></a>
                                    </c:when>
                                    <c:otherwise><c:out value="${program.programName}"/></c:otherwise>
                                </c:choose>
                            </td>

                            <td colspan="5" style="position: relative;">
                                <div class="timeline-bar" style="left: 5px; width: ${program.timelineWidthPct}%;"></div>
                            </td>

                            <td class="publications-cell">
                                <c:choose>
                                    <c:when test="${not empty program.publications}">
                                        <button class="publications-toggle" onclick="togglePublications('${fn:escapeXml(program.publicationsRowId)}')">
                                            <i class="fas fa-file-alt"></i>
                                            <span class="pub-count">${fn:length(program.publications)}</span>
                                            <i class="fas fa-chevron-down toggle-icon"></i>
                                        </button>
                                    </c:when>
                                    <c:otherwise><div class="no-publications">&mdash;</div></c:otherwise>
                                </c:choose>
                            </td>

                            <td class="publications-cell">
                                <c:choose>
                                    <c:when test="${not empty program.documents}">
                                        <button class="publications-toggle docs-toggle" onclick="togglePublications('${fn:escapeXml(program.documentsRowId)}')">
                                            <i class="fas fa-folder-open"></i>
                                            <span class="pub-count">${fn:length(program.documents)}</span>
                                            <i class="fas fa-chevron-down toggle-icon"></i>
                                        </button>
                                    </c:when>
                                    <c:otherwise><div class="no-publications">&mdash;</div></c:otherwise>
                                </c:choose>
                            </td>
                        </tr>

                        <c:if test="${not empty program.publications}">
                        <tr class="publications-row" id="${fn:escapeXml(program.publicationsRowId)}">
                            <td colspan="9" class="publications-content">
                                <div class="publications-container">
                                    <h5 class="publications-title">
                                        <i class="fas fa-file-alt"></i> <c:out value="${program.programName}"/> Publications
                                    </h5>
                                    <ul class="publications-list">
                                        <c:forEach var="publication" items="${program.publications}">
                                            <li>
                                                <a href="${fn:escapeXml(publication.url)}" target="_blank"><c:out value="${publication.displayTitle}"/></a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                        </c:if>

                        <c:if test="${not empty program.documents}">
                        <tr class="publications-row" id="${fn:escapeXml(program.documentsRowId)}">
                            <td colspan="9" class="publications-content">
                                <div class="publications-container">
                                    <h5 class="publications-title">
                                        <i class="fas fa-folder-open"></i> <c:out value="${program.programName}"/> Documents
                                    </h5>
                                    <ul class="publications-list">
                                        <c:forEach var="document" items="${program.documents}">
                                            <c:url var="documentUrl" value="/public/download/regulatory">
                                                <c:param name="documentName" value="${document.fileName}"/>
                                            </c:url>
                                            <li>
                                                <a href="${fn:escapeXml(documentUrl)}" target="_blank"><c:out value="${document.label}"/></a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                        </c:if>
                        </c:forEach>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
function findDiseaseAreaCell(pubRow) {
    var prevRow = pubRow.previousElementSibling;
    while (prevRow) {
        var diseaseCell = prevRow.querySelector('.disease-area-cell');
        if (diseaseCell) {
            return diseaseCell;
        }
        prevRow = prevRow.previousElementSibling;
    }
    return null;
}

function togglePublications(rowId) {
    const row = document.getElementById(rowId);
    const button = event.currentTarget;
    const icon = button.querySelector('.toggle-icon');

    if (row.classList.contains('active')) {
        row.classList.remove('active');
        icon.classList.remove('fa-chevron-up');
        icon.classList.add('fa-chevron-down');
        // Decrease rowspan when hiding
        var cell = findDiseaseAreaCell(row);
        if (cell) cell.rowSpan -= 1;
    } else {
        // Close all other open publications and adjust their rowspans
        document.querySelectorAll('.publications-row.active').forEach(openRow => {
            openRow.classList.remove('active');
            var cell = findDiseaseAreaCell(openRow);
            if (cell) cell.rowSpan -= 1;
        });
        document.querySelectorAll('.toggle-icon.fa-chevron-up').forEach(openIcon => {
            openIcon.classList.remove('fa-chevron-up');
            openIcon.classList.add('fa-chevron-down');
        });

        // Open clicked publication and increase rowspan
        row.classList.add('active');
        icon.classList.remove('fa-chevron-down');
        icon.classList.add('fa-chevron-up');
        var cell = findDiseaseAreaCell(row);
        if (cell) cell.rowSpan += 1;
    }
}

function toggleSidebarPublications(contentId) {
    const content = document.getElementById(contentId);
    const button = event.currentTarget;

    if (content.classList.contains('active')) {
        content.classList.remove('active');
        button.classList.remove('active');
    } else {
        content.classList.add('active');
        button.classList.add('active');
    }
}
</script>
