<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="/platform/css/regulatoryDocuments.css" rel="stylesheet" type="text/css"/>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3">
            <div class="sidebar-content">
                <h5>Contents</h5>

                <%@include file="pku_docs.jsp"%>
                <%@include file="ucd_docs.jsp"%>
                <%@include file="cps1_docs.jsp"%>
            </div>
        </div>

        <!-- Main Content -->
        <div class="col-md-9">
            <div class="main-content-area">
                <h1 class="page-title">SCGE Documents</h1>

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
                            <th style="width: 80px;">Publications</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Inborn Errors of Metabolism -->
                        <tr>
                            <td rowspan="3" class="disease-area-cell">
                                <div class="disease-icon-container">
                                    <div class="disease-icon inborn-errors-icon">
<%--                                        <i class="fas fa-dna" style="color: white !important;"></i>--%>
                                        <img src="/platform/common/images/liver_100_noBorder_blue1.png"/>
                                    </div>
                                    <div class="disease-label">Inborn<br>Errors of<br>Metabolism</div>
                                </div>
                            </td>
                            <td class="program-name">Phenylketonuria<br>(PKU)</td>
                            <td colspan="5" style="position: relative;">
                                <div class="timeline-bar" style="left: 5px; width: 55%;"></div>
                            </td>
                            <td class="publications-cell">
                                <button class="publications-toggle" onclick="togglePublications('pku-publications')">
                                    <i class="fas fa-file-alt"></i>
                                    <span class="pub-count">4</span>
                                    <i class="fas fa-chevron-down toggle-icon"></i>
                                </button>
                            </td>
                        </tr>
                        <tr class="publications-row" id="pku-publications">
                            <td colspan="8" class="publications-content">
                                <div class="publications-container">
                                    <h5 class="publications-title">
                                        <i class="fas fa-file-alt"></i> PKU Program Publications
                                    </h5>
                                    <ul class="publications-list">
                                        <li>
                                            <a href="https://pubmed.ncbi.nlm.nih.gov/41175865/" target="_blank">
                                                How to create personalized gene editing platforms: Next steps towards interventional genetics (2025)
                                            </a>
                                        </li>
                                        <li>
                                            <a href="https://pubmed.ncbi.nlm.nih.gov/37924808/" target="_blank">
                                                Efficient in vivo prime editing corrects the most frequent phenylketonuria variant, associated with high unmet medical need (2023)
                                            </a>
                                        </li>
                                        <li>
                                            <a href="https://pubmed.ncbi.nlm.nih.gov/37301931/" target="_blank">
                                                Rapid and definitive treatment of phenylketonuria in variant-humanized mice with corrective editing (2023)
                                            </a>
                                        </li>
                                        <li>
                                            <a href="https://pubmed.ncbi.nlm.nih.gov/37922902/" target="_blank">
                                                A base editing strategy using mRNA-LNPs for in vivo correction of the most frequent phenylketonuria variant (2024)
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="program-name">Carbamoyl<br>Phosphate<br>Synthetase I (CPS1)<br>Deficiency</td>
                            <td colspan="5" style="position: relative;">
                                <div class="timeline-bar" style="left: 5px; width: 85%;"></div>
                            </td>
                            <td class="publications-cell">
                                <button class="publications-toggle" onclick="togglePublications('cps1-publications')">
                                    <i class="fas fa-file-alt"></i>
                                    <span class="pub-count">1</span>
                                    <i class="fas fa-chevron-down toggle-icon"></i>
                                </button>
                            </td>
                        </tr>
                        <tr class="publications-row" id="cps1-publications">
                            <td colspan="8" class="publications-content">
                                <div class="publications-container">
                                    <h5 class="publications-title">
                                        <i class="fas fa-file-alt"></i> CPS1 Program Publications
                                    </h5>
                                    <ul class="publications-list">
                                        <li>
                                            <a href="https://pubmed.ncbi.nlm.nih.gov/40373211/" target="_blank">
                                                Patient-Specific In Vivo Gene Editing to Treat a Rare Genetic Disease (2025)</a>                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="program-name">Urea Cycle Disorders<br>(UCDs)</td>
                            <td colspan="5" style="position: relative;">
                                <div class="timeline-bar" style="left: 5px; width: 55%;"></div>
                            </td>
                            <td class="publications-cell">
                                <button class="publications-toggle" onclick="togglePublications('ucd-publications')">
                                    <i class="fas fa-file-alt"></i>
                                    <span class="pub-count">1</span>
                                    <i class="fas fa-chevron-down toggle-icon"></i>
                                </button>
                            </td>
                        </tr>

                        <tr class="publications-row" id="ucd-publications">
                            <td colspan="8" class="publications-content">
                                <div class="publications-container">
                                    <h5 class="publications-title">
                                        <i class="fas fa-file-alt"></i> UCD Program Publications
                                    </h5>
                                    <ul class="publications-list">
                                        <li>
                                            <a href="https://pubmed.ncbi.nlm.nih.gov/41175865/" target="_blank">
                                                How to create personalized gene editing platforms: Next steps towards interventional genetics (2025)
                                            </a>
                                        </li>
                                    </ul>
                                </div>
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
                            <td class="publications-cell">
                                <div class="no-publications">—</div>
                            </td>
                        </tr>
                        <tr>
                            <td class="program-name">Angelman Syndrome</td>
                            <td colspan="5" style="position: relative;">
<%--                                <div class="timeline-bar" style="left: 5px; width: 35%;"></div>--%>
                                <div class="coming-soon-text">Coming Soon..</div>
                            </td>
                            <td class="publications-cell">
                                <div class="no-publications">—</div>
                            </td>
                        </tr>
                        <tr>
                            <td class="program-name">Prion Disease</td>
                            <td colspan="5" style="position: relative;">
<%--                                <div class="timeline-bar" style="left: 5px; width: 30%;"></div>--%>
                                <div class="coming-soon-text">Coming Soon..</div>
                            </td>
                            <td class="publications-cell">
                                <div class="no-publications">—</div>
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
<%--                                <div class="coming-soon-text">Coming Soon..</div>--%>
                            </td>
                            <td class="publications-cell">
                                <div class="no-publications">—</div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
function togglePublications(rowId) {
    const row = document.getElementById(rowId);
    const button = event.currentTarget;
    const icon = button.querySelector('.toggle-icon');

    if (row.classList.contains('active')) {
        row.classList.remove('active');
        icon.classList.remove('fa-chevron-up');
        icon.classList.add('fa-chevron-down');
    } else {
        // Close all other open publications
        document.querySelectorAll('.publications-row.active').forEach(openRow => {
            openRow.classList.remove('active');
        });
        document.querySelectorAll('.toggle-icon.fa-chevron-up').forEach(openIcon => {
            openIcon.classList.remove('fa-chevron-up');
            openIcon.classList.add('fa-chevron-down');
        });

        // Open clicked publication
        row.classList.add('active');
        icon.classList.remove('fa-chevron-down');
        icon.classList.add('fa-chevron-up');
    }
}

function toggleSidebarPublications(contentId) {
    const content = document.getElementById(contentId);
    const button = event.currentTarget;

    if (content.classList.contains('active')) {
        content.classList.remove('active');
        button.classList.remove('active');
    } else {
        content.classList.add('active');
        button.classList.add('active');
    }
}
</script>