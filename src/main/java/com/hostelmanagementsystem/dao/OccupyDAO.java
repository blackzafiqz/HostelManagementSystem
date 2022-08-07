/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hostelmanagementsystem.dao;

import com.hostelmanagementsystem.model.Occupy;
import com.hostelmanagementsystem.model.Room;
import com.hostelmanagementsystem.model.User;
import com.hostelmanagementsystem.util.DBConnection;
import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author black
 */
public class OccupyDAO {

    public Connection conn = DBConnection.createConnection();

    public int Create(Occupy occupy) {

        String sql = "INSERT INTO OCCUPY(userID,roomID,dateIn,dateOut) values(?,?,?,?)";

        PreparedStatement ps;
        try {
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, occupy.getUserID());
            ps.setInt(2, occupy.getRoomID());
            ps.setDate(3, new java.sql.Date(occupy.getDateIn().getTime()));
            ps.setDate(4, new java.sql.Date(occupy.getDateOut().getTime()));
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
            conn.close();
        } catch (Exception ex) {
            System.out.println(ex);

        }
        return 0;
    }
    public int Update(Occupy occupy) {

        String sql = "UPDATE OCCUPY SET userID=?,roomID=?,dateIn=?,dateOut=? WHERE id=?";

        PreparedStatement ps;
        try {
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, occupy.getUserID());
            ps.setInt(2, occupy.getRoomID());
            ps.setDate(3, new java.sql.Date(occupy.getDateIn().getTime()));
            ps.setDate(4, new java.sql.Date(occupy.getDateOut().getTime()));
            ps.setInt(5, occupy.getId());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
            conn.close();
        } catch (Exception ex) {
            System.out.println(ex);

        }
        return 0;
    }
    public int Create(User user, Room room) {

        for (var r :new RoomDAO().ReadAvailable()) {
            if (r.getBlock().equals(room.getBlock()) && r.getLevel() == room.getLevel() && r.getNumber() == room.getNumber()) {
                String sql = "INSERT INTO OCCUPY(userID,roomID,dateIn,dateOut) values(?,?,?,?)";

                PreparedStatement ps;
                try {
                    ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                    ps.setInt(1, user.getId());
                    ps.setInt(2, r.getId());
                    ps.setString(3,  "2022-1-1");
                    ps.setString(4, "2022-6-1");
                    ps.executeUpdate();
                    ResultSet rs = ps.getGeneratedKeys();
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                    conn.close();
                } catch (Exception ex) {
                    System.out.println(ex);

                }
            }
        }
        return -1;
    }

    public ArrayList<Occupy> Read() {
        String sql = "SELECT * FROM OCCUPY";
        ArrayList<Occupy> occupies = new ArrayList<Occupy>();
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                java.sql.Date dateIn = rs.getDate("dateIn");
                java.sql.Date dateOut = rs.getDate("dateOut");
                Occupy occupy = new Occupy();
                occupy.setId(rs.getInt("id"));
                occupy.setRoomID(rs.getInt("roomID"));
                occupy.setUserID(rs.getInt("userID"));
                occupy.setDateOut(dateOut);
                occupy.setDateIn(dateIn);
                occupies.add(occupy);
            }
        } catch (SQLException ex) {
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }
        return occupies;
    }

    public Occupy Read(int ID) {
        String sql = "SELECT * FROM OCCUPY WHERE id=" + ID;
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Occupy occupy = new Occupy();
                occupy.setId(rs.getInt("id"));
                occupy.setRoomID(rs.getInt("roomID"));
                occupy.setUserID(rs.getInt("userID"));
                occupy.setDateIn(rs.getTime("dateIn"));
                occupy.setDateOut(rs.getTime("dateOut"));
                return occupy;
            }
        } catch (SQLException ex) {
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }
        return null;
    }
    public Occupy Read(User user) {
        String sql = "SELECT * FROM OCCUPY WHERE userID=" + user.getId();
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Occupy occupy = new Occupy();
                occupy.setId(rs.getInt("id"));
                occupy.setRoomID(rs.getInt("roomID"));
                occupy.setUserID(rs.getInt("userID"));
                occupy.setDateIn(rs.getTime("dateIn"));
                occupy.setDateOut(rs.getTime("dateOut"));
                return occupy;
            }
        } catch (SQLException ex) {
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }
        return null;
    }
    public void Delete(User user) {
        String sql = "DELETE FROM OCCUPY WHERE dateIn>='2022-1-1' AND userID=" + user.getId();
        PreparedStatement ps;
        try {
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.executeUpdate();
            conn.close();
        } catch (Exception ex) {
            System.out.println(ex);

        }
    }

}
