<%-- 
    Document   : HistoryRoom
    Created on : 22 Jul 2022, 3:49:59 pm
    Author     : black
--%>
<%@page import="com.hotelmanagementsystem.dao.RoomDAO"%>
<%@page import="com.hostelmanagementsystem.model.Room"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hostelmanagementsystem.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%

    User user = (User) request.getSession().getAttribute("user");

    if (user == null) {
        response.sendRedirect("/Login.jsp");
        return;
    }
    int pg = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
    boolean t = request.getParameter("id") != null;
    if (t) {
        pageContext.setAttribute("id", request.getParameter("id"));
        Room room = new RoomDAO().Read(Integer.parseInt(request.getParameter("id")));
        if (room != null) {
            pageContext.setAttribute("number", room.getNumber());
            pageContext.setAttribute("level", room.getLevel());
            pageContext.setAttribute("block", room.getBlock());
        }

    }
    pageContext.setAttribute("test", t);
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
            <%@include file="/Staff/Sidebar.jsp" %>
            <main class="bd-main order-1">
                <h3 class="mt-3">ROOM DATA</h3>
                <div class="bd-content ps-lg-2">
                    <%@include file="/WEB-INF/jspf/Connection.jspf" %>
                    <form method="get">
                        <div class="row">
                            <div class="col-sm-2">
                                <label class="col-form-label">Room ID</label>
                            </div>
                            <div class="col-sm-2">
                                <input type="number" name="id" class="form-control" value="${id}"/>
                            </div>
                            <div class="col-sm-2">
                                <button type="submit" class="form-control">Search</button>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-2">
                                <label class="col-form-label">Room Number</label>
                            </div>
                            <div class="col-sm-2">
                                <input type="number" name="id" class="form-control-plaintext" readonly value="${number}"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-2">
                                <label class="col-form-label">Level</label>
                            </div>
                            <div class="col-sm-2">
                                <input type="number" name="id" class="form-control-plaintext" readonly value="${level}"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-2">
                                <label class="col-form-label">Block</label>
                            </div>
                            <div class="col-sm-2">
                                <input type="text" name="id" class="form-control-plaintext" readonly value="${block}"/>
                            </div>
                        </div>
                    </form>
                    <c:if test="${test}">
                        <sql:query dataSource = "${db}" var = "totalQuery">
                            SELECT count(*) as total FROM ROOM,OCCUPY,USER                                                       
                            WHERE ROOM.id=OCCUPY.roomID AND USER.id=OCCUPY.userID AND OCCUPY.dateIn>='2022-1-1' AND  ROOM.id=${id}
                        </sql:query>
                        <c:set var="total" value="${totalQuery.rows[0].total}"/>
                        <%
                            int total = Integer.parseInt(pageContext.getAttribute("total").toString());
                            int maxPage = (int) Math.ceil((double) total / 10);
                        %>
                        <sql:query startRow="<%= 0 + ((pg - 1) * 10)%>"  maxRows="10" dataSource = "${db}" var = "result">
                            SELECT USER.id,name,email FROM ROOM,OCCUPY,USER                                                       
                            WHERE ROOM.id=OCCUPY.roomID AND USER.id=OCCUPY.userID AND  ROOM.id=${id}  AND OCCUPY.dateIn>='2022-1-1' ;
                        </sql:query>
                    </c:if>
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col"></th>
                                <th scope="col">Student ID</th>
                                <th scope="col">Name</th>
                                <th scope="col">Email</th>
                            </tr>
                        </thead>
                        <c:set value="1" var="counter"/>
                        <c:forEach var = "row" items = "${result.rows}">
                            <tr>
                                <th scope="row"><c:out value = "${counter}"/></th>
                                <td><c:out value = "${row.id}"/></td>
                                <td><c:out value = "${row.name}"/></td>
                                <td><c:out value = "${row.email}"/></td>
                                <c:set var="counter" value="${counter + 1}"/>
                            </tr>   
                        </c:forEach>
                    </table>

                </div>
            </main>
        </div>
        <%@include file="/Footer.jsp" %>
        <script>
            $("#btnRoom").attr("aria-expanded", "true");
            $("#room-collapse").addClass("show");
        </script>
    </body>
</html>
