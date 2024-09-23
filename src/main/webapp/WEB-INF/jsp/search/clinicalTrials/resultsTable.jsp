<%--
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

    #myTable tbody .info-card{
        /*white-space: nowrap;*/
        width:30%
    }
    #myTable tbody  .manual{
        /*white-space: nowrap;*/
      background-color:yellowgreen;
    }
    /* OPTIONAL CSS! */
    #myTable tbody td {
        /* force "Notes" column to not wrap, so we get a horizontal scrolling demo! */
        /* white-space: nowrap;*/
        /* Add min column width, or "Index" column filter gets too narrow to use */
        min-width: 60px;
        font-size: 1rem;
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
        <td class="info-card"><strong>Sponsor:</strong> <%=sourceFields.get("sponsor")%><br><strong>Compound:</strong> <%=sourceFields.get("compoundName")%><br><strong>NCTID:</strong><strong> <a href="https://www.clinicaltrials.gov/study/<%=sourceFields.get("nCTNumber")%>" target="_blank"><%=sourceFields.get("nCTNumber")%></a></strong><br><strong>Start Date:</strong> <%=sourceFields.get("actualStudyStartDate(m/d/y)")%><br><strong>Completion Date:</strong> <%=sourceFields.get("estimatedPrimaryCompletionDate(m/d/y)")%><br><strong>Status:</strong><%=sourceFields.get("studyStatus")%></td>
        <td ><%=sourceFields.get("funderType")%></td>
        <td><%=sourceFields.get("indication")%></td>
        <td class="manual"><%=sourceFields.get("targetGene/Variant")%></td>
        <td class="manual"><%=sourceFields.get("therapyType")%></td>
        <td class="manual"><%=sourceFields.get("therapyRoute")%></td>
        <td class="manual"><%=sourceFields.get("mechanismofaction")%></td>
        <td class="manual"><%=sourceFields.get("routeofAdministration")%></td>
        <td class="manual"><%=sourceFields.get("drugProductType")%></td>
        <td class="manual"><%=sourceFields.get("targetTissue/Cell")%></td>
        <td class="manual"><%=sourceFields.get("deliverySystem")%></td>
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
        <td ><%=sourceFields.get("currentStage")%></td>
        <td><%=sourceFields.get("dateofLastUpdate")%></td>
        <td><%=sourceFields.get("adults,Peds,Both")%></td>
        <td><%=sourceFields.get("agesEligibleforStudy")%></td>
        <td><%=sourceFields.get("trialEnrollment")%></td>
        <td><%=sourceFields.get("ntrialsites")%></td>
        <td><%=sourceFields.get("clinicalCentersinUSA?")%></td>
        <td><%=sourceFields.get("countries")%></td>
        <td><%=sourceFields.get("hasUSIND?")%></td>
        <td class="manual"><%=sourceFields.get("clinicalPublications")%></td>
        <td class="manual"><%=sourceFields.get("preclinicalPublications")%></td>
        <td class="manual"><%=sourceFields.get("grants")%></td>
        <td class="manual"><%=sourceFields.get("protocols")%></td>
        <td class="manual"><%=sourceFields.get("patents")%></td>
        <td class="manual"><%=sourceFields.get("sponsor'sTrialWebsiteLink")%></td>
        <td class="manual"><%=sourceFields.get("recentUpdates")%></td>
        <td class="manual"><%=sourceFields.get("newsandPressReleases")%></td>
    </tr>
    <%}%>
    </tbody>
</table>
