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
    #resultsTable{
        height: auto;
        min-height: 50px;
        max-height: 580px;
        overflow: auto;
        position: relative;
        width:100%;
        margin-top: 10px;
    }
    #myTable{
        position: relative;
        /*top:-8px;*/
        bottom:1px;
        left:-0.75px;
        margin-top: 0px;
        margin-bottom: 0px;
        border-collapse: separate;
        border-spacing: 0;
        border-left: 1px;
        /*border-right: 0.5px;*/
    }
    #myTable td.firstColumn{
        position: sticky;
        /*left:-1px;*/
        left:0;
        z-index: 2;
        background-color: white;
    }

    #myTable td.firstColumn:hover{
        background-color: #ddd;
    }

    #myTable thead th{
        position: sticky;
        top:0px;
        z-index: 2;
    }

    #myTable tfoot th{
        position: sticky;
        bottom:0px;
        z-index: 2;
    }

    #myTable td.firstColumn:before {
        content: "";
        position: absolute;
        left: 0;
        top: 0;
        bottom: 0;
        width: 1px;
        background-color: lightgrey;
        /*z-index: -1; */
    }
    /*#myTable td.lastColumn:after {*/
    /*    content: "";*/
    /*    position: absolute;*/
    /*    right: 0;*/
    /*    top: 0;*/
    /*    bottom: 0;*/
    /*    width: 0.5px;*/
    /*    background-color: #ddd;*/
    /*    z-index: -1; !* Behind the content but still part of the cell *!*/
    /*}*/

    #resultsTable {
        scrollbar-color: #ff6b00 #f1f1f1;  /* thumb and track color */
    }


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

</style>

<div id="resultsTable"  style="display: none">
<table  id="myTable">
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
        <a href="/platform/clinicalTrials/report/<%=sourceFields.get("nctId")%>" target="_blank" style="text-decoration: none;">
            <button style="font-size:0.75rem;font-weight: normal;padding:2px 5px;border: none; background-color: #007bff; color: white; border-radius: 4px; cursor: pointer;">
                View Report
            </button>
        </a>
    </td>
        <td class="manual"><%=sourceFields.get("indication")%></td>
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
        <td class="manual"><%=sourceFields.get("dose1")%></td>
        <td class="manual"><%=sourceFields.get("dose2")%></td>
        <td class="manual"><%=sourceFields.get("dose3")%></td>
        <td class="manual"><%=sourceFields.get("dose4")%></td>
        <td class="manual"><%=sourceFields.get("dose5")%></td>
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
        <td><%
            if(sourceFields.get("locations")!=null){
                List<String> location= (List<String>) sourceFields.get("locations");
                String locations= location.stream().collect(Collectors.joining(", "));
        %>
            <%=locations%>
            <%}%></td>
        <td><%=sourceFields.get("isFDARegulated")%></td>
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