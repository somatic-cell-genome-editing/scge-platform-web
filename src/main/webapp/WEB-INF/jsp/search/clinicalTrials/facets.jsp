
<%@ page import="org.elasticsearch.search.aggregations.Aggregation" %>
<%@ page import="edu.mcw.scge.service.es.clinicalTrials.ClinicalTrialsService" %><%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 4/22/2024
  Time: 2:40 PM
  To change this template use File | Settings | File Templates.
--%>
<style>
  .sponsorClass,.therapyType,.therapyRoute,.mechanismOfAction,.routeOfAdministration, .drugProductType,.deliverySystem,.locations{
    color:red;
  }
</style>
<h4 class="grid-title"><i class="fa fa-filter"></i> Filters ..&nbsp;&nbsp;&nbsp;<span style="float:right"><button id="clearFilters" class="btn btn-primary btn-sm" onclick="removeFilters()" >Clear Filters</button></span></h4>

<hr>


<div align="right">

</div>
<form id="facetForm" action="/platform/data/search/clinicalTrials">
<%
  for(Aggregation agg:sr.getAggregations()){%>
  <div class="accordion-group">
    <div class="pl-3  accordion-heading card-header">
      <a class="accordion-toggle  search-results-anchor" data-toggle="collapse" href="#collapse<%=agg.getName()%>">
        <span class="<%=agg.getName()%>"><%=ClinicalTrialsService.fieldDisplayNames.get(agg.getName())%></span><span class="float-right"><i class="fas fa-angle-up"></i></span>
      </a>
    </div>
    <div id="collapse<%=agg.getName()%>" class="accordion-body collapse" >
      <div class="pl-3  accordion-inner" style="height:auto;max-height: 300px;; overflow-y: auto">
        <%
         Terms aggs= sr.getAggregations().get(agg.getName());
          for(Terms.Bucket bkt:aggs.getBuckets()){

            if(bkt.getKey()!=null && !bkt.getKey().equals("")){
        %>
        <div class="form-check">
          <input class="form-check-input" type="checkbox" name="<%=agg.getName()%>" value="<%=bkt.getKey()%>" id="<%=bkt.getKey()%>">
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
