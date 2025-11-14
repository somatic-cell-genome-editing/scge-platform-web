<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 11/6/2025
  Time: 2:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div style="margin-bottom: 25px;">
    <h6 style="color: #007bff; text-decoration: underline; font-weight: bold;"><a href="https://scge.mcw.edu/phase-2-ind-enabling-studies/#peranteau" target="_blank" style="color: #007bff; text-decoration: underline;">PKU Program (CHOP/UPENN)</a></h6>
    <ul>
        <li>• <a href="/platform/public/download/regulatory?documentName='PKU Pre-IND briefing book redacted.pdf'" target="_blank">Pre-IND Briefing Book</a></li>
        <li>• <a href="/platform/public/download/regulatory?documentName='PKU FDA Preliminary Responses_PS008879_4 redacted.pdf'" target="_blank" >Pre-IND Official Responses/Meeting Summary</a></li>
    </ul>
    <div class="sidebar-publications">
        <button class="sidebar-pub-toggle" onclick="toggleSidebarPublications('sidebar-pku-pubs')">
            <i class="fas fa-file-alt"></i>
            <span>Publications (4)</span>
            <i class="fas fa-chevron-down sidebar-toggle-icon"></i>
        </button>
        <div class="sidebar-pub-content" id="sidebar-pku-pubs">
<%--            <ul>--%>
<%--                <li>• <a href="https://pubmed.ncbi.nlm.nih.gov/41175865/" target="_blank">How to create personalized gene editing platforms: Next steps towards interventional genetics (2025)</a></li>--%>
<%--                <li>• <a href="https://pubmed.ncbi.nlm.nih.gov/37924808/" target="_blank">Efficient in vivo prime editing corrects the most frequent phenylketonuria variant, associated with high unmet medical need (2023)</a></li>--%>
<%--                <li>• <a href="https://pubmed.ncbi.nlm.nih.gov/37301931/" target="_blank">Rapid and definitive treatment of phenylketonuria in variant-humanized mice with corrective editing (2023)</a></li>--%>
<%--                <li>• <a href="https://pubmed.ncbi.nlm.nih.gov/37922902/" target="_blank">A base editing strategy using mRNA-LNPs for in vivo correction of the most frequent phenylketonuria variant (2024)</a></li>--%>

<%--            </ul>--%>
            <%@include file="pku_publications.jsp"%>
        </div>
    </div>
</div>
