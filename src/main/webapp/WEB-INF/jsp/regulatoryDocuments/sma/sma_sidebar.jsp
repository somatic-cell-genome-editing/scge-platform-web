<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar-program">
    <h6><a href="https://scge.mcw.edu/phase-2-ind-enabling-studies/#jackson" target="_blank">Spinal Muscular Atrophy (SMA)</a></h6>
    <ul class="sidebar-docs-list">
        <li>
            <a href="INTERACT_Meeting_Request_Final_04.30.2024_Redacted.pdf'" target="_blank">INTERACT Briefing Book</a>
        </li>
        <li>
            <a href="/platform/public/download/regulatory?documentName='SMA_Annotated_FDA_Responses_Redacted.pdf'" target="_blank">FDA Responses</a>        </li>

    </ul>
    <div class="sidebar-publications">
        <button class="sidebar-pub-toggle" onclick="toggleSidebarPublications('sidebar-sma-pubs')">
            <i class="fas fa-file-alt"></i>
            <span>Publications (1)</span>
            <i class="fas fa-chevron-down sidebar-toggle-icon"></i>
        </button>
        <div class="sidebar-pub-content" id="sidebar-sma-pubs">
            <%@include file="sma_publications.jsp"%>
        </div>
    </div>
</div>