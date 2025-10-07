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
    .sidebar-note {
        color: #dc3545;
        font-weight: bold;
        margin-top: 30px;
        font-size: 14px;
    }
    .gantt-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
        margin-top: 30px;
    }
    .gantt-table th {
        background-color: #2c3e50;
        color: white;
        padding: 12px 8px;
        text-align: center;
        font-size: 12px;
        font-weight: normal;
        border: 1px solid #34495e;
    }
    .gantt-table td {
        padding: 8px;
        border: 1px solid #ddd;
        position: relative;
        height: 35px;
    }
    .disease-icon {
        width: 60px;
        height: 60px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto;
        color: white;
        font-weight: bold;
    }
    .disease-label {
        text-align: center;
        font-size: 11px;
        margin-top: 5px;
    }
    .gantt-bar {
        position: absolute;
        height: 25px;
        background-color: #87ceeb;
        border-radius: 4px;
        top: 50%;
        transform: translateY(-50%);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 10px;
        color: #333;
        white-space: nowrap;
        padding: 0 5px;
    }
    .phase-column {
        border-left: 2px dotted #999 !important;
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
    .note-text {
        color: #dc3545;
        font-weight: bold;
        font-size: 18px;
        margin: 20px 0;
    }
    .inborn-errors {
        background-color: #6c5ce7;
    }
    .neurological {
        background-color: #00b894;
    }
    .retinal {
        background-color: #fdcb6e;
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

                <div class="sidebar-note">
                    We can add more in this sidebar list as they become available
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="col-md-9">
            <div class="main-content-area">
                <h1 class="page-title">SCGE Regulatory Documents</h1>

                <div class="intro-text">
                    <p>
                        Text blurb about the documents, what was shared, short bio on the
                        projects, can be added to as more documents become available
                    </p>
                </div>

                <!-- Gantt Chart Table -->
                <table class="gantt-table">
                    <thead>
                        <tr>
                            <th style="width: 120px;">Disease Area</th>
                            <th style="width: 100px;">Program</th>
                            <th>Lead<br>Optimization</th>
                            <th class="phase-column">INTERACT<br>Meeting</th>
                            <th>Pre-IND<br>Meeting</th>
                            <th class="phase-column">IND Enabling<br>Studies</th>
                            <th>Clinical Trial<br>Initiated</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Inborn Errors of Metabolism -->
                        <tr>
                            <td rowspan="3" style="vertical-align: middle;">
                                <div class="disease-icon inborn-errors">IE</div>
                                <div class="disease-label">Inborn<br>Errors of<br>Metabolism</div>
                            </td>
                            <td style="font-size: 11px;">Phenylketonuria<br>(PKU)</td>
                            <td colspan="5" style="position: relative;">
                                <div class="gantt-bar" style="left: 0; width: 85%;">PKU Timeline</div>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-size: 11px;">CPSI Deficiency</td>
                            <td colspan="5" style="position: relative;">
                                <div class="gantt-bar" style="left: 0; width: 100%;">CPSI Timeline</div>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-size: 11px;">Urea Cycle Disorders</td>
                            <td colspan="5" style="position: relative;">
                                <div class="gantt-bar" style="left: 0; width: 60%;">UCD Timeline</div>
                            </td>
                        </tr>

                        <!-- Neurological Disorders -->
                        <tr>
                            <td rowspan="3" style="vertical-align: middle;">
                                <div class="disease-icon neurological">ND</div>
                                <div class="disease-label">Neurological<br>Disorders</div>
                            </td>
                            <td style="font-size: 11px;">Spinal Muscular<br>Atrophy (SMA)</td>
                            <td colspan="5" style="position: relative;">
                                <div class="gantt-bar" style="left: 0; width: 35%;">SMA Timeline</div>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-size: 11px;">Angelman Syndrome</td>
                            <td colspan="5" style="position: relative;">
                                <div class="gantt-bar" style="left: 0; width: 30%;">Angelman Timeline</div>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-size: 11px;">Prion Disease</td>
                            <td colspan="5" style="position: relative;">
                                <div class="gantt-bar" style="left: 0; width: 45%;">Prion Timeline</div>
                            </td>
                        </tr>

                        <!-- Retinal Diseases -->
                        <tr>
                            <td rowspan="2" style="vertical-align: middle;">
                                <div class="disease-icon retinal">RD</div>
                                <div class="disease-label">Retinal<br>Diseases</div>
                            </td>
                            <td style="font-size: 11px;">Leber Congenital<br>Amaurosis (XCNJ13)</td>
                            <td colspan="5" style="position: relative;">
                                <div class="gantt-bar" style="left: 0; width: 35%;">LCA Timeline</div>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-size: 11px;">Best Disease</td>
                            <td colspan="5" style="position: relative;">
                                <div class="gantt-bar" style="left: 0; width: 30%;">Best Disease Timeline</div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>