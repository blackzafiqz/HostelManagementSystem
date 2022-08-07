<%-- 
    Document   : InformationStudent
    Created on : 24 Jul 2022, 5:03:23 am
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

%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/Header.jsp"%>
<title>JSP Page</title>
<link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css"
	rel="stylesheet">
<link href="/css/sidebars.css" rel="stylesheet">
</head>
<body>
	<header
		class="navbar navbar-expand-lg navbar-dark bd-navbar sticky-top"
		style="background-color: #712cf9">
		<nav class="container-xxl  bd-gutter flex-wrap flex-lg-nowrap">
			<h1 class="navbar-brand p-0 me-0 me-lg-2">HOSTEL MANAGEMENT
				SYSTEM</h1>
			<p class="d-flex navbar-brand "><%=user.getName()%></p>
		</nav>
	</header>
	<div class="container-xxl bd-gutter bd-layout">
		<%@include file= "/Staff/Sidebar.jsp"%>
		<main class="bd-main order-1">
			<h3 class="mt-3">Leave Information</h3>
			<div class="bd-content ps-lg-2">

				<div class="container">
					<form id="form">
						<div class="row">
							<div class="col-sm-2">
								<label class="col-form-label">Leave ID</label>
							</div>
							<div class="col">
								<input type="number" id="leaveid" name="studentid" required
									class="form-control" value="" />
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-sm-2">
								<label class="col-form-label">Name</label>
							</div>
							<div class="col">
								<input type="text" id="name" class="form-control-plaintext"
									readonly value="" />
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-sm-2">
								<label class="col-form-label">Description</label>
							</div>
							<div class="col">
								<input type="text" id="description" class="form-control" value="" />
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-sm-2">
								<label class="col-form-label">Approval</label>
							</div>
							<div class="col">
								<select class="form-control" id="approval">
								<option value="Approved">Approved</option>
								<option value="Rejected">Rejected</option>
								</select>
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-sm-2">
								<label class="col-form-label">Date Out</label>
							</div>
							<div class="col">
								<input type="date" id="dateout" required class="form-control"
									value="" />
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-sm-2">
								<label class="col-form-label">Date In</label>
							</div>
							<div class="col">
								<input type="date" id="datein" required class="form-control"
									value="" />
							</div>
						</div>
						<br>
						<div class="row justify-content-md-end">
							<div class="col col-lg-5 btn-group">
								<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
									Update</button>
							</div>
						</div>
					</form>
					<div id="replace"></div>
				</div>

			</div>
		</main>
		<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
			data-bs-keyboard="false" tabindex="-1"
			aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="staticBackdropLabel">Update approval</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">Are you sure to update this approval?</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Cancel</button>
						<button data-bs-dismiss="modal" type="button" id="btnUnassign" class="btn btn-danger">Yes</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="/Footer.jsp"%>
	<script>
            $(document).ready(function () {
                
                $("#btnUnassign").click(function (){
                	var formData={
                			id:$("#leaveid").val(),
                			description:$("#description").val(),
                			datein:$("#datein").val(),
                			approval:$("#approval").val(),
                			dateout:$("#dateout").val()
                	};
                	$.ajax({
                		type: "POST",
                        url: "/LeaveServlet",
                        data: formData,
                        encode: true,
                    }).done(function (data) {
                    	$("#form").hide();
                        $("#replace").replaceWith(data);
                        
                    });
                });
                $("#leaveid").keyup(function () {
                    var formData = {
                        id: $("#leaveid").val()
                    };

                    $.ajax({
                        type: "GET",
                        url: "/LeaveServlet",
                        data: formData,
                        dataType: 'json',
                        encode: true,
                    }).done(function (data) {
                        $("#description").val(data.leave.description);
                        $("#approval").val(data.leave.approval);
                        $("#datein").val(new Date(data.leave.dateIn).toISOString().split('T')[0]);
                        $("#name").val(data.name);
                        $("#dateout").val(new Date(data.leave.dateOut).toISOString().split('T')[0]);
                    });
                });
                const urlParams = new URLSearchParams(location.search);
                if(urlParams.has("id"))
                	{
                	$("#leaveid").val(urlParams.get("id"));
                	$("#leaveid").trigger("keyup");
                	}
                $("#btnLeave").attr("aria-expanded", "true");
                $("#leave-collapse").addClass("show");
            });
            
        </script>
</body>
</html>
