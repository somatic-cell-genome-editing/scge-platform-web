<%@ page import="edu.mcw.scge.services.SCGEContext" %>
<style>
    /* Logo Blending and Styling */
    .navbar-brand {
        padding: 0;
        margin: 0;
        background: transparent;
    }

    .navbar-brand img {
        max-height: 80px;
        width: auto;
        padding: 10px;
        background: transparent;
        mix-blend-mode: darken;
        transition: transform 0.3s ease, opacity 0.3s ease;
    }

    .navbar-brand:hover img {
        transform: scale(1.05);
        opacity: 0.9;
    }

    /* Make the navbar background seamless with logo */
    nav.navbar.bg-light {
        background-color: #ffffff !important;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    /* Navbar Dropdown Styling */
    .navbar .dropdown-menu {
        border: none;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        border-radius: 8px;
        padding: 10px 0;
        margin-top: 8px;
        min-width: 250px;
    }

    .navbar .dropdown-item {
        padding: 10px 20px;
        font-size: 0.95rem;
        color: #333;
        transition: all 0.2s ease;
    }

    .navbar .dropdown-item:hover {
        background-color: #0066cc;
        color: #ffffff;
        padding-left: 25px;
    }

    .navbar .dropdown-divider {
        margin: 8px 0;
        border-top-color: #e9ecef;
    }

    .navbar .nav-link.dropdown-toggle {
        font-weight: 500;
    }

    .navbar .nav-link.dropdown-toggle:hover {
        color: #0066cc;
    }

    /* Mobile responsiveness for dropdowns */
    @media (max-width: 991px) {
        .navbar .dropdown-menu {
            border: none;
            box-shadow: none;
            padding-left: 15px;
        }

        .navbar-brand img {
            max-height: 60px;
            padding: 8px;
        }
    }
</style>

<nav class="navbar navbar-expand-lg navbar-light bg-light" style="padding:0">
        <div class="container-fluid" style="padding: 0">
            <!-- Brand Logo (Left) -->
            <a class="navbar-brand" href="/platform/home"> <img src="/platform/common/images/SCGE_Platform_logo_5.jpg" srcset="/platform/common/images/SCGE_Platform_logo_5.jpg 1x"  alt="Somatic Cell Gene Editing Logo" data-retina_logo_url="" class="fusion-standard-logo"/></a>

            <!-- Mobile Toggle Button -->
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Navbar Links (Right) -->
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav" style="padding-right: 1%" >
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link" href="/platform/home">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="/platform/public/documents/regulatory">Regulatory Documents</a></li>
                    <li class="nav-item"><a class="nav-link" href="/platform/data/search/ClinicalTrial">Gene Therapy Trial Browser</a></li>
                    <%
                        if(!SCGEContext.isProduction()){
                    %>
                    <li class="nav-item"><a class="nav-link" href="/platform/data/ind/templates">Templates & Forms</a></li>
                    <li class="nav-item"><a class="nav-link" href="/platform/data/ind/forms">Guidance</a></li>
               <%}%>
                </ul>
                <!-- Separator -->
                <div class="navbar-separator"></div>
            </div>



            <%@include file="search/search.jsp"%>

        </div>
    </nav>


