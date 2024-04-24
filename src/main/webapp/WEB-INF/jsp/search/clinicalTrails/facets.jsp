<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 4/22/2024
  Time: 2:40 PM
  To change this template use File | Settings | File Templates.
--%>


<h2 class="grid-title"><i class="fa fa-filter"></i> Filters ..</h2>
<%--<button  onclick="applyFilters()">Apply</button>--%>
<hr>

<%
for(String id:idsFromTrackerSheet){
  boolean flag=false;
  for(String idFound:found){
    if (id.contains(idFound) || id.equalsIgnoreCase(idFound)) {
      flag = true;

      break;
    }
  }
  if(!flag){
    notFound.add(id);
  }
}%>

<form id="facetForm" action="/platform/data/search/clinicalTrails">
<h4>By STATUS:</h4>


<%for(Terms.Bucket bkt:statAggregations.getBuckets()){%>
<div class="checkbox">
  <label><input type="checkbox" class="icheck" name="status" value="<%=bkt.getKey()%>"> <%=bkt.getKey()%>&nbsp;(<%=bkt.getDocCount()%>)</label>
</div>
<%}%>


<!-- END FILTER BY CATEGORY -->
  <div class="padding"></div><br>
  <!-- BEGIN FILTER BY CATEGORY -->
  <h4>By Condition:</h4>
  <div style="height: 300px;overflow-y: auto">

    <%for(Terms.Bucket bkt:conditionAggregations.getBuckets()){%>
    <div class="checkbox">
      <label><input type="checkbox" class="icheck" name="condition" value="<%=bkt.getKey()%>" > <%=bkt.getKey()%>&nbsp;(<%=bkt.getDocCount()%>)</label>
    </div>
    <%}%>
  </div>
<div class="padding"></div><br>
<!-- BEGIN FILTER BY CATEGORY -->
<h4>By Sponsor:</h4>
<div style="height: 300px;overflow-y: auto">
    <%for(Terms.Bucket bkt:orgAggregations.getBuckets()){%>

  <div class="checkbox">
    <label><input type="checkbox" class="icheck" name="organization" value="<%=bkt.getKey()%>"> <%=bkt.getKey()%>&nbsp;(<%=bkt.getDocCount()%>)</label>
  </div>
<%}%>
</div>


</form>
<%if(filterMap.size()==0){%>
<p><b>NCTIDS in Tracker:</b>&nbsp;<%=idsFromTrackerSheet.size()%></p>
<p><b>NCTIDS indexed:</b>&nbsp;<%=found.size()%></p>
<p><b>NCTIDS not indexed:</b>&nbsp;<%=notFound.size()%></p>
<% int i=1;
  for(String idNotFound:notFound){%>
<p style="color:red"><%=i++%>.&nbsp;<a href="https://www.clinicaltrials.gov/study/<%=idNotFound%>" target="_blank"><b style="color:red"><%=idNotFound%></b></a></p>
<%}%>
<%}%>

<script>
  function applyFilters(){
    $('#facetForm').submit()
  }
  $('input[type="checkbox"]').on('click',function (){
    $('#facetForm').submit()
  })


    $(function () {
    $.each($('input[name="status"]'), function(){
      var _this=$(this);
      var val=_this.val();
      _this.prop('checked', false);
      console.log("SELECTED status :" + statusSelected);
      if(statusSelected !== typeof undefined) {
        $.each(statusSelected, function (i, selected) {
          if (selected === val) {
            _this.prop('checked', true)
          }
        })
      }
    });
    $.each($('input[name="organization"]'), function(){
    var _this=$(this);
    var val=_this.val();
    _this.prop('checked', false);

    if(orgSelected !== typeof undefined) {
    $.each(orgSelected, function (i, selected) {
    if (selected === val) {
    _this.prop('checked', true)
  }
  })
  }
  });
    $.each($('input[name="condition"]'), function(){
    var _this=$(this);
    var val=_this.val();
    _this.prop('checked', false);

    if(conditionSelected !== typeof undefined) {
    $.each(conditionSelected, function (i, selected) {
    if (selected === val) {
    _this.prop('checked', true)
  }
  })
  }
  });
  })
</script>