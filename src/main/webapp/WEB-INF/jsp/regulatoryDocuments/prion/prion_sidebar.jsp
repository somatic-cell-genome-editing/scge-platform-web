<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar-program">
    <h6><a href="https://scge.mcw.edu/phase-2-ind-enabling-studies/#vallabh" target="_blank">Prion Disease (Broad Institute)</a></h6>
    <ul class="sidebar-docs-list">
        <li><a href="/platform/public/download/regulatory?documentName='2025-02-10_PRNP-CHARM-001_INTERACT-noncon-v2.pdf'" target="_blank">INTERACT Briefing Book</a></li>
        <li><a href="/platform/public/download/regulatory?documentName='2025-02-10-PRNP-CHARM-INTERACT-feedback-CBER-noncon-v2.pdf'" target="_blank">FDA Responses</a></li>
    </ul>
    <div class="sidebar-publications">
        <button class="sidebar-pub-toggle" onclick="toggleSidebarPublications('sidebar-prion-pubs')">
            <i class="fas fa-file-alt"></i>
            <span>Publications (2)</span>
            <i class="fas fa-chevron-down sidebar-toggle-icon"></i>
        </button>
        <div class="sidebar-pub-content" id="sidebar-prion-pubs">
            <%@include file="prion_publications.jsp"%>
        </div>
    </div>
</div>