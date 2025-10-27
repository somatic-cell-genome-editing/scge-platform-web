<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    /* Regulatory Documents Page Modern Styling */
    .regulatory-documents-container {
        margin-bottom: 60px;
    }

    /* Sidebar Styling */
    .sidebar-content {
        background: #ffffff;
        padding: 25px;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        position: sticky;
        top: 20px;
        min-height: 500px;
    }

    .sidebar-content h5 {
        color: #003366;
        font-weight: 700;
        font-size: 1.2rem;
        margin-bottom: 20px;
        padding-bottom: 12px;
        border-bottom: 3px solid #0066cc;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .sidebar-content > div {
        margin-bottom: 25px;
        padding-bottom: 20px;
        border-bottom: 1px solid #e9ecef;
    }

    .sidebar-content > div:last-child {
        border-bottom: none;
    }

    .sidebar-content h6 {
        font-size: 0.95rem;
        font-weight: 600;
        margin-bottom: 12px;
    }

    .sidebar-content h6 a {
        color: #0066cc !important;
        text-decoration: none;
        transition: color 0.2s ease;
    }

    .sidebar-content h6 a:hover {
        color: #004499 !important;
        text-decoration: underline !important;
    }

    .sidebar-content ul {
        list-style-type: none;
        padding-left: 0;
    }

    .sidebar-content li {
        margin-bottom: 10px;
        transition: all 0.2s ease;
        padding: 5px 0;
    }

    .sidebar-content li:hover {
        padding-left: 10px;
        background: #f8f9fa;
    }

    .sidebar-content li a {
        color: #0066cc;
        text-decoration: none;
        font-size: 0.9rem;
        transition: color 0.2s ease;
    }

    .sidebar-content li a:hover {
        color: #004499;
        text-decoration: underline;
    }

    /* Main Content Area */
    .main-content-area {
        padding: 25px 35px;
        background: #ffffff;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
    }

    h1.page-title {
        color: #003366;
        font-size: 1.8rem;
        font-weight: 700;
        margin-bottom: 25px;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        padding-bottom: 15px;
        border-bottom: 3px solid #0066cc;
    }

    .intro-text {
        font-size: 1rem;
        line-height: 1.8;
        margin-bottom: 35px;
        color: #495057;
    }

    .intro-text p {
        margin-bottom: 0;
    }

    /* Gantt Table Styling */
    .gantt-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
        margin-top: 30px;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
    }

    .gantt-table th {
        background: linear-gradient(135deg, #003366 0%, #004499 100%);
        color: white;
        padding: 18px 12px;
        text-align: center;
        font-size: 0.9rem;
        font-weight: 600;
        border: 1px solid #002244;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        line-height: 1.4;
    }

    .gantt-table thead tr th:first-child {
        border-top-left-radius: 12px;
    }

    .gantt-table thead tr th:last-child {
        border-top-right-radius: 12px;
    }

    .gantt-table td {
        padding: 12px;
        border: 1px solid #dee2e6;
        position: relative;
        height: 60px;
        background-color: #ffffff;
        transition: background-color 0.2s ease;
    }

    .gantt-table tbody tr:hover td {
        background-color: #f8f9fa;
    }

    .phase-column {
        border-left: 2px solid #0066cc !important;
    }

    .disease-area-cell {
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        vertical-align: middle;
        text-align: center;
        border-right: 2px solid #0066cc !important;
    }

    .disease-icon-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        padding: 10px;
    }

    .disease-icon {
        width: 75px;
        height: 75px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 12px;
        font-size: 32px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
        transition: transform 0.3s ease;
    }

    .disease-icon:hover {
        transform: scale(1.1);
    }

    .disease-label {
        text-align: center;
        font-size: 0.85rem;
        font-weight: 700;
        line-height: 1.4;
        color: #003366;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .program-name {
        font-size: 0.85rem;
        color: #495057;
        text-align: center;
        line-height: 1.4;
        font-weight: 500;
    }

    .timeline-bar {
        position: absolute;
        height: 38px;
        background: linear-gradient(90deg, #0066cc 0%, #4d94d6 50%, #0066cc 100%);
        top: 50%;
        transform: translateY(-50%);
        clip-path: polygon(0 0, calc(100% - 20px) 0, 100% 50%, calc(100% - 20px) 100%, 0 100%);
        border-radius: 4px 0 0 4px;
        box-shadow: 0 2px 6px rgba(0, 102, 204, 0.3);
        transition: all 0.3s ease;
    }

    .timeline-bar:hover {
        background: linear-gradient(90deg, #004499 0%, #0066cc 50%, #004499 100%);
        box-shadow: 0 4px 12px rgba(0, 102, 204, 0.4);
        transform: translateY(-50%) scale(1.02);
    }

    /* Disease Icon Colors */
    .inborn-errors-icon {
        background: linear-gradient(135deg, #0066cc 0%, #004499 100%);
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
        color: white;
    }

    .inborn-errors-icon img {
        width: 60%;
        height: 60%;
        object-fit: contain;
    }

    .neurological-icon {
        background: linear-gradient(135deg, #28a745 0%, #1e7e34 100%);
        color: white;
    }

    .retinal-icon {
        background: linear-gradient(135deg, #dc3545 0%, #bd2130 100%);
        color: white;
    }

    /* Coming Soon Styling */
    .coming-soon-text {
        display: flex;
        align-items: center;
        justify-content: center;
        height: 100%;
        color: #6c757d;
        font-size: 0.9rem;
        font-style: italic;
        font-weight: 500;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .sidebar-content {
            position: relative;
            top: 0;
            margin-bottom: 20px;
        }

        .main-content-area {
            padding: 20px;
        }

        h1.page-title {
            font-size: 1.5rem;
        }

        .gantt-table {
            font-size: 0.8rem;
        }

        .gantt-table th {
            padding: 12px 8px;
        }

        .disease-icon {
            width: 60px;
            height: 60px;
            font-size: 26px;
        }

        .disease-label {
            font-size: 0.75rem;
        }
    }
</style>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3">
            <div class="sidebar-content">
                <h5>Contents</h5>

                <div style="margin-bottom: 25px;">
                    <h6 style="color: #007bff; text-decoration: underline; font-weight: bold;"><a href="https://scge.mcw.edu/phase-2-ind-enabling-studies/#peranteau" target="_blank" style="color: #007bff; text-decoration: underline;">CHOP/UPENN (PKU Program)</a></h6>
                    <ul>
                        <li>• <a href="/platform/public/download/regulatory?documentName='PKU Pre-IND briefing book redacted.pdf'" target="_blank">Pre-IND Briefing Book</a></li>
                        <li>• <a href="/platform/public/download/regulatory?documentName='PKU FDA Preliminary Responses_PS008879_4 redacted.pdf'" target="_blank" >Pre-IND Official Responses/Meeting Summary</a></li>
                    </ul>
                </div>

                <div style="margin-bottom: 25px;">
                    <h6 style="color: #007bff; text-decoration: underline; font-weight: bold;"><a href="https://scge.mcw.edu/ind-enabling-studies-multiple-disease-platforms/#ahrens-nicklas" target="_blank" style="color: #007bff; text-decoration: underline;">CHOP/UPENN (UCD Program)</a></h6>
                    <ul>
                        <li>• <a href="/platform/public/download/regulatory?documentName='UCD Pre-IND briefing book redacted.pdf'" target="_blank">Pre-IND Briefing Book</a></li>
                        <li>• <a href="/platform/public/download/regulatory?documentName='UCD FDA Signed_a_Meeting Summary_PS010343-CHOP redacted.pdf'" target="_blank">Pre-IND Official Responses/Meeting Summary</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="col-md-9">
            <div class="main-content-area">
                <h1 class="page-title">SCGE Regulatory Documents</h1>

                <div class="intro-text">
                    <p>
                        The Somatic Cell Genome Editing (SCGE) Consortium is an NIH Common Fund program created to accelerate translational research in genome editing. A primary goal is to disseminate documents generated through regulatory interactions between the U.S. Food and Drug Administration (FDA) and consortium projects to help the rare disease communities and the providers and researchers that serve them.
                    </p>
                </div>

                <!-- Gantt Chart Table -->
                <table class="gantt-table">
                    <thead>
                        <tr>
                            <th style="width: 140px;">Disease Area</th>
                            <th style="width: 180px;">Program</th>
                            <th>Lead<br>Optimization</th>
                            <th class="phase-column">INTERACT<br>Meeting</th>
                            <th class="phase-column">Pre-IND<br>Meeting</th>
                            <th class="phase-column">IND Enabling<br>Studies</th>
                            <th class="phase-column">Clinical Trial<br>Initiated</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Inborn Errors of Metabolism -->
                        <tr>
                            <td rowspan="3" class="disease-area-cell">
                                <div class="disease-icon-container">
                                    <div class="disease-icon inborn-errors-icon">
<%--                                        <i class="fas fa-dna" style="color: white !important;"></i>--%>
                                        <img src="/platform/common/images/liver_100_noBorder.jpg"/>
                                    </div>
                                    <div class="disease-label">Inborn<br>Errors of<br>Metabolism</div>
                                </div>
                            </td>
                            <td class="program-name">Phenylketonuria<br>(PKU)</td>
                            <td colspan="5" style="position: relative;">
                                <div class="timeline-bar" style="left: 5px; width: 55%;"></div>
                            </td>
                        </tr>
                        <tr>
                            <td class="program-name">Carbamoyl<br>Phosphate<br>Synthetase I (CPS1)<br>Deficiency</td>
                            <td colspan="5" style="position: relative;">
<%--                                <div class="timeline-bar" style="left: 5px; width: 85%;"></div>--%>
                                <div class="coming-soon-text">Coming Soon..</div>
                            </td>
                        </tr>
                        <tr>
                            <td class="program-name">Urea Cycle Disorders<br>(UCDs)</td>
                            <td colspan="5" style="position: relative;">
                                <div class="timeline-bar" style="left: 5px; width: 55%;"></div>
                            </td>
                        </tr>

                        <!-- Neurological Disorders -->
                        <tr>
                            <td rowspan="3" class="disease-area-cell">
                                <div class="disease-icon-container">
                                    <div class="disease-icon neurological-icon">
                                        <i class="fas fa-brain"></i>
                                    </div>
                                    <div class="disease-label">Neurological<br>Disorders</div>
                                </div>
                            </td>
                            <td class="program-name">Spinal Muscular<br>Atrophy (SMA)</td>
                            <td colspan="5" style="position: relative;">
<%--                                <div class="timeline-bar" style="left: 5px; width: 40%;"></div>--%>
                                <div class="coming-soon-text">Coming Soon..</div>
                            </td>
                        </tr>
                        <tr>
                            <td class="program-name">Angelman Syndrome</td>
                            <td colspan="5" style="position: relative;">
<%--                                <div class="timeline-bar" style="left: 5px; width: 35%;"></div>--%>
                                <div class="coming-soon-text">Coming Soon..</div>
                            </td>
                        </tr>
                        <tr>
                            <td class="program-name">Prion Disease</td>
                            <td colspan="5" style="position: relative;">
<%--                                <div class="timeline-bar" style="left: 5px; width: 30%;"></div>--%>
                                <div class="coming-soon-text">Coming Soon..</div>
                            </td>
                        </tr>

                        <!-- Retinal Diseases -->
                        <tr>
                            <td class="disease-area-cell">
                                <div class="disease-icon-container">
                                    <div class="disease-icon retinal-icon">
                                        <i class="fas fa-eye"></i>
                                    </div>
                                    <div class="disease-label">Retinal<br>Diseases</div>
                                </div>
                            </td>
                            <td class="program-name">Leber Congenital<br>Amaurosis (KCNJ13)</td>
                            <td colspan="5" style="position: relative;">
<%--                                <div class="timeline-bar" style="left: 5px; width: 40%;"></div>--%>
                                <div class="coming-soon-text">Coming Soon..</div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>