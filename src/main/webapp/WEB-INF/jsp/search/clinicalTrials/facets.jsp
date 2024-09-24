<%@ page import="java.util.ArrayList" %>
<%@ page import="org.elasticsearch.search.aggregations.Aggregations" %>
<%@ page import="org.elasticsearch.search.aggregations.Aggregation" %><%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 4/22/2024
  Time: 2:40 PM
  To change this template use File | Settings | File Templates.
--%>
<script>
  $(document).ready(function(){
    // Add down arrow icon for collapse element which is open by default
    // $(".collapse.show").each(function(){
    //   $(this).prev(".card-header").find(".fas").addClass("fa-angle-down").removeClass("fa-angle-up");
    // });

    // Toggle right and down arrow icon on show hide of collapse element
    $(".collapse").on('show.bs.collapse', function(){
      $(this).prev(".card-header").find(".fas").removeClass("fa-angle-up").addClass("fa-angle-down");
    }).on('hide.bs.collapse', function(){
      $(this).prev(".card-header").find(".fas").removeClass("fa-angle-down").addClass("fa-angle-up");
    });
  });
</script>

<h2 class="grid-title"><i class="fa fa-filter"></i> Filters ..</h2>

<hr>


<div align="right">
  <button id="clearFilters" class="btn btn-primary btn-sm" onclick="removeFilters()" >Clear Filters</button>
</div>
<form id="facetForm" action="/platform/data/search/clinicalTrials">
<%
  for(Aggregation agg:sr.getAggregations()){%>
  <div class="accordion-group">
    <div class="pl-3  accordion-heading card-header">
      <a class="accordion-toggle  search-results-anchor" data-toggle="collapse" href="#collapse<%=agg.getName()%>">
        <%=agg.getName()%><span class="float-right"><i class="fas fa-angle-up"></i></span>
      </a>
    </div>
    <div id="collapse<%=agg.getName()%>" class="accordion-body collapse" >
      <div class="pl-3  accordion-inner" style="height:auto;max-height: 300px;; overflow-y: auto">
        <%
         Terms aggs= sr.getAggregations().get(agg.getName());
          for(Terms.Bucket bkt:aggs.getBuckets()){%>
        <div class="form-check">
          <input class="form-check-input" type="checkbox" name="<%=agg.getName()%>" value="<%=bkt.getKey()%>" id="<%=bkt.getKey()%>">
          <label class="form-check-label" for="<%=bkt.getKey()%>">
            <%=bkt.getKey()%>&nbsp;(<%=bkt.getDocCount()%>)
          </label>
        </div>
          <%}%>

      </div>
    </div>

  </div>

  <%}%>

<%--<h4>By Status:</h4>--%>


<%--<%for(Terms.Bucket bkt:statAggregations.getBuckets()){%>--%>
<%--<div class="checkbox">--%>
<%--  <label><input type="checkbox" class="icheck" name="studyStatus" value="<%=bkt.getKey()%>"> <%=bkt.getKey()%>&nbsp;(<%=bkt.getDocCount()%>)</label>--%>
<%--</div>--%>
<%--<%}%>--%>


<%--<!-- END FILTER BY CATEGORY -->--%>
<%--  <div class="padding"></div><br>--%>
<%--  <!-- BEGIN FILTER BY CATEGORY -->--%>
<%--  <h4>By Indication:</h4>--%>
<%--  <div style="height: 300px;overflow-y: auto">--%>

<%--    <%for(Terms.Bucket bkt:conditionAggregations.getBuckets()){%>--%>
<%--    <div class="checkbox">--%>
<%--      <label><input type="checkbox" class="icheck" name="indication" value="<%=bkt.getKey()%>" > <%=bkt.getKey()%>&nbsp;(<%=bkt.getDocCount()%>)</label>--%>
<%--    </div>--%>
<%--    <%}%>--%>
<%--  </div>--%>
<%--<div class="padding"></div><br>--%>
<%--<!-- BEGIN FILTER BY CATEGORY -->--%>
<%--<h4>By Sponsor:</h4>--%>
<%--<div style="height: 300px;overflow-y: auto">--%>
<%--    <%for(Terms.Bucket bkt:orgAggregations.getBuckets()){%>--%>

<%--  <div class="checkbox">--%>
<%--    <label><input type="checkbox" class="icheck" name="sponsor" value="<%=bkt.getKey()%>"> <%=bkt.getKey()%>&nbsp;(<%=bkt.getDocCount()%>)</label>--%>
<%--  </div>--%>
<%--<%}%>--%>
<%--</div>--%>


</form>
<%--<%if(filterMap.size()==0){%>--%>
<%--<p><b>NCTIDS in Tracker:</b>&nbsp;<%=idsFromTrackerSheet.size()%></p>--%>
<%--<p><b>NCTIDS indexed:</b>&nbsp;<%=found.size()%></p>--%>
<%--<p><b>NCTIDS not indexed:</b>&nbsp;<%=notFound.size()%></p>--%>
<%--<% int i=1;--%>
<%--  for(String idNotFound:notFound){%>--%>
<%--<p style="color:red"><%=i++%>.&nbsp;<a href="https://www.clinicaltrials.gov/study/<%=idNotFound%>" target="_blank"><b style="color:red"><%=idNotFound%></b></a></p>--%>
<%--<%}%>--%>
<%--<%}%>--%>

<script>
  function applyFilters(){
    $('#facetForm').submit()
  }
  function removeFilters(){
    $.each($('input[type="checkbox"]'), function (){
      var _this=$(this);
      _this.prop('checked', false);
    })
    $('#facetForm').submit()
  }
  $('input[type="checkbox"]').on('click',function (){
    $('#facetForm').submit()
  })


    $(function () {
    $.each($('input[name="studyStatus"]'), function(){
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
    $.each($('input[name="sponsor"]'), function(){
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
    $.each($('input[name="indication"]'), function(){
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
      $.each($('input[name="trackerType"]'), function(){
        var _this=$(this);
        var val=_this.val();
        _this.prop('checked', false);

        if(trackerTypeSelected !== typeof undefined) {
          $.each(trackerTypeSelected, function (i, selected) {
            if (selected === val) {
              _this.prop('checked', true)
            }
          })
        }
      });
  })
</script>