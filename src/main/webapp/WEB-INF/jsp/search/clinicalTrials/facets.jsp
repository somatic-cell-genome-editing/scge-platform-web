
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
  .standardAges{
    color:red;
  }
</style>
<h4 class="grid-title"><i class="fa fa-filter"></i> Filters ..&nbsp;&nbsp;&nbsp;<span style="float:right"><button id="clearFilters" class="btn btn-primary btn-sm" onclick="removeFilters()" >Clear Filters</button></span></h4>

<hr>


<div align="right">

</div>
<form id="facetForm" action="/platform/data/search/clinicalTrials">
  <input type="hidden" id="unchecked" name="unchecked" value=''/>
  <input type="hidden" id="checked" name="checked" value=''/>
  <input type="hidden" id="filtersSelected" name="filtersSelected" value='<%=gson.toJson(filtersSelected)%>'/>

  <%
    List<String> aggNames=Arrays.asList("indication","status","phases","standardAges","therapyType","therapyRoute","drugProductType","deliverySystem","sponsorClass","sponsor",
            "vectorType","editorType","targetTissueOrCell","targetGeneOrVariant","routeOfAdministration", "mechanismOfAction", "locations");
  for(String aggName:aggNames){
%>
  <div class="accordion-group">
    <div class="pl-3  accordion-heading card-header">
      <a class="accordion-toggle  search-results-anchor" data-toggle="collapse" href="#collapse<%=aggName%>">
        <span class="<%=aggName%>"><%=ClinicalTrialsService.fieldDisplayNames.get(aggName)%></span><span class="float-right"><i class="fas fa-angle-up"></i></span>
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
            <%=bkt.getKey()%>&nbsp;(<%=bkt.getDocCount()%>)
          </label>
        </div>
          <%}}%>

      </div>
    </div>

  </div>

  <%}%>


</form>

<script src="/platform/js/search/ctFacets.js"></script>

