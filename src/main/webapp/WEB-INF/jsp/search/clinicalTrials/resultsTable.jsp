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
    .tablesorter-scroller-fixed:after {
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
    .using-jui-theme .tablesorter-scroller-fixed:after {
        /* use "left" here for RTL pages */
        right: 0;
    }
    .using-green-theme .tablesorter-scroller-fixed:after,
    .using-black-ice-theme .tablesorter-scroller-fixed:after,
    .using-dark-theme .tablesorter-scroller-fixed:after,
    .using-dropbox-theme .tablesorter-scroller-fixed:after {
        /* match the margins set to the table to keep the border the same height as the table */
        margin: 0;
    }

    /* OPTIONAL CSS! */
    #myTable tbody td {
        /* force "Notes" column to not wrap, so we get a horizontal scrolling demo! */
        /*white-space: nowrap;*/
        /* Add min column width, or "Index" column filter gets too narrow to use */
        min-width: 60px;
    }
</style>
<table  id="myTable">
    <thead>
    <tr>
        <th>Study</th>
        <th>Editor Type</th>
        <th>Therapy Type</th>
        <th>Current Stage</th>
        <th>Indication</th>
        <th>Last_Update</th>
        <th>Days Progressed</th>
        <th>Updates</th>
    </tr>
    </thead>
    <tfoot>
    <tr>
        <th>Study</th>
        <th>Editor Type</th>
        <th>Therapy Type</th>
        <th>Current Stage</th>
        <th>Indication</th>
        <th>Last_Update</th>
        <th>Days Progressed</th>
        <th>Updates</th>
    </tr>
    </tfoot>
    <tbody>
    <%
        for(SearchHit hit:hits) {
            Map<String, Object> sourceFields = hit.getSourceAsMap();
    %>
    <tr>
        <td>
            <strong>Sponsor:</strong> <%=sourceFields.get("sponsor")%><br>
            <strong>Compound:</strong> <%=sourceFields.get("sponsorCompound")%><br>
            <strong>NCTID:</strong><strong> <a href="https://www.clinicaltrials.gov/study/<%=sourceFields.get("nCTNumber")%>" target="_blank"><%=sourceFields.get("nCTNumber")%></a></strong><br>
            <strong>Start Date:</strong> <%=sourceFields.get("actualStudyStartDate(m/d/y)")%><br>
            <strong>Completion Date:</strong> <%=sourceFields.get("estimatedPrimaryCompletion(m/d/y)")%><br>

            <strong>Status:</strong><%=sourceFields.get("status")%>

        </td>
        <%--                        <td><%=sourceFields.get("sponsorCompound")%></td>--%>
        <td><%=sourceFields.get("editorType")%></td>
        <td><%=sourceFields.get("therapyType")%></td>
        <td><%=sourceFields.get("currentStage")%></td>
        <%--                        <td><%=sourceFields.get("status")%></td>--%>
        <%--                        <td><strong><a href="https://www.clinicaltrials.gov/study/<%=sourceFields.get("nCTNumber")%>" target="_blank"><%=sourceFields.get("nCTNumber")%></a></strong></td>--%>

        <td><%=sourceFields.get("indication")%></td>
        <%--                        <td><%=sourceFields.get("actualStudyStartDate(m/d/y)")%></td>--%>
        <%--                        <td><%=sourceFields.get("estimatedPrimaryCompletion(m/d/y)")%></td>--%>
        <td><%=sourceFields.get("dateofLastupdate")%></td>
        <%--                        <td><%=sourceFields.get("totalDays")%></td>--%>
        <%--                        <td><%=sourceFields.get("dayselapsed")%></td>--%>
        <td><%
            String progress=sourceFields.get("progress").toString().replace("%","").trim();
        %>
            <div class="progress">
                <div class="progress-bar" role="progressbar" style="width: <%=progress%>%" aria-valuenow=<%=progress%> aria-valuemin="0" aria-valuemax="100"></div>
            </div><%=sourceFields.get("progress")%></td>
        <td><%
            if(sourceFields.get("notes")!=null){
        %>
            <%=sourceFields.get("notes")%>
            <%}%>
        </td>
    </tr>
    <%}%>
    </tbody>
</table>
