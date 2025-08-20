<%@ page import="edu.mcw.scge.datamodel.ctd.Section" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="edu.mcw.scge.dao.implementation.ctd.SectionDAO" %>
<%@ page import="org.springframework.ui.Model" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="edu.mcw.scge.datamodel.Document" %>
<%@ page import="edu.mcw.scge.datamodel.Application" %>
<%@ page import="org.apache.commons.lang.StringUtils" %><%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 6/26/2024
  Time: 1:12 PM
  To change this template use File | Settings | File Templates.
--%>
<script>
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    })
</script>
<style>
    table thead tr th{
        color:whitesmoke;
    }
    .ctd-modules button{
        color:black
    }
    .Yes{
        color:green;
        font-weight: bold;
    }
    .No{
        color:red;
    }
    .Maybe{
        color:orange;
    }
</style>
<%
    String docLocationURI=new String();
    Application application1=null;
    if(request.getAttribute("application")!=null){
       application1= (Application) request.getAttribute("application");
        if(application1!=null) {
            int applicationId = application1.getApplicationId();
            String sponsor = application1.getSponsorName();
            docLocationURI = "/platform/secure/store/files/" + application1.getApplicationId() + "/" + application1.getSponsorName() + "/";
        }
    }
    Map<String, List<Document>> sectionDocuments= null;
    if(request.getAttribute("sectionDocuments")!=null){
        sectionDocuments=(Map<String, List<Document>>) request.getAttribute("sectionDocuments");
    }

    Model model= (Model) request.getAttribute("model");
    String message= "";
    if(model!=null && model.getAttribute("message")!=null)
        message+= (String) model.getAttribute("message");
    Map<String, String> fileLocationMap= new HashMap<>();
    if(model!=null && model.getAttribute("fileLocationMap")!=null)
        fileLocationMap.putAll ((Map<String, String>)model.getAttribute("fileLocationMap"));

%>
<%--<div>--%>
<%--<%@include file="application.jsp"%>--%>
<%--</div>--%>
<div>

    <%=message%>
    <ul>
        <%
            for(Map.Entry entry:fileLocationMap.entrySet()){%>
        <li><a href="<%=entry.getValue()%>" target="_blank"><%=entry.getKey()%></a></li>
        <%}%>

    </ul>
</div>

<%
    SectionDAO sectionDAO=new SectionDAO();
    CTDResourceDAO resourceDAO=new CTDResourceDAO();

%>
<ul class="nav nav-tabs ctd-modules" id="myTab" role="tablist">
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
            List<Section> level2Sections= null;
            try {
                level2Sections = sectionDAO.getSectionsOfModuleByLevel(module,2);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
            List<Section> level3Sections= null;
            try {
                level3Sections = sectionDAO.getSectionsOfModuleByLevel(module,3);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
            List<Section> level4Sections= null;
            try {
                level4Sections = sectionDAO.getSectionsOfModuleByLevel(module,4);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }

            String activeTab="";
            if(module==1){
                activeTab+="active";
            }
    %>
    <div class="tab-pane fade show <%=activeTab%>" id="module<%=module%>" role="tabpanel" aria-labelledby="home-tab">
        <div style="padding: 20px">
            <%=sectionDAO.getModuleDescription(module)%>
        </div>

        <div class="container card" style="height:600px;overflow-y: auto;">
            <table class="table table-sm " >
                <thead>
                <tr>
<%--                    <th style="width: 5%;background-color: cadetblue">Module</th>--%>
                    <th colspan="4" style="text-align: center;width: 10%;background-color: cadetblue">Section</th>
                    <th style="background-color: cadetblue;">Section_Name</th>
                    <th colspan=2 style="background-color: cadetblue;white-space: nowrap;">Required for submission</th>
                    <th style="background-color: cadetblue;">Submission Timing</th>
                    <th style="width: 5%;background-color: cadetblue">Resources</th>
                    <%if(application1!=null){%>
                    <th style="background-color: cadetblue">Documents Uploaded</th>
                    <th style="background-color: cadetblue;text-align: center;">Action</th><%}%>
                </tr>
                <tr><th colspan="4"></th><th></th> <th class="text-nowrap"><small style="color: black;"><b>Initial IND</b></small></th><th><small style="color: black;"><b>Marketing</b></small></th><th></th><th></th></tr>
                </thead>
                <tr>
<%--                    <td style="text-wrap: none"><strong>Module<%=module%></strong></td>--%>
                    <td style="text-wrap: none"><strong>Module<%=module%></strong></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <%
                        if(application1!=null){
                    %>
                    <td>0</td>
                    <td></td>
                    <%}%>
                </tr>
                <%
                    for(Section section:sections){
                        //    int sectionCode=0;
                        String l1SectionCode =new String();
                        String l1SectionName =section.getSectionName();
                        String sectionCode=null;
                        String sectionName=null;
                        List<CTDResource> externalResources=null;
                        if(!section.getSectionCode().trim().isEmpty()) {
                            l1SectionCode = section.getSectionCode().replaceAll("\\.", "_");

                        }
                        if(!l1SectionCode.isEmpty()) {
                            sectionCode = l1SectionCode.trim();
                            sectionName = l1SectionName;
                        }
                %>
                <tr>
                    <td><%=section.getSectionCode()%></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td><strong><%=section.getSectionName()%></strong>

                        <%@include file="sectionDocuments.jsp"%>
                    </td>
                    <td> <%if(section.getRequiredForInitialIND()!=null){%>
                        <span class="<%=section.getRequiredForInitialIND().trim()%>" title="Submission Requirement"><%=section.getRequiredForInitialIND()%></span>
                        <%}%>
                    </td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <%
                        if(application1!=null){
                    %>
                    <td>0</td>
                    <td >
                        <%if(!l1SectionCode.isEmpty()){%>
                        <%@include file="action.jsp"%>
                        <%}%>
                    </td>
                    <%}%>
                </tr>
                <%for(Section l2:level2Sections){

                    if(l2.getParentId().equals(section.getSectionCode())){
                        String l2SectionCode=new String();
                        String l2SectionName=l2.getSectionName();
                        if(!l2.getSectionCode().trim().isEmpty()) {
                            l2SectionCode = l2.getSectionCode().replaceAll("\\.", "_");

                        }
                        if(!l2SectionCode.isEmpty()) {
                            sectionCode = l2SectionCode.trim();
                            sectionName = l2SectionName;
                        }
                %>

                <tr>
<%--                    <td></td>--%>
                    <td></td>
                    <td><%=l2.getSectionCode()%></td>
                    <td></td>
                    <td></td>
                    <td>
                        <%
                            if(module==1 || module==2){%>
                        <%=l2.getSectionName()%>
                        <%if(l2.getSectionDescription()!=null && !l2.getSectionDescription().equals("")){%>
                        <sup>
            <span data-toggle="tooltip" title="<%=StringUtils.capitalize( l2.getSectionDescription())%>" style="color: lightseagreen">
               <i class="fa-solid fa-circle-info"></i>
            </span>
                        </sup>
                        <%}%>
                        <%}else{%>
                        <strong><%=l2.getSectionName()%></strong>
                        <%}%>
                        <%@include file="sectionDocuments.jsp"%>
                    </td>
                    <td> <%if(l2.getRequiredForInitialIND()!=null){%>
                        <span class="<%=l2.getRequiredForInitialIND().trim()%>" title="Submission Requirement"><%=l2.getRequiredForInitialIND()%></span>
                        <%}%>
                    </td>

                    <td> <%if(l2.getRequiredForMarketingApplicationOnly()!=null){%>
                        <span class="<%=l2.getRequiredForMarketingApplicationOnly().trim()%>" title="Submission Requirement"><%=l2.getRequiredForMarketingApplicationOnly()%></span>
                        <%}%>
                    </td>
                    <td> <%if(l2.getSubmissionTiming()!=null){%>
                        <span class="<%=l2.getSubmissionTiming().trim()%>"><%=StringUtils.capitalize(l2.getSubmissionTiming().trim())%></span>
                        <%}%>
                    </td>

                    <td>
<%--                        <%--%>
<%--                            if(l2.getResources()!=null && !l2.getResources().equals("")){--%>
<%--                                String[] links=l2.getResources().split(";");--%>
<%--                                for(int i=0;i<links.length;i++){%>--%>
<%--                        <p><a href="<%=links[i]%>">External Link</a> </p>--%>
<%--                                <%}}%>--%>
<%--                        <%if(l2.getTemplateLinkText()!=null && !l2.getTemplateLinkText().equals("")){%>--%>
<%--                        <p><a href=""><%=l2.getTemplateLinkText()%></a></p>--%>
<%--                        <%}%>--%>
<%--                        <%@include file="resources.jsp"%>--%>
                        <%@include file="externalResourceLinks.jsp" %>
                    </td>
                    <%
                        if(application1!=null){
                    %>
                    <td>0</td>
                    <td > <%if(!l2SectionCode.isEmpty()){

                    %><%@include file="action.jsp"%><%}%></td>
                    <%}%>
                </tr>
                <%
                    for(Section l3:level3Sections){

                        if(l3.getParentId().equals(l2.getSectionCode())){
                            String l3SectionCode=new String();
                            String l3SectionName=l3.getSectionName();
                            if(!l3.getSectionCode().trim().isEmpty()){
                                l3SectionCode=l3.getSectionCode().replaceAll("\\.","_");
                                sectionCode=l3SectionCode.trim();
                                sectionName=l3SectionName;
                            }

                %>
                <tr>
<%--                    <td></td>--%>
                    <td></td>
                    <td></td>
                    <td><%=l3.getSectionCode()%></td>
                    <td></td>
                    <td>
                        <%if(module==3){%>
                        <strong><%=l3.getSectionName()%></strong>
                        <%}else{%>
                        <%=l3.getSectionName()%>
                        <%if(l3.getSectionDescription()!=null && !l3.getSectionDescription().equals("")){%>

                        <sup>
            <span data-toggle="tooltip" title="<%=StringUtils.capitalize( l3.getSectionDescription())%>" style="color: lightseagreen">
               <i class="fa-solid fa-circle-info"></i>
            </span>
                        <%}}%>
                        <%@include file="sectionDocuments.jsp"%>
                    </td>
                    <td> <%
                        if(l3.getRequiredForInitialIND()!=null){
                    %>
                        <span class="<%=l3.getRequiredForInitialIND().trim()%>" title="Submission Requirement"><%=l3.getRequiredForInitialIND()%></span>
                        <%}%>

                    </td>
                    <td> <%
                        if(l3.getRequiredForMarketingApplicationOnly()!=null){
                    %>
                        <span class="<%=l3.getRequiredForMarketingApplicationOnly().trim()%>" title="Submission Requirement"><%=l3.getRequiredForMarketingApplicationOnly()%></span>
                        <%}%>

                    </td>
                    <td> <%
                        if(l3.getSubmissionTiming()!=null){
                    %>
                        <span class="<%=l3.getSubmissionTiming().trim()%>"><%=StringUtils.capitalize(l3.getSubmissionTiming())%></span>
                        <%}%>

                    </td>
                    <td>
<%--                        <%--%>
<%--                            if(l3.getResources()!=null && !l3.getResources().equals("")){--%>
<%--                                String[] links=l3.getResources().split(";");--%>
<%--                                for(int i=0;i<links.length;i++){%>--%>
<%--                        <p class="text-nowrap"><a href="<%=links[i]%>">External Link</a></p>--%>
<%--                        <%}}%>--%>
<%--                        <%if(l3.getTemplateLinkText()!=null && !l3.getTemplateLinkText().equals("")){%>--%>
<%--                        <p><a href=""><%=l3.getTemplateLinkText()%>></a></p>--%>
<%--                        <%}%>--%>
<%--                        <%@include file="resources.jsp"%>--%>
    <%@include file="externalResourceLinks.jsp"%>

                    </td>
                    <%
                        if(application1!=null){
                    %>
                    <td>0</td>
                    <td> <%if(!l3SectionCode.isEmpty()){

                    %><%@include file="action.jsp"%><%}%></td>
                    <%}%>
                </tr>

                <%
                    for(Section l4:level4Sections){
                        String l4SectionCode=new String();
                        String l4SectionName=l4.getSectionName();
                        if(l4.getParentId().equals(l3.getSectionCode())){
                            if(!l4.getSectionCode().trim().isEmpty()){
                                l4SectionCode=l4.getSectionCode().replaceAll("\\.","_");
                                sectionCode=l4SectionCode.trim();
                                sectionName=l4SectionName;
                            }



                %>
                <tr>
<%--                    <td></td>--%>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td><%=l4.getSectionCode()%></td>
                    <td><%=l4.getSectionName()%>
                        <%if(l4.getSectionDescription()!=null && !l4.getSectionDescription().equals("")){%>

                        <sup>
            <span data-toggle="tooltip" title="<%=StringUtils.capitalize( l4.getSectionDescription())%>" style="color: lightseagreen">
               <i class="fa-solid fa-circle-info"></i>
            </span>
                            <%}%>
                        <%@include file="sectionDocuments.jsp"%>
                    </td>
                    <td>
                        <%
                            if(l4.getRequiredForInitialIND()!=null){
                        %>
                        <span class="<%=l4.getRequiredForInitialIND().trim()%>" title="Submission Requirement"><%=l4.getRequiredForInitialIND()%></span>
                        <%}%>
                    </td>
                    <td>
                        <%
                            if(l4.getRequiredForMarketingApplicationOnly()!=null){
                        %>
                        <span class="<%=l4.getRequiredForMarketingApplicationOnly().trim()%>" title="Submission Requirement"><%=l4.getRequiredForMarketingApplicationOnly()%></span>
                        <%}%>
                    </td>
                    <td>
                        <%
                            if(l4.getSubmissionTiming()!=null){
                        %>
                        <span class="<%=l4.getSubmissionTiming().trim()%>"><%=StringUtils.capitalize(l4.getSubmissionTiming())%></span>
                        <%}%>
                    </td>
                    <td>
<%--                        <%--%>
<%--                            if(l4.getResources()!=null && !l4.getResources().equals("")){--%>
<%--                                String[] links=l4.getResources().split(";");--%>
<%--                                for(int i=0;i<links.length;i++){%>--%>
<%--                        <p><a href="<%=links[i]%>">External Link</a></p>--%>
<%--                        <%}}%>--%>
<%--                       <%if(l4.getTemplateLinkText()!=null && !l4.getTemplateLinkText().equals("")){%>--%>
<%--                        <p><a href=""><%=l4.getTemplateLinkText()%>></a></p>--%>
<%--                        <%}%>--%>
<%--                        <%@include file="resources.jsp"%>--%>
    <%@include file="externalResourceLinks.jsp"%>

                    </td>
                    <%
                        if(application1!=null){
                    %>
                    <td>0</td>
                    <td ><%if(!l4SectionCode.isEmpty()){


                    %><%@include file="action.jsp"%><%}%></td>
                    <%}%>
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

