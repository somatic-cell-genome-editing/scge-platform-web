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
<th>Indication&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Indication")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th>Compound Name&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Compound Name")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th>Sponsor&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Sponsor")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th>Funder Type&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Funder Type")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<%--<th>Intervention</th>--%>
<th class="manual">Target Gene/Variant&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Target Gene or Variant")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Therapy Type&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Therapy Type")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Therapy Route&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Therapy Route")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Mechanism of Action&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Mechanism of Action")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Route of Administration&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Route of Administration")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Drug Product Type&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Drug Product Type")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Target Tissue/Cell&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Target Tissue or Cell")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Delivery System&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Delivery System")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Vector Type&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Vector Type")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Editor Type&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Editor Type")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Dose 1&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Dose levels (up to 5)")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Dose 2&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Dose levels (up to 5)")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Dose 3&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Dose levels (up to 5)")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Dose 4&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Dose levels (up to 5)")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Dose 5&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Dose levels (up to 5)")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<%--<th>Treatment</th>--%>
<th>Current Stage&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Current Stage")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th>Status&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Study Status")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th>Submit Date&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Actual Study Start Date (m/d/y)")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th>Completion Date&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Estimated Primary Completion Date (m/d/y)")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th>Last_Update&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Date of Last Update")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<%--<th>Std Ages</th>--%>
<th>Eligibility Age&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Ages Eligible for Study")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th>Enrollment Count&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Trial Enrollment")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th>No. of Trial Sites&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("N trial sites")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<%--<th>Centers in USA</th>--%>
<th>Locations&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Countries")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th>Has US IND&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Has US IND?")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>

<th class="manual">Patents&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Patents")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual">Recent Updates&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Recent Regulatory Updates")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
<th class="manual sorter-false">Resources/Links&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("News and Press Releases")%>"><i class="fa-solid fa-circle-info"></i></span></sup></th>
