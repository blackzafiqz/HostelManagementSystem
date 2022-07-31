/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.hostelmanagementsystem.controller;

import com.hostelmanagementsystem.model.User;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hostelmanagementsystem.dao.OccupyDAO;
import com.hostelmanagementsystem.dao.RoomDAO;
import com.hostelmanagementsystem.dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author black
 */
public class UserServlet extends HttpServlet {

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
			out.println("<title>Servlet UserServlet</title>");
			out.println("</head>");
			out.println("<body>");
			out.println("<h1>Servlet UserServlet at " + request.getContextPath() + "</h1>");
			out.println("</body>");
			out.println("</html>");
		}
	}

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
		try (PrintWriter out = response.getWriter()) {
			if (request.getParameter("query") != null) {
				var query = request.getParameter("query");
				if (query.equals("name")) {
					var id = Integer.parseInt(request.getParameter("id"));

					var user = new UserDAO().Read(id);
					ObjectMapper mapper = new ObjectMapper();

					if (user != null) {
						var occupy = new OccupyDAO().Read(user);
						if (occupy != null) {
							user.setOccupy(occupy);

							var room = new RoomDAO().Read(occupy.getRoomID());
							if (room != null)
								user.setRoom(room);
						}
						out.println(mapper.writeValueAsString(user));
					} else
						out.print("");
				}
			}
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

		if (request.getParameter("submit") != null) {
			var submit = request.getParameter("submit");
			if (submit.equals("update")) {
				var id = Integer.parseInt(request.getParameter("id"));
				var email = request.getParameter("email");
				var password = request.getParameter("password");
				try (PrintWriter out = response.getWriter()) {
					var user = new User();
					user.setEmail(email);
					user.setId(id);
					user.setPassword(password);
					new UserDAO().Update(user);

					if (request.getParameter("room") != null) {
						var rooms = new RoomDAO().Read();

						for (var r : rooms) {
							var number = Integer.parseInt(request.getParameter("room"));
							var block = request.getParameter("block");
							var level = Integer.parseInt(request.getParameter("level"));

							if (r.getBlock().equals(block) && r.getLevel() == level && r.getNumber() == number) {
								user = new UserDAO().Read(id);
								var occupy = new OccupyDAO().Read(user);
								occupy.setRoomID(r.getId());
								new OccupyDAO().Update(occupy);
							}
						}
					}
					out.print("<p id='replace' style=\"color:green\">Sucessful</p>");
				}
			}
		} else {
			var id = Integer.parseInt(request.getParameter("id"));

			try (PrintWriter out = response.getWriter()) {
				var user = new User();
				user.setId(id);
				new OccupyDAO().Delete(user);
				out.print("<p id='replace' style=\"color:green\">Sucessful</p>");
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
