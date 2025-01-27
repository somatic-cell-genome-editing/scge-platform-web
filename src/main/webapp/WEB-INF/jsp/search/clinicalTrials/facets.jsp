
<%@ page import="org.elasticsearch.search.aggregations.Aggregation" %>
<%@ page import="edu.mcw.scge.service.es.clinicalTrials.ClinicalTrialsService" %>
<%@ page import="org.elasticsearch.search.aggregations.bucket.terms.Terms" %><%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 4/22/2024
  Time: 2:40 PM
  To change this template use File | Settings | File Templates.
--%>
<style>
  /*.sponsorClass,.therapyType,.therapyRoute,.mechanismOfAction,.routeOfAdministration, .drugProductType,.deliverySystem,.locations,*/
  /*.standardAges{*/
  /*  color:red;*/
  /*}*/
  .tooltip-inner {
    word-break: break-all;
  }
</style>
<script>
$(function () {
$('[data-toggle="tooltip"]').tooltip()
})
expandFilterVal="<%=request.getAttribute("expandAllFilters")%>"

</script>
<h4 class="grid-title"><i class="fa fa-filter"></i> Filters ..&nbsp;<span id="expandAll" class="plus" title="Expand All" onclick="expandAll()" style="cursor: pointer;font-size: medium"><i class="fa-solid fa-circle-plus"></i></span><span id="collapseAll" class="minus" style="display: none;color:red;cursor:pointer;font-size: medium" title="Close All" onclick="collapseAll()"><i class="fa-solid fa-circle-minus"></i></span><span style="float:right"><button id="clearFilters" class="btn btn-primary btn-sm" onclick="removeFilters()" >Clear</button></span></h4>
<div class="input-group"><input class="search selectable form-control form-control-sm" type="search" placeholder="Find in the table" data-column="all"><div class="input-group-append">&nbsp;<span class="input-group-text reset" title="Reset"><i class="fa fa-refresh" aria-hidden="true"></i></span></div></div>

<hr>


<div align="right">

</div>
<form id="facetForm" action="/platform/data/search/ClinicalTrial">
  <input type="hidden" id="unchecked" name="unchecked" value=''/>
  <input type="hidden" id="checked" name="checked" value=''/>
  <input type="hidden" id="filtersSelected" name="filtersSelected" value='<%=gson.toJson(filtersSelected)%>'/>
  <input type="hidden" id="expandAllFilters" name="expandAllFilters" value="<%=request.getAttribute("expandAllFilters")%>">
  <%
    List<String> aggNames=Arrays.asList("indication","status","phases","standardAges","therapyType","therapyRoute","drugProductType","deliverySystem","sponsorClass","sponsor",
            "vectorType","editorType","targetTissueOrCell","targetGeneOrVariant","routeOfAdministration", "mechanismOfAction", "locations");
  for(String aggName:aggNames){
%>
  <div class="accordion-group">
    <div class="pl-3  accordion-heading">
      <a class="accordion-toggle  search-results-anchor" data-toggle="collapse" href="#collapse<%=aggName%>">
        <%
          String value = ClinicalTrialsService.fieldDisplayNames.get(aggName);
          if (value != null) {
            value = value.replaceAll("\\bOf\\b", "of").replaceAll("\\bOr\\b", "or");
          }
        %>
<%--        <span class="<%=aggName%>"><%=ClinicalTrialsService.fieldDisplayNames.get(aggName)%></span><span class="float-right"><i class="fas fa-angle-up"></i></span>--%>
        <span class="<%=aggName%>"><%=value%>&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get(value.trim())%>"><i class="fa-solid fa-circle-info"></i></span></sup></span><span class="float-right"><i class="fas fa-angle-up"></i></span>
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
          <label class="form-check-label" for="<%=bkt.getKey()%>">
            <%=bkt.getKey()%>&nbsp;<!--(<%--=bkt.getDocCount()--%>)-->
          </label>
        </div>
          <%}}%>

      </div>
    </div>

  </div>

  <%}%>


</form>

<script src="/platform/js/search/ctFacets.js"></script>

