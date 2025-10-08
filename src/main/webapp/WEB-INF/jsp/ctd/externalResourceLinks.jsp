
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
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    try {
         externalResources=resourceDAO.getResourcesBySection(sectionCode.trim().replaceAll("_", "."));

        templates= externalResources!=null?externalResources.stream().filter(r -> r.getType() != null && r.getType().equalsIgnoreCase("template") && r.getResourceName() != null && !r.getResourceName().trim().equals("")).toList():null;
        examples= externalResources!=null ?externalResources.stream().filter(r ->r.getType()!=null && r.getType().equalsIgnoreCase("example")&& r.getResourceName()!=null && !r.getResourceName().trim().equals("")).toList():null;
        other= externalResources!=null ?externalResources.stream().filter(r -> ((r.getType()==null || r.getType().equals("") || !r.getType().equalsIgnoreCase("example") || !r.getType().equalsIgnoreCase("template")) && (r.getResourceName()!=null && !r.getResourceName().trim().equals("")))).toList():null;
        System.out.println(sectionCode+" resources:"+ externalResources.size());
    } catch (Exception e) {
        throw new RuntimeException(e);
    }
    if(other!=null && other.size()>0){
%>
    <b>FDA/Other Links:</b>
        <%for(CTDResource resource:other){%>
            <span class="chip"><a href="<%=resource.getResourceUrl()%>" target="_blank"><%=resource.getResourceName()%></a></span><br>

<%}}
    if(templates!=null && templates.size()>0){%>
        <b>Templates:</b>
<%for(CTDResource resource:templates){
    if(resource.getType()!=null && resource.getType().equals("template")){%>
<span class="chip"><a href="/platform/download/module?path='<%=resource.getFilePath()%>'&filename=<%=resource.getResourceName()%>" target="_blank"><%=resource.getResourceName()%></a></span><br>

<%}}}
    if(examples!=null && examples.size()>0){%>
<b>Examples:</b>
<%for(CTDResource resource:examples){
    if(resource.getType()!=null && resource.getType().equals("example")){%>
<span class="chip"><a href="/platform/download/module?path='<%=resource.getFilePath()%>'&filename=<%=resource.getResourceName()%>" target="_blank"><%=resource.getResourceName()%></a></span><br>

<%}}}%>
<%--            <li><a href="/platform/download/module?filename=hello.pdf">m1_1_FORM1571_fillablePDF.pdf</a></li>--%>

