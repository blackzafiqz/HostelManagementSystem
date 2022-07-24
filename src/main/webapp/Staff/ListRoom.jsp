<%-- 
    Document   : ListRoom
    Created on : 21 Jul 2022, 10:11:17 am
    Author     : black
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.hostelmanagementsystem.model.User"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User user = (User) request.getSession().getAttribute("user");
    if (user == null) {
        response.sendRedirect("/Login.jsp");
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
            <%@include file="/Staff/Sidebar.jsp" %>
            <main class="bd-main order-1">
                <h3 class="mt-3">LIST ROOM</h3>
                <div class="bd-content ps-lg-2">
                    <%@include file="/WEB-INF/jspf/Connection.jspf" %>

                    <sql:query dataSource = "${db}" var = "totalQuery">
                        SELECT COUNT(*) as total FROM (SELECT ROOM.id FROM ROOM,OCCUPY WHERE  ROOM.id=OCCUPY.roomID AND OCCUPY.dateIn>='2022-1-1' <%= user.getName().contains("BINTI") ? " AND (block='A' OR block='B')" : " AND (block='C' OR block='D')"%> 
                        GROUP BY ROOM.id
                        HAVING COUNT(ROOM.id)<4) AS x;
                    </sql:query>
                    <c:set var="total" value="${totalQuery.rows[0].total}"/>
                    <c:set var="test" value="test1"/>
<!--                    <p>Total rooms available : ${total}</p>-->
                    <%
                        int total = Integer.parseInt(pageContext.getAttribute("total").toString());
                        int maxPage = (int) Math.ceil((double) total / 10);
                    %>
                    <sql:query dataSource = "${db}" var = "result">
                        SELECT *,(SELECT COUNT(ROOM.id) AS total FROM ROOM,OCCUPY WHERE ROOM.id=OCCUPY.roomID AND OCCUPY.dateIn>='2022-1-1'  AND ROOM.id=r.id
                        GROUP BY ROOM.id) AS total FROM ROOM AS r;
                    </sql:query>
                        <table id="tab" hidden class="table " >
                        <thead>
                            <tr>
                                <th scope="col">Room ID</th>
                                <th scope="col">Number</th>
                                <th scope="col">Block</th>
                                <th scope="col">Level</th>
                                <th scope="col">Resident</th>
                                <th scope="col" ></th>
                            </tr>
                        </thead>
                        <c:forEach var = "row" items = "${result.rows}">
                            <tr>
                                <th scope="row"><c:out value = "${row.id}"/></th>
                                <td><c:out value = "${row.number}"/></td>
                                <td><c:out value = "${row.block}"/></td>
                                <td><c:out value = "${row.level}"/></td>
                                <td><c:out value = "${row.total}"/></td>
                                <td><div class="btn-group" role="group" >
                                        <a href="/Staff/HistoryRoom.jsp?id=${row.id}" role="button" class="btn btn-primary">View</a>
                                <c:if test='${row.total!="4"}'>
                                    <c:out escapeXml="false" value = "<a role=\"button\" href=\"/Staff/RegisterRoom.jsp?number=${row.number}&level=${row.level}&block=${row.block}\" class='btn btn-success'>Register</a>"/>
                                </c:if>
                                    </div></td>
                            </tr>   
                        </c:forEach>
                        <tfoot>
                            <tr>
<!--                                <th scope="col">Room ID</th>
                                <th scope="col">Number</th>
                                <th scope="col">Block</th>
                                <th scope="col">Level</th>
                                <th scope="col">Resident</th>-->
                                <th scope="col"><input class="form-control" type="text"  /></th>
                                <th scope="col"><input class="form-control" type="text"  /></th>
                                <th scope="col"><input class="form-control" type="text"   /></th>
                                <th scope="col"><input class="form-control" type="text"  /></th>
                                <th scope="col"><input class="form-control" type="text"   /></th>
                                
                            </tr>
                        </tfoot>
                    </table>

                </div>
            </main>
        </div>
        <%@include file="/Footer.jsp" %>
        <script>
            $(document).ready(function () {

//                $('#tab tfoot th').each(function () {
//                    var title = $(this).text();
//                    if(title!="Action")
//                    $(this).html('<input class="form-control" type="text" style="width:100%" placeholder="' + title + '" />');
//                });

                // DataTable
                var table = $('#tab').DataTable({
                    initComplete: function () {
                        // Apply the search
                        this.api()
                                .columns()
                                .every(function () {
                                    var that = this;

                                    $('input', this.footer()).on('keyup change clear', function () {
                                        if (that.search() !== this.value) {
                                            that.search(this.value).draw();
                                        }
                                    });
                                });
                    },
                });
                $("#tab").removeAttr("hidden");
            });
            $("#btnRoom").attr("aria-expanded", "true");
            $("#room-collapse").addClass("show");
        </script>
    </body>
</html>
