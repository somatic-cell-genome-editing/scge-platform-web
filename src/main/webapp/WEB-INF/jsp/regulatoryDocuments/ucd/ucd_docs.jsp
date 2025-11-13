<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 11/6/2025
  Time: 2:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div style="margin-bottom: 25px;">
    <h6 style="color: #007bff; text-decoration: underline; font-weight: bold;"><a href="https://scge.mcw.edu/ind-enabling-studies-multiple-disease-platforms/#ahrens-nicklas" target="_blank" style="color: #007bff; text-decoration: underline;">UCD Program (CHOP/UPENN)</a></h6>
    <ul>
        <li>• <a href="/platform/public/download/regulatory?documentName='UCD Pre-IND briefing book redacted.pdf'" target="_blank">Pre-IND Briefing Book</a></li>
        <li>• <a href="/platform/public/download/regulatory?documentName='UCD FDA Signed_a_Meeting Summary_PS010343-CHOP redacted.pdf'" target="_blank">Pre-IND Official Responses/Meeting Summary</a></li>
    </ul>
    <div class="sidebar-publications">
        <button class="sidebar-pub-toggle" onclick="toggleSidebarPublications('sidebar-ucd-pubs')">
            <i class="fas fa-file-alt"></i>
            <span>Publications (1)</span>
            <i class="fas fa-chevron-down sidebar-toggle-icon"></i>
        </button>
        <div class="sidebar-pub-content" id="sidebar-ucd-pubs">
<%--            <ul>--%>
<%--                <li>• <a href="https://pubmed.ncbi.nlm.nih.gov/41175865/" target="_blank">How to create personalized gene editing platforms: Next steps towards interventional genetics (2025)</a></li>--%>
<%--            </ul>--%>
            <%@include file="ucd_publications.jsp"%>
        </div>
    </div>
</div>
