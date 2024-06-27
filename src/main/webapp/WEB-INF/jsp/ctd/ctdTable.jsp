<%@ page import="edu.mcw.scge.platform.datamodel.ctd.Section" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="edu.mcw.scge.platform.dao.implementation.ctd.SectionDAO" %><%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 6/26/2024
  Time: 1:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    table tr th{
        background-color: cadetblue;
        color:whitesmoke;
    }
</style>
<div class="jumbotron">
<h1>Common Technical Document (CTD) requirements for Initial IND</h1>
</div>
<%
    SectionDAO sectionDAO=new SectionDAO();
%>
<div class="container card">
<table class="table table-sm " >
    <thead>
    <tr>
    <th style="width: 5%">Module</th>
    <th colspan="4" style="text-align: center;width: 10%">Section</th>
    <th>Section_Name</th>
        <th>Required for Initial IND submission <br>[<strong>Y</strong>(Yes)/<strong>N</strong>(No)/<strong>M</strong>(May Be)]</th>
    </tr>
    </thead>
<%
    Map<Integer, List<Section>> modules= (Map<Integer, List<Section>>) request.getAttribute("modules");
    for(int module: modules.keySet()){
        List<Section> sections=modules.get(module);
        List<Section> level2Sections=sectionDAO.getLevel2SectionsOfModule(module);
        List<Section> level3Sections=sectionDAO.getLevel3SectionsOfModule(module);
        List<Section> level4Sections=sectionDAO.getLevel4SectionsOfModule(module);
        %>
    <tr>
        <td style="text-wrap: none"><strong>Module<%=module%></strong></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <%
        for(Section section:sections){

    %>
            <tr><td></td>
                <td><%=section.getSectionCode()%></td>
                <td></td>
                <td></td>
                <td></td>
                <td><strong><%=section.getSectionName()%></strong></td>
                <td></td>
            </tr>
       <%for(Section l2:level2Sections){
            if(l2.getParentId().equals(section.getSectionCode())){
       %>

    <tr><td></td>
        <td></td>
        <td><%=l2.getSectionCode()%></td>
        <td></td>
        <td></td>
        <td><%=l2.getSectionName()%></td>
        <td></td>
    </tr>
    <%
        for(Section l3:level3Sections){
            if(l3.getParentId().equals(l2.getSectionCode())){


    %>
    <tr><td></td>
        <td></td>
        <td></td>
        <td><%=l3.getSectionCode()%></td>
        <td></td>
        <td><%=l3.getSectionName()%></td>
        <td></td>
    </tr>

    <%
        for(Section l4:level4Sections){
            if(l4.getParentId().equals(l3.getSectionCode())){



    %>
    <tr><td></td>
        <td></td>
        <td></td>
        <td></td>
        <td><%=l4.getSectionCode()%></td>
        <td><%=l4.getSectionName()%></td>
        <td></td>
    </tr>
       <%}     } }

       }
       }
    }
}
%>
    <%}%>
</table>

</div>