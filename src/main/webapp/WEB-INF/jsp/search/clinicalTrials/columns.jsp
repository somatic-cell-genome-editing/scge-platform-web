<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 9/23/2024
  Time: 9:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<th class="firstColumn" style="position: sticky;left: 0px;z-index: 20;background: #f8fafc;">Trial ID&nbsp;<sup><span data-toggle="tooltip" data-html="true" title="Unique identification code given to each clinical study upon registration at ClinicalTrials.gov" class="column-header-description"></span></sup></th>
<%--<th class="firstColumn">Trial ID</th>--%>
<%--<th class="manual">Indication DOID&nbsp;<sup><span title="" class="column-header-description"></span></sup></th>--%>
<th>Indication&nbsp;<%=columnInfo("Indication")%></th>

<th>Drug Product Name&nbsp;<%=columnInfo("Drug Product Name")%></th>
<th>Sponsor&nbsp;<%=columnInfo("Sponsor")%></th>
<th data-default-hidden="true">Funder Type&nbsp;<%=columnInfo("Funder Type")%></th>
<%--<th>Intervention</th>--%>
<th class="manual">Target Gene/Variant&nbsp;<%=columnInfo("Target Gene or Variant")%></th>
<th class="manual" data-default-hidden="true">Regulatory Element&nbsp;<%=columnInfo("Regulatory Element", "Regulatory element(s) associated with the therapeutic construct")%></th>
<th class="manual">Therapeutic Modality&nbsp;<%=columnInfo("Therapeutic Modality")%></th>
<th class="manual">Therapy Route&nbsp;<%=columnInfo("Therapy Route")%></th>
<th class="manual">Mechanism of Action&nbsp;<%=columnInfo("Mechanism of Action")%></th>
<th class="manual">Route of Administration&nbsp;<%=columnInfo("Route of Administration")%></th>
<th class="manual">Drug Product Type&nbsp;<%=columnInfo("Drug Product Type")%></th>
<th class="manual" data-default-hidden="true">Target Tissue/Cell&nbsp;<%=columnInfo("Target Tissue or Cell")%></th>
<th class="manual" data-default-hidden="true">Gene Delivery System&nbsp;Type<%=columnInfo("Delivery System")%></th>
<th class="manual" data-default-hidden="true">Vector Type&nbsp;<%=columnInfo("Vector Type")%></th>
<th class="manual" data-default-hidden="true">Editor Type&nbsp;<%=columnInfo("Editor Type")%></th>
<th class="manual" data-default-hidden="true">Dosage/s&nbsp;<%=columnInfo("Dose levels (up to 5)")%></th>
<%--<th class="manual">Dose 5&nbsp;<sup><span title="<%=ClinicalTrialsService.facetDefinitions.get("Dose levels (up to 5)")%>" class="column-header-description"></span></sup></th>--%>
<%--<th>Treatment</th>--%>
<th>Current Phase&nbsp;<%=columnInfo("Current Stage")%></th>
<th>Recruitment Status&nbsp;<%=columnInfo("Recruitment Status")%></th>
<th class="manual">Development Status&nbsp;<%=columnInfo("Development Status")%></th>

<th data-default-hidden="true">Submit Date&nbsp;<%=columnInfo("Actual Study Start Date (m/d/y)")%></th>
<th data-default-hidden="true">Completion Date&nbsp;<%=columnInfo("Estimated Primary Completion Date (m/d/y)")%></th>
<th>Last_Update&nbsp;<%=columnInfo("Date of Last Update")%></th>
<%--<th>Std Ages</th>--%>
<th>Eligibility Age&nbsp;<%=columnInfo("Ages Eligible for Study")%></th>
<th data-default-hidden="true">Enrollment Count&nbsp;<%=columnInfo("Trial Enrollment")%></th>
<th data-default-hidden="true">No. of Trial Sites&nbsp;<%=columnInfo("N trial sites")%></th>
<%--<th>Centers in USA</th>--%>
<th>Locations&nbsp;<%=columnInfo("Countries")%></th>
<th data-default-hidden="true">Has US IND&nbsp;<%=columnInfo("Has US IND?")%></th>
<th class="manual">FDA Designation&nbsp;<%=columnInfo("FDA Designations")%></th>

<%--<th class="manual">Patents&nbsp;<%=columnInfo("Patents")%></th>--%>
<th class="manual">Recent Updates&nbsp;<%=columnInfo("Recent Regulatory Updates")%></th>
<th class="manual sorter-false">Resources/Links&nbsp;<%=columnInfo("News and Press Releases")%></th>

