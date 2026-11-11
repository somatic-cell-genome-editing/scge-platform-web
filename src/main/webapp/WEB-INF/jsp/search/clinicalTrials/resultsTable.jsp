<%@ page import="edu.mcw.scge.datamodel.ClinicalTrialExternalLink" %>
<%@ page import="java.util.stream.Collectors" %><%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 9/16/2024
  Time: 9:44 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    /**
     * Elasticsearch leaves a field out of _source when the trial has no value for it,
     * so printing map.get(...) directly puts the literal "null" in the cell.
     * Render an empty cell instead.
     */
    private static String cellValue(Object value) {
        if (value == null) return "";
        String text = value.toString().trim();
        return text.equalsIgnoreCase("null") ? "" : text;
    }
%>
<link href="/platform/css/clinicalTrialsResultsTable.css" rel="stylesheet" type="text/css"/>
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
<!-- Column Visibility Dropdown -->
<div id="columnToggleWrapper" class="column-toggle-wrapper" style="display: none">
    <div class="column-toggle-dropdown">
        <button type="button" class="btn btn-outline-secondary btn-sm column-toggle-btn" id="columnToggleBtn">
            <i class="fa-solid fa-table-columns"></i>&nbsp; Columns <span class="column-count-badge" id="columnCountBadge"></span>
        </button>
        <div class="column-toggle-menu" id="columnToggleMenu">
            <div class="column-toggle-header">
                <span>Show/Hide Columns</span>
                <div>
                    <a href="javascript:void(0)" id="colSelectAll" class="column-toggle-action">All</a>
                    <a href="javascript:void(0)" id="colSelectNone" class="column-toggle-action">None</a>
                </div>
            </div>
            <div class="column-toggle-list" id="columnToggleList"></div>
        </div>
    </div>
</div>

<!-- Top Scrollbar -->
<div id="topScrollWrapper" class="top-scroll-wrapper" style="display: none">
    <div id="topScrollContent" class="top-scroll-content"></div>
</div>
<!-- Table Container -->
<div id="resultsTable" style="display: none">
<table  id="myTable">
    <caption>SCGE Platform GTCT</caption>
    <thead><tr><%@include file="columns.jsp"%></tr></thead>
    <tfoot><tr><%@include file="columns.jsp"%></tr></tfoot>
    <tbody>
    <%
        for(Hit<Map> hit:hits) {
            Map<String, Object> sourceFields = (Map<String, Object>) hit.source();
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
        <td class="manual"><%=cellValue(sourceFields.get("indication"))%></td>

        <td class="manual"><%=cellValue(sourceFields.get("compoundName"))%></td>
        <td><%=cellValue(sourceFields.get("sponsor"))%></td>
        <td ><%=cellValue(sourceFields.get("sponsorClass"))%></td>
<%--        <td><%=sourceFields.get("interventionName")%></td>--%>
        <td class="manual"><%=cellValue(sourceFields.get("targetGeneOrVariant"))%></td>
        <td class="manual">
            <%
                if(sourceFields.get("regulatoryElement")!=null){
            %>
            <%=cellValue(sourceFields.get("regulatoryElement"))%>
            <%}%>
        </td>
        <td class="manual"><%=cellValue(sourceFields.get("therapyType"))%></td>
        <td class="manual"><%=cellValue(sourceFields.get("therapyRoute"))%></td>
        <td class="manual"><%=cellValue(sourceFields.get("mechanismOfAction"))%></td>
        <td class="manual"><%=cellValue(sourceFields.get("routeOfAdministration"))%></td>
        <td class="manual"><%=cellValue(sourceFields.get("drugProductType"))%></td>
        <td class="manual"><%=cellValue(sourceFields.get("targetTissueOrCell"))%></td>
        <td class="manual"><%=cellValue(sourceFields.get("deliverySystem"))%></td>
        <td class="manual"><%=cellValue(sourceFields.get("vectorType"))%></td>
        <td class="manual"><%if(sourceFields.get("editorType")!=null && !sourceFields.get("editorType").toString().equalsIgnoreCase("none")){%>
            <%=cellValue(sourceFields.get("editorType"))%>
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
                String phase= phases==null ? "" : phases.stream().collect(Collectors.joining(", "));
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
        <%=cellValue(sourceFields.get("developmentStatus"))%>
        <%}%>
    </td>
        <td class="text-nowrap"><%=cellValue(sourceFields.get("firstSubmitDate"))%></td>
        <td><%=cellValue(sourceFields.get("estimatedCompleteDate"))%></td>
        <td class="text-nowrap"><%=cellValue(sourceFields.get("lastUpdatePostDate"))%></td>
<%--        <td class="text-nowrap"><%=sourceFields.get("standardAges")%></td>--%>
        <td class="text-nowrap">
            <%
                String minAge = cellValue(sourceFields.get("elibilityMinAge"));
                String maxAge = cellValue(sourceFields.get("elibilityMaxAge"));
                if(!minAge.isEmpty() && !maxAge.isEmpty()){
            %>
            <%=minAge%> - <%=maxAge%>
            <%}else if(!minAge.isEmpty()){%>
                   >=&nbsp;<%=minAge%>
            <%}else if(!maxAge.isEmpty()){%>
            <=&nbsp;<%=maxAge%>
            <%}%>
        </td>
        <td><%=cellValue(sourceFields.get("enrorllmentCount"))%></td>
        <td><%=cellValue(sourceFields.get("numberOfLocations"))%></td>
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
    <td class="manual">
        <%
            if(sourceFields.get("fdaDesignations")!=null){
        %>
        <%=((List<String>)sourceFields.get("fdaDesignations")).stream().collect(Collectors.joining(", "))%>
        <%}%>
    </td>
<%--        <td class="manual"><%=sourceFields.get("patents")%></td>--%>
        <td class="manual"><%=cellValue(sourceFields.get("recentUpdates"))%></td>
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
                            <a href="<%=map.get("link")%>" target="_blank"><%=cellValue(map.get("name"))%></a>
                                <%}else{%>
                                <%=cellValue(map.get("name"))%>
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

// Synchronized Top Scrollbar
function updateTopScrollWidth() {
    var topScrollContent = document.getElementById('topScrollContent');
    var resultsTable = document.getElementById('resultsTable');
    if (topScrollContent && resultsTable) {
        // Set content to same scrollWidth as table
        topScrollContent.style.width = resultsTable.scrollWidth + 'px';
    }
}

$(document).ready(function() {
    var topScroll = document.getElementById('topScrollWrapper');
    var resultsTable = document.getElementById('resultsTable');

    // Sync scroll positions using percentage
    if (topScroll && resultsTable) {
        topScroll.addEventListener('scroll', function() {
            var topMaxScroll = topScroll.scrollWidth - topScroll.clientWidth;
            var tableMaxScroll = resultsTable.scrollWidth - resultsTable.clientWidth;
            if (topMaxScroll > 0) {
                var scrollPercent = topScroll.scrollLeft / topMaxScroll;
                resultsTable.scrollLeft = scrollPercent * tableMaxScroll;
            }
        });

        resultsTable.addEventListener('scroll', function() {
            var topMaxScroll = topScroll.scrollWidth - topScroll.clientWidth;
            var tableMaxScroll = resultsTable.scrollWidth - resultsTable.clientWidth;
            if (tableMaxScroll > 0) {
                var scrollPercent = resultsTable.scrollLeft / tableMaxScroll;
                topScroll.scrollLeft = scrollPercent * topMaxScroll;
            }
        });
    }

    // Update on window resize
    $(window).on('resize', function() {
        setTimeout(updateTopScrollWidth, 50);
    });
});

// Column Visibility Toggle
(function() {
    var columnNames = [];
    var columnVisible = [];
    // Paging / filtering reloads the whole page, so the chosen columns have to be
    // remembered outside the DOM or every navigation would reset them to the default.
    var STORAGE_KEY = 'ctColumnVisibility';

    // Keyed by header name rather than index so adding, removing or reordering a
    // column later does not shift a saved preference onto the wrong column.
    function loadSavedVisibility() {
        try {
            var raw = localStorage.getItem(STORAGE_KEY);
            var parsed = raw ? JSON.parse(raw) : null;
            return (parsed && typeof parsed === 'object') ? parsed : {};
        } catch (e) {
            return {};
        }
    }

    function saveVisibility() {
        try {
            var saved = {};
            $.each(columnNames, function(index, name) {
                saved[name] = columnVisible[index];
            });
            localStorage.setItem(STORAGE_KEY, JSON.stringify(saved));
        } catch (e) {}
    }

    function initColumnToggle() {
        var $headerCells = $('#myTable thead tr:first th');
        if ($headerCells.length === 0) return;

        columnNames = [];
        columnVisible = [];
        var listHtml = '';
        var saved = loadSavedVisibility();

        $headerCells.each(function(index) {
            var name = $(this).clone().children('sup').remove().end().text().trim();
            if (!name) name = 'Column ' + (index + 1);
            // Columns marked data-default-hidden="true" start hidden until picked from this list
            var hiddenByDefault = String($(this).attr('data-default-hidden')) === 'true';
            // A saved choice wins; a column with no saved entry falls back to its default
            var isVisible = saved.hasOwnProperty(name) ? saved[name] !== false : !hiddenByDefault;
            columnNames.push(name);
            columnVisible.push(isVisible);
            listHtml += '<label class="column-toggle-item">' +
                '<input type="checkbox" ' + (isVisible ? 'checked' : '') + ' data-col-index="' + index + '"> ' +
                '<span>' + name + '</span></label>';
        });

        $('#columnToggleList').html(listHtml);

        // Hide the columns that are off, whether by default or by saved choice
        $.each(columnVisible, function(index, isVisible) {
            if (!isVisible) {
                toggleColumn(index, false);
            }
        });

        updateColumnCount();
        saveVisibility();

        // Toggle button
        $('#columnToggleBtn').off('click').on('click', function(e) {
            e.stopPropagation();
            $('#columnToggleMenu').toggleClass('open');
        });

        // Close on outside click
        $(document).off('click.colToggle').on('click.colToggle', function(e) {
            if (!$(e.target).closest('.column-toggle-dropdown').length) {
                $('#columnToggleMenu').removeClass('open');
            }
        });

        // Checkbox change
        $('#columnToggleList').off('change').on('change', 'input[type="checkbox"]', function() {
            var colIndex = $(this).data('col-index');
            var isVisible = $(this).is(':checked');
            columnVisible[colIndex] = isVisible;
            toggleColumn(colIndex, isVisible);
            updateColumnCount();
            saveVisibility();
        });

        // Select All
        $('#colSelectAll').off('click').on('click', function() {
            $('#columnToggleList input[type="checkbox"]').each(function() {
                if (!$(this).is(':checked')) {
                    $(this).prop('checked', true).trigger('change');
                }
            });
        });

        // Select None
        $('#colSelectNone').off('click').on('click', function() {
            $('#columnToggleList input[type="checkbox"]').each(function(index) {
                if (index === 0) return; // keep Trial ID visible
                if ($(this).is(':checked')) {
                    $(this).prop('checked', false).trigger('change');
                }
            });
        });

        $('#columnToggleWrapper').show();
    }

    function toggleColumn(colIndex, show) {
        var colNum = colIndex + 1;
        var selector = '#myTable tr th:nth-child(' + colNum + '), #myTable tr td:nth-child(' + colNum + ')';
        if (show) {
            $(selector).show();
        } else {
            $(selector).hide();
        }
        setTimeout(updateTopScrollWidth, 50);
    }

    function updateColumnCount() {
        var visible = columnVisible.filter(function(v) { return v; }).length;
        var total = columnVisible.length;
        $('#columnCountBadge').text(visible + '/' + total);
    }

    // Expose init function globally so it can be called after table loads
    window.initColumnToggle = initColumnToggle;
})();
</script>
