<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar-program">
    <h6><a href="https://scge.mcw.edu/phase-2-ind-enabling-studies/#peranteau" target="_blank">PKU Program (CHOP/UPENN)</a></h6>
    <ul class="sidebar-docs-list">
        <li><a href="/platform/public/download/regulatory?documentName='PKU Pre-IND briefing book redacted.pdf'" target="_blank">Pre-IND Briefing Book</a></li>
        <li><a href="/platform/public/download/regulatory?documentName='PKU FDA Preliminary Responses_PS008879_4 redacted.pdf'" target="_blank">Pre-IND Responses</a></li>
    </ul>
    <div class="sidebar-publications">
        <button class="sidebar-pub-toggle" onclick="toggleSidebarPublications('sidebar-pku-pubs')">
            <i class="fas fa-file-alt"></i>
            <span>Publications (5)</span>
            <i class="fas fa-chevron-down sidebar-toggle-icon"></i>
        </button>
        <div class="sidebar-pub-content" id="sidebar-pku-pubs">
            <%@include file="pku_publications.jsp"%>
        </div>
    </div>
</div>
