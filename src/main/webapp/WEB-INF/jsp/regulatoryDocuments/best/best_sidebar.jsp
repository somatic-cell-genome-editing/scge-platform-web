<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 6/24/26
  Time: 11:31 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar-program">
<h6><a href="https://scge.mcw.edu/phase-2-ind-enabling-studies/#saha" target="_blank">Best Disease (UW-Madison)</a></h6>
<ul class="sidebar-docs-list">
    <li>
        <a href="/platform/public/download/regulatory?documentName=UW-LNP-SpCaS9-BEST1-R218C_PS010799_INTERACT_Briefing_Book_Redacted.pdf" target="_blank">INTERACT Briefing Book</a>
    </li>
    <li>
        <a href="/platform/public/download/regulatory?documentName='Annotated_Preliminary_Response_University_of_Wisconsin_PS010799_Meeting_ID_22451_for_sponsor_Redacted.pdf'" target="_blank" >FDA Responses</a>
    </li>
</ul>
<div class="sidebar-publications">
    <button class="sidebar-pub-toggle" onclick="toggleSidebarPublications('sidebar-best-pubs')">
        <i class="fas fa-file-alt"></i>
        <span>Publications (2)</span>
        <i class="fas fa-chevron-down sidebar-toggle-icon"></i>
    </button>
    <div class="sidebar-pub-content" id="sidebar-best-pubs">
        <%@include file="publications.jsp"%>
    </div>
</div>
</div>