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
    /* ================================================
       MODERN TABLE DESIGN - CLINICAL TRIALS
       ================================================ */

    /* Results Table Container */
    #resultsTable {
        height: auto;
        min-height: 50px;
        max-height: 600px;
        overflow: auto;
        position: relative;
        width: 100%;
        margin-top: 0;
        border: 1px solid #e2e8f0;
        border-radius: 8px;
        background: white;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
    }

    /* Table Styling */
    #myTable {
        position: relative;
        margin: 0;
        border-collapse: separate;
        border-spacing: 0;
        width: 100%;
        min-width: 1000px;
    }

    /* Enhanced Scrollbar */
    #resultsTable::-webkit-scrollbar {
        width: 10px;
        height: 10px;
    }

    #resultsTable::-webkit-scrollbar-track {
        background: #f1f5f9;
    }

    #resultsTable::-webkit-scrollbar-thumb {
        background: #fb923c;
        border-radius: 4px;
    }

    #resultsTable::-webkit-scrollbar-thumb:hover {
        background: #f97316;
    }

    #resultsTable::-webkit-scrollbar-corner {
        background: #f1f5f9;
    }

    /* Sticky First Column */
    #myTable td.firstColumn {
        position: sticky;
        left: 0;
        z-index: 10;
        background: white;
        border-right: 2px solid #e2e8f0;
        font-weight: 600;
    }

    #myTable td.firstColumn:hover {
        background: #f8fafc;
    }

    #myTable td.firstColumn:before {
        content: "";
        position: absolute;
        left: 0;
        top: 0;
        bottom: 0;
        width: 1px;
        background-color: #e2e8f0;
    }

    /* Table Headers - Sticky */
    #myTable thead th {
        position: sticky;
        top: 0;
        z-index: 15;
        background: #f8fafc;
        font-weight: 700;
        color: #1e293b;
        text-transform: uppercase;
        font-size: 0.75rem;
        letter-spacing: 0.05em;
        padding: 1rem;
        border-bottom: 2px solid #cbd5e1;
        white-space: nowrap;
        cursor: pointer;
        user-select: none;
    }

    #myTable thead th:first-child {
        position: sticky;
        left: 0;
        z-index: 20;
        border-right: 2px solid #cbd5e1;
        background: #f8fafc;
    }

    /* Sort Arrow Styling */
    #myTable thead th:not(.sorter-false)::after {
        content: '\2195';
        display: inline-block;
        margin-left: 0.5rem;
        color: #64748b;
        font-size: 1.125rem;
        font-weight: bold;
        vertical-align: middle;
    }

    #myTable thead th:not(.sorter-false):hover::after {
        color: #1a80b6;
    }

    #myTable thead th.tablesorter-headerAsc::after,
    #myTable thead th.headerSortUp::after {
        content: '\2191';
        color: #1a80b6;
        font-weight: bold;
        font-size: 1.25rem;
    }

    #myTable thead th.tablesorter-headerDesc::after,
    #myTable thead th.headerSortDown::after {
        content: '\2193';
        color: #1a80b6;
        font-weight: bold;
        font-size: 1.25rem;
    }

    #myTable thead th.tablesorter-header:hover,
    #myTable thead th:not(.sorter-false):hover {
        background: #f1f5f9;
        color: #1a80b6;
    }

    /* Table Footer */
    #myTable tfoot th {
        position: sticky;
        bottom: -1px;
        z-index: 15;
        background: #f8fafc;
        font-weight: 600;
        color: #475569;
        border-top: 2px solid #cbd5e1;
    }

    #myTable tfoot th:first-child {
        position: sticky;
        left: 0;
        z-index: 20;
        border-right: 2px solid #cbd5e1;
        background: #f8fafc;
    }

    /* Table Cells */
    #myTable th,
    #myTable td {
        padding: 0.875rem 1rem;
        border: 1px solid #e2e8f0;
        white-space: nowrap;
        text-align: left;
        color: #475569;
        font-size: 0.875rem;
        vertical-align: top;
    }

    /* Row Styles */
    #myTable tbody tr {
        border-bottom: 1px solid #e2e8f0;
    }

    #myTable tbody tr:hover {
        background-color: #f8fafc;
    }

    #myTable tbody tr:nth-child(even) {
        background-color: #fafbfc;
    }

    #myTable tbody tr:nth-child(even):hover {
        background-color: #f1f5f9;
    }

    /* Links in Table */
    #myTable tbody td a {
        color: #1a80b6;
        text-decoration: none;
        font-weight: 500;
    }

    #myTable tbody td a:hover {
        color: #0891b2;
        text-decoration: underline;
    }

    /* Buttons in Table */
    #myTable tbody td button {
        font-size: 0.75rem;
        font-weight: 600;
        padding: 0.375rem 0.75rem;
        border: none;
        background: #1a80b6;
        color: white;
        border-radius: 0.375rem;
        cursor: pointer;
        text-transform: uppercase;
        letter-spacing: 0.025em;
        transition: background 0.2s;
    }

    #myTable tbody td button:hover {
        background: #0891b2;
    }

    /* Specific Column Padding */
    #myTable td:nth-child(2),
    #myTable td:nth-child(3),
    #myTable td:nth-child(4),
    #myTable td:nth-child(6),
    #myTable td:nth-child(9),
    #myTable td:nth-child(12),
    #myTable td:nth-child(15),
    #myTable td:nth-child(16),
    #myTable td:nth-child(17),
    #myTable td:nth-child(18),
    #myTable td:nth-child(19),
    #myTable td:nth-child(20),
    #myTable td:nth-child(22),
    #myTable td:nth-child(31),
    #myTable td:nth-child(32) {
        padding-right: 23px;
    }

    #myTable td:nth-child(26) {
        padding-right: 15px;
    }

    /* Icons */
    .fa-check {
        color: #10b981 !important;
        font-size: 1.125rem;
    }

    .fa-xmark {
        color: #ef4444 !important;
        font-size: 1.125rem;
    }

    .fa-eye {
        color: #1a80b6;
        cursor: pointer;
        font-size: 1.125rem;
    }

    .fa-eye:hover {
        color: #0891b2;
    }

    /* Popover */
    .popover {
        border: 1px solid #e2e8f0;
        max-width: 400px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    .popover-header {
        background: #1a80b6;
        color: white;
        font-weight: 600;
        padding: 0.75rem 1rem;
    }

    .popover-body {
        padding: 1rem;
        color: #475569;
        font-size: 0.875rem;
        line-height: 1.6;
        max-height: 300px;
        overflow-y: auto;
    }

    .popover-body::-webkit-scrollbar {
        width: 6px;
    }

    .popover-body::-webkit-scrollbar-thumb {
        background: #94a3b8;
    }

    /* Modal */
    .modal-content {
        border: 1px solid #e2e8f0;
        border-radius: 8px;
    }

    .modal-header {
        background: #1a80b6;
        color: white;
        padding: 1.25rem 1.5rem;
        border-radius: 8px 8px 0 0;
    }

    .modal-header .modal-title {
        font-weight: 700;
        font-size: 1.25rem;
    }

    .modal-header .btn {
        color: white;
        padding: 0.5rem;
    }

    .modal-header .btn:hover {
        background: rgba(255, 255, 255, 0.2);
        border-radius: 4px;
    }

    .modal-body {
        padding: 1.5rem;
        max-height: 60vh;
        overflow-y: auto;
    }

    .modal-body::-webkit-scrollbar {
        width: 8px;
    }

    .modal-body::-webkit-scrollbar-thumb {
        background: #94a3b8;
    }

    .modal-footer {
        border-top: 1px solid #e2e8f0;
        padding: 1rem 1.5rem;
        background: #f8fafc;
    }

    .modal-footer .btn {
        padding: 0.625rem 1.25rem;
        font-weight: 600;
        border-radius: 6px;
    }

    /* Caption */
    #myTable caption {
        caption-side: top;
        color: #64748b;
        font-size: 0.875rem;
        font-weight: 600;
        padding: 0.75rem 1rem;
        text-align: left;
    }

    /* Responsive */
    @media (max-width: 768px) {
        #resultsTable {
            max-height: 400px;
        }

        #myTable th,
        #myTable td {
            padding: 0.625rem 0.75rem;
            font-size: 0.8125rem;
        }

        #myTable thead th {
            font-size: 0.7rem;
        }
    }

    /* Print Styles */
    @media print {
        #resultsTable {
            max-height: none;
            overflow: visible;
            border: none;
        }

        #myTable tbody tr:hover {
            background-color: transparent;
        }

        #myTable td.firstColumn {
            position: relative;
        }

        #myTable thead th,
        #myTable tfoot th {
            position: relative;
        }
    }
</style>
<script>
$(function () {
$('[data-toggle="popover"]').popover({
html: true,
content: function () {
var content = $(this).attr("data-popover-content");
return $(content).children(".popover-body").html();
}

})
.on("focus", function () {
$(this).popover("show");
}).on("focusout", function () {
var _this = this;
if (!$(".popover:hover").length) {
$(this).popover("hide");
} else {
$('.popover').mouseleave(function () {
$(_this).popover("hide");
$(this).off('mouseleave');
});
}
});
})
</script>
<div id="resultsTable"  style="display: none">
<table  id="myTable">
    <caption>SCGE Platform GTCT</caption>
    <thead><tr><%@include file="columns.jsp"%></tr></thead>
    <tfoot><tr><%@include file="columns.jsp"%></tr></tfoot>
    <tbody>
    <%
        for(SearchHit hit:hits) {
            Map<String, Object> sourceFields = hit.getSourceAsMap();
    %>
    <tr>
<%--        <td style="font-weight: bold"><a href="https://www.clinicaltrials.gov/study/<%=sourceFields.get("nctId")%>" target="_blank"><%=sourceFields.get("nctId")%></a></td>--%>
    <td style="font-weight: bold" class="firstColumn">
        <%=sourceFields.get("nctId")%>&nbsp;
        <a href="/platform/data/report/clinicalTrials/<%=sourceFields.get("nctId")%>" target="_blank" style="text-decoration: none;">
            <button style="font-size:0.75rem;font-weight: normal;padding:2px 5px;border: none; background-color: #007bff; color: white; border-radius: 4px; cursor: pointer;">
                View Report
            </button>
        </a>
    </td>
<%--    <td class="manual">--%>
<%--        <%--%>
<%--            if(sourceFields.get("indicationDOID")!=null && !sourceFields.get("indicationDOID").toString().contains("?")){--%>
<%--                for(String doid:sourceFields.get("indicationDOID").toString().split("/")){--%>
<%--        %>--%>
<%--        <a href="https://www.disease-ontology.org/term/DOID:<%=doid%>" target="_blank">DOID:<%=doid%></a>&nbsp;--%>
<%--        <%}}%>--%>
<%--    </td>--%>
        <td class="manual"><%=sourceFields.get("indication")%></td>
    <td class="manual">
        <%
            if(sourceFields.get("fdaDesignations")!=null){
        %>
        <%=((List<String>)sourceFields.get("fdaDesignations")).stream().collect(Collectors.joining(", "))%>
        <%}%>
    </td>
        <td class="manual"><%=sourceFields.get("compoundName")%></td>
        <td><%=sourceFields.get("sponsor")%></td>
        <td ><%=sourceFields.get("sponsorClass")%></td>
<%--        <td><%=sourceFields.get("interventionName")%></td>--%>
        <td class="manual"><%=sourceFields.get("targetGeneOrVariant")%></td>
        <td class="manual"><%=sourceFields.get("therapyType")%></td>
        <td class="manual"><%=sourceFields.get("therapyRoute")%></td>
        <td class="manual"><%=sourceFields.get("mechanismOfAction")%></td>
        <td class="manual"><%=sourceFields.get("routeOfAdministration")%></td>
        <td class="manual"><%=sourceFields.get("drugProductType")%></td>
        <td class="manual"><%=sourceFields.get("targetTissueOrCell")%></td>
        <td class="manual"><%=sourceFields.get("deliverySystem")%></td>
        <td class="manual"><%=sourceFields.get("vectorType")%></td>
        <td class="manual"><%if(sourceFields.get("editorType")!=null && !sourceFields.get("editorType").toString().equalsIgnoreCase("none")){%>
            <%=sourceFields.get("editorType")%>
            <%}%>
        </td>
        <td class="manual">

            <%
                String dosage=null;
                List<String> dosages=new ArrayList<>();
                if(sourceFields.get("dose1")!=null && !sourceFields.get("dose1").toString().equals("")){
                    if(sourceFields.get("dose2")!=null && !sourceFields.get("dose2").toString().equals(""))
                    dosages.add("<b>Dose 1:</b>&nbsp;"+(sourceFields.get("dose1").toString()));
                    else
                        dosages.add((sourceFields.get("dose1").toString()));

                }
                if(sourceFields.get("dose2")!=null && !sourceFields.get("dose2").toString().equals("")){
                    dosages.add("<b>Dose 2:</b>&nbsp;"+sourceFields.get("dose2").toString());
                }
                if(sourceFields.get("dose3")!=null && !sourceFields.get("dose3").toString().equals("")){
                    dosages.add("<b>Dose 3:</b>&nbsp;"+(sourceFields.get("dose3").toString()));
                }
                if(sourceFields.get("dose4")!=null && !sourceFields.get("dose4").toString().equals("")){
                    dosages.add("<b>Dose 4:</b>&nbsp;"+(sourceFields.get("dose4").toString()));
                }
                if(sourceFields.get("dose5")!=null && !sourceFields.get("dose5").toString().equals("")){
                    dosages.add("<b>Dose 5:</b>&nbsp;"+(sourceFields.get("dose5").toString()));
                }
                if(dosages.size()==1){
                    dosage=dosages.get(0);
                }else if(dosages.size()>1){
                    dosage=dosages.stream().collect(Collectors.joining(" | "));
                }
                if(dosage!=null){
            %>
            <%=dosage%>
            <%}%>
        </td>



<%--        <td class="manual"><%=sourceFields.get("dose5")%></td>--%>
        <td class="text-nowrap">
            <%
                List<String> phases= (List<String>) sourceFields.get("phases");
                String phase= phases.stream().collect(Collectors.joining(", "));
            %>
            <%=phase%>
        </td>
        <td>   <%
            if(sourceFields.get("status")!=null){
            List<String> statuses= (List<String>) sourceFields.get("status");
            String status= statuses.stream().collect(Collectors.joining(", "));
        %>
            <%=status%>
        <%}%></td>
    <td class="manual">
        <%
            if(sourceFields.get("developmentStatus")!=null){
        %>
        <%=sourceFields.get("developmentStatus")%>
        <%}%>
    </td>
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
    <td>
<%--        <td><%--%>
<%--            if(sourceFields.get("locations")!=null){--%>
<%--                List<String> location= (List<String>) sourceFields.get("locations");--%>
<%--                String locations= location.stream().collect(Collectors.joining(", "));--%>
<%--        %>--%>
<%--            <%=locations%>--%>
<%--            <%}%>--%>
    <%if(sourceFields.get("locations")!=null){
        List<String> location= ((List<String>) sourceFields.get("locations"));
        Collections.sort(location);
        String firstMatch = "";
        for(String loc:location){
            if(loc.equalsIgnoreCase("united states")){
                firstMatch+=loc;
            }
        }
        if(firstMatch.isEmpty()){
            firstMatch=location.get(0);
        }
        String locations= location.stream().collect(Collectors.joining(", "));
        if(locations.length()>0){
            if(location.size()>1){
    %>
    <a data-container="body" data-trigger="hover click" data-toggle="popover" data-placement="bottom" data-popover-content="#popover-<%=sourceFields.get("nctId")%>" title="Locations" style="background-color: transparent;cursor: pointer;text-decoration: none">
    <span style="display: none">Locations:</span><span style="text-decoration:underline"><%=firstMatch%>&nbsp; + <%=location.size()-1%>&nbsp;more</span>
    </a>
    <div style="display: none" id="popover-<%=sourceFields.get("nctId")%>">
        <div class="popover-body"><%=locations%></div>
    </div>
    <%}else{%>
            <%=location.get(0)%>

    <%}}}%>
        </td>
        <td style="text-align: center">
            <%
                String isFDARegulated="";
                if(sourceFields.get("isFDARegulated")!=null){
                    String regulated= (String) sourceFields.get("isFDARegulated");
                    if(regulated.equalsIgnoreCase("true")) {
                        isFDARegulated += "<i class=\"fa-solid fa-check\" style='color:green'></i>";
                    }else{
                        isFDARegulated+="<i class=\"fa-solid fa-xmark\" style='color:red'></i>";
                    }
            }%>
            <%=isFDARegulated%>
        </td>
        <td class="manual"><%=sourceFields.get("patents")%></td>
        <td class="manual"><%=sourceFields.get("recentUpdates")%></td>
        <td class="manual lastColumn">
            <% if (sourceFields.get("externalLinks")!=null){%>
            <a href="javascript:void(0)" onclick="myModal('<%=sourceFields.get("nctId")%>')" title="Resources/Links" ><i class="fa-solid fa-eye"></i></a>
            <% } %>
            <div id="<%=sourceFields.get("nctId").toString().toLowerCase()%>" style="display: none">
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
            <div>
            <div class="text-nowrap"><strong><%=type%>&nbsp;:</strong></div>
                <div class="card-body" style="overflow-y: auto">
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
            </div>
        </td>
    </tr>
    <%}%>
    </tbody>
</table>
</div>
<div class="modal fade" id="refModal" role="dialog" >
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content" >
            <div class="modal-header">
                <h4 class="modal-title">References</h4>
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-window-close" aria-hidden="true"></i>
                </button>
            </div>
            <div class="modal-body" >
                <div id="refDiv">Some text in the modal.</div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>

<script>
    function myModal(nctId) {
    var content=$('#refDiv');
    var contentDivId='#'+nctId.toLowerCase().trim()
    var data=$(contentDivId).html()

            content.html(data);

    $( "#refModal" ).modal();
}

</script>