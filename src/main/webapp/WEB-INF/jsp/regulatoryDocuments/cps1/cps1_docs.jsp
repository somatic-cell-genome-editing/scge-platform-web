<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar-program">
    <h6><a href="https://scge.mcw.edu/ind-enabling-studies-multiple-disease-platforms/#ahrens-nicklas" target="_blank">CPS1 Deficiency (Multiple Institutions)</a></h6>
    <div class="sidebar-publications">
        <button class="sidebar-pub-toggle" onclick="toggleSidebarPublications('sidebar-cps1-pubs')">
            <i class="fas fa-file-alt"></i>
            <span>Publications (1)</span>
            <i class="fas fa-chevron-down sidebar-toggle-icon"></i>
        </button>
        <div class="sidebar-pub-content" id="sidebar-cps1-pubs">
            <%@include file="cps1_publications.jsp"%>
        </div>
    </div>
</div>
