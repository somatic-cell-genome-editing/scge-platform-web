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
<ul class="nav nav-tabs" id="myTab" role="tablist">
    <li class="nav-item" role="presentation">
        <button class="nav-link active" id="module1-tab" data-toggle="tab" data-target="#module1" type="button" role="tab" aria-controls="module1" aria-selected="true">Module 1</button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="module2-tab" data-toggle="tab" data-target="#module2" type="button" role="tab" aria-controls="module2" aria-selected="false">Module 2</button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="module3-tab" data-toggle="tab" data-target="#module3" type="button" role="tab" aria-controls="module3" aria-selected="false">Module 3</button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="module4-tab" data-toggle="tab" data-target="#module4" type="button" role="tab" aria-controls="module4" aria-selected="false">Module 4</button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="module5-tab" data-toggle="tab" data-target="#module5" type="button" role="tab" aria-controls="module5" aria-selected="false">Module 5</button>
    </li>
</ul>
<%--<div class="tab-content" id="myTabContent">--%>
<%--    <div class="tab-pane fade show active" id="module1" role="tabpanel" aria-labelledby="home-tab">MODULE1</div>--%>
<%--    <div class="tab-pane fade" id="module2" role="tabpanel" aria-labelledby="profile-tab">MODULE2</div>--%>
<%--    <div class="tab-pane fade" id="module3" role="tabpanel" aria-labelledby="contact-tab">MODULE3</div>--%>
<%--    <div class="tab-pane fade" id="module4" role="tabpanel" aria-labelledby="contact-tab">MODULE4</div>--%>

<%--    <div class="tab-pane fade" id="module5" role="tabpanel" aria-labelledby="contact-tab">MODULE5</div>--%>

<%--</div>--%>
<div class="tab-content" id="myTabContent">

<%
    Map<Integer, List<Section>> modules= (Map<Integer, List<Section>>) request.getAttribute("modules");

    for(int module: modules.keySet()){
        List<Section> sections=modules.get(module);
        List<Section> level2Sections=sectionDAO.getLevel2SectionsOfModule(module);
        List<Section> level3Sections=sectionDAO.getLevel3SectionsOfModule(module);
        List<Section> level4Sections=sectionDAO.getLevel4SectionsOfModule(module);
        String activeTab="";
        if(module==1){
            activeTab+="active";
        }
        %>
    <div class="tab-pane fade show <%=activeTab%>" id="module<%=module%>" role="tabpanel" aria-labelledby="home-tab">
        <div style="padding: 20px">
           <%=sectionDAO.getModuleDescription(module)%>
        </div>

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
    </table>
        </div>
    </div>
    <%}%>


</div>