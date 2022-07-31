/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.hostelmanagementsystem.controller;

import com.hostelmanagementsystem.model.Leave;
import com.hostelmanagementsystem.model.Occupy;
import com.hostelmanagementsystem.model.User;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hostelmanagementsystem.dao.LeaveDAO;
import com.hostelmanagementsystem.dao.OccupyDAO;
import com.hostelmanagementsystem.dao.UserDAO;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author black
 */
public class LeaveServlet extends HttpServlet {

	/**
	 * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
	 * methods.
	 *
	 * @param request  servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException      if an I/O error occurs
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			/* TODO output your page here. You may use following sample code. */
			out.println("<!DOCTYPE html>");
			out.println("<html>");
			out.println("<head>");
			out.println("<title>Servlet LeaveServlet</title>");
			out.println("</head>");
			out.println("<body>");
			out.println("<h1>Servlet LeaveServlet at " + request.getContextPath() + "</h1>");
			out.println("</body>");
			out.println("</html>");
		}
	}

	// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
	// + sign on the left to edit the code.">
	/**
	 * Handles the HTTP <code>GET</code> method.
	 *
	 * @param request  servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException      if an I/O error occurs
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		var id = Integer.parseInt(request.getParameter("id"));
		var leave = new LeaveDAO().Read(id);
		var occupy = new OccupyDAO().Read(leave.getOccupyId());
		var user = new UserDAO().Read(occupy.getUserID());
		user.setOccupy(occupy);
		user.setLeave(leave);
		try (PrintWriter out = response.getWriter()) {
			ObjectMapper mapper = new ObjectMapper();
			out.print(mapper.writeValueAsString(user));
		}

	}

	/**
	 * Handles the HTTP <code>POST</code> method.
	 *
	 * @param request  servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException      if an I/O error occurs
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try (PrintWriter out = response.getWriter()) {
			if (request.getParameter("submit") != null) {
				var submit = request.getParameter("submit");

				if (submit.contains("register")) {
					var description = request.getParameter("description");
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
					try {
						var dateIn = new Date(format.parse(request.getParameter("dateIn")).getTime());
						var dateOut = new Date(format.parse(request.getParameter("dateOut")).getTime());

						var leave = new Leave();
						leave.setDateIn(dateIn);
						leave.setDateOut(dateOut);
						leave.setDescription(description);

						var res = new LeaveDAO().Create(leave, (User) request.getSession().getAttribute("user"));
						if (res == -1)
							out.print("<p style=\"color:red\">Register failed</p>");
						else
							out.print("<p style=\"color:green\">Leave successfully applied</p>");
					} catch (ParseException ex) {
						Logger.getLogger(LeaveServlet.class.getName()).log(Level.SEVERE, null, ex);
					}
				}
			} else {
				try {
					var id = Integer.parseInt(request.getParameter("id"));
					var description = request.getParameter("description");
					var approval = request.getParameter("approval");
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
					var dateIn = new Date(format.parse(request.getParameter("datein")).getTime());
					var dateOut = new Date(format.parse(request.getParameter("dateout")).getTime());
					var leave = new Leave();
					leave.setId(id);
					leave.setDescription(description);
					leave.setApproval(approval);
					leave.setDateIn(dateIn);
					leave.setDateOut(dateOut);
					new LeaveDAO().Update(leave);
					out.print("<p style=\"color:green\">Leave successfully updated</p>");
				} catch (Exception e) {
					out.print(e);
				}

			}
		}
	}

	/**
	 * Returns a short description of the servlet.
	 *
	 * @return a String containing servlet description
	 */
	@Override
	public String getServletInfo() {
		return "Short description";
	}// </editor-fold>

}
