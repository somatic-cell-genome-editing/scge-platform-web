<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 9/23/2024
  Time: 9:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<th class="firstColumn"style="position: sticky;left: 0px;z-index: 3">Trial ID&nbsp;<sup><span title="Unique identification code given to each clinical study upon registration at ClinicalTrials.gov" class="column-header-description"></span></sup></th>
<%--<th class="firstColumn">Trial ID</th>--%>
<%--<th class="manual">Indication DOID&nbsp;<sup><span title="" class="column-header-description"></span></sup></th>--%>
<th>Indication&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Indication")%>" class="column-header-description"></span></sup></th>
<th class="manual">FDA Designation&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("FDA Designations")%>" class="column-header-description"></span></sup></th>

<th>Compound Name&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Compound Name")%>" class="column-header-description"></span></sup></th>
<th>Sponsor&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Sponsor")%>" class="column-header-description"></span></sup></th>
<th>Funder Type&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Funder Type")%>" class="column-header-description"></span></sup></th>
<%--<th>Intervention</th>--%>
<th class="manual">Target Gene/Variant&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Target Gene or Variant")%>" class="column-header-description"></span></sup></th>
<th class="manual">Therapy Type&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Therapy Type")%>" class="column-header-description"></span></sup></th>
<th class="manual">Therapy Route&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Therapy Route")%>" class="column-header-description"></span></sup></th>
<th class="manual">Mechanism of Action&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Mechanism of Action")%>" class="column-header-description"></span></sup></th>
<th class="manual">Route of Administration&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Route of Administration")%>" class="column-header-description">></span></sup></th>
<th class="manual">Drug Product Type&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Drug Product Type")%>" class="column-header-description"></span></sup></th>
<th class="manual">Target Tissue/Cell&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Target Tissue or Cell")%>" class="column-header-description"></span></sup></th>
<th class="manual">Delivery System&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Delivery System")%>" class="column-header-description"></span></sup></th>
<th class="manual">Vector Type&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Vector Type")%>" class="column-header-description"></span></sup></th>
<th class="manual">Editor Type&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Editor Type")%>" class="column-header-description"></span></sup></th>
<th class="manual">Dosage/s&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Dose levels (up to 5)")%>" class="column-header-description"></span></sup></th>
<%--<th class="manual">Dose 5&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Dose levels (up to 5)")%>" class="column-header-description"></span></sup></th>--%>
<%--<th>Treatment</th>--%>
<th>Current Stage&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Current Stage")%>" class="column-header-description"></span></sup></th>
<th>Recruitment Status&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Study Status")%>" class="column-header-description"></span></sup></th>
<th class="manual">Development Status&nbsp;<sup><span title="" class="column-header-description"></span></sup></th>

<th>Submit Date&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Actual Study Start Date (m/d/y)")%>" class="column-header-description">></span></sup></th>
<th>Completion Date&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Estimated Primary Completion Date (m/d/y)")%>" class="column-header-description"></span></sup></th>
<th>Last_Update&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Date of Last Update")%>" class="column-header-description"></span></sup></th>
<%--<th>Std Ages</th>--%>
<th>Eligibility Age&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Ages Eligible for Study")%>" class="column-header-description"></span></sup></th>
<th>Enrollment Count&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Trial Enrollment")%>" class="column-header-description"></span></sup></th>
<th>No. of Trial Sites&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("N trial sites")%>" class="column-header-description"></span></sup></th>
<%--<th>Centers in USA</th>--%>
<th>Locations&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Countries")%>" class="column-header-description"></span></sup></th>
<th>Has US IND&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Has US IND?")%>" class="column-header-description"></span></sup></th>

<th class="manual">Patents&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Patents")%>" class="column-header-description"></span></sup></th>
<th class="manual">Recent Updates&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Recent Regulatory Updates")%>" class="column-header-description"></span></sup></th>
<th class="manual sorter-false">Resources/Links&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("News and Press Releases")%>" class="column-header-description"></span></sup></th>
