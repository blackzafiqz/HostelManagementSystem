<%-- 
    Document   : ApplyLeave
    Created on : 22 Jul 2022, 11:47:54 pm
    Author     : black
--%>

<%@page import="com.hostelmanagementsystem.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    User user = (User) request.getSession().getAttribute("user");

    if (user == null) {
        response.sendRedirect("/Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/Header.jsp" %>
        <title>JSP Page</title>
        <link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">
        <link href="/css/sidebars.css" rel="stylesheet">
                <script>
            $(document).ready(function () {
                $("#btnLeave").attr("aria-expanded", "true");
                $("#leave-collapse").addClass("show");
            });
        </script>
    </head>
    <body>
        <header class="navbar navbar-expand-lg navbar-dark bd-navbar sticky-top" style="background-color:#712cf9">
            <nav class="container-xxl  bd-gutter flex-wrap flex-lg-nowrap">
                <h1 class="navbar-brand p-0 me-0 me-lg-2" >HOSTEL MANAGEMENT SYSTEM</h1>
                <p class="d-flex navbar-brand "><%=user.getName()%></p>
            </nav>
        </header>
        <div class="container-xxl bd-gutter bd-layout">
            <%@include file="/Student/Sidebar.jsp" %>
            <main class="bd-main order-1">
                <h3 class="mt-3">APPLY LEAVE</h3>
                <div class="bd-content ps-lg-2">
                    <div class="container">
                        <form id="form" method="post" action="/LeaveServlet">
                            <div class="row">
                                <div class="col-sm-2">
                                    <label class="col-form-label">Student ID</label>
                                </div>
                                <div class="col">
                                    <input type="text" name="id" class="form-control-plaintext" readonly value="${user.id}"/>
                                </div>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-sm-2">
                                    <label class="col-form-label">Name</label>
                                </div>
                                <div class="col">
                                    <input type="text" class="form-control-plaintext" readonly value="${user.name}"/>
                                </div>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-sm-2">
                                    <label class="col-form-label">Description</label>
                                </div>
                                <div class="col">
                                    <textarea id="description" class="form-control"></textarea>
                                </div>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-sm-2">
                                    <label class="col-form-label">Date Out</label>
                                </div>
                                <div class="col">
                                    <input id="dateOut" type="date" class="form-control"/>
                                </div>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-sm-2">
                                    <label class="col-form-label">Date In</label>
                                </div>
                                <div class="col">
                                    <input id="dateIn" type="date" class="form-control"/>
                                </div>
                            </div>
                            <br>
                            <div class="row justify-content-md-end">
                                <div class="col col-sm-2">
                                    <button class="btn-success btn" type="submit">Register</button>
                                </div>
                            </div>
                        </form>
                        <div id="replace"></div>
                    </div>

                </div>
            </main>
        </div>
        <%@include file="/Footer.jsp" %>
        <script>
            $(document).ready(function () {
                $("form").submit(function (event) {
                    var formData = {
                        description: $("#description").val(),
                        dateOut: $("#dateOut").val(),
                        dateIn: $("#dateIn").val(),
                        submit: "register"
                    };

                    $.ajax({
                        type: "POST",
                        url: "/LeaveServlet",
                        data: formData,
                        encode: true,
                    }).done(function (data) {
                        $("form").hide();
                        $("#replace").replaceWith(data);

                    });
            $("#btnLeave").attr("aria-expanded", "true");
            $("#leave-collapse").addClass("show");
                    event.preventDefault();
                });
            });
        </script>
    </body>
</html>
