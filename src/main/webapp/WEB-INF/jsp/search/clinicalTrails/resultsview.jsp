<%@ page import="org.elasticsearch.search.SearchHit" %>
<%@ page import="org.elasticsearch.action.search.SearchResponse" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="org.elasticsearch.search.aggregations.Aggregations" %>
<%@ page import="org.elasticsearch.search.aggregations.bucket.terms.Terms" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="edu.mcw.scge.web.utils.Stamp" %>
<%@ page import="java.util.*" %><%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 3/26/2024
  Time: 2:59 PM
  To change this template use File | Settings | File Templates.
--%>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<style>
  included, to get the result that you can see in the preview selection

  body{margin-top:20px;
    background:#eee;
  }


  .grid {
    position: relative;
    width: 100%;
    background: #fff;
    /*color: #666666;*/
    border-radius: 2px;
    margin-bottom: 25px;
    box-shadow: 0px 1px 4px rgba(0, 0, 0, 0.1);
  }

  .grid .grid-body {
    padding: 15px 20px 15px 20px;
    font-size: 0.9em;
    /*line-height: 1.9em;*/
  }


  .search table tr:hover {
    cursor: pointer;
  }



  /*.search table tr td img {*/
  /*  width: 50px;*/
  /*  height: 50px;*/
  /*}*/


</style>
<%
    Gson gson=new Gson();
    List<String> found=new ArrayList<>();
    Set<String> notFound=new HashSet<>();
    String idsStr="NCT05197270\n" +
            "NCT05930561\n" +
            "NCT04483440\n" +
            "NCT04517149\n" +
            "NCT04519749\n" +
            "NCT05248230\n" +
            "NCT04704921\n" +
            "NCT02556736\n" +
            "NCT04227106\n" +
            "NCT05536973\n" +
            "NCT04676048\n" +
            "NCT03199469\n" +
            "NCT04174105\n" +
            "NCT05598333\n" +
            "NCT05230459\n" +
            "NCT03533673\n" +
            "NCT06285643\n" +
            "NCT05541627\n" +
            "NCT05224505\n" +
            "NCT05973630\n" +
            "NCT03920007\n" +
            "NCT05878860\n" +
            "NCT06064890\n" +
            "NCT03588299\n" +
            "NCT05456880\n" +
            "NCT05121376\n" +
            "NCT04783181\n" +
            "NCT04998396\n" +
            "NCT03328130\n" +
            "NCT05788536\n" +
            "NCT04853576\n" +
            "NCT05821959\n" +
            "NCT04411654\n" +
            "NCT04408625\n" +
            "NCT06112275\n" +
            "NCT05144386\n" +
            "NCT05903794\n" +
            "NCT04418414\n" +
            "NCT05739643\n" +
            "NCT05835895\n" +
            "NCT03293524\n" +
            "NCT03326336\n" +
            "NCT05906953\n" +
            "NCT06255782\n" +
            "NCT05120830\n" +
            "NCT06128629\n" +
            "NCT05735158\n" +
            "NCT05504837\n" +
            "NCT06049082\n" +
            "NCT03634007\n" +
            "NCT05445323\n" +
            "NCT06109181\n" +
            "NCT04671433\n" +
            "NCT05811351\n" +
            "NCT03278873\n" +
            "NCT05603312\n" +
            "NCT02781480\n" +
            "NCT05926765\n" +
            "NCT04833907\n" +
            "NCT04945772\n" +
            "NCT05417126\n" +
            "NCT05984927\n" +
            "NCT05228145\n" +
            "NCT05898620\n" +
            "NCT05293626\n" +
            "NCT05203939\n" +
            "NCT06018558\n" +
            "NCT05956626\n" +
            "NCT05616793\n" +
            "NCT06149403\n" +
            "NCT04747431\n" +
            "NCT04713475\n" +
            "NCT03861273\n" +
            "NCT04370054\n" +
            "NCT04281485\n" +
            "NCT04903288\n" +
            "NCT03566043\n" +
            "NCT05693142\n" +
            "NCT06092034\n" +
            "NCT05885412\n" +
            "NCT04069533\n" +
            "NCT03812263\n" +
            "NCT04105166\n" +
            "NCT04046224\n" +
            "NCT05972629\n" +
            "NCT06061549\n" +
            "NCT06246513\n" +
            "NCT01976091\n" +
            "NCT05906251\n" +
            "NCT06138639\n" +
            "NCT05748873\n" +
            "NCT03003533\n" +
            "NCT04093349\n" +
            "NCT04850118\n" +
            "NCT05394064\n" +
            "NCT05324943\n" +
            "NCT04455230\n" +
            "NCT05606614\n" +
            "NCT05836259\n" +
            "NCT02716246\n" +
            "NCT05139316\n" +
            "NCT05345171\n" +
            "NCT04884815\n" +
            "NCT05243017\n" +
            "NCT06100276\n" +
            "NCT06063850\n" +
            "NCT05398029\n" +
            "NCT04125732\n";

    String[] array=idsStr.split("\n");
    List<String> idsFromTrackerSheet=Arrays.asList(array);
    SearchResponse sr= (SearchResponse) request.getAttribute("sr");


    Terms orgAggregations=sr.getAggregations().get("organization");
    Terms statAggregations=sr.getAggregations().get("status");
    Terms conditionAggregations=sr.getAggregations().get("condition");

    SearchHit[] hitsArray=sr.getHits().getHits();
    List<SearchHit> hits=(Arrays.asList(hitsArray));
    Map<String, List<String>> filterMap= (Map<String, List<String>>) request.getAttribute("filterMap");
    List<String> selectedStatus=new ArrayList<>();
    List<String> selectedCondition=new ArrayList<>();
    List<String> selectedOrganization=new ArrayList<>();
    if(filterMap!=null){
        if(filterMap.get("status")!=null)
            selectedStatus.addAll(filterMap.get("status"));
        if(filterMap.get("condition")!=null)
            selectedCondition.addAll(filterMap.get("condition"));
        if(filterMap.get("organization")!=null)
            selectedOrganization.addAll(filterMap.get("organization"));
    }
    for(SearchHit hit:hits){
        Map<String, Object> sourceFields=hit.getSourceAsMap();
        Map<String, Object> protocolSection= (Map<String, Object>) sourceFields.get("protocolSection");
        Map<String, Object> identificationModule= (Map<String, Object>) protocolSection.get("identificationModule");
        String nctId= (String) identificationModule.get("nctId");
        if(idsFromTrackerSheet.contains(nctId)){
            found.add(nctId);
        }
    }

%>

<script>
    var  statusSelected=<%=gson.toJson(selectedStatus)%>;
    var  conditionSelected=<%=gson.toJson(selectedCondition)%>;
    var orgSelected=<%=gson.toJson(selectedOrganization)%>;
</script>
<h1>Clinical Trails - <%=hits.size()%></h1>
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
              <h2><i class="fa fa-file-o"></i> Result</h2>
              <hr>
              <p>Showing all  <%=hits.size()%> results matching <strong>Intervention:&nbsp;BIOLOGICAL OR GENETIC OR GENE THERAPY OR GENE EDITING</strong>&nbsp;|&nbsp;<strong>Condition: Gene Therapy OR  Gene Editing</strong></p>
                <%if(filterMap!=null && filterMap.size()>0){%>
                <strong>Filters:</strong>

                <%for(String key: filterMap.keySet()){
                    List<String> values=filterMap.get(key);
                    for(String filter:values){%>
                        &nbsp;<%=filter%>
                    <%}}}%>

              <div class="padding"></div>
                <!-- BEGIN TABLE RESULT -->
              <div >
                <table class="table table-hover table-sm tablesorter " id="myTable">
                  <caption align="top">Clinical Trails -BIOLOGICAL INTERVENTIONS - Summary</caption>
                  <thead>
                  <tr><th></th>
                      <th>Sponsor</th>
                      <th>NCTID</th>
                    <%--            <th>Org StudyId</th>--%>
<%--                    <th>Organization</th>--%>
<%--                    <th>briefTitle</th>--%>
                    <th>Intervention</th>
<%--                      <th>Description</th>--%>
                    <th>Conditions</th>
                    <th>Phases</th>
                    <th>Start_Date</th>
                    <th>Completion</th>
                    <th>Submit_Date</th>
                    <th>Last_Update</th>
                      <th>% Days Elapsed</th>
                    <th>Status</th>
                    <th>Has Results</th>
                      <th>Expanded Access</th>
                  </tr>
                  </thead>
                  <tbody>
                  <%for(SearchHit hit:hits){
                    Map<String, Object> sourceFields=hit.getSourceAsMap();
                    Map<String, Object> protocolSection= (Map<String, Object>) sourceFields.get("protocolSection");
                    Map<String, Object> identificationModule= (Map<String, Object>) protocolSection.get("identificationModule");
                   String  nctId= (String) identificationModule.get("nctId");
                   try{
                      Map<String, Object> sponsorCollaboratorsModule= (Map<String, Object>) protocolSection.get("sponsorCollaboratorsModule");
//                    Map leadSponsor= (Map) sponsorCollaboratorsModule.get("leadSponsor");
//                      Map idMap= (Map) identificationModule.get("orgStudyIdInfo");
//                    Map orgMap= (Map) identificationModule.get("organization");

                    Map<String, Object> statusModule= (Map<String, Object>) protocolSection.get("statusModule");
                    Map startDate = new HashMap<>();
                    if((statusModule.get("startDateStruct")!=null)){
                           startDate=  (Map) statusModule.get("startDateStruct");
                    }
                    Map completionDate= new HashMap();
                    if(statusModule.get("completionDateStruct")!=null){
                        completionDate  = (Map) statusModule.get("completionDateStruct");
                    }
                    Map lastUpdatePostDate= new HashMap();
                    if(statusModule.get("lastUpdatePostDateStruct")!=null){
                        lastUpdatePostDate=   (Map) statusModule.get("lastUpdatePostDateStruct");
                    }

                    Map expandedAccess= new HashMap();
                    if(statusModule.get("expandedAccessInfo")!=null){
                        expandedAccess=  (Map) statusModule.get("expandedAccessInfo");
                    }
                    Map<String, Object> conditionsModule= (Map<String, Object>) protocolSection.get("conditionsModule");
//                    String conditions=((List<String>)conditionsModule.get("conditions")).stream().collect(Collectors.joining(", "));

                    Map<String, Object> armsInterventionsModule= (Map<String, Object>) protocolSection.get("armsInterventionsModule");
//                    List<Map> interventions= (List<Map>) armsInterventionsModule.get("interventions");

                    Map<String, Object> designModule= (Map<String, Object>) protocolSection.get("designModule");
                    List<String> phases= (List<String>) designModule.get("phases");
                    if(phases!=null){


                  %>
                  <tr>
                      <td><%if(idsFromTrackerSheet.contains(nctId)){%>
                          <i class="fa-solid fa-circle-check" style="color:green"></i>
                          <%}%>
                      </td>
                      <td><%Map leadSponsor= new HashMap();
                          if(sponsorCollaboratorsModule.get("leadSponsor")!=null){
                               leadSponsor= (Map) sponsorCollaboratorsModule.get("leadSponsor");

                      %>
                          <%=leadSponsor.get("name")%>
                          <%}%>
                      </td>

                      <td><strong><a href="https://www.clinicaltrials.gov/study/<%=nctId%>" target="_blank"><%=nctId%></a></strong>

                  </td>
                    <%--            <td><%=idMap.get("id")%></td>--%>
<%--                    <td><%=orgMap.get("fullName")%></td>--%>
<%--                    <td><%=identificationModule.get("briefTitle")%></td>--%>
                      <td>
                          <%
                            List<Map> interventions=new ArrayList<>();
                            if(  armsInterventionsModule.get("interventions")!=null){
                                interventions= (List<Map>) armsInterventionsModule.get("interventions");%>

                          <details><summary><%=interventions.get(0).get("name")%></summary><p><%=interventions.get(0).get("description")%></p></details>
                          <%}%>
                      </td>

                    <td><%
                        String conditions=null;
                        if(conditionsModule.get("conditions")!=null) {
                          conditions=  ((List<String>) conditionsModule.get("conditions")).stream().collect(Collectors.joining(", "));%>

                        <%=conditions%>
                        <% } %>
                    </td>
                    <td><%=String.join(", ", phases)%>

                    </td>

                    <td><%=startDate.get("date")%></td>

                    <td><% if(completionDate!=null){%>
                      <%=completionDate.get("date")%>
                      <%}%>
                    </td>


                    <td><%=statusModule.get("lastUpdateSubmitDate")%></td>
                    <td><%=lastUpdatePostDate.get("date")%></td>
<td>
    <%
        String percentDiff ="";
        if(startDate.get("date") != null && lastUpdatePostDate.get("date") != null && completionDate!=null && completionDate.get("date")!=null ) {
            Stamp stamp = new Stamp();

            try {
                percentDiff += stamp.getpercentage(startDate.get("date").toString(),completionDate.get("date").toString() , lastUpdatePostDate.get("date").toString() );


            }catch (Exception e){}}
        %>
    <%=percentDiff%>
</td>
                    <td><%=statusModule.get("overallStatus")%></td>
                    <td><%=sourceFields.get("hasResults")%></td>
                      <td><%if(expandedAccess!=null && expandedAccess.get("nctId")!=null){%>
                          <strong><a href="https://www.clinicaltrials.gov/study/<%=expandedAccess.get("nctId")%>"><%=expandedAccess.get("nctId")%></a></strong>
                          <%}%></td>
                  </tr>

                  <%}
                  }catch (Exception e){
                       System.err.println("NCD ID:"+nctId);
                       e.printStackTrace();
                   }
                  }

                  %>
                  </tbody>
                </table>
              </div>
              <!-- END TABLE RESULT -->

              <!-- BEGIN PAGINATION -->
<%--              <nav aria-label="Page navigation example">--%>
<%--                <ul class="pagination">--%>
<%--                  <li class="page-item"><a class="page-link" href="#">Previous</a></li>--%>
<%--                  <li class="page-item"><a class="page-link" href="#">1</a></li>--%>
<%--                  <li class="page-item"><a class="page-link" href="#">2</a></li>--%>
<%--                  <li class="page-item"><a class="page-link" href="#">3</a></li>--%>
<%--                  <li class="page-item"><a class="page-link" href="#">Next</a></li>--%>
<%--                </ul>--%>
<%--              </nav>--%>
              <!-- END PAGINATION -->
            </div>
            <!-- END RESULT -->
          </div>
        </div>
      </div>
    </div>
    <!-- END SEARCH RESULT -->
  </div>
</div>