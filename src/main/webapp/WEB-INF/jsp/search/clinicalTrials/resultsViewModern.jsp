<%@ page import="org.elasticsearch.search.SearchHit" %>
<%@ page import="org.elasticsearch.action.search.SearchResponse" %>
<%@ page import="com.google.gson.Gson" %>

<%@ page import="java.util.*" %>
<%@ page import="edu.mcw.scge.services.SCGEContext" %>
<%@ page import="edu.mcw.scge.datamodel.Person" %>
<%@ page import="edu.mcw.scge.configuration.Access" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 3/26/2024
  Time: 2:59 PM
  To change this template use File | Settings | File Templates.
--%>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<link href="/platform/css/resultTable.css" rel="stylesheet" type="text/css"/>
<link href="/platform/css/referencesModal.css" rel="stylesheet" type="text/css"/>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<script src="/platform/js/scge.js"></script>
<script src="/platform/common/js/jquery.tabletoCSV.js"> </script>

<style>
  /* ============================================
     MODERN CSS DESIGN SYSTEM
     ============================================ */

  /* CSS Variables for Design Tokens */
  :root {
    /* Brand Colors */
    --primary-600: #1a80b6;
    --primary-700: #0d5a8a;
    --primary-800: #084571;
    --primary-50: #e6f3f9;

    /* Neutral Colors */
    --slate-50: #f8fafc;
    --slate-100: #f1f5f9;
    --slate-200: #e2e8f0;
    --slate-300: #cbd5e1;
    --slate-400: #94a3b8;
    --slate-500: #64748b;
    --slate-600: #475569;
    --slate-700: #334155;
    --slate-800: #1e293b;
    --slate-900: #0f172a;

    /* Accent Colors */
    --cyan-500: #06b6d4;
    --cyan-600: #0891b2;
    --amber-300: #fcd34d;
    --amber-400: #fbbf24;
    --amber-500: #f59e0b;
    --amber-50: #fef3c7;
    --amber-100: #fde68a;
    --amber-900: #78350f;

    /* Status Colors */
    --green-500: #10b981;
    --red-500: #ef4444;
    --red-600: #dc2626;

    /* Shadows */
    --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);

    /* Border Radius */
    --radius-sm: 0.375rem;
    --radius-md: 0.5rem;
    --radius-lg: 0.75rem;
    --radius-xl: 1rem;
    --radius-full: 9999px;

    /* Spacing Scale */
    --space-xs: 0.5rem;
    --space-sm: 0.75rem;
    --space-md: 1rem;
    --space-lg: 1.5rem;
    --space-xl: 2rem;
    --space-2xl: 3rem;

    /* Typography */
    --font-sans: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui, sans-serif;
    --font-size-xs: 0.75rem;
    --font-size-sm: 0.875rem;
    --font-size-base: 1rem;
    --font-size-lg: 1.125rem;
    --font-size-xl: 1.25rem;
    --font-size-2xl: 1.5rem;
    --font-size-3xl: 1.875rem;
    --font-size-4xl: 2.25rem;

    /* Line Heights */
    --leading-tight: 1.25;
    --leading-snug: 1.375;
    --leading-normal: 1.5;
    --leading-relaxed: 1.625;
    --leading-loose: 2;

    /* Z-Index Scale */
    --z-base: 1;
    --z-dropdown: 1000;
    --z-sticky: 1020;
    --z-fixed: 1030;
    --z-modal-backdrop: 1040;
    --z-modal: 1050;
    --z-popover: 1060;
    --z-tooltip: 1070;
  }

  /* Base Typography & Body */
  body {
    font-family: var(--font-sans);
    color: var(--slate-800);
    background: white;
    min-height: 100vh;
  }

  /* Container Improvements */
  .container-fluid {
    max-width: 1400px;
    margin: 0 auto;
    padding: var(--space-xl) var(--space-lg);
  }

  /* Header Section */
  .jumbotron {
    background: white !important;
    padding: var(--space-xl) var(--space-xl) !important;
    margin-bottom: var(--space-xl);
    border: 1px solid var(--slate-200);
    border-left: 4px solid var(--primary-600);
  }

  .jumbotron h3 {
    color: var(--slate-900) !important;
    font-weight: 700;
    font-size: var(--font-size-2xl);
    margin-bottom: var(--space-md);
    line-height: var(--leading-tight);
  }

  .jumbotron p {
    color: var(--slate-600) !important;
    font-size: var(--font-size-base);
    line-height: var(--leading-relaxed);
    margin: 0;
    font-weight: 400;
    max-width: 95%;
  }

  /* Disclaimer Card */
  .disclaimer-card {
    background: #fef3c7;
    border-left: 4px solid var(--amber-500);
    padding: var(--space-lg);
    margin-bottom: var(--space-xl);
    border: 1px solid #fde68a;
  }

  .disclaimer-card small {
    color: #92400e;
    line-height: var(--leading-relaxed);
    display: block;
    font-size: var(--font-size-sm);
  }

  .disclaimer-card strong {
    color: #78350f;
    font-weight: 700;
    text-transform: uppercase;
    font-size: var(--font-size-xs);
    letter-spacing: 0.05em;
  }

  .disclaimer-card b {
    color: #78350f;
    font-weight: 600;
  }

  .disclaimer-card a {
    color: var(--primary-700);
    text-decoration: underline;
    font-weight: 500;
  }

  .disclaimer-card a:hover {
    color: var(--primary-800);
  }

  /* Grid Layout Enhancements */
  .grid.search {
    background: transparent;
  }

  .grid-body {
    background: transparent;
  }

  /* Filters Panel - Modern Card Design */
  .grid-body .row > .col-md-2 {
    background: white;
    border-radius: var(--radius-lg);
    padding: 0;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.06), 0 1px 2px rgba(0, 0, 0, 0.04);
    position: sticky;
    top: var(--space-lg);
    align-self: flex-start;
    border: 1px solid var(--slate-200);
    overflow: hidden;
  }

  .grid-body .row > .col-md-2 > * {
    padding: var(--space-lg);
  }

  /* Results Section */
  .grid-body .row > .col-md-10 {
    padding-left: var(--space-lg);
  }

  /* Results Header Row - Enhanced */
  .grid-body .col-md-10 > .row:first-child {
    background: white;
    border-radius: var(--radius-lg);
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.06), 0 1px 2px rgba(0, 0, 0, 0.04);
    padding: var(--space-lg) var(--space-xl);
    margin-bottom: var(--space-lg);
    border: 1px solid var(--slate-200);
    align-items: center;
  }

  /* Results Count - Enhanced */
  .grid-body .col-6 > span {
    font-size: var(--font-size-base);
    color: var(--slate-700);
    font-weight: 600;
    display: inline-flex;
    align-items: center;
    padding: var(--space-xs) 0;
  }

  .grid-body .col-6 > span::before {
    content: '\1F4CA';  /* Bar chart */
    margin-right: var(--space-sm);
    font-size: var(--font-size-lg);
  }

  /* Modern Buttons - Enhanced */
  .btn {
    font-weight: 600;
    font-size: var(--font-size-sm);
    padding: 0.625rem 1.5rem;
    border-radius: var(--radius-md);
    transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
    border: none;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: var(--space-xs);
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
    text-transform: none;
    letter-spacing: 0.01em;
    position: relative;
    overflow: hidden;
  }

  .btn::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: rgba(255, 255, 255, 0.1);
    transition: left 0.3s ease;
  }

  .btn:hover::before {
    left: 100%;
  }

  .btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  }

  .btn:active {
    transform: translateY(0);
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
  }

  .btn-primary {
    background: linear-gradient(135deg, var(--primary-600) 0%, var(--primary-700) 100%) !important;
    color: white !important;
    border: none !important;
  }

  .btn-primary:hover {
    background: linear-gradient(135deg, var(--primary-700) 0%, var(--primary-800) 100%) !important;
  }

  .btn-info {
    background: linear-gradient(135deg, var(--cyan-500) 0%, var(--cyan-600) 100%) !important;
    color: white !important;
    border: none !important;
  }

  .btn-info:hover {
    background: linear-gradient(135deg, var(--cyan-600) 0%, #0e7490 100%) !important;
  }

  .btn-warning {
    background: linear-gradient(135deg, var(--amber-500) 0%, #d97706 100%) !important;
    color: white !important;
    border: none !important;
  }

  .btn-warning:hover {
    background: linear-gradient(135deg, #d97706 0%, #b45309 100%) !important;
  }

  .btn-light {
    background: white !important;
    border: 1px solid var(--slate-300) !important;
    color: var(--slate-700) !important;
    border-radius: var(--radius-full) !important;
    padding: 0.5rem 1rem;
    font-size: var(--font-size-sm);
    font-weight: 500;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
  }

  .btn-light:hover {
    background: var(--slate-50) !important;
    border-color: var(--slate-400) !important;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  }

  .btn-light .fa-times-circle {
    color: var(--red-500) !important;
    transition: color 0.2s ease;
    font-size: 1rem;
  }

  .btn-light:hover .fa-times-circle {
    color: var(--red-600) !important;
  }

  .btn-sm {
    padding: 0.5rem 1.25rem;
    font-size: var(--font-size-sm);
  }

  .btn-group {
    display: flex;
    gap: var(--space-sm);
    flex-wrap: wrap;
    align-items: center;
  }

  .btn i {
    font-size: 1rem;
  }

  /* Applied Filters - Enhanced */
  .grid-body .col-md-10 strong {
    color: var(--slate-800);
    font-weight: 700;
    font-size: var(--font-size-sm);
    margin-right: var(--space-md);
    text-transform: uppercase;
    letter-spacing: 0.05em;
  }

  /* Table Container - Enhanced */
  .grid-body .col-md-10 > div[style*="width:100%"] {
    background: white;
    border-radius: var(--radius-lg);
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.06), 0 1px 2px rgba(0, 0, 0, 0.04);
    padding: var(--space-xl);
    margin-top: 0;
    border: 1px solid var(--slate-200);
  }

  /* No Results - Enhanced */
  h4 {
    text-align: center;
    padding: var(--space-2xl) var(--space-xl);
    color: var(--slate-500);
    font-size: var(--font-size-xl);
    font-weight: 600;
    position: relative;
  }

  h4::before {
    content: '\1F50D';  /* Magnifying glass */
    display: block;
    font-size: 3rem;
    margin-bottom: var(--space-md);
    opacity: 0.5;
  }

  /* Spacing Utilities */
  .padding {
    height: var(--space-md);
  }

  /* Links - Enhanced */
  a {
    color: var(--primary-600);
    text-decoration: none;
    transition: all 0.2s ease;
    position: relative;
  }

  a:hover {
    color: var(--primary-700);
  }

  a:not(.btn):hover {
    text-decoration: underline;
    text-decoration-thickness: 2px;
    text-underline-offset: 2px;
  }

  /* Search By Category Link */
  .d-flex.justify-content-end a {
    color: var(--primary-600);
    font-weight: 500;
    padding: var(--space-xs) var(--space-md);
    border-radius: var(--radius-md);
    transition: all 0.2s ease;
  }

  .d-flex.justify-content-end a:hover {
    background: var(--primary-50);
    text-decoration: none;
  }

  /* Responsive Design - Enhanced */
  @media (max-width: 768px) {
    .container-fluid {
      padding: var(--space-md);
    }

    .jumbotron {
      padding: var(--space-lg) !important;
    }

    .jumbotron h3 {
      font-size: var(--font-size-xl);
    }

    .jumbotron p {
      font-size: var(--font-size-sm);
    }

    .disclaimer-card {
      padding: var(--space-md);
    }

    .disclaimer-card small {
      padding-left: var(--space-lg);
    }

    .grid-body .row > .col-md-2,
    .grid-body .row > .col-md-10 {
      padding-left: 0;
      padding-right: 0;
      margin-bottom: var(--space-md);
    }

    .grid-body .row > .col-md-2 {
      position: relative;
      top: auto;
    }

    .grid-body .col-md-10 > .row:first-child {
      padding: var(--space-md);
    }

    .grid-body .col-md-10 > div[style*="width:100%"] {
      padding: var(--space-md);
    }

    .btn-group {
      width: 100%;
      flex-direction: column;
    }

    .btn {
      width: 100%;
      justify-content: center;
    }

    .grid-body .col-6 {
      flex: 0 0 100%;
      max-width: 100%;
      margin-bottom: var(--space-sm);
    }
  }

  /* High-Resolution Rendering - Enhanced */
  @media (-webkit-min-device-pixel-ratio: 2), (min-resolution: 192dpi) {
    body {
      -webkit-font-smoothing: subpixel-antialiased;
    }

    .jumbotron,
    .disclaimer-card,
    .grid-body .row > .col-md-2,
    .grid-body .col-md-10 > .row:first-child,
    .grid-body .col-md-10 > div[style*="width:100%"] {
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07), 0 2px 4px rgba(0, 0, 0, 0.05);
    }

    .btn {
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
    }
  }

  /* Print Styles - Enhanced */
  @media print {
    body {
      background: white;
    }

    .jumbotron {
      background: white !important;
      border: 1px solid var(--slate-300) !important;
      page-break-inside: avoid;
    }

    .jumbotron::before,
    .jumbotron::after {
      display: none;
    }

    .jumbotron h3,
    .jumbotron p {
      color: var(--slate-800) !important;
    }

    .disclaimer-card {
      page-break-inside: avoid;
    }

    .btn,
    .d-flex.justify-content-end {
      display: none !important;
    }

    .grid-body .row > .col-md-2,
    .grid-body .col-md-10 > .row:first-child,
    .grid-body .col-md-10 > div[style*="width:100%"] {
      box-shadow: none;
      border: 1px solid var(--slate-300);
    }
  }

  /* Smooth Scrolling */
  html {
    scroll-behavior: smooth;
  }

  /* Focus Styles for Accessibility - Enhanced */
  button:focus,
  a:focus,
  input:focus {
    outline: 3px solid rgba(26, 128, 182, 0.4);
    outline-offset: 2px;
    border-radius: var(--radius-sm);
  }

  button:focus:not(:focus-visible),
  a:focus:not(:focus-visible),
  input:focus:not(:focus-visible) {
    outline: none;
  }

  /* Selection Styling - Enhanced */
  ::selection {
    background-color: rgba(26, 128, 182, 0.2);
    color: var(--slate-900);
  }

  ::-moz-selection {
    background-color: rgba(26, 128, 182, 0.2);
    color: var(--slate-900);
  }

  /* Loading State */
  @keyframes shimmer {
    0% {
      background-position: -1000px 0;
    }
    100% {
      background-position: 1000px 0;
    }
  }

  /* Fade In Animation */
  @keyframes fadeIn {
    from {
      opacity: 0;
      transform: translateY(10px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }

  .jumbotron,
  .disclaimer-card,
  .grid-body .row > .col-md-2,
  .grid-body .col-md-10 > .row:first-child,
  .grid-body .col-md-10 > div[style*="width:100%"] {
    animation: fadeIn 0.4s ease-out;
  }
</style>
<%
  Gson gson=new Gson();
  SearchResponse sr= (SearchResponse) request.getAttribute("sr");
  SearchHit[] hitsArray=sr.getHits().getHits();
  List<SearchHit> hits=new ArrayList<>();
  if(hitsArray!=null && hitsArray.length>0) {
    hits = (Arrays.asList(hitsArray));
  }
  Map<String, List<String>> filterMap= (Map<String, List<String>>) request.getAttribute("filterMap");
  List<String> filtersSelected= (List<String>) request.getAttribute("filtersSelected");
  request.setAttribute("filtersSelected", filtersSelected);
  String category= "";
  String dCategory="";
  String searchTerm="";
  if(request.getAttribute("category")!=null){
    category= (String) request.getAttribute("category");
    dCategory+=" in "+request.getAttribute("category")+"s";
  }
  if(request.getParameter("searchTerm")!=null && !Objects.equals(request.getParameter("searchTerm"), "null")){
    searchTerm+="of \""+request.getParameter("searchTerm")+"\"";
  }
  Access access= new Access();
  Person p = null;
  try {
    p = access.getUser(request.getSession());
  } catch (Exception e) {
    e.printStackTrace();
  }
%>

<script>
  var filterMap='<%=gson.toJson(filterMap)%>'
  var json=JSON.parse(filterMap)
</script>
<div class="jumbotron">
  <%
    if(category!=null && !category.equals("")){%>
  <h3>Clinical Trials - Gene Therapy Trial Browser</h3>
  <p>The Gene Therapy Trial Browser represents a unique publicly accessible, free database for the benefit of users seeking information on gene therapy development. The information within integrates various sources, including clinicaltrials.gov, publications, sponsor press releases, patent applications, and more to give a comprehensive overview of the gene therapy clinical trial landscape.
  </p>

  <%}else{%>
  <h3>SCGE Platform - General Search Results</h3>
  <%}%>

</div>

<div class="container-fluid">
  <div class="disclaimer-card">
    <small><strong>Disclaimer:</strong> The information on this dashboard has been collected for the convenience of patients and researchers. <b>The SCGE team are not medical doctors and cannot provide medical advice. Please discuss with your provider the risks/benefits of participating in a clinical trial, and do not send us your personal medical information.</b> The information contained within this table does not make use of any confidential or privileged information-all data is collected from publicly available sources. The SCGE makes no comment as to the efficacy and safety of the items listed, as these are not known at the time of publication. For the most up to date information, or to inquire about enrollment, please refer to <a href="https://clinicaltrials.gov/">clinicaltrials.gov</a> or the Sponsor's website for contact information.</small>

  </div>
  <div class="d-flex justify-content-end">
    <%
      if(category!=null && !category.equals("")){%>

    <%@include file="../searchByCategory.jsp"%>
    <%}%>
  </div>
  <br>
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
              <div class="row">
                <div class="col-6"> <span>Showing all  <%=hits.size()%> results ... <%=searchTerm%><%=dCategory%></span></div>
                <%
                  if(hits.size()>0){
                %>
                <div class="col-6 d-flex justify-content-end">
                  <div class="row">

                    <div class="col">
                      <%
                        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
                        LocalDateTime now = LocalDateTime.now();

                      %>

                      <div id="fileCitation" style="display:none;">SCGE Platform Gene Therapy Clinical Trials downloaded on: <%=dtf.format(now)%>; Please cite the Somatic Cell Genome Editing Consortium Platform when using publicly accessible data in formal presentation or publication.</div>
                      <div class="btn-group" role="group">
                        <button type="button" class="btn btn-sm btn-primary text-nowrap"  onclick="download()">Export table to (.CSV) file</button>
                        <button type="button" class="btn btn-info btn-sm text-nowrap" data-toggle="modal" data-target="#definitionsModal">Help Doc&nbsp;&nbsp;<i class="fa fa-question-circle" aria-hidden="true" style="color:whitesmoke"></i></button>
                        <%@include file="modal.jsp"%>
                        <% if (request.getServerName().equals("localhost") || request.getServerName().equals("dev.scge.mcw.edu") || request.getServerName().equals("stage.scge.mcw.edu") ) { %>
                        <%try {if (p!=null && access.isAdmin(p) && !SCGEContext.isProduction()) {%>&nbsp;&nbsp;
                        <a style="margin-left: 20px" href="/platform/clinicalTrialEdit/home/" ><button type="button" class="btn btn-warning btn-sm">Add</button></a>
                        <%}} catch (Exception e) {e.printStackTrace();}}%>
                      </div>
                    </div>
                  </div>
                </div>
                <%}%>
              </div>

              <%@include file="filtersApplied.jsp"%>
              <div class="padding"></div>
              <!-- BEGIN TABLE RESULT -->
              <div style="width:100%">
                <%
                  if(hits.size()==0){%>
                <h4>0 results found <!--for term <%--=request.getAttribute("searchTerm")--%>--></h4>
                <%}else{%>
                <%@include file="resultsTable.jsp"%>
                <%}%>
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
<div style="padding-top:2%;padding-bottom:  5%">
</div>
<script>
  function download(){
    $("#myTable").tableToCSV();
  }
</script>