<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 9/23/2024
  Time: 9:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<th class="firstColumn"style="position: sticky;left: 0px;z-index: 3">Trial ID&nbsp;<sup><span title="Unique identification code given to each clinical study upon registration at ClinicalTrials.gov"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<%--<th class="firstColumn">Trial ID</th>--%>
<th>Indication&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("indication")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th>Compound Name&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("compoundName")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th>Sponsor&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("sponsor")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th>Funder Type&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("sponsorClass")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<%--<th>Intervention</th>--%>
<th class="manual">Target Gene/Variant&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("targetGeneOrVariant")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Therapy Type&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("therapyType")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Therapy Route&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("therapyRoute")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Mechanism of Action&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("mechanismOfAction")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Route of Administration&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("routeOfAdministration")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Drug Product Type&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("drugProductType")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Target Tissue/Cell&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("targetTissueOrCell")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Delivery System&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("deliverySystem")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Vector Type&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("vectorType")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Editor Type&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("editorType")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Dose 1&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("dose1")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Dose 2&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("dose2")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Dose 3&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("dose3")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Dose 4&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("dose4")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Dose 5&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("dose5")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<%--<th>Treatment</th>--%>
<th>Current Stage&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("phases")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th>Status&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("status")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th>Submit Date&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("submissionDate")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th>Completion Date&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("completionDate")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th>Last_Update&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("lastUpdate")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<%--<th>Std Ages</th>--%>
<th>Eligibility Age&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("standardAges")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th>Enrollment Count&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("enrollmentCount")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th>No. of Trial Sites&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("trialSites")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<%--<th>Centers in USA</th>--%>
<th>Locations&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("locations")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th>Has US IND&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>

<th class="manual">Patents&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("aggName")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Recent Updates&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("aggName")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual sorter-false">Resources/Links&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("aggName")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
