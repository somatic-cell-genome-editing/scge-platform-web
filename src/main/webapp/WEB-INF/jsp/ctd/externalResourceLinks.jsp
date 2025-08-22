
<%@ page import="edu.mcw.scge.datamodel.ctd.CTDResource" %>
<%@ page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 8/20/2025
  Time: 12:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    try {
         externalResources=resourceDAO.getResourcesBySection(sectionCode.trim().replaceAll("_", "."));
    } catch (Exception e) {
        throw new RuntimeException(e);
    }
    if(externalResources!=null && externalResources.size()>0){%>
        <ul>
        <%for(CTDResource resource:externalResources){
%>
            <li><a href="<%=resource.getResourceUrl()%>" target="_blank"><%=resource.getResourceName()%></a>
            </li>
<%}%>
<%--            <li><a href="/platform/download/module?filename=hello.pdf">m1_1_FORM1571_fillablePDF.pdf</a></li>--%>
</ul>
    <%}%>