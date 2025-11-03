<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 1/4/2024
  Time: 3:31 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link href="/platform/css/home.css" rel="stylesheet" type="text/css"/>


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