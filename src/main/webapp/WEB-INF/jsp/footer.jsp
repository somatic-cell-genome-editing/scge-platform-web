<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 6/2/2025
  Time: 10:20 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    /* Sticky Footer - Ensures footer sticks to bottom without overlap */
    html {
        height: 100%;
    }

    body {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
        margin: 0;
    }

    /* Main content wrapper should grow to push footer down */
    main, .container, #main-content {
        flex: 1 0 auto;
    }

    footer.site-footer {
        flex-shrink: 0;
        width: 100%;
        background: linear-gradient(135deg, rgb(27, 128, 182) 0%, rgb(20, 100, 150) 100%);
        box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.15);
        margin-top: auto;
    }

    /* Modern Footer Styling */
    .footer-content {
        padding: 50px 0 30px 0;
    }

    .footer-section {
        margin-bottom: 30px;
    }

    .footer-section h5 {
        font-size: 1.3rem;
        font-weight: 700;
        margin-bottom: 25px;
        padding-bottom: 12px;
        border-bottom: 3px solid rgba(255, 255, 255, 0.3);
        display: inline-block;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    /* Footer Links */
    .footer-links {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .footer-links li {
        margin-bottom: 12px;
    }

    .footer-links li a {
        color: rgba(255, 255, 255, 0.9);
        text-decoration: none;
        transition: all 0.3s ease;
        display: inline-block;
        font-size: 0.95rem;
        position: relative;
        padding-left: 0;
    }

    .footer-links li a::before {
        content: '›';
        margin-right: 8px;
        font-size: 1.2rem;
        font-weight: bold;
        opacity: 0;
        transition: all 0.3s ease;
    }

    .footer-links li a:hover {
        color: #ffffff;
        padding-left: 12px;
        text-decoration: none;
    }

    .footer-links li a:hover::before {
        opacity: 1;
    }

    /* Footer Social Media Icons - Match Home Page Style */
    .footer-social-icons {
        display: flex;
        flex-wrap: wrap;
        gap: 12px;
        list-style: none;
        padding: 0;
        margin-top: 15px;
    }

    .footer-social-icons li {
        display: inline-block;
    }

    .footer-social-icons a {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 45px;
        height: 45px;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.15);
        color: #ffffff;
        transition: all 0.3s ease;
        font-size: 1.2rem;
        text-decoration: none;
    }

    .footer-social-icons a:hover {
        background: #ffffff;
        color: rgb(27, 128, 182);
        transform: translateY(-5px) scale(1.1);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.25);
    }

    /* Copyright Section */
    .footer-copyright {
        background: rgba(0, 0, 0, 0.2);
        padding: 20px 0;
        margin-top: 30px;
        border-top: 1px solid rgba(255, 255, 255, 0.15);
    }

    .footer-copyright p {
        margin: 0;
        font-size: 0.9rem;
        color: rgba(255, 255, 255, 0.85);
        line-height: 1.6;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .footer-content {
            padding: 40px 0 20px 0;
        }

        .footer-section {
            margin-bottom: 35px;
            text-align: center;
        }

        .footer-section h5 {
            display: block;
        }

        .footer-social-icons {
            justify-content: center;
        }

        .footer-copyright p {
            font-size: 0.85rem;
        }
    }
</style>

<footer class="site-footer text-white">
  <div class="container footer-content">
    <div class="row">

      <!-- About Section (Empty for now, can be used later) -->
      <div class="col-md-4 footer-section">
        <%--                <h5>About Us</h5>--%>
        <%--                <p>Translational Coordination and Dissemination Center (TCDC) is to support the SCGE Consortium and work cooperatively with all initiatives, projects, and members to facilitate the objectives of the entire SCGE Consortium. The Medical College of Wisconsin (MCW) TCDC will create the infrastructure to develop policies, track progress within the consortium, communicate within and beyond the consortium, develop outreach and educational activities to support the process of moving pre-clinical studies through the regulatory process, into clinical trials, and eventually to the patient. To disseminate data and resources developed within the SCGE Consortium, the SCGE Platform will be assembled to store, query, visualize, and analyze the outcomes of the SCGE initiatives. The MCW TCDC team will facilitate the administrative and management activities to support the overall success of the program.</p>--%>
      </div>

      <!-- Quick Links -->
      <div class="col-md-4 footer-section">
        <h5>Quick Links</h5>
        <ul class="footer-links">
          <li><a href="/platform/home">Home</a></li>
          <li><a href="https://scge.mcw.edu/phase-2-tcdc/">About TCDC</a></li>
          <li><a href="https://scge.mcw.edu/contact/">Contact</a></li>
          <li><a class="nav-link" href="https://creativecommons.org/licenses/by/4.0/" target="_blank">License</a></li>
        </ul>
      </div>

      <!-- Social Media -->
      <div class="col-md-4 footer-section">
        <h5>Follow Us</h5>
        <ul class="footer-social-icons">
          <li><a href="https://twitter.com/somaticediting" target="_blank" title="Twitter"><i class="fa-brands fa-x-twitter"></i></a></li>
          <li><a href="https://www.linkedin.com/company/somatic-cell-genome-editing-consortium/about/" target="_blank" title="LinkedIn"><i class="fab fa-linkedin"></i></a></li>
          <li><a href="https://www.youtube.com/channel/UCnMSf_YZdv1gIuqPmB6vrYw" target="_blank" title="YouTube"><i class="fab fa-youtube"></i></a></li>
        </ul>
      </div>

    </div>
  </div>

  <!-- Copyright -->
  <div class="footer-copyright">
    <div class="container">
      <div class="text-center">
        <p>Copyright &copy; 2024 SCGE Platform | All Rights Reserved | Hosted by the SCGE Consortium</p>
      </div>
    </div>
  </div>
  <%--  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">--%>
  <%--    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>--%>
  <%--    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script> <link rel="stylesheet" href="https://cdn.jsdelivr.net/chartist.js/latest/chartist.min.css">--%>
  <%--    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">--%>
  <%--        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>--%>

</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script> <link rel="stylesheet" href="https://cdn.jsdelivr.net/chartist.js/latest/chartist.min.css">

</body>
</html>
