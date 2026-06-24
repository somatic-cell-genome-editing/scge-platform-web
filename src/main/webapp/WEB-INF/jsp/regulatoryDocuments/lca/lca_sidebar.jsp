<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 6/24/26
  Time: 11:31 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<<div class="sidebar-program">
<h6><a href="https://scge.mcw.edu/phase-2-ind-enabling-studies/#peranteau" target="_blank">Phenylketonuria (CHOP/UPENN)</a></h6>
<ul class="sidebar-docs-list">
    <li>
        <a href="/platform/public/download/regulatory?documentName='UW-LNP-ABE8E INTERACT Briefing Book_Redacted.pdf'" target="_blank">INTERACT Briefing Book</a>
    </li>
    <li>
        <a href="/platform/public/download/regulatory?documentName='UW-LNP-ABE8E Agency Response_Redacted.pdf'" target="_blank" >FDA Responses</a>
    </li>
</ul>
<div class="sidebar-publications">
    <button class="sidebar-pub-toggle" onclick="toggleSidebarPublications('sidebar-lca-pubs')">
        <i class="fas fa-file-alt"></i>
        <span>Publications (6)</span>
        <i class="fas fa-chevron-down sidebar-toggle-icon"></i>
    </button>
    <div class="sidebar-pub-content" id="sidebar-lca-pubs">
        <%@include file="publications.jsp"%>
    </div>
</div>
</div>