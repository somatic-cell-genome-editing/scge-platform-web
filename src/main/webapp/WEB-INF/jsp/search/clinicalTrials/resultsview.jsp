<%@ page import="org.elasticsearch.search.SearchHit" %>
<%@ page import="org.elasticsearch.action.search.SearchResponse" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="org.elasticsearch.search.aggregations.bucket.terms.Terms" %>

<%@ page import="java.util.*" %><%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 3/26/2024
  Time: 2:59 PM
  To change this template use File | Settings | File Templates.
--%>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<style>

  .grid .grid-body {
    padding: 15px 20px 15px 20px;
    font-size: 0.9em;
    /*line-height: 1.9em;*/
  }


  .search table tr:hover {
    cursor: pointer;
  }


</style>

<%
    Gson gson=new Gson();

    SearchResponse sr= (SearchResponse) request.getAttribute("sr");


    Terms orgAggregations=sr.getAggregations().get("sponsor");
    Terms statAggregations=sr.getAggregations().get("status");
    Terms conditionAggregations=sr.getAggregations().get("indication");
    Terms trackerTypeAggregations=sr.getAggregations().get("trackerType");

    Terms vectorTypeAggregations=sr.getAggregations().get("vectorType");
    Terms deliverySystermAggregations=sr.getAggregations().get("deliverySystem");
    Terms routeOfAdministrationAggregations=sr.getAggregations().get("routeOfAdministration");
    Terms therapyType=sr.getAggregations().get("therapyType");

    Terms editorTypeAggregations=sr.getAggregations().get("editorType");
    Terms drugProductTypeAggregations=sr.getAggregations().get("drugProductType");
    Terms sponsorClassAggregations=sr.getAggregations().get("sponsorClass");

    SearchHit[] hitsArray=sr.getHits().getHits();
    List<SearchHit> hits=(Arrays.asList(hitsArray));
    Map<String, List<String>> filterMap= (Map<String, List<String>>) request.getAttribute("filterMap");
    List<String> selectedStatus=new ArrayList<>();
    List<String> selectedCondition=new ArrayList<>();
    List<String> selectedOrganization=new ArrayList<>();
    List<String> selectedTrackerType=new ArrayList<>();

    List<String> selectedVectorType=new ArrayList<>();
    List<String> selectedDeliverySystem=new ArrayList<>();
    List<String> selectedEditorType=new ArrayList<>();
    List<String> selectedDrugProductType=new ArrayList<>();

    List<String> selectedRouteOfAdministration=new ArrayList<>();
    List<String> selectedSponsorClass=new ArrayList<>();
    List<String> selectedTherapyType=new ArrayList<>();

    if(filterMap!=null){
        if(filterMap.get("status")!=null)
            selectedStatus.addAll(filterMap.get("status"));
        if(filterMap.get("indication")!=null)
            selectedCondition.addAll(filterMap.get("indication"));
        if(filterMap.get("sponsor")!=null)
            selectedOrganization.addAll(filterMap.get("sponsor"));
        if(filterMap.get("trackerType")!=null)
            selectedTrackerType.addAll(filterMap.get("trackerType"));

        if(filterMap.get("vectorType")!=null)
            selectedVectorType.addAll(filterMap.get("vectorType"));
        if(filterMap.get("deliverySystem")!=null)
            selectedDeliverySystem.addAll(filterMap.get("deliverySystem"));
        if(filterMap.get("editorType")!=null)
            selectedEditorType.addAll(filterMap.get("editorType"));
        if(filterMap.get("routeOfAdministration")!=null)
            selectedRouteOfAdministration.addAll(filterMap.get("routeOfAdministration"));

        if(filterMap.get("drugProductType")!=null)
            selectedDrugProductType.addAll(filterMap.get("drugProductType"));
        if(filterMap.get("sponsorClass")!=null)
            selectedSponsorClass.addAll(filterMap.get("sponsorClass"));
        if(filterMap.get("therapyType")!=null)
            selectedTherapyType.addAll(filterMap.get("therapyType"));

    }

%>

<script>
    var  statusSelected=<%=gson.toJson(selectedStatus)%>;
    var  conditionSelected=<%=gson.toJson(selectedCondition)%>;
    var orgSelected=<%=gson.toJson(selectedOrganization)%>;
    var trackerTypeSelected=<%=gson.toJson(selectedTrackerType)%>

    var  vectorTypeSelected=<%=gson.toJson(selectedVectorType)%>;
    var  deliverySystemSelected=<%=gson.toJson(selectedDeliverySystem)%>;
    var editorTypeSelected=<%=gson.toJson(selectedEditorType)%>;
    var therapyTypeSelected=<%=gson.toJson(selectedTherapyType)%>

    var  drugProductTypeSelected=<%=gson.toJson(selectedDrugProductType)%>;
    var  routeOfAdministrationSelected=<%=gson.toJson(selectedRouteOfAdministration)%>;
    var sponsorClasssSelected=<%=gson.toJson(selectedSponsorClass)%>;

</script>


<div>
    <div class="row">
        <div class="col-6"><h3>Clinical Trials - Gene Therapy Tracker</h3></div>
<%--        <div class="col-3"><small>Last Updated Date: 09/23/2024</small></div>--%>
    </div>
</div>
<hr>
<div class="container-fluid">

  <div class="row">
    <!-- BEGIN SEARCH RESULT -->
    <div class="col-md-12">
      <div class="grid search">
        <div class="grid-body">
          <div class="row">
            <!-- BEGIN FILTERS -->
            <div class="col-md-2">
                <%@include file="facets.jsp"%>
            </div>
            <!-- END FILTERS -->
            <!-- BEGIN RESULT -->
            <div class="col-md-10">
              <h4><i class="fa fa-file-o"></i> Result</h4>

              <hr>
                <span>Showing all  <%=hits.size()%> results ...</span><br>
                <%if(filterMap!=null && filterMap.size()>0){
                    boolean first=true;
                %>
                <strong>Filters:</strong>

                <%for(String key: filterMap.keySet()){
                    List<String> values=filterMap.get(key);
                    for(String filter:values){
                        if(first){first=false;%>
                &nbsp;<span style="color:darkorange; font-weight: bold"><%=filter%></span>
                       <% }else{%>
                &nbsp;<span style="font-weight: bold">&nbsp;|&nbsp;</span><span style="color:darkorange; font-weight: bold"><%=filter%></span>
                       <% }
                %>

                    <%}}}%>

              <div class="padding"></div>
                <!-- BEGIN TABLE RESULT -->
              <div style="width:100%">
               <%@include file="resultsTable.jsp"%>
              </div>

            </div>
            <!-- END RESULT -->
          </div>
        </div>
      </div>
    </div>
    <!-- END SEARCH RESULT -->
  </div>
</div>