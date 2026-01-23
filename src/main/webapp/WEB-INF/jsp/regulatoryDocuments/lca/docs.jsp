<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 1/23/2026
  Time: 10:40 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar-program">
    <h6><a href="https://scge.mcw.edu/phase-2-ind-enabling-studies/#saha" target="_blank">Leber Congenital Amaurosis (UW-Madison)</a></h6>
    <div class="sidebar-publications">
        <button class="sidebar-pub-toggle" onclick="toggleSidebarPublications('sidebar-lca-pubs')">
            <i class="fas fa-file-alt"></i>
            <span>Publications (1)</span>
            <i class="fas fa-chevron-down sidebar-toggle-icon"></i>
        </button>
        <div class="sidebar-pub-content" id="sidebar-lca-pubs">
            <%@include file="publications.jsp"%>
        </div>
    </div>
</div>
