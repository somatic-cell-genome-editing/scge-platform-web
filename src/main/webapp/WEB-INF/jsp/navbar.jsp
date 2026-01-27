<%@ page import="edu.mcw.scge.services.SCGEContext" %>

<link href="/platform/css/navbar.css" rel="stylesheet" type="text/css"/>


<nav class="navbar navbar-expand-lg navbar-light bg-light" style="padding:0">
        <div class="container-fluid" style="padding: 0">
            <!-- Brand Logo (Left) -->
            <a class="navbar-brand" href="/platform/home"> <img src="/platform/common/images/SCGE_Platform_logo_5.jpg" srcset="/platform/common/images/SCGE_Platform_logo_5.jpg 1x"  alt="Somatic Cell Gene Editing Logo" data-retina_logo_url="" class="fusion-standard-logo"/></a>

            <!-- Mobile Toggle Button -->
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Navbar Links (Right) -->
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav" style="padding-right: 1%" >
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link" href="/platform/home">Home</a></li>

                    <!-- Projects Dropdown -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="projectsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Initiatives
                        </a>
                        <div class="dropdown-menu" aria-labelledby="projectsDropdown">
<%--                            <a class="dropdown-item" href="https://scge.mcw.edu/phase-2-ind-enabling-studies/">All Projects</a>--%>
<%--                            <div class="dropdown-divider"></div>--%>
<%--                            <h6 class="dropdown-header" style="color:black">IND-Enabling Studies</h6>--%>
                            <a class="dropdown-item" href="https://scge.mcw.edu/phase-2-ind-enabling-studies/" target="_blank">Therapeutic Leads</a>
                            <a class="dropdown-item" href="https://scge.mcw.edu/ind-enabling-studies-multiple-disease-platforms/" target="_blank">Multiple Disease Platforms</a>
<%--                            <div class="dropdown-divider"></div>--%>
                            <a class="dropdown-item" href="https://scge.mcw.edu/phase-2-platform-clinical-trials/" target="_blank">Platform Clinical Programs</a>
<%--                            <a class="dropdown-item" href="/platform/projects?category=Collaboration">Collaborations</a>--%>
                        </div>
                    </li>

                    <!-- Regulatory Documents Dropdown -->
                    <li class="nav-item"><a class="nav-link" href="/platform/public/documents/regulatory">Regulatory Documents</a></li>
<%--                    <li class="nav-item dropdown">--%>
<%--                        <a class="nav-link dropdown-toggle" href="#" id="regulatoryDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">--%>
<%--                            Regulatory Documents--%>
<%--                        </a>--%>
<%--                        <div class="dropdown-menu" aria-labelledby="regulatoryDropdown">--%>
<%--                            <a class="dropdown-item" href="/platform/public/documents/regulatory">All Documents</a>--%>
<%--                            <div class="dropdown-divider"></div>--%>
<%--&lt;%&ndash;                            <a class="dropdown-item" href="/platform/public/documents/regulatory?type=FDA">FDA Guidelines</a>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <a class="dropdown-item" href="/platform/public/documents/regulatory?type=IND">IND Documents</a>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <a class="dropdown-item" href="/platform/public/documents/regulatory?type=Safety">Safety Standards</a>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <a class="dropdown-item" href="/platform/public/documents/regulatory?type=Compliance">Compliance</a>&ndash;%&gt;--%>
<%--                        </div>--%>
<%--                    </li>--%>

                    <!-- Gene Therapy Trial Browser Dropdown -->
                    <li class="nav-item dropdown hover-dropdown">
                        <a class="nav-link dropdown-toggle" href="/platform/data/search/ClinicalTrial" id="trialsDropdown" role="button" aria-haspopup="true" aria-expanded="false">
                            Gene Therapy Trial Browser
                        </a>
                        <div class="dropdown-menu" aria-labelledby="trialsDropdown">
                            <a class="dropdown-item" href="/platform/data/search/ClinicalTrial">All Trials</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="/platform/data/search/ClinicalTrial?status=Active">Active Trials</a>
                            <a class="dropdown-item" href="/platform/data/search/ClinicalTrial?status=Recruiting">Recruiting</a>
                            <a class="dropdown-item" href="/platform/data/search/ClinicalTrial?status=Completed">Completed Trials</a>
                            <a class="dropdown-item" href="/platform/data/search/ClinicalTrial?phases=Phase1">Phase I</a>
                            <a class="dropdown-item" href="/platform/data/search/ClinicalTrial?phases=Phase2">Phase II</a>
                            <a class="dropdown-item" href="/platform/data/search/ClinicalTrial?phases=Phase3">Phase III</a>
                        </div>
                    </li>


                    <!-- Templates & Forms Dropdown -->
                    <li class="nav-item dropdown hover-dropdown">
                        <a class="nav-link dropdown-toggle" href="/platform/data/ind/templates" id="templatesDropdown" role="button"  aria-haspopup="true" aria-expanded="false">
                            Guidance & Forms
                        </a>
                        <div class="dropdown-menu" aria-labelledby="templatesDropdown">
                            <a class="dropdown-item" href="/platform/data/ind/templates">SCGE IND Templates</a>
                            <%
                                if(!SCGEContext.isProduction() && !SCGEContext.isTest()){
                            %>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="/platform/data/ind/forms">General IND Guidance</a>
<%--                            <a class="dropdown-item" href="/platform/data/ind/templates?type=Protocol">Protocol Templates</a>--%>
<%--                            <a class="dropdown-item" href="/platform/data/ind/templates?type=Safety">Safety Reporting Forms</a>--%>
<%--                            <a class="dropdown-item" href="/platform/data/ind/templates?type=CMC">CMC Documents</a>--%>
                            <%}%>
                        </div>
                    </li>
                  
                    <!-- Guidance Dropdown -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="guidanceDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Publications
                        </a>
                        <div class="dropdown-menu" aria-labelledby="guidanceDropdown">
                            <a class="dropdown-item" href="https://scge.mcw.edu/phase-2-publications/">All SCGE Publications</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="https://scge.mcw.edu/publications-by-project/#peranteau">All PKU Program</a>
                            <a class="dropdown-item" href="https://scge.mcw.edu/publications-by-project/#ahrens-nicklas">All UCD Program</a>
                            <a class="dropdown-item" href="https://scge.mcw.edu/publications-by-project/#ahrens-nicklas">All CPS1 Program</a>

                        </div>
                    </li>

                </ul>
                <!-- Separator -->
                <div class="navbar-separator"></div>
            </div>



            <%@include file="search/search.jsp"%>

        </div>
    </nav>


