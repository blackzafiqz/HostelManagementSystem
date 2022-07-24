/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.hotelmanagementsystem.controller;

import com.hostelmanagementsystem.model.Room;
import com.hostelmanagementsystem.model.User;
import com.hotelmanagementsystem.dao.OccupyDAO;
import com.hotelmanagementsystem.dao.RoomDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author black
 */
public class RoomServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RoomServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RoomServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Room> rooms;
        String gender = request.getParameter("gender");
        if (gender.equals("male")) {
            rooms = new RoomDAO().ReadAvailableMale();
        } else if (gender.equals("male")){
            rooms = new RoomDAO().ReadAvailableFemale();
        }
        else
            rooms = new RoomDAO().ReadAvailable();
        try ( PrintWriter out = response.getWriter()) {
            if (request.getParameter("level") != null) {
                int level = Integer.parseInt(request.getParameter("level"));
                String block = request.getParameter("block");

                for (var b : rooms) {
                    if (b.getBlock().equals(block) && b.getLevel() == level) {
                        
                        out.println(String.format("<option value='%s'>%s</option>", b.getNumber(), b.getNumber()));
                    }
                }
            } else if (request.getParameter("block") != null) {
                String block = request.getParameter("block");
                List<Integer> levels = new ArrayList<Integer>();
                for (var b : rooms) {
                    if (b.getBlock().equals(block)) {
                        if (!levels.contains(b.getLevel())) {
                            levels.add(b.getLevel());
                        }

                    }
                }
                for (var b : levels) {
                    out.println(String.format("<option value='%s'>%s</option>", b, b));
                }
            }
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        var submit =request.getParameter("submit");
        if(submit.equals("register"))
        {
            var user=(User)request.getSession().getAttribute("user");
            if(request.getParameter("id")!=null)
            {
                user=new User();
                user.setId(Integer.parseInt(request.getParameter("id")));
            }
            var room = new Room();
            room.setBlock(request.getParameter("block"));
            room.setLevel(Integer.parseInt(request.getParameter("level")));
            room.setNumber(Integer.parseInt(request.getParameter("room")));
            
            
                try ( PrintWriter out = response.getWriter()) {
                    
                    if(new OccupyDAO().Create(user, room)==-1)
                    out.print("<p style=\"color:red\">Register failed, room already occupied</p>");
                    else
                        out.print("<p style=\"color:green\">Sucessful</p>");
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
