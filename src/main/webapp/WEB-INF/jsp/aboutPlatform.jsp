<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 4/14/2025
  Time: 11:45 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    /* About Platform Page Modern Styling */
    .about-platform-container {
        margin-bottom: 60px;
        padding: 20px;
    }

    .about-platform-header {
        background: #ffffff;
        padding: 30px 40px;
        border-radius: 12px;
        margin-bottom: 30px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        /*border-bottom: 4px solid #0066cc;*/
    }

    .about-platform-header h2 {
        color: #003366;
        font-size: 2rem;
        font-weight: 700;
        margin: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .about-content-card {
        background: #ffffff;
        padding: 40px 45px;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        margin-bottom: 30px;
        transition: box-shadow 0.3s ease;
    }

    .about-content-card:hover {
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
    }

    .about-text {
        background-color: transparent !important;
    }

    .about-text p {
        font-size: 1.05rem;
        line-height: 1.8;
        color: #495057;
        margin-bottom: 25px;
        text-align: justify;
    }

    .about-text a {
        color: #0066cc;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.2s ease;
        border-bottom: 1px solid transparent;
    }

    .about-text a:hover {
        color: #004499;
        border-bottom: 1px solid #004499;
        text-decoration: none;
    }

    .about-text ul {
        list-style: none;
        padding-left: 0;
        margin-left: 0;
    }

    .about-text > ul > li {
        font-size: 1.05rem;
        line-height: 1.8;
        color: #495057;
        margin-bottom: 20px;
        padding-left: 35px;
        position: relative;
    }

    .about-text > ul > li::before {
        content: '►';
        position: absolute;
        left: 10px;
        color: #0066cc;
        font-size: 0.9rem;
        font-weight: bold;
    }

    .about-text ul ul {
        margin-top: 12px;
        margin-bottom: 12px;
        padding-left: 15px;
    }

    .about-text ul ul li {
        font-size: 1rem;
        line-height: 1.7;
        color: #6c757d;
        margin-bottom: 10px;
        padding-left: 25px;
        position: relative;
    }

    .about-text ul ul li::before {
        content: '•';
        position: absolute;
        left: 8px;
        color: #6c757d;
        font-size: 1.2rem;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .about-platform-container {
            padding: 10px;
        }

        .about-platform-header {
            padding: 20px 25px;
        }

        .about-platform-header h2 {
            font-size: 1.5rem;
        }

        .about-content-card {
            padding: 25px 20px;
        }

        .about-text p,
        .about-text > ul > li {
            font-size: 0.95rem;
        }

        .about-text > ul > li {
            padding-left: 30px;
        }
    }
</style>

<div class="about-platform-container">
    <div class="about-platform-header">
        <h2>Somatic Cell Genome Editing (SCGE) Platform</h2>
    </div>

    <div class="about-content-card about-text">
<div class="text-justify">
    <p>The National Institutes of Health (NIH) is leading an effort to help accelerate genome editing approaches from the lab to the clinic through the <a href="https://scge.mcw.edu/">Somatic Cell Genome Editing (SCGE) Program</a>.
        <a href="https://scge.mcw.edu/phase-1-project-goals/">Phase I</a> of the program included the <a href="https://scge.mcw.edu/toolkit" target="_blank">SCGE Toolkit</a> to disseminate the outcomes focused on translating safe and effective genome editing therapeutics into the clinic. During <a href="https://scge.mcw.edu/about-the-scge-phase-2/">Phase 2</a> the <a href="https://scge.mcw.edu/phase-2-tcdc/">Translational Coordination and Dissemination Center (TCDC)</a> will support and work cooperatively with all initiatives, projects, and members to facilitate the objectives of the entire SCGE Consortium and the broader gene editing therapy field through development of the SCGE Platform, consisting of multiple initiatives.
    </p>
<ul>
    <li>The SCGE Platform is tracking and curating information on current and past gene therapy and gene editing clinical trials to help investigators leverage other successful trials
        <ul>
            <li>Explore the <a href="/platform/data/search/ClinicalTrial">Gene Therapy Trial Browser</a></li>
        </ul>
    </li>
    <li>The Platform will help investigators accelerate their efforts to get their therapies to the clinic by:
        <ul>
            <li>Collecting and collating useful resources and form templates specific to gene editing therapies and products to help investigators work with and submit Investigational New Drug (IND) applications to the Federal Drug Administration (FDA) </li>
            <li>Learning and communicating best practices regarding a successful IND application </li>
            <li>Collecting and sharing data and protocols generated by consortium laboratories</li>
        </ul>
    </li>
</ul>
</div>
    </div>
</div>