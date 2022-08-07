<%-- 
    Document   : RegisterRoom
    Created on : 22 Jul 2022, 12:59:01 am
    Author     : black
--%>

<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Date"%>
<%@page import="com.hostelmanagementsystem.dao.OccupyDAO"%>
<%@page import="com.hostelmanagementsystem.model.Occupy"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hostelmanagementsystem.model.Room"%>
<%@page import="com.hostelmanagementsystem.dao.RoomDAO"%>
<%@page import="com.hostelmanagementsystem.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    User user = (User) request.getSession().getAttribute("user");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/Login.jsp");
        return;
    }
    boolean occupy = false;
    Calendar c = new GregorianCalendar();
    c.set(2021, 11, 31);
    Date d = new Date(c.getTime().getTime());
    for (Occupy o : new OccupyDAO().Read()) {
        if (o.getUserID() == user.getId() && o.getDateIn().compareTo(d) > 0) {
            occupy = true;
        }
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
                <h3 class="mt-3">ROOM REGISTRATION</h3>
                <div class="bd-content ps-lg-2">

                    <div class="container">
                        <%=occupy ? "<p style=\"color:red\">You are already registered</p>" : ""%>
                        <form id="form" method="post" action="/RoomServlet">
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
                                    <label class="col-form-label">Block</label>
                                </div>
                                <div class="col">

                                    <select id="block" name="block" class="form-control" <%=occupy ? "disabled" : ""%> onchange="showLevel(this.value)">
                                        <option hidden>Select Block</option>
                                        <%
                                            ArrayList<String> blocks = new ArrayList<String>();
                                            for (Room room : user.getName().contains("BINTI") ? new RoomDAO().ReadAvailableFemale() : new RoomDAO().ReadAvailableMale()) {
                                                if (!blocks.contains(room.getBlock())) {
                                                    blocks.add(room.getBlock());
                                                }
                                            }
                                            for (String b : blocks)
                                                out.println(String.format("<option value='%s'>%s</option>", b, b));
                                        %>
                                    </select>
                                </div>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-sm-2">
                                    <label class="col-form-label">Level</label>
                                </div>
                                <div class="col">
                                    <select id="level" name="level" class="form-control" <%=occupy ? "disabled" : ""%>  onchange="showRoom(this.value)">
                                        <option hidden>Select Level</option>
                                    </select>

                                </div>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-sm-2">
                                    <label class="col-form-label">Room</label>
                                </div>
                                <div class="col">
                                    <select id="room" name="room" class="form-control " <%=occupy ? "disabled" : ""%>>
                                        <option hidden>Select Room</option>
                                    </select>

                                </div>
                            </div>
                            <br>
                            <div class="row justify-content-md-end">
                                <div class="col col-sm-2">
                                    <button class="btn-success btn <%=occupy ? "disabled" : ""%>" type="submit" value="submit">Register</button>
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
                        level: $("#level").val(),
                        room: $("#room").val(),
                        block: $("#block").val(),
                        submit: "register"
                    };

                    $.ajax({
                        type: "POST",
                        url: "/RoomServlet",
                        data: formData,
                        encode: true,
                    }).done(function (data) {
                        $("form").hide();
                        $("#replace").replaceWith(data);

                    });

                    event.preventDefault();
                });
                $("#btnRoom").attr("aria-expanded","true");
                $("#room-collapse").addClass("show");
            });
            function showLevel(str) {
                if (str == "") {
                    document.getElementById("level").innerHTML = "";
                    return;
                }
                const xhttp = new XMLHttpRequest();
                xhttp.onload = function () {
                    document.getElementById("level").innerHTML = "<option hidden>Select Level</option>" + this.responseText;
                }
                $("#room").empty();
                $("#level").empty();
                document.getElementById("room").innerHTML = "<option hidden>Select Room</option>";
                xhttp.open("GET", "/RoomServlet?block=" + str + "&gender=" + "${user.getName().contains("BINTI") ? "female":"male"}");
                xhttp.send();
            }
            function showRoom(str) {
                if (str == "") {
                    document.getElementById("room").innerHTML = "";
                    return;
                }
                const xhttp = new XMLHttpRequest();
                xhttp.onload = function () {
                    document.getElementById("room").innerHTML = "<option hidden>Select Room</option>" + this.responseText;
                }
                xhttp.open("GET", "/RoomServlet?level=" + str + "&gender=" + "${user.getName().contains("BINTI") ? "female":"male"}" + "&block=" + document.getElementById("block").value);
                xhttp.send();
            }
        </script>
    </body>
</html>
