<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    .sidebar-content {
        background-color: #f8f9fa;
        padding: 20px;
        border-radius: 5px;
        min-height: 500px;
    }
    .sidebar-content h5 {
        font-weight: bold;
        margin-bottom: 15px;
    }
    .sidebar-content ul {
        list-style-type: none;
        padding-left: 0;
    }
    .sidebar-content li {
        margin-bottom: 8px;
    }
    .sidebar-content a {
        color: #007bff;
        text-decoration: none;
    }
    .sidebar-content a:hover {
        text-decoration: underline;
    }
    .gantt-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 30px;
        border: 1px solid #ddd;
    }
    .gantt-table th {
        background-color: #3b4a6b;
        color: white;
        padding: 15px 10px;
        text-align: center;
        font-size: 14px;
        font-weight: 600;
        border: 1px solid #2c3858;
    }
    .gantt-table td {
        padding: 10px;
        border: 1px solid #ddd;
        position: relative;
        height: 50px;
        background-color: white;
    }
    .phase-column {
        border-left: 2px dashed #999 !important;
    }
    .disease-area-cell {
        background-color: #f8f9fa;
        vertical-align: middle;
        text-align: center;
    }
    .disease-icon-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
    }
    .disease-icon {
        width: 70px;
        height: 70px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 8px;
        font-size: 28px;
    }
    .disease-label {
        text-align: center;
        font-size: 13px;
        font-weight: 600;
        line-height: 1.3;
        color: #2c3858;
    }
    .program-name {
        font-size: 13px;
        color: #333;
        text-align: center;
        line-height: 1.3;
    }
    .timeline-bar {
        position: absolute;
        height: 35px;
        background: linear-gradient(90deg, #7eb3c7 0%, #8fc4d4 50%, #7eb3c7 100%);
        top: 50%;
        transform: translateY(-50%);
        clip-path: polygon(0 0, calc(100% - 20px) 0, 100% 50%, calc(100% - 20px) 100%, 0 100%);
        border-radius: 3px 0 0 3px;
    }
    .main-content-area {
        padding: 20px;
    }
    h1.page-title {
        font-size: 28px;
        margin-bottom: 20px;
        color: #2c3e50;
    }
    .intro-text {
        font-size: 16px;
        line-height: 1.6;
        margin-bottom: 30px;
    }
    .inborn-errors-icon {
        background-color: #3b4a6b;
        color: white;
    }
    .neurological-icon {
        background-color: #3b4a6b;
        color: white;
    }
    .retinal-icon {
        background-color: #3b4a6b;
        color: white;
    }
</style>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3">
            <div class="sidebar-content">
                <h5>Contents</h5>

                <div style="margin-bottom: 25px;">
                    <h6 style="color: #007bff; text-decoration: underline; font-weight: bold;">CHOP/UPENN (PKU Program)</h6>
                    <ul>
                        <li>• <a href="#">Pre-IND Briefing Book</a></li>
                        <li>• <a href="#">Pre-IND Preliminary Feedback</a></li>
                        <li>• <a href="#">Pre-IND Annotated Feedback</a></li>
                    </ul>
                </div>

                <div style="margin-bottom: 25px;">
                    <h6 style="color: #007bff; text-decoration: underline; font-weight: bold;">CHOP/UPENN (UCD Program)</h6>
                    <ul>
                        <li>• <a href="#">Pre-IND Briefing Book</a></li>
                        <li>• <a href="#">Pre-IND Preliminary Feedback</a></li>
                        <li>• <a href="#">Pre-IND Annotated Feedback</a></li>
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
                                        <i class="fas fa-dna" style="color: white !important;"></i>
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
                                <div class="timeline-bar" style="left: 5px; width: 85%;"></div>
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
                                <div class="timeline-bar" style="left: 5px; width: 40%;"></div>
                            </td>
                        </tr>
                        <tr>
                            <td class="program-name">Angelman Syndrome</td>
                            <td colspan="5" style="position: relative;">
                                <div class="timeline-bar" style="left: 5px; width: 35%;"></div>
                            </td>
                        </tr>
                        <tr>
                            <td class="program-name">Prion Disease</td>
                            <td colspan="5" style="position: relative;">
                                <div class="timeline-bar" style="left: 5px; width: 30%;"></div>
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
                                <div class="timeline-bar" style="left: 5px; width: 40%;"></div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>