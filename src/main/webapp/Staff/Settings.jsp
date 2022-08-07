<%-- 
    Document   : Settings
    Created on : 23 Jul 2022, 2:13:00 am
    Author     : black
--%>

<%@page import="com.hostelmanagementsystem.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    User user = (User) request.getSession().getAttribute("user");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/Login.jsp");
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
    </head>
    <body>
        <header class="navbar navbar-expand-lg navbar-dark bd-navbar sticky-top" style="background-color:#712cf9">
            <nav class="container-xxl  bd-gutter flex-wrap flex-lg-nowrap">
                <h1 class="navbar-brand p-0 me-0 me-lg-2" >HOSTEL MANAGEMENT SYSTEM</h1>
                <p class="d-flex navbar-brand "><%=user.getName()%></p>
            </nav>
        </header>
        <div class="container-xxl bd-gutter bd-layout">
            <%@include file= "/Student/Sidebar.jsp" %>
            <main class="bd-main order-1">
                <h3 class="mt-3">USER SETTINGS</h3>
                <div class="bd-content ps-lg-2">
                    <div class="container">
                        <form id="form" method="post" action="/UserServlet">
                            <div class="row">
                                <div class="col-sm-2">
                                    <label class="col-form-label">Staff ID</label>
                                </div>
                                <div class="col">
                                    <input type="text" id="id" class="form-control-plaintext" readonly value="${user.id}"/>
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
                                    <label class="col-form-label">Role</label>
                                </div>
                                <div class="col">
                                    <input id="role" type="text" value="${user.role}" readonly class="form-control-plaintext"/>
                                </div>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-sm-2">
                                    <label class="col-form-label">Email</label>
                                </div>
                                <div class="col">
                                    <input id="email" type="email" value="${user.email}" class="form-control"/>
                                </div>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-sm-2">
                                    <label class="col-form-label">Password</label>
                                </div>
                                <div class="col">
                                    <input id="password" type="password" required class="form-control"/>
                                </div>
                            </div>
                            <div id="replace"></div>
                            <br>
                            <div class="row justify-content-md-end">
                                <div class="col col-sm-2">
                                    <button class="btn-success btn" required type="submit">Update</button>
                                </div>
                            </div>
                        </form>
                        
                    </div>

                </div>
            </main>
        </div>
        <%@include file="/Footer.jsp" %>
        <script>
            $(document).ready(function () {
                $("form").submit(function (event) {
                    var formData = {
                        id:$("#id").val(),
                        email: $("#email").val(),
                        password: $("#password").val(),
                        submit: "update"
                    };

                    $.ajax({
                        type: "POST",
                        url: "/UserServlet",
                        data: formData,
                        encode: true,
                    }).done(function (data) {
                        $("#replace").replaceWith(data);

                    });

                    event.preventDefault();
                });
                $("#btnAccount").attr("aria-expanded", "true");
                $("#account-collapse").addClass("show");
            });
        </script>
    </body>
</html>
