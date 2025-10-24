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

<%--    <div style="text-align: center; margin-bottom: 20px; font-family: Arial, sans-serif; font-size: 25px; color: #003366;">--%>
<%--        <strong>--%>
<%--            <span>The new Gene Therapy Trial Browser</span> is live!</strong>&nbsp;&nbsp;--%>
<%--        </strong>--%>
<%--        <a href="/platform/data/search/ClinicalTrial" style="color: red; font-weight: bold; display: inline-block;">--%>
<%--            Click here to explore it now.--%>
<%--        </a>--%>
<%--    </div>--%>

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

<%--    <div class="row mb-2">--%>
<%--        <div class="col-md-6" style="display: table-cell;" >--%>
<%--            <div class="card  flex-md-row mb-4 box-shadow h-100">--%>
<%--                <div class="card-body d-flex flex-column align-items-start">--%>
<%--                    <strong class="d-inline-block mb-2 text-primary">SCGE Program Background</strong>--%>
<%--                    &lt;%&ndash;                    <h3 class="mb-0">&ndash;%&gt;--%>
<%--                    &lt;%&ndash;&lt;%&ndash;                        <a class="text-dark" href="#">SCGE Program Background</a>&ndash;%&gt;&ndash;%&gt;--%>
<%--                    &lt;%&ndash;                    </h3>&ndash;%&gt;--%>
<%--                    &lt;%&ndash;                    <div class="mb-1 text-muted"></div>&ndash;%&gt;--%>
<%--                    &lt;%&ndash;                    <p class="card-text mb-auto"></p>&ndash;%&gt;--%>
<%--                    <ul>--%>
<%--                        <li>Genome Editing allows precise corrections to be made in patients DNA and RNA</li>--%>
<%--                        <li>CRISPR-Cas9 catalyzed development of experimental genomed editing therapeutics.</li>--%>
<%--                        <li>Thousands of genetic diseases are amenable to targeted in vivo genome editing approaches</li>--%>

<%--                    </ul>--%>

<%--                </div>--%>
<%--                &lt;%&ndash;                <img class="card-img-right flex-auto" src="/platform/images/body-image.png" alt="SCGE Program Background">&ndash;%&gt;--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-md-6" style="display: table-cell;">--%>
<%--            <div class="card flex-md-row mb-4 box-shadow h-100">--%>
<%--                <div class="card-body d-flex flex-column align-items-start">--%>
<%--                    <strong class="d-inline-block mb-2 text-success">SCGE Phase 1</strong>--%>
<%--                    &lt;%&ndash;                    <h3 class="mb-0">&ndash;%&gt;--%>
<%--                    &lt;%&ndash;&lt;%&ndash;                        <a class="text-dark" href="#">SCGE Phase I</a>&ndash;%&gt;&ndash;%&gt;--%>
<%--                    &lt;%&ndash;                    </h3>&ndash;%&gt;--%>
<%--                    &lt;%&ndash;                    <div class="mb-1 text-muted">Nov 11</div>&ndash;%&gt;--%>

<%--                    <p class="card-text mb-auto">Gaps and Opportunities from 2017 Common Fund Planning Workshop</p>--%>
<%--                    <ul>--%>
<%--                        <li>Improved animal models to detect editing</li>--%>
<%--                        <li>Human Cell Systems for measuring adverse events</li>--%>
<%--                        <li>Delivery Systems for in vivo targeting</li>--%>
<%--                        <li>Methods to track edited cells in vivo.</li>--%>
<%--                        <li>Safer and more effective editors</li>--%>
<%--                    </ul>--%>
<%--                    <p class="card-text mb-auto">SCGE Phase I addressed these gaps.</p>--%>

<%--                    <a href="https://scge.mcw.edu/toolkit">SCGE Toolkit</a>--%>
<%--                    &lt;%&ndash;                    <a href="#">Continue reading</a>&ndash;%&gt;--%>
<%--                </div>--%>
<%--                &lt;%&ndash;                <img class="card-img-right flex-auto d-none d-md-block" data-src="holder.js/200x250?theme=thumb" alt="Card image cap">&ndash;%&gt;--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
</div>

<main role="main" class="container">
<%--    <div class="p-3 mb-3 bg-light rounded">--%>
<%--        <h4 class="font-italic">About</h4>--%>
<%--        <p class="mb-0">The National Institutes of Health (NIH) has awarded over $140 million to help accelerate genome editing approaches from the lab to the clinic. The newly funded projects build upon the work performed though the Somatic Cell Genome Editing (SCGE) Program over the past five years and will focus on translating safe and effective genome editing therapeutics into the clinic.</p>--%>
<%--    </div>--%>
    <div class="row">
        <div class="col-md-8">
            <div class="news-section">
                <h3>Latest News & Updates</h3>

                <div class="news-item">
                    <div class="news-item-date">October 15, 2025</div>
                    <h4 class="news-item-title">
                        <a href="#">New Gene Therapy Trial Browser Launched</a>
                    </h4>
                    <p class="news-item-excerpt">
                        The SCGE Consortium is excited to announce the launch of our comprehensive Gene Therapy Trial Browser,
                        providing researchers and clinicians with access to the latest clinical trial information in genome editing.
                    </p>
                    <a href="#" class="news-item-link">Read more &rarr;</a>
                </div>

<%--                <div class="news-item">--%>
<%--                    <div class="news-item-date">September 28, 2025</div>--%>
<%--                    <h4 class="news-item-title">--%>
<%--                        <a href="#">NIH Awards $140M for Genome Editing Research</a>--%>
<%--                    </h4>--%>
<%--                    <p class="news-item-excerpt">--%>
<%--                        The National Institutes of Health has awarded over $140 million to accelerate genome editing approaches--%>
<%--                        from the lab to the clinic, building upon five years of groundbreaking SCGE Program research.--%>
<%--                    </p>--%>
<%--                    <a href="#" class="news-item-link">Read more &rarr;</a>--%>
<%--                </div>--%>

<%--                <div class="news-item">--%>
<%--                    <div class="news-item-date">August 12, 2025</div>--%>
<%--                    <h4 class="news-item-title">--%>
<%--                        <a href="#">SCGE Annual Meeting Registration Now Open</a>--%>
<%--                    </h4>--%>
<%--                    <p class="news-item-excerpt">--%>
<%--                        Join us for the annual SCGE Consortium Meeting where leading researchers will present the latest--%>
<%--                        advances in somatic cell genome editing technologies and therapeutic applications.--%>
<%--                    </p>--%>
<%--                    <a href="#" class="news-item-link">Read more &rarr;</a>--%>
<%--                </div>--%>

<%--                <div class="news-item">--%>
<%--                    <div class="news-item-date">July 5, 2025</div>--%>
<%--                    <h4 class="news-item-title">--%>
<%--                        <a href="#">New Safety Guidelines for Genome Editing Published</a>--%>
<%--                    </h4>--%>
<%--                    <p class="news-item-excerpt">--%>
<%--                        SCGE researchers have collaborated with the FDA to develop comprehensive safety guidelines for--%>
<%--                        genome editing therapeutics, advancing the path toward clinical applications.--%>
<%--                    </p>--%>
<%--                    <a href="#" class="news-item-link">Read more &rarr;</a>--%>
<%--                </div>--%>
            </div>
        </div><!-- /.col-md-8 -->

        <aside class="col-md-4 blog-sidebar">
            <%--            <div class="p-3 mb-3 bg-light rounded">--%>
            <%--                <h4 class="font-italic">About</h4>--%>
            <%--                <p class="mb-0">The National Institutes of Health (NIH) has awarded over $140 million to help accelerate genome editing approaches from the lab to the clinic. The newly funded projects build upon the work performed though the Somatic Cell Genome Editing (SCGE) Program over the past five years and will focus on translating safe and effective genome editing therapeutics into the clinic.</p>--%>
            <%--            </div>--%>

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
                    <%--                    <li class="nav-item collapse-social-icons-dropdown"><a class="nav-link" href=""><i class="fab fa-facebook mr-1"></i></a></li>--%>
                    <%--                    <li class="nav-item collapse-social-icons-dropdown"><a class="nav-link " href=""><i class="fab fa-instagram mr-1"></i></a></li>--%>
                    <li class="list-group-item"><a href="https://twitter.com/somaticediting" target="_blank" title="twitter"><i class="fa-brands fa-x-twitter"></i></a></li>
                    <li class="list-group-item"><a href="https://www.linkedin.com/company/somatic-cell-genome-editing-consortium/about/" target="_blank" title="LinkedIn"><i class="fab fa-linkedin mr-1"></i></a></li>
                    <li class="list-group-item"><a href="https://www.youtube.com/channel/UCnMSf_YZdv1gIuqPmB6vrYw" target="_blank" title="YouTube"><i class="fab fa-youtube mr-1"></i></a></li>
                </ul>
            </div>
        </aside><!-- /.blog-sidebar -->

    </div><!-- /.row -->

</main><!-- /.container -->