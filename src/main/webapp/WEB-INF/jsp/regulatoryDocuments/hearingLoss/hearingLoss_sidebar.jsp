<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar-program">
    <h6><a href="https://scge.mcw.edu/ind-enabling-studies-multiple-disease-platforms/" target="_blank">Genetic Hearing Loss (Mass Eye and Ear)</a></h6>
    <div class="sidebar-publications">
        <button class="sidebar-pub-toggle" onclick="toggleSidebarPublications('sidebar-hearing-loss-pubs')">
            <i class="fas fa-file-alt"></i>
            <span>Publications (2)</span>
            <i class="fas fa-chevron-down sidebar-toggle-icon"></i>
        </button>
        <div class="sidebar-pub-content" id="sidebar-hearing-loss-pubs">
            <%@include file="hearingLoss_publications.jsp"%>
        </div>
    </div>
</div>
