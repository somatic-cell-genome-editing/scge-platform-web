<%@ page import="edu.mcw.scge.datamodel.ClinicalTrialExternalLink" %>
<%@ page import="java.util.stream.Collectors" %><%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 9/16/2024
  Time: 9:44 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    .tablesorter-scroller-bar-spacer {
        background: #eee;
    }
    /* add border to right side (LTR pages) of fixed column */
    .using-blue-theme .tablesorter-scroller-fixed:after {
        content: '';
        border-right: 1px solid #444;
        width: 1px;
        position: absolute;
        top: 0;
        bottom: 0;
        z-index: 2;
        /* set to zero for non-jquery ui themes; use "left" here for RTL pages */
        right: 0;
        /* match the margins set to the table to keep the border the same height as the table */
        margin: 10px 0 15px;
    }

    /* using-x-theme added by the demo code */
    .using-blue-theme .tablesorter-scroller-fixed:after {
        /* use "left" here for RTL pages */
        right: 0;
    }
    .using-blue-theme .tablesorter-scroller-fixed:after,
    .using-green-theme .tablesorter-scroller-fixed:after,
    .using-black-ice-theme .tablesorter-scroller-fixed:after,
    .using-dark-theme .tablesorter-scroller-fixed:after,
    .using-dropbox-theme .tablesorter-scroller-fixed:after {
        /* match the margins set to the table to keep the border the same height as the table */
        margin: 0;
    }

    #myTable tbody  .manual{
        /*white-space: nowrap;*/
      background-color:yellowgreen;
    }
    /* OPTIONAL CSS! */
    .tablesorter tbody td {
        /* force "Notes" column to not wrap, so we get a horizontal scrolling demo! */
         white-space: nowrap;
        /* Add min column width, or "Index" column filter gets too narrow to use */
        min-width: 60px;
        font-size: .9rem;
    }
    .tablesorter tbody td .card{
        padding-left: 5%;

    }


</style>

<table  id="myTable" class="tablesorter">
    <thead><tr><%@include file="columns.jsp"%></tr></thead>
    <tfoot><tr><%@include file="columns.jsp"%></tr></tfoot>
    <tbody>
    <%
        for(SearchHit hit:hits) {
            Map<String, Object> sourceFields = hit.getSourceAsMap();
    %>
    <tr>
        <td>
            <strong><a href="https://www.clinicaltrials.gov/study/<%=sourceFields.get("nctId")%>" target="_blank"><%=sourceFields.get("nctId")%></a></strong>
<%--                <div class="w-100"></div>--%>
<%--                <div class="col-5"><strong>Start Date:</strong></div><div class="col-7"><%=sourceFields.get("actualStudyStartDate(m/d/y)")%></div>--%>
<%--                <div class="w-100"></div>--%>
<%--                <div class="col-5"><strong>Completion Date:</strong></div><div class="col-7"><%=sourceFields.get("estimatedPrimaryCompletionDate(m/d/y)")%></div>--%>


        </td>

        <td><%=sourceFields.get("sponsor")%></td>
<%--        <td><%=sourceFields.get("interventionName")%></td>--%>
        <td class="manual"><%=sourceFields.get("compoundName")%></td>
<%--        <td ><%=sourceFields.get("sponsorClass")%></td>--%>

        <td class="manual"><%=sourceFields.get("indication")%></td>
        <td class="manual"><%=sourceFields.get("targetGeneOrVariant")%></td>
<%--        <td class="manual"><%=sourceFields.get("therapyType")%></td>--%>
<%--        <td class="manual"><%=sourceFields.get("therapyRoute")%></td>--%>
<%--        <td class="manual"><%=sourceFields.get("mechanismOfAction")%></td>--%>
<%--        <td class="manual"><%=sourceFields.get("routeOfAdministration")%></td>--%>
<%--        <td class="manual"><%=sourceFields.get("drugProductType")%></td>--%>
        <td class="manual"><%=sourceFields.get("targetTissueOrCell")%></td>
<%--        <td class="manual"><%=sourceFields.get("deliverySystem")%></td>--%>
        <td class="manual"><%=sourceFields.get("vectorType")%></td>
        <td class="manual"><%if(sourceFields.get("editorType")!=null && !sourceFields.get("editorType").toString().equalsIgnoreCase("none")){%>
            <%=sourceFields.get("editorType")%>
            <%}%>
        </td>
        <td class="manual"><%=sourceFields.get("dose1")%></td>
        <td class="manual"><%=sourceFields.get("dose2")%></td>
        <td class="manual"><%=sourceFields.get("dose3")%></td>
        <td class="manual"><%=sourceFields.get("dose4")%></td>
        <td class="manual"><%=sourceFields.get("dose5")%></td>
<%--        <td ><%=sourceFields.get("interventionDescription")%></td>--%>
        <td class="text-nowrap">
            <%
                List<String> phases= (List<String>) sourceFields.get("phases");
                String phase= phases.stream().collect(Collectors.joining(", "));
            %>
            <%=phase%>
        </td>
        <td>   <%
            List<String> statuses= (List<String>) sourceFields.get("status");
            String status= statuses.stream().collect(Collectors.joining(", "));
        %>
            <%=status%></td>
        <td class="text-nowrap"><%=sourceFields.get("firstSubmitDate")%></td>
        <td><%=sourceFields.get("estimatedCompleteDate")%></td>
        <td class="text-nowrap"><%=sourceFields.get("lastUpdatePostDate")%></td>
<%--        <td class="text-nowrap"><%=sourceFields.get("standardAges")%></td>--%>
        <td class="text-nowrap">
            <%if(sourceFields.get("elibilityMinAge")!=null && sourceFields.get("elibilityMaxAge")!=null){%>
            <%=sourceFields.get("elibilityMinAge")%> - <%=sourceFields.get("elibilityMaxAge")%>

            <%}else{
                if(sourceFields.get("elibilityMinAge")!=null && sourceFields.get("elibilityMaxAge")==null){%>
                   >=&nbsp;<%=sourceFields.get("elibilityMinAge")%>
               <%}else{
                   if(sourceFields.get("elibilityMinAge")==null && sourceFields.get("elibilityMaxAge")!=null){%>
            <=&nbsp;<%=sourceFields.get("elibilityMaxAge")%>
                  <% }}}%>

        </td>
        <td><%=sourceFields.get("enrorllmentCount")%></td>
        <td><%=sourceFields.get("numberOfLocations")%></td>
<%--        <td><%=sourceFields.get("clinicalCentersinUSA?")%></td>--%>
<%--        <td><%=sourceFields.get("locations")%></td>--%>
        <td><%=sourceFields.get("isFDARegulated")%></td>
<%--        <td class="manual">--%>
<%--&lt;%&ndash;            <%=sourceFields.get("clinicalPublications")%>&ndash;%&gt;--%>
<%--    <% if(sourceFields.get("clinicalPublications")!=null){--%>
<%--        List<String> publications= Arrays.asList(sourceFields.get("clinicalPublications").toString().split(";"));--%>
<%--        for(String s:publications){--%>
<%--            String url="";--%>
<%--            String label="";--%>
<%--            if(s.contains("https") || s.toLowerCase().contains("pmid")) {--%>
<%--                if(s.contains("https")) {--%>
<%--                    url += s;--%>
<%--                    label += s.substring(s.lastIndexOf("/") + 1);--%>
<%--                }--%>
<%--                if(s.toLowerCase().contains("pmid")) {--%>
<%--                    url += "https://pubmed.ncbi.nlm.nih.gov/";--%>
<%--                    url += s.substring(s.indexOf(":") + 1).trim();--%>
<%--                    label += s;--%>
<%--                }--%>
<%--    %>--%>
<%--    <a href="<%=url%>" target="_blank"><%=label%></a><br>--%>
<%--    &lt;%&ndash;            <%=sourceFields.get("clinicalPublications")%>&ndash;%&gt;--%>
<%--    <%}else{%>--%>
<%--    <%=s%><br>--%>
<%--    <%}}}%>--%>
<%--        </td>--%>
<%--        <td class="manual">--%>
<%--                 <% if(sourceFields.get("preclinicalPublications")!=null){--%>
<%--                List<String> publications= Arrays.asList(sourceFields.get("preclinicalPublications").toString().split(";"));--%>
<%--                for(String s:publications){--%>
<%--                    String url="";--%>
<%--                    String label="";--%>
<%--                    if(s.contains("https") || s.toLowerCase().contains("pmid")) {--%>
<%--                        if(s.contains("https")) {--%>
<%--                            url += s;--%>
<%--                            label += s.substring(s.lastIndexOf("/") + 1);--%>
<%--                        }--%>
<%--                        if(s.toLowerCase().contains("pmid")) {--%>
<%--                            url += "https://pubmed.ncbi.nlm.nih.gov/";--%>
<%--                            url += s.substring(s.indexOf(":") + 1).trim();--%>
<%--                            label += s;--%>
<%--                        }--%>
<%--            %>--%>
<%--            <a href="<%=url%>" target="_blank"><%=label%></a><br>--%>
<%--            <%}else{%>--%>
<%--            <%=s%><br>--%>
<%--            <%}}}%>--%>

<%--        </td>--%>
<%--        <td class="manual"><%=sourceFields.get("grants")%></td>--%>
<%--        <td class="manual">--%>
<%--&lt;%&ndash;            <%=sourceFields.get("protocols")%>&ndash;%&gt;--%>
<%--            <% if(sourceFields.get("protocols")!=null){--%>
<%--                List<String> publications= Arrays.asList(sourceFields.get("protocols").toString().split(";"));--%>
<%--                for(String s:publications){--%>
<%--                    String url="";--%>
<%--                    String label="";--%>
<%--                    if(s.contains("https") || s.toLowerCase().contains("pmid")) {--%>
<%--                    if(s.contains("https")) {--%>
<%--                        url += s;--%>
<%--                        label += s.substring(s.lastIndexOf("/") + 1);--%>
<%--                    }--%>
<%--                    if(s.toLowerCase().contains("pmid")) {--%>
<%--                        url += "https://pubmed.ncbi.nlm.nih.gov/";--%>
<%--                        url += s.substring(s.indexOf(":") + 1).trim();--%>
<%--                        label += s;--%>
<%--                    }--%>
<%--            %>--%>
<%--            <a href="<%=url%>" target="_blank"><%=label%></a><br>--%>
<%--            <%}else{%>--%>
<%--            <%=s%><br>--%>
<%--            <%}}}%>--%>

<%--        </td>--%>
        <td class="manual"><%=sourceFields.get("patents")%></td>
<%--        <td class="manual"><%=sourceFields.get("sponsor'sTrialWebsiteLink")%></td>--%>
        <td class="manual"><%=sourceFields.get("recentUpdates")%></td>
<%--        <td class="manual">--%>
<%--            <%=sourceFields.get("newsandPressReleases")%>--%>
<%--    <% if(sourceFields.get("newsandPressReleases")!=null){--%>
<%--        List<String> publications= Arrays.asList(sourceFields.get("newsandPressReleases").toString().split(";"));--%>
<%--        for(String s:publications){--%>
<%--            String url="";--%>
<%--            String label="";--%>
<%--            if(s.contains("https") || s.toLowerCase().contains("pmid")) {--%>
<%--                if(s.contains("https")) {--%>
<%--                    url += s;--%>
<%--                    label += s.substring(s.lastIndexOf("/") + 1);--%>
<%--                }--%>
<%--                if(s.toLowerCase().contains("pmid")) {--%>
<%--                    url += "https://pubmed.ncbi.nlm.nih.gov/";--%>
<%--                    url += s.substring(s.indexOf(":") + 1).trim();--%>
<%--                    label += s;--%>
<%--                }--%>
<%--    %>--%>
<%--    <a href="<%=url%>" target="_blank"><%=label%></a><br>--%>
<%--    &lt;%&ndash;            <%=sourceFields.get("clinicalPublications")%>&ndash;%&gt;--%>
<%--    <%}else{%>--%>
<%--    <%=s%><br>--%>
<%--    <%}}}%>--%>


<%--        </td>--%>
        <td class="manual">

            <%
                if(sourceFields.get("externalLinks")!=null){
                    List<Map<String,String>> links= (List<Map<String,String>>) sourceFields.get("externalLinks");
                    Map<String, List<Map<String,String>>> sortedLinks=new HashMap<>();
                    for(Map<String, String> map:links){
                        if(map.get("type")!=null){
                            List<Map<String,String>> list=new ArrayList<>();
                           if( sortedLinks.get(map.get("type"))!=null){
                               list.addAll(sortedLinks.get(map.get("type")));
                           }
                           list.add(map);
                           sortedLinks.put(map.get("type"), list);
                        }}%>

                    <%for(String type:sortedLinks.keySet()){%>
            <div class="row">
            <div class="col-1 text-nowrap"><strong><%=type%>&nbsp;:</strong></div>
                <div class="col-3">
                    <ul>
                        <%for(Map<String, String> map:sortedLinks.get(type)){%>
                        <li  style="list-style-type: none">
                        <%if(map.get("link")!=null){%>
                            <a href="<%=map.get("link")%>" target="_blank"><%=map.get("name")%></a>
                                <%}else{%>
                                <%=map.get("name")%>
                        <%}%>
                        </li>
                        <%}%>
                    </ul>
                </div>
            </div>
                    <%}%>

                <%}%>
        </td>
    </tr>
    <%}%>
    </tbody>
</table>
