
<%@ page import="edu.mcw.scge.datamodel.ctd.CTDResource" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.stream.Collectors" %>
<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 8/20/2025
  Time: 12:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%
    try {
         externalResources=resourceDAO.getResourcesBySection(sectionCode.trim().replaceAll("_", "."));

        templates= externalResources!=null?externalResources.stream().filter(r -> r.getType() != null && r.getType().trim().equalsIgnoreCase("template") && r.getResourceName() != null && !r.getResourceName().trim().equals("")).toList():null;
        examples= externalResources!=null ?externalResources.stream().filter(r ->r.getType()!=null && r.getType().trim().equalsIgnoreCase("example")&& r.getResourceName()!=null && !r.getResourceName().trim().equals("")).toList():null;
        guidance= externalResources!=null ?externalResources.stream().filter(r ->r.getType()!=null && r.getType().trim().equalsIgnoreCase("guidance")&& r.getResourceName()!=null && !r.getResourceName().trim().equals("")).toList():null;
        regulation= externalResources!=null ?externalResources.stream().filter(r ->r.getType()!=null && r.getType().trim().equalsIgnoreCase("regulation")&& r.getResourceName()!=null && !r.getResourceName().trim().equals("")).toList():null;
        other= externalResources!=null ?externalResources.stream().filter(r -> ((r.getType()==null || r.getType().trim().equals("") || (!r.getType().trim().equalsIgnoreCase("example") && !r.getType().trim().equalsIgnoreCase("template") && !r.getType().trim().equalsIgnoreCase("guidance") && !r.getType().trim().equalsIgnoreCase("regulation"))) && (r.getResourceName()!=null && !r.getResourceName().trim().equals("")))).toList():null;
    } catch (Exception e) {
        throw new RuntimeException(e);
    }
%>

