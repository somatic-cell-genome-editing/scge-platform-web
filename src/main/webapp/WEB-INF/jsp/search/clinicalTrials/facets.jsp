
<%@ page import="org.elasticsearch.search.aggregations.Aggregation" %>
<%@ page import="edu.mcw.scge.service.es.clinicalTrials.ClinicalTrialsService" %>
<%@ page import="org.elasticsearch.search.aggregations.bucket.terms.Terms" %>
<%@ page import="edu.mcw.scge.datamodel.web.ClinicalTrials" %><%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 4/22/2024
  Time: 2:40 PM
  To change this template use File | Settings | File Templates.
--%>
<link href="/platform/css/clinicalTrialsFacets.css" rel="stylesheet" type="text/css"/>
<script>
// $(function () {
// $('[data-toggle="tooltip"]').tooltip()
// })
expandFilterVal="<%=request.getAttribute("expandAllFilters")%>"

</script>

<%--<div class="input-group">--%>
<%--  <input class="search selectable form-control form-control-sm" type="search" placeholder="Search Gene Therapy Trials.." data-column="all">--%>
<%--  <div class="input-group-append">&nbsp;<span class="input-group-text reset" title="Reset"><i class="fa fa-refresh" aria-hidden="true"></i></span>--%>
<%--  </div>--%>
<%--</div>--%>

<h4 class="grid-title"><i class="fa fa-filter"></i> Filters ..&nbsp;<span id="expandAll" class="plus" title="Expand All" onclick="expandAll()" style="cursor: pointer;font-size: medium"><i class="fa-solid fa-circle-plus"></i></span><span id="collapseAll" class="minus" style="display: none;color:red;cursor:pointer;font-size: medium" title="Close All" onclick="collapseAll()"><i class="fa-solid fa-circle-minus"></i></span><span style="float:right"><!--button id="clearFilters" class="btn btn-primary btn-sm" onclick="removeFilters()" >Clear</button-->
<a href="/platform/data/search/ClinicalTrial"><button id="clearFilters" class="btn btn-primary btn-sm"  >Clear</button></a></span></h4>

<hr>


<div align="right">

</div>
<form id="facetForm" action="/platform/data/search/<%=category%>">
  <input type="hidden" id="unchecked" name="unchecked" value=''/>
  <input type="hidden" id="checked" name="checked" value=''/>
  <input type="hidden" id="filtersSelected" name="filtersSelected" value='<%=gson.toJson(filtersSelected)%>'/>
  <input type="hidden" id="expandAllFilters" name="expandAllFilters" value="<%=request.getAttribute("expandAllFilters")%>">
  <input type="hidden" id="category" name="category" value="<%=request.getAttribute("category")%>">
  <input type="hidden"  name="searchTerm" value="<%=request.getAttribute("searchTerm")%>">

  <%

  for(String aggName:ClinicalTrials.facets){
%>
  <div class="accordion-group">
    <div class="pl-3  accordion-heading">
      <a class="accordion-toggle  search-results-anchor" data-toggle="collapse" href="#collapse<%=aggName%>">
        <%
          String value = ClinicalTrialsService.fieldDisplayNames.get(aggName);
          if (value != null) {
            value = value.replaceAll("\\bOf\\b", "of").replaceAll("\\bOr\\b", "or").trim();
          }
        %>
<%--        <span class="<%=aggName%>"><%=ClinicalTrialsService.fieldDisplayNames.get(aggName)%></span><span class="float-right"><i class="fas fa-angle-up"></i></span>--%>
        <span class="<%=aggName%>" data-title="<%=value%>"><%=value%>&nbsp;
          <sup>
            <span data-toggle="tooltip" title="<%=ClinicalTrialsService.facetDefinitions.get(value)%>">
             <%@include file="infoSvg.jsp"%>
            </span>
          </sup>
        </span>
        <span class="float-right"><i class="fas fa-angle-up"></i></span>
      </a>
    </div>
    <div id="collapse<%=aggName%>" class="accordion-body collapse" >
      <div class="pl-3  accordion-inner" style="height:auto;max-height: 300px;; overflow-y: auto">
        <%
         Terms aggs= sr.getAggregations().get(aggName);
          for(Terms.Bucket bkt:aggs.getBuckets()){

            if(bkt.getKey()!=null && !bkt.getKey().equals("")){
        %>
        <div class="form-check">
          <input class="form-check-input" type="checkbox" name="<%=aggName%>" value="<%=bkt.getKey()%>" id="<%=bkt.getKey()%>">
          <label class="form-check-label" for="<%=bkt.getKey()%>" data-title="<%=bkt.getKey()%>">
            <%=bkt.getKey()%>&nbsp;<!--(<%--=bkt.getDocCount()--%>)-->
          </label>
        </div>
          <%}}%>

      </div>
    </div>

  </div>

  <%}%>


</form>
<script>
let allFacets=<%=gson.toJson(ClinicalTrials.facets)%>
</script>
<script src="/platform/js/search/ctFacets.js"></script>

