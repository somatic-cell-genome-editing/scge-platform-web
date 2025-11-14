<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 11/14/2025
  Time: 10:28 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div style="margin-bottom: 25px;">
    <h6 style="color: #007bff; text-decoration: underline; font-weight: bold;"><a href="https://scge.mcw.edu/phase-2-ind-enabling-studies/#vallabh" target="_blank" style="color: #007bff; text-decoration: underline;">Prion Disease Program (Broad Institute)</a></h6>
    <ul>
        <li>• <a href="/platform/public/download/regulatory?documentName='2025-02-10_PRNP-CHARM-001_INTERACT-noncon-v2.pdf'" target="_blank">INTERACT Meeting Briefing Book</a></li>
        <li>• <a href="/platform/public/download/regulatory?documentName='2025-02-10-PRNP-CHARM-INTERACT-feedback-CBER-noncon-v2.pdf'" target="_blank">Official FDA Responses</a></li>
    </ul>
    <div class="sidebar-publications">
        <button class="sidebar-pub-toggle" onclick="toggleSidebarPublications('sidebar-prion-pubs')">
            <i class="fas fa-file-alt"></i>
            <span>Publications (2)</span>
            <i class="fas fa-chevron-down sidebar-toggle-icon"></i>
        </button>
        <div class="sidebar-pub-content" id="sidebar-prion-pubs">
            <%--            <ul>--%>
            <%--                <li>• <a href="https://pubmed.ncbi.nlm.nih.gov/41175865/" target="_blank">How to create personalized gene editing platforms: Next steps towards interventional genetics (2025)</a></li>--%>
            <%--            </ul>--%>
            <%@include file="prion_publications.jsp"%>
        </div>
    </div>
</div>