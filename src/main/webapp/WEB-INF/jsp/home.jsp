<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 1/4/2024
  Time: 3:31 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    /* Home Page Specific Styles */
    .home-container {
        padding-top: 20px;
        padding-bottom: 40px;
    }

    .hero-section {
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        border-radius: 12px;
        padding: 30px;
        margin-bottom: 40px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
    }

    .hero-image-wrapper {
        max-width: 90%;
        margin: 0 auto;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
    }

    .hero-image-wrapper img {
        transition: transform 0.3s ease;
    }

    .hero-image-wrapper:hover img {
        transform: scale(1.02);
    }

    .sidebar-section {
        background: #ffffff;
        border-radius: 8px;
        padding: 25px;
        margin-bottom: 25px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        border-left: 4px solid #0066cc;
    }

    .sidebar-section h4 {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        font-size: 1.3rem;
        font-weight: 600;
        color: #003366;
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 2px solid #e9ecef;
    }

    .sidebar-section .list-unstyled li {
        margin-bottom: 12px;
    }

    .sidebar-section .list-unstyled li a {
        color: #0066cc;
        text-decoration: none;
        transition: color 0.2s ease, padding-left 0.2s ease;
        display: inline-block;
        font-weight: 500;
    }

    .sidebar-section .list-unstyled li a:hover {
        color: #004499;
        padding-left: 5px;
    }

    .social-links-wrapper {
        background: #ffffff;
        border-radius: 8px;
        padding: 25px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        border-left: 4px solid #0066cc;
    }

    .social-links-wrapper h4 {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        font-size: 1.3rem;
        font-weight: 600;
        color: #003366;
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 2px solid #e9ecef;
    }

    .list-group-horizontal {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
    }

    .list-group-horizontal .list-group-item {
        border: none;
        padding: 0;
        background: transparent;
    }

    .list-group-horizontal .list-group-item a {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 45px;
        height: 45px;
        border-radius: 50%;
        background: #f8f9fa;
        color: #003366;
        transition: all 0.3s ease;
        font-size: 1.2rem;
    }

    .list-group-horizontal .list-group-item a:hover {
        background: #0066cc;
        color: #ffffff;
        transform: translateY(-3px);
        box-shadow: 0 4px 8px rgba(0, 102, 204, 0.3);
    }

    /* News Section Styles */
    .news-section {
        background: #ffffff;
        border-radius: 8px;
        padding: 30px;
        margin-bottom: 30px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
    }

    .news-section h3 {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        font-size: 1.8rem;
        font-weight: 700;
        color: #003366;
        margin-bottom: 25px;
        padding-bottom: 15px;
        border-bottom: 3px solid #0066cc;
    }

    .news-item {
        padding: 20px 0;
        border-bottom: 1px solid #e9ecef;
        transition: background-color 0.2s ease;
    }

    .news-item:last-child {
        border-bottom: none;
    }

    .news-item:hover {
        background-color: #f8f9fa;
        padding-left: 10px;
        padding-right: 10px;
        margin-left: -10px;
        margin-right: -10px;
        border-radius: 6px;
    }

    .news-item-title {
        font-size: 1.3rem;
        font-weight: 600;
        color: #003366;
        margin-bottom: 10px;
    }

    .news-item-title a {
        color: #003366;
        text-decoration: none;
        transition: color 0.2s ease;
    }

    .news-item-title a:hover {
        color: #0066cc;
    }

    .news-item-date {
        font-size: 0.9rem;
        color: #6c757d;
        font-weight: 500;
        margin-bottom: 10px;
        display: inline-block;
    }

    .news-item-excerpt {
        color: #495057;
        line-height: 1.6;
        margin-bottom: 10px;
    }

    .news-item-link {
        color: #0066cc;
        text-decoration: none;
        font-weight: 600;
        font-size: 0.95rem;
        transition: color 0.2s ease;
    }

    .news-item-link:hover {
        color: #004499;
        text-decoration: underline;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .hero-section {
            padding: 20px;
        }

        .hero-image-wrapper {
            max-width: 100%;
        }

        .sidebar-section, .social-links-wrapper, .news-section {
            padding: 20px;
        }

        .news-section h3 {
            font-size: 1.5rem;
        }

        .news-item-title {
            font-size: 1.1rem;
        }
    }
</style>

<div class="container home-container">

        <div align="center">
            <%@include file="aboutPlatform.jsp"%>
        </div>


    <div class="hero-section">
        <div class="col" align="center">
            <div class="hero-image-wrapper">
                <%--            <img class="img-fluid" src="/platform/images/platform-overview.png" />--%>
                <img class="img-fluid" src="/platform/common/images/Platform_Home_Page_V2.png" width="100%"/>
            </div>
        </div>
    </div>


</div>

<main role="main" class="container">

    <div class="row">
        <div class="col-md-8">
            <div class="news-section">
                <h3>Latest News & Updates</h3>

                <div class="news-item">
                    <div class="news-item-date">October 31, 2025</div>
                    <h4 class="news-item-title">
                        <a href="#">SCGE Regulatory Documents – First Set Released</a>
                    </h4>
                    <p class="news-item-excerpt">
                        Full set of pre-IND briefing books and the FDA’s written responses of projects “Postnatal and Prenatal Therapeutic Base Editing for Metabolic Diseases” and “Personalized prime editing as a platform for hepatic inborn errors of metabolism“ are available on the SCGE Translational Coordination and Dissemination Center
                    </p>
                    <a href="/platform/public/documents/regulatory" class="news-item-link">Explore &rarr;</a>
                </div>
                <div class="news-item">
                    <div class="news-item-date">January 15, 2025</div>
                    <h4 class="news-item-title">
                        <a href="#">New Gene Therapy Trial Browser Launched</a>
                    </h4>
                    <p class="news-item-excerpt">
                        The SCGE Consortium is excited to announce the launch of our comprehensive Gene Therapy Trial Browser,
                        providing researchers and clinicians with access to the latest clinical trial information in genome editing.
                    </p>
                    <a href="/platform/data/search/ClinicalTrial" class="news-item-link">Explore &rarr;</a>
                </div>
            </div>
        </div><!-- /.col-md-8 -->

        <aside class="col-md-4 blog-sidebar">

            <div class="sidebar-section">
                <h4>External Resources/Links</h4>
                <ol class="list-unstyled mb-0">
                    <li><a href="https://www.fda.gov/drugs/investigational-new-drug-ind-application/ind-forms-and-instructions" target="_blank">FDA IND Forms and Instructions</a></li>
                    <li><a href="https://www.fda.gov/drugs/types-applications/investigational-new-drug-ind-application#FDA%20Guidances%20for%20Investigational%20New%20Drugs" target="_blank">FDA Guidance Documents for INDs</a></li>
                </ol>
            </div>

            <div class="social-links-wrapper">
                <h4>Follow us on</h4>
                <ul class="list-group list-group-horizontal">
                    <li class="list-group-item"><a href="https://twitter.com/somaticediting" target="_blank" title="twitter"><i class="fa-brands fa-x-twitter"></i></a></li>
                    <li class="list-group-item"><a href="https://www.linkedin.com/company/somatic-cell-genome-editing-consortium/about/" target="_blank" title="LinkedIn"><i class="fab fa-linkedin mr-1"></i></a></li>
                    <li class="list-group-item"><a href="https://www.youtube.com/channel/UCnMSf_YZdv1gIuqPmB6vrYw" target="_blank" title="YouTube"><i class="fab fa-youtube mr-1"></i></a></li>
                </ul>
            </div>
        </aside><!-- /.blog-sidebar -->

    </div><!-- /.row -->

</main><!-- /.container -->