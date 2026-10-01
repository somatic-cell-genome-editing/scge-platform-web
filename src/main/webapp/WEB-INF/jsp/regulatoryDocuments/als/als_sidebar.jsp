<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar-program">
    <h6><a href="https://scge.mcw.edu/phase-2-ind-enabling-studies/#wilson" target="_blank">Amyotrophic Lateral Sclerosis-C9orf72 (UCSF)</a></h6>
    <div class="sidebar-publications">
        <button class="sidebar-pub-toggle" onclick="toggleSidebarPublications('sidebar-als-pubs')">
            <i class="fas fa-file-alt"></i>
            <span>Publications (6)</span>
            <i class="fas fa-chevron-down sidebar-toggle-icon"></i>
        </button>
        <div class="sidebar-pub-content" id="sidebar-als-pubs">
            <%@include file="als_publications.jsp"%>
        </div>
    </div>
</div>
