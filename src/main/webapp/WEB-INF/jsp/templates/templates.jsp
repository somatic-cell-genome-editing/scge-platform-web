<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 5/10/2024
  Time: 3:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

<script src="/platform/js/ctdModules.js"></script>
<div class="page-header">
    <h3>IND (Investigational New Drug) Application for gene therapy </h3>
</div>
<div style="margin-bottom: 10%">
<div class="card">
    <div class="card-header"><h5>Common Technical Document (CTD)</h5></div>
    <div class="card-body">
        <div class="row">
            <div class="col">
               <p>The eCTD contains an electronic table of contents also referred to as a backbone that manages all the metadata for an application.

                This backbone is broken down into five modules. Documents are placed appropriately into modules, which are graphically presented as the CTD Triangle.
               </p>
               <p><a href="#module1-tab" id="go-to-module1"><strong>Module 1</strong></a> references regional information such as forms, cover letter, labeling, and investigational brochures.</p>

                <p><a href="#module2-tab" id="go-to-module2"><strong>Module 2</strong></a> references summaries such as quality, clinical, and non-clinical summaries.</p>

                <p><a href="#module3-tab" id="go-to-module3"><strong>Module 3</strong></a> references quality information.</p>

                <p><a href="#module4-tab" id="go-to-module4"><strong>Module 4</strong></a> references non-clinical information.</p>

                <p><a href="#module5-tab" id="go-to-module5"><strong>Module 5</strong></a> references clinical information.</p>
                <div class="card" style="margin-top: 1%;margin-bottom: 1%">
                    <div class="card-header"><a href="/platform/forms_public/USFDA_eCTDv4_0_CTOC_v1.pdf" target="_blank"><h5 style="text-decoration: underline">Comprehensive Table of Contents Headings and Hierarchy</h5></a>
                    </div>

                </div>
                <div class="card" style="margin-top: 1%;margin-bottom: 1%">
                    <div class="card-header"><h5>ICH and FDA Guidance on eCTD Organization and Specifications                        <i class="fa-solid fa-download" style="color:darkorange;font-size: 30px;font-weight: bold"></i>&nbsp;<a href="/platform/download/ctd-XXXXX.zip">Download .zip file</a>
                    </h5></div>

                </div>
            </div>
            <div class="col">
                <img src="/platform/images/CTD_triangle.png" alt="CTD triangle" usemap="#ctdmap">
                <map name="ctdmap">
                    <area shape="rect" coords="234,42,395,164" alt="CTD triangle" href="#module1-tab" id="module1-map">
                    <area shape="rect" coords="224,165,510,335" alt="CTD triangle" href="#module2-tab" id="module2-map">
                    <area shape="rect" coords="102,335,246,444" alt="CTD triangle" href="#module3-tab" id="module3-map">
                    <area shape="rect" coords="248,337,372,446" alt="CTD triangle" href="#module4-tab" id="module4-map">
                    <area shape="rect" coords="372,337,590,446" alt="CTD triangle" href="#module5-tab" id="module5-map">
                </map>
            </div>
        </div>

    </div>
</div>

    <div class="card" style="margin-top: 1%;margin-bottom: 1%">
        <div class="card-header"><h5>FDA Submission Elements <div style="float:right;"><button id="downloadExcelBtn" class="btn btn-success btn-sm mb-3">Download Excel</button> </div></h5>
        </div>
        <div class="card-body">

            <div class="row">
                <div class="col-2"><%@include file="../ctd/rquirementsFilter.jsp"%></div>
                <div class="col-10"> <%@include file="../ctd/ctdTable.jsp"%></div>
            </div>

            
           

        </div>
    </div>
<div class="card">
    <div class="card-header"><h5>Templates</h5></div>
    <div class="card-body">

        <ul>
            <li><a href="/platform/data/protected/GENERAL INVESTIGATIONAL PLAN_Template .docx">GENERAL INVESTIGATIONAL PLAN</a></li>
            <li><a href="/platform/data/protected/INTERACT MEETING REQUEST_MEETING INFORMATION PACKAGE_Template.docx">INTERACT MEETING REQUEST</a></li>
            <li><a href="/platform/data/protected/INVESTIGATOR'S BROCHURE_template.docx">INVESTIGATOR'S BROCHURE</a></li>
            <li><a href="/platform/data/protected/Module 5_ CLINICAL PROTOCOL_Template.docx">Module 5 CLINICAL PROTOCOL</a></li>
            <li><a href="/platform/data/protected/Module 5_ INFORMED CONSENT_Template.docx">Module 5 INFORMED CONSENT</a></li>
            <li><a href="/platform/data/protected/Module4_Template.docx">Module 4</a></li>
            <li><a href="/platform/data/protected/NON-CLINICAL OVERVIEW_Template.docx">NON-CLINICAL OVERVIEW</a></li>
            <li><a href="/platform/data/protected/NON-CLINICAL WRITTEN AND TABULATED SUMMARIES_template.docx">NON-CLINICAL WRITTEN AND TABULATED SUMMARIES TEMPLATE</a></li>
            <li><a href="/platform/data/protected/PRE_IND MEETING INFORMATION PACKAGE Template.docx">Pre-IND Meeting Information Package</a></li>
            <li><a href="/platform/data/protected/PRE_IND MEETING REQUEST_template.docx">Pre-IND Meeting Request</a></li>
        </ul>

    </div>
</div>
    <div class="card">
        <div class="card-header">
            <h5>Resources/Links</h5>
        </div>
        <div class="card-body">
            <ul>
            <li><a href="/platform/forms_public/eCTD Tech Guide v1.8 Final.pdf" target="_blank">eCTD TECHNICAL CONFORMANCE GUIDE </a>- Content current as of: 03/22/2023</li>
            <li><a href="https://www.fda.gov/drugs/electronic-regulatory-submission-and-review/submit-using-ectd#review" target="_blank">Submit Using eCTD</a></li>
                <li><a href="https://www.fda.gov/vaccines-blood-biologics/cellular-gene-therapy-products/otp-pre-ind-meetings" target="_blank">OTP Pre-IND Meetings</a></li>
            <li><a href="https://www.fda.gov/vaccines-blood-biologics/cellular-gene-therapy-products/otp-interact-meeting" target="_blank">OTP INTERACT Meeting</a></li>
            <li><a href="https://www.elpidatx.com/documents" target="_blank">Elpida Therapeutics (SPG50 Phase I/II Regulatory Documents)</a></li>
            </ul>
        </div>
    </div>
</div>

<script>
    document.getElementById('downloadExcelBtn').addEventListener('click', function () {
        const wb = XLSX.utils.book_new(); // Create a new workbook

        const tableConfigs = [
            { id: 'module1', name: 'Module_1' },
            { id: 'module2', name: 'Module_2' },
            { id: 'module3', name: 'Module_3' },
            { id: 'module4', name: 'Module_4' },
            { id: 'module5', name: 'Module_5' }
        ];

        tableConfigs.forEach(config => {
            const tableElement = document.getElementById(config.id);
            if (tableElement) {
                const ws = XLSX.utils.table_to_sheet(tableElement, { raw: true });
                XLSX.utils.book_append_sheet(wb, ws, config.name);
            }
        });

        XLSX.writeFile(wb, 'FDA_Submission_elements.xlsx');
    });
</script>