/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hostelmanagementsystem.dao;

import com.hostelmanagementsystem.model.Leave;
import com.hostelmanagementsystem.model.Occupy;
import com.hostelmanagementsystem.model.User;
import com.hostelmanagementsystem.util.DBConnection;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;

/**
 *
 * @author black
 */
public class LeaveDAO {

    public Connection conn = DBConnection.createConnection();

    public int Create(Leave leave, User user) {

        Occupy occupy = null;

        Calendar c = new GregorianCalendar();
        c.set(2021, 11, 31);
        Date d = new Date(c.getTime().getTime());
        var occupies =new OccupyDAO().Read();
        for (Occupy o : occupies) {
            if (o.getUserID() == user.getId() && o.getDateIn().compareTo(d) > 0) {
                occupy = o;
            }
        }
        var sql = "insert into `LEAVE`(description,dateOut,dateIn,occupyID,approval) values(?,?,?,?,\"Pending\")";

        PreparedStatement ps;
        try {
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, leave.getDescription());
            ps.setDate(2, leave.getDateOut());
            ps.setDate(3, leave.getDateIn());
            ps.setInt(4, occupy.getId());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
            conn.close();
        } catch (Exception ex) {
            System.out.println(ex);

        }
        return -1;
    }

    public ArrayList<Leave> Read() {
        String sql = "SELECT * FROM `LEAVE`";
        ArrayList<Leave> leaves = new ArrayList<Leave>();
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Leave leave = new Leave();
                leave.setDescription(rs.getString("description"));
                leave.setApproval(rs.getString("approval"));
                leave.setDateOut(rs.getDate("dateOut"));
                leave.setDateIn(rs.getDate("dateIn"));
                leave.setId(rs.getInt("id"));
                leaves.add(leave);
                return leaves;
            }
        } catch (SQLException ex) {
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }
        return null;
    }

    public Leave Read(int ID) {
        String sql = "SELECT * FROM `LEAVE` WHERE ID=" + ID;
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Leave leave = new Leave();
                leave.setDescription(rs.getString("description"));
                leave.setApproval(rs.getString("approval"));
                leave.setDateOut(rs.getDate("dateOut"));
                leave.setDateIn(rs.getDate("dateIn"));
                leave.setId(rs.getInt("id"));
                leave.setOccupyId(rs.getInt("occupyID"));
                return leave;
            }
        } catch (SQLException ex) {
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }
        return null;
    }

    public void Update(Leave leave) {
        String sql = "UPDATE `LEAVE` SET description=?, approval=?,dateIn=?,dateOut=? WHERE id=?";

        PreparedStatement ps;
        try {
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, leave.getDescription());
            ps.setString(2, leave.getApproval());
            ps.setDate(3, leave.getDateIn());
            ps.setDate(4, leave.getDateOut());
            ps.setInt(5, leave.getId());
            ps.executeUpdate();
        } catch (Exception ex) {
            System.out.println(ex);

        }
    }

    public void Delete(Leave leave) {
        String sql = "DELETE FROM `LEAVE` WHERE id=?";

        PreparedStatement ps;
        try {
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, leave.getId());
            ps.executeUpdate();
        } catch (Exception ex) {
            System.out.println(ex);

        }
    }
}
