<%@ page import="edu.mcw.scge.datamodel.ctd.Section" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="edu.mcw.scge.dao.implementation.ctd.SectionDAO" %>
<%@ page import="org.springframework.ui.Model" %>
<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 6/26/2024
  Time: 1:12 PM
  To change this template use File | Settings | File Templates.
--%>
<style>
    table thead tr th{
        color:whitesmoke;
    }
</style>
<div>
  <%
      Model model= (Model) request.getAttribute("model");
      String message= "";
              if(model.getAttribute("message")!=null)
             message+= (String) model.getAttribute("message");
              Map<String, String> fileLocationMap= new HashMap<>();
              if(model.getAttribute("fileLocationMap")!=null)
                     fileLocationMap.putAll ((Map<String, String>)model.getAttribute("fileLocationMap"));
  %>
    <%=message%>
<ul>
    <%
        for(Map.Entry entry:fileLocationMap.entrySet()){%>
    <li><a href="<%=entry.getValue()%>" target="_blank"><%=entry.getKey()%></a></li>
        <%}%>

</ul>
</div>
<h2>View/Upload Common Technical Document (CTD) requirements</h2>
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
            <th style="width: 5%;background-color: cadetblue">Module</th>
            <th colspan="4" style="text-align: center;width: 10%;background-color: cadetblue">Section</th>
            <th style="background-color: cadetblue">Section_Name</th>
            <th style="background-color: cadetblue">Required for Initial IND submission <br>[<strong>Y</strong>(Yes)/<strong>N</strong>(No)/<strong>M</strong>(May Be)]</th>
            <th style="background-color: cadetblue">Documents_Uploaded</th>
            <th style="background-color: cadetblue;text-align: center">Action</th>

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
        <td>0</td>
        <td></td>
    </tr>
    <%
        for(Section section:sections){
        //    int sectionCode=0;
            String l1SectionCode =new String();
            String l1SectionName =section.getSectionName();
            if(!section.getSectionCode().trim().isEmpty()) {
                 l1SectionCode = section.getSectionCode().replaceAll("\\.", "_");

            }
    %>
            <tr><td></td>
                <td><%=section.getSectionCode()%></td>
                <td></td>
                <td></td>
                <td></td>
                <td><strong><%=section.getSectionName()%></strong></td>
                <td> <%
                    if(section.getRequiredForInitialIND()!=null){
                %>
                    <%=section.getRequiredForInitialIND()%>
                    <%}%></td>
                <td>0</td>
                <td>
                    <%if(!l1SectionCode.isEmpty()){
                        String sectionCode=l1SectionCode;
                        String sectionName=l1SectionName;
                    %>
                    <%@include file="action.jsp"%>
                    <%}%>
                </td>
            </tr>
       <%for(Section l2:level2Sections){

           if(l2.getParentId().equals(section.getSectionCode())){
               String l2SectionCode=new String();
               String l2SectionName=l2.getSectionName();
               if(!l2.getSectionCode().trim().isEmpty()) {
                    l2SectionCode = l2.getSectionCode().replaceAll("\\.", "_");

               }
       %>

    <tr><td></td>
        <td></td>
        <td><%=l2.getSectionCode()%></td>
        <td></td>
        <td></td>
        <td>
            <%
                if(module==1 || module==2){%>
            <%=l2.getSectionName()%>
                <%}else{%>
            <strong><%=l2.getSectionName()%></strong>
            <%}%>
        </td>
        <td> <%
            if(l2.getRequiredForInitialIND()!=null){
        %>
            <%=l2.getRequiredForInitialIND()%>
            <%}%></td>
        <td>0</td>
        <td> <%if(!l2SectionCode.isEmpty()){
            String sectionCode=l2SectionCode;
            String sectionName=l2SectionName;
        %><%@include file="action.jsp"%><%}%></td>
    </tr>
    <%
        for(Section l3:level3Sections){

            if(l3.getParentId().equals(l2.getSectionCode())){
                String l3SectionCode=new String();
                String l3SectionName=l3.getSectionName();
                if(!l3.getSectionCode().trim().isEmpty()){
                     l3SectionCode=l3.getSectionCode().replaceAll("\\.","_");

                }

    %>
    <tr><td></td>
        <td></td>
        <td></td>
        <td><%=l3.getSectionCode()%></td>
        <td></td>
        <td>
            <%if(module==3){%>
                    <strong><%=l3.getSectionName()%></strong>
               <%}else{%>
            <%=l3.getSectionName()%>
            <%}%>
        </td>
        <td> <%
            if(l3.getRequiredForInitialIND()!=null){
        %>
            <%=l3.getRequiredForInitialIND()%>
            <%}%></td>
        <td>0</td>
        <td> <%if(!l3SectionCode.isEmpty()){
        String sectionCode=l3SectionCode;
        String sectionName=l3SectionName;
        %><%@include file="action.jsp"%><%}%></td>
    </tr>

    <%
        for(Section l4:level4Sections){
            String l4SectionCode=new String();
            String l4SectionName=l4.getSectionName();
            if(l4.getParentId().equals(l3.getSectionCode())){
                if(!l4.getSectionCode().trim().isEmpty()){
                     l4SectionCode=l4.getSectionCode().replaceAll("\\.","_");

                }



    %>
    <tr><td></td>
        <td></td>
        <td></td>
        <td></td>
        <td><%=l4.getSectionCode()%></td>
        <td><%=l4.getSectionName()%></td>
        <td>
            <%
            if(l4.getRequiredForInitialIND()!=null){
        %>
            <%=l4.getRequiredForInitialIND()%>
            <%}%>
        </td>
        <td>0</td>
        <td><%if(!l4SectionCode.isEmpty()){

           String sectionCode=l4SectionCode;
           String sectionName=l4SectionName;
        %><%@include file="action.jsp"%><%}%></td>
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
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.9.1.min.js" type="text/javascript"></script>

