<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 5/13/2024
  Time: 4:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    /* Modern Sidebar Menu Styling */
    .forms-menu-container {
        background: #ffffff;
        border-radius: 12px;
        padding: 25px 20px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        position: sticky;
        top: 20px;
        max-height: calc(100vh - 100px);
        overflow-y: auto;
    }

    .forms-menu-container h4 {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        font-size: 1.4rem;
        font-weight: 700;
        color: #003366;
        margin-bottom: 25px;
        padding-bottom: 15px;
        border-bottom: 3px solid #0066cc;
    }

    .forms-menu-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .forms-menu-list p {
        margin: 0;
    }

    .forms-menu-list a {
        display: block;
        padding: 12px 15px;
        color: #333;
        text-decoration: none;
        font-size: 0.95rem;
        font-weight: 500;
        border-radius: 8px;
        transition: all 0.3s ease;
        position: relative;
        margin-bottom: 8px;
    }

    .forms-menu-list a::before {
        content: '›';
        position: absolute;
        left: -5px;
        opacity: 0;
        transition: all 0.3s ease;
        font-weight: bold;
        font-size: 1.3rem;
        color: #0066cc;
    }

    .forms-menu-list a:hover {
        background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
        color: #0066cc;
        padding-left: 25px;
        transform: translateX(5px);
    }

    .forms-menu-list a:hover::before {
        opacity: 1;
        left: 10px;
    }

    .forms-menu-list a.active {
        background: linear-gradient(135deg, #0066cc 0%, #004499 100%);
        color: #ffffff;
        font-weight: 600;
    }

    /* Custom Scrollbar for Menu */
    .forms-menu-container::-webkit-scrollbar {
        width: 6px;
    }

    .forms-menu-container::-webkit-scrollbar-track {
        background: #f1f1f1;
        border-radius: 10px;
    }

    .forms-menu-container::-webkit-scrollbar-thumb {
        background: #0066cc;
        border-radius: 10px;
    }

    .forms-menu-container::-webkit-scrollbar-thumb:hover {
        background: #004499;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .forms-menu-container {
            position: relative;
            top: 0;
            margin-bottom: 30px;
            max-height: none;
        }

        .forms-menu-container h4 {
            font-size: 1.2rem;
        }

        .forms-menu-list a {
            font-size: 0.9rem;
            padding: 10px 12px;
        }
    }
</style>

<div class="forms-menu-container">
    <h4>Contents</h4>
    <div class="forms-menu-list">
        <p><a href="#clinical-path">FDA's Clinical Path</a></p>
        <p><a href="#ind-def">What is IND?</a></p>
        <p><a href="#ind-types">IND Types</a></p>
        <p><a href="#ind-categories">IND Categories</a></p>
        <p><a href="#ind-meetings">IND Meetings</a></p>
        <p><a href="#timing-pre-ind">Pre-IND Meeting</a></p>
        <p><a href="#ind-content-format">IND Content and Format</a></p>
        <p><a href="#ind-submission">Submission of an IND</a></p>
        <p><a href="#fda-review-time">FDA's Review Time</a></p>
    </div>
</div>