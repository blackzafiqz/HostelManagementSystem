<%-- 
    Document   : index
    Created on : 21 Jul 2022, 12:14:34 am
    Author     : black
--%>

<%@page import="com.hostelmanagementsystem.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User user = (User) request.getSession().getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.request.getContextPath() + "/Login.jsp");
        return;
    } else if (user.getRole().equals("Student")) {
        request.getRequestDispatcher(request.request.getContextPath() + "/Student/Student.jsp").forward(request, response);
    } else {
        request.getRequestDispatcher(request.request.getContextPath() + "/Staff/Staff.jsp").forward(request, response);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
