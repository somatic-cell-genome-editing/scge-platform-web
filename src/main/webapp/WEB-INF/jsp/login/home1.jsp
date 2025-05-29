<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 6/14/2024
  Time: 9:32 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dashboard</title>

    <style>

        @media (max-width: 767.98px) {
            .sidebar {
                top: 11.5rem;
                padding: 0;
            }
        }

        .navbar {
            box-shadow: inset 0 -1px 0 rgba(0, 0, 0, .1);
        }

        @media (min-width: 767.98px) {
            .navbar {
                top: 0;
                position: sticky;
                z-index: 999;
            }
        }

        .sidebar .nav-link {
            color: #333;
        }

        .sidebar .nav-link.active {
            color: #0d6efd;
        }

    </style>
</head>
<body>
<%
    Map<Integer, List<Application>> applicationsMap= (Map<Integer, List<Application>>) request.getAttribute("applicationsMap");
    int applicationsCount=0;
    for(int key:applicationsMap.keySet()){
        applicationsCount+=((List<Application>)applicationsMap.get(key)).size();
    }
%>

<div class="container-fluid">
    <div class="row">
        <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
            <!-- sidebar content goes in here -->
            <div class="position-sticky pt-md-5">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-home"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
                            <span class="ml-2">Dashboard</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <span style="font-size: large"><i class="fa-brands fa-app-store"></i></span><span class="ml-2">Applications</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-file"><path d="M13 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V9z"></path><polyline points="13 2 13 9 20 9"></polyline></svg>
                            <span class="ml-2">Documents</span>
                        </a>
                    </li>
                    <li class="nav-item">&nbsp;</li>
                    <li class="nav-item">
                        <a href="/platform/ind/application/new"><button class="btn btn-primary">Create Application</button></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"> <i class="fa-solid fa-folder-open"></i>  Applications</a>
                        <ul class="nav flex-column">
                            <%
                                for(int key:applicationsMap.keySet()){
                                    for(Application app:applicationsMap.get(key)){%>
                            <li class="nav-item"><a class="nav-link" href="/platform/ind/application/<%=app.getApplicationId()%>"><%=app.getApplicationId()%>_<%=app.getSponsorName()%></a> </li>
                            <%}}%>
                        </ul>
                    </li>
                    <%--                    <li class="nav-item">--%>
                    <%--                        <a class="nav-link" href="#">--%>
                    <%--                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-users"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>--%>
                    <%--                            <span class="ml-2">Customers</span>--%>
                    <%--                        </a>--%>
                    <%--                    </li>--%>
                    <%--                    <li class="nav-item">--%>
                    <%--                        <a class="nav-link" href="#">--%>
                    <%--                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-bar-chart-2"><line x1="18" y1="20" x2="18" y2="10"></line><line x1="12" y1="20" x2="12" y2="4"></line><line x1="6" y1="20" x2="6" y2="14"></line></svg>--%>
                    <%--                            <span class="ml-2">Reports</span>--%>
                    <%--                        </a>--%>
                    <%--                    </li>--%>
                    <%--                    <li class="nav-item">--%>
                    <%--                        <a class="nav-link" href="#">--%>
                    <%--                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-layers"><polygon points="12 2 2 7 12 12 22 7 12 2"></polygon><polyline points="2 17 12 22 22 17"></polyline><polyline points="2 12 12 17 22 12"></polyline></svg>--%>
                    <%--                            <span class="ml-2">Integrations</span>--%>
                    <%--                        </a>--%>
                    <%--                    </li>--%>
                    <%--                    <li class="nav-item">&nbsp;</li>--%>
                    <%--                    <li class="nav-item">&nbsp;</li>--%>
                    <%--                    <li class="nav-item">--%>

                    <%--                            <ul class="progress">--%>
                    <%--                                <li class="active"></li>--%>
                    <%--                                <li style="background-color: white;padding-left: 20px">In Progress</li>--%>
                    <%--                            </ul>--%>
                    <%--                            <ul class="progress">--%>
                    <%--                                <li style="background-color:green "></li>--%>
                    <%--                                <li style="background-color: white;padding-left: 20px">Completed</li>--%>
                    <%--                            </ul>--%>

                    <%--                    </li>--%>
                </ul>
            </div>

        </nav>
        <main class="col-md-9 ml-sm-auto col-lg-10 px-md-4 py-4">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Overview</li>
                </ol>
            </nav>
            <h1 class="h2">Dashboard</h1>
            <p>Overview of Investigational New Drug (IND) Application Submission Progress </p>
            <div>
                <%@include file="progressbar.jsp"%>
            </div>
            <div class="row my-4">
                <div class="col-12 col-md-6 col-lg-3 mb-4 mb-lg-0">
                    <div class="card">
                        <h5 class="card-header">Applications</h5>
                        <div class="card-body">
                            <h5 class="card-title"><%=applicationsCount%></h5>
                            <p class="card-text">05 June 2024</p>
                            <%
                                if(applicationsCount>0){
                            %>
                            <p class="card-text text-success" style="font-weight: bold"><%=applicationsCount%> Applications in progress</p>
                            <%}else{%>
                            <p class="card-text text-danger"><%=applicationsCount%> Applications in progress</p>
                            <%}%>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6 mb-4 mb-lg-0 col-lg-3">
                    <div class="card">
                        <h5 class="card-header">Documents</h5>
                        <div class="card-body">
                            <h5 class="card-title">0</h5>
                            <p class="card-text">05 June 2024</p>
                            <p class="card-text text-danger">0 documents uploaded</p>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6 mb-4 mb-lg-0 col-lg-3">
                    <div class="card">
                        <h5 class="card-header">FDA Responses</h5>
                        <div class="card-body">
                            <h5 class="card-title">0</h5>
                            <p class="card-text">05 June 2024</p>
                            <p class="card-text text-danger">0 documents uploaded</p>
                        </div>
                    </div>
                </div>
                <%--                <div class="col-12 col-md-6 mb-4 mb-lg-0 col-lg-3">--%>
                <%--                    <div class="card">--%>
                <%--                        <h5 class="card-header">Module 1</h5>--%>
                <%--                        <div class="card-body">--%>
                <%--                            <h5 class="card-title">0</h5>--%>
                <%--                            <p class="card-text">05 June 2024</p>--%>
                <%--                            <p class="card-text text-danger">0 documents uploaded</p>--%>
                <%--                        </div>--%>
                <%--                    </div>--%>
                <%--                </div>--%>
                <%--                <div class="col-12 col-md-6 mb-4 mb-lg-0 col-lg-3">--%>
                <%--                    <div class="card">--%>
                <%--                        <h5 class="card-header">Module 2</h5>--%>
                <%--                        <div class="card-body">--%>
                <%--                            <h5 class="card-title">0</h5>--%>
                <%--                            <p class="card-text">05 June 2024</p>--%>
                <%--                            <p class="card-text text-danger">0 documents uploaded</p>--%>
                <%--                        </div>--%>
                <%--                    </div>--%>
                <%--                </div>--%>
            </div>
            <%--            <div class="row my-4">--%>

            <%--                <div class="col-12 col-md-6 mb-4 mb-lg-0 col-lg-3">--%>
            <%--                    <div class="card">--%>
            <%--                        <h5 class="card-header">Module 3</h5>--%>
            <%--                        <div class="card-body">--%>
            <%--                            <h5 class="card-title">0</h5>--%>
            <%--                            <p class="card-text">05 June 2024</p>--%>
            <%--                            <p class="card-text text-danger">0 documents uploaded</p>--%>
            <%--                        </div>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--                <div class="col-12 col-md-6 mb-4 mb-lg-0 col-lg-3">--%>
            <%--                    <div class="card">--%>
            <%--                        <h5 class="card-header">Module 4</h5>--%>
            <%--                        <div class="card-body">--%>
            <%--                            <h5 class="card-title">0</h5>--%>
            <%--                            <p class="card-text">05 June 2024</p>--%>
            <%--                            <p class="card-text text-danger">0 documents uploaded</p>--%>
            <%--                        </div>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--                <div class="col-12 col-md-6 mb-4 mb-lg-0 col-lg-3">--%>
            <%--                    <div class="card">--%>
            <%--                        <h5 class="card-header">Module 5</h5>--%>
            <%--                        <div class="card-body">--%>
            <%--                            <h5 class="card-title">0</h5>--%>
            <%--                            <p class="card-text">05 June 2024</p>--%>
            <%--                            <p class="card-text text-danger">0 documents uploaded</p>--%>
            <%--                        </div>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--                <div class="col-12 col-md-6 mb-4 mb-lg-0 col-lg-3">--%>
            <%--                    <div class="card">--%>
            <%--                        <h5 class="card-header">FDA Responses</h5>--%>
            <%--                        <div class="card-body">--%>
            <%--                            <h5 class="card-title">0</h5>--%>
            <%--                            <p class="card-text">05 June 2024</p>--%>
            <%--                            <p class="card-text text-danger">0 documents uploaded</p>--%>
            <%--                        </div>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </div>--%>

            <div class="row">
                <div class="col-12 col-xl-8 mb-4 mb-lg-0">
                    <div class="card">
                        <h5 class="card-header">eCTD v4.0 Comprehensive Table of Contents Headings and Hierarchy</h5>
                        <div class="card-body">
                            <div class="table-responsive">
                                <%@include file="../ctd/ctdTable.jsp"%>
                            </div>
                            <%--                            <a href="#" class="btn btn-block btn-light">View all</a>--%>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-xl-4">
                    <!-- Another widget will go here -->
                    <div class="card">
                        <h5 class="card-header">Submissions last 6 months</h5>
                        <div class="card-body">
                            <div id="submission-chart"></div>
                        </div>
                    </div>
                    <div class="card">
                        <h5 class="card-header">IND Application Modules</h5>
                        <div class="card-body">
                            <div ><img src="common/images/modules.png" alt="IND Modules" width="100%"> </div>
                        </div>
                    </div>
                </div>
            </div>

        </main>
    </div>
</div>
<script>
    new Chartist.Line('#submission-chart', {
        labels: ['January', 'Februrary', 'March', 'April', 'May', 'June'],
        series: [
            [23, 25, 19, 34, 56, 64]
        ]
    }, {
        low: 0,
        showArea: true
    });
</script>
</body>
</html>
