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

<style>
    /* Templates Page Modern Styling */
    .templates-container {
        margin-bottom: 60px;
        margin-top: 20px;
    }

    .page-header {
        background: #ffffff;
        padding: 25px 35px;
        border-radius: 0;
        margin-bottom: 35px;
        border-bottom: 1px solid #e9ecef;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.04);
    }

    .page-header h3 {
        color: #003366;
        font-size: 1.7rem;
        font-weight: 700;
        margin: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        line-height: 1.4;
    }

    /* Card Styling */
    .templates-container .card {
        border: none;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        margin-bottom: 25px;
        overflow: visible;
        transition: all 0.3s ease;
    }

    .templates-container .card:hover {
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
    }

    .templates-container .card-header {
        background: #ffffff;
        border-bottom: 3px solid #0066cc;
        border-left: 5px solid #0066cc;
        padding: 15px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .templates-container .card-header h5 {
        color: #003366;
        font-size: 1.1rem;
        font-weight: 600;
        margin: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .templates-container .card-header a {
        color: #003366;
        text-decoration: none;
        transition: color 0.2s ease;
    }

    .templates-container .card-header a:hover {
        color: #0066cc;
    }

    .templates-container .card-body {
        padding: 30px;
        background: #ffffff;
    }

    .templates-container .card-body p {
        line-height: 1.7;
        margin-bottom: 15px;
        color: #333;
    }

    .templates-container .card-body p a {
        color: #0066cc;
        font-weight: 600;
        text-decoration: none;
        transition: color 0.2s ease;
    }

    .templates-container .card-body p a:hover {
        color: #004499;
        text-decoration: underline;
    }

    /* Nested Cards */
    .templates-container .card .card {
        border: 1px solid #e9ecef;
        border-radius: 8px;
        box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
    }

    .templates-container .card .card .card-header {
        background: #f8f9fa;
        border-bottom: 2px solid #e9ecef;
        border-left: 4px solid #6c757d;
        padding: 12px 18px;
    }

    .templates-container .card .card .card-header h5 {
        color: #495057;
        font-size: 1rem;
        font-weight: 600;
    }

    /* Buttons */
    .templates-container .btn-primary {
        background: #0066cc;
        border: none;
        border-radius: 6px;
        padding: 8px 16px;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    .templates-container .btn-primary:hover {
        background: #004499;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0, 102, 204, 0.3);
    }

    .templates-container .btn-success {
        background: #28a745;
        border: none;
        border-radius: 6px;
        padding: 8px 16px;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    .templates-container .btn-success:hover {
        background: #218838;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(40, 167, 69, 0.3);
    }

    /* CTD Triangle Image */
    .templates-container img[usemap] {
        max-width: 100%;
        height: auto;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease;
    }

    .templates-container img[usemap]:hover {
        transform: scale(1.02);
    }

    /* Lists */
    .templates-container ul {
        list-style: none;
        padding-left: 0;
    }

    .templates-container ul li {
        padding: 10px 0;
        border-bottom: 1px solid #f1f1f1;
        transition: all 0.2s ease;
    }

    .templates-container ul li:last-child {
        border-bottom: none;
    }

    .templates-container ul li:hover {
        padding-left: 10px;
        background: #f8f9fa;
    }

    .templates-container ul li a {
        color: #0066cc;
        text-decoration: none;
        font-weight: 500;
        transition: color 0.2s ease;
    }

    .templates-container ul li a::before {
        content: '📄';
        margin-right: 10px;
    }

    .templates-container ul li a:hover {
        color: #004499;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .page-header {
            padding: 15px 20px;
        }

        .page-header h3 {
            font-size: 1.3rem;
        }

        .templates-container .card-header {
            flex-direction: column;
            align-items: flex-start;
            gap: 10px;
        }

        .templates-container .card-body {
            padding: 20px;
        }
    }
</style>

<div class="page-header">
    <h3>IND (Investigational New Drug) Application for gene therapy </h3>
</div>
<div class="templates-container">
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
                    <div class="card-header">
                        <h5>ICH and FDA Guidance on eCTD Organization and Specifications</h5>
                        <form action="/platform/public/download/zipFile" method="post" style="margin: 0;">
                            <input type="hidden" name="filename" value="IND000000.zip">
                            <button class="btn btn-primary btn-sm"><i class="fa-solid fa-download" style="font-weight: bold"></i>&nbsp;Download .zip file</button>
                        </form>
                    </div>

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
        <div class="card-header">
            <h5>FDA Submission Elements</h5>
            <button id="downloadExcelBtn" class="btn btn-success btn-sm">Download Excel</button>
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

        const instructionsWorkSheet= XLSX.utils.json_to_sheet([{"created by":"Jthota"}]);
        XLSX.utils.book_append_sheet(wb, instructionsWorkSheet, "Instructions");
        XLSX.writeFile(wb, 'FDA_Submission_elements.xlsx');
    });
</script>