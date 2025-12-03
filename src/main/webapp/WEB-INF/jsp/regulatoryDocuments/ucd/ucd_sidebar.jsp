<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar-program">
    <h6><a href="https://scge.mcw.edu/ind-enabling-studies-multiple-disease-platforms/#ahrens-nicklas" target="_blank">UCD Program (CHOP/UPENN)</a></h6>
    <ul class="sidebar-docs-list">
        <li><a href="/platform/public/download/regulatory?documentName='UCD Pre-IND briefing book redacted.pdf'" target="_blank">Pre-IND Briefing Book</a></li>
        <li><a href="/platform/public/download/regulatory?documentName='UCD FDA Signed_a_Meeting Summary_PS010343-CHOP redacted.pdf'" target="_blank">Pre-IND Responses</a></li>
    </ul>
    <div class="sidebar-publications">
        <button class="sidebar-pub-toggle" onclick="toggleSidebarPublications('sidebar-ucd-pubs')">
            <i class="fas fa-file-alt"></i>
            <span>Publications (1)</span>
            <i class="fas fa-chevron-down sidebar-toggle-icon"></i>
        </button>
        <div class="sidebar-pub-content" id="sidebar-ucd-pubs">
            <%@include file="ucd_publications.jsp"%>
        </div>
    </div>
</div>
