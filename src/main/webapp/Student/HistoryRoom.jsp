<%-- 
    Document   : HistoryRoom
    Created on : 22 Jul 2022, 3:49:59 pm
    Author     : black
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hostelmanagementsystem.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%

    User user = (User) request.getSession().getAttribute("user");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/Login.jsp");
        return;
    }
    int pg = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
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
                <div class="bd-content ps-lg-2">
                    <%@include file="/WEB-INF/jspf/Connection.jspf" %>

                    <sql:query dataSource = "${db}" var = "totalQuery">
                        SELECT COUNT(*) as total FROM ROOM,OCCUPY,USER 
                        WHERE ROOM.id=OCCUPY.roomID AND USER.id=OCCUPY.userID AND USER.id=${user.id};
                    </sql:query>
                    <c:set var="total" value="${totalQuery.rows[0].total}"/>
                    <p>Total rooms registered : ${total}</p>
                    <%
                        int total = Integer.parseInt(pageContext.getAttribute("total").toString());
                        int maxPage = (int) Math.ceil((double) total / 10);
                    %>
                    <sql:query startRow="<%= 0 + ((pg - 1) * 10)%>"  maxRows="10" dataSource = "${db}" var = "result">
                        SELECT ROOM.id,block,number,level,dateIn,dateOut,OCCUPY.id FROM ROOM,OCCUPY,USER 
                        WHERE ROOM.id=OCCUPY.roomID AND USER.id=OCCUPY.userID AND USER.id=${user.id};
                    </sql:query>
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col"></th>
                                <th scope="col">Room Number</th>
                                <th scope="col">Block</th>
                                <th scope="col">Level</th>
                                <th scope="col">Date In</th>
                                <th scope="col">Date Out</th>
                            </tr>
                        </thead>
                        <c:set value="1" var="counter"/>
                        <c:forEach var = "row" items = "${result.rows}">
                            <tr>
                                <th scope="row"><c:out value = "${counter}"/></th>
                                <td><c:out value = "${row.number}"/></td>
                                <td><c:out value = "${row.block}"/></td>
                                <td><c:out value = "${row.level}"/></td>
                                <td><c:out value = "${row.dateIn}"/></td>
                                <td><c:out value = "${row.dateOut}"/></td>
                                <c:set var="counter" value="${counter + 1}"/>
                            </tr>   
                        </c:forEach>
                    </table>
                    <nav aria-label="Page navigation example">
                        <ul class="pagination justify-content-center">
                            <%
                                ArrayList al = new ArrayList();

                                if (pg
                                        <= 3) {
                                    for (int i = 0; i < 5 && i < maxPage; i++) {
                                        al.add(i + 1);
                                    }
                                } else if (pg + 3 > maxPage) {
                                    for (int i = maxPage - 5; i < maxPage; i++) {
                                        al.add(i + 1);
                                    }
                                } else {
                                    al.add(pg - 2);
                                    al.add(pg - 1);
                                    al.add(pg);
                                    al.add(pg + 1);
                                    al.add(pg + 2);
                                }

                                pageContext.setAttribute(
                                        "pages", al);
                                pageContext.setAttribute(
                                        "currentPage", pg);
                            %>
                            <li class="page-item <%= pg == 1 ? "disabled" : ""%>">
                                <a class="page-link" href="<% out.print(request.getContextPath());%>/Student/ListRoom.jsp?page=<c:out value="${currentPage-1}"/>">Previous</a>
                            </li>
                            <c:forEach var="pg" items="${pages}">
                                <li class="page-item <c:if test="${currentPage==pg}"><c:out value = "disabled"/></c:if>"><a class="page-link" href="<% out.print(request.getContextPath());%>/Student/ListRoom.jsp?page=<c:out value="${pg}"/>"><c:out value="${pg}"/></a></li>
                                </c:forEach>
                            <li class="page-item <%= pg == maxPage ? "disabled" : ""%>">
                                <a class="page-link" href="<% out.print(request.getContextPath());%>/Student/ListRoom.jsp?page=<c:out value="${currentPage+1}"/>">Next</a>
                            </li>
                        </ul>
                    </nav>
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
