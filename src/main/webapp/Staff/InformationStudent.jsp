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
			<h3 class="mt-3">STUDENT INFORMATION</h3>
			<div class="bd-content ps-lg-2">

				<div class="container">
					<form id="form" method="post" action="/RoomServlet">
						<div class="row">
							<div class="col-sm-2">
								<label class="col-form-label">Student ID</label>
							</div>
							<div class="col">
								<input type="number" id="studentid" name="studentid" required
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
								<label class="col-form-label">Email</label>
							</div>
							<div class="col">
								<input type="text" id="email" class="form-control" value="" />
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-sm-2">
								<label class="col-form-label">Password</label>
							</div>
							<div class="col">
								<input type="password" id="password" class="form-control"
									value="" />
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-sm-2">
								<label class="col-form-label">Block</label>
							</div>
							<div class="col">
								<input type="text" id="block" required class="form-control"
									value="" />
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-sm-2">
								<label class="col-form-label">Level</label>
							</div>
							<div class="col">
								<input type="number" id="level" required class="form-control"
									value="" />
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-sm-2">
								<label class="col-form-label">Room</label>
							</div>
							<div class="col">
								<input type="number" id="room" required class="form-control"
									value="" />

							</div>
						</div>
						<br>
						<div class="row justify-content-md-end">
							<div class="col col-lg-5 btn-group">
								<button id="uroom" type="button" class="btn btn-danger disabled"
									data-bs-toggle="modal" data-bs-target="#staticBackdrop">
									Unassign room</button>
								<button class="btn-success btn" type="submit" value="submit">Update</button>
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
						<h5 class="modal-title" id="staticBackdropLabel">Unassign
							room</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">Are you sure to unassign this student
						room?</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Cancel</button>
						<button data-bs-dismiss="modal" type="button" id="btnUnassign"
							class="btn btn-danger">Yes</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="/Footer.jsp"%>
	<script>
		$(document).ready(function() {
			$("form").submit(function(event) {
				var formData = {
					level : $("#level").val(),
					room : $("#room").val(),
					block : $("#block").val(),
					submit : "update",
					email : $("#email").val(),
					password : $("#password").val(),

					id : $("#studentid").val()
				};

				$.ajax({
					type : "POST",
					url : "/UserServlet",
					data : formData,
					encode : true,
				}).done(function(data) {
					$("form").hide();
					$("#replace").replaceWith(data);

				});

				event.preventDefault();
			});
			$("#btnUnassign").click(function() {
				var formData = {
					id : $("#studentid").val()
				};
				$.ajax({
					type : "POST",
					url : "/UserServlet",
					data : formData,
					encode : true,
				}).done(function(data) {
					$("form").hide();
					$("#replace").replaceWith(data);
				});
			});
			$("#studentid").keyup(function() {
				var formData = {
					query : "name",
					id : $("#studentid").val()
				};

				$.ajax({
					type : "GET",
					url : "/UserServlet",
					data : formData,
					dataType : 'json',
					encode : true,
				}).done(function(data) {
					$("#name").val(data.name);
					$("#email").val(data.email);
					$("#password").val(data.password);
					if (data.room != null) {
						$("#uroom").removeClass("disabled");
						$("#room").val(data.room.number);
						$("#block").val(data.room.block);
						$("#level").val(data.room.level);
					} else {
						$("#uroom").addClass("disabled");
						$("#room").val("");
						$("#block").val("");
						$("#level").val("");
					}
					console.log(data);
					if (jQuery.isEmptyObject(data)) {
						$("#name").val("");
						$("#email").val("");
						$("#password").val("");
					}
				});
			});
			const urlParams = new URLSearchParams(location.search);
			if (urlParams.has("id")) {
				$("#studentid").val(urlParams.get("id"));
				$("#studentid").trigger("keyup");
			}
			$("#btnStudent").attr("aria-expanded", "true");
			$("#student-collapse").addClass("show");
		});
	</script>
</body>
</html>
