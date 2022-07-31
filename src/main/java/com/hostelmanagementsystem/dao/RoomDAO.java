/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hostelmanagementsystem.dao;

import com.hostelmanagementsystem.model.Room;
import com.hostelmanagementsystem.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author black
 */
public class RoomDAO {

    public Connection conn = DBConnection.createConnection();

    public int Create(Room room) {

        String sql = "insert into ROOM(block,number,level) values(?,?,?)";

        PreparedStatement ps;
        try {
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, room.getBlock());
            ps.setInt(2, room.getNumber());
            ps.setInt(3, room.getLevel());
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
    

    public ArrayList<Room> Read() {
        String sql = "SELECT * FROM ROOM";
        ArrayList<Room> rooms = new ArrayList<Room>();
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Room room = new Room();
                room.setId(rs.getInt("id"));
                room.setBlock(rs.getString("block"));
                room.setNumber(rs.getInt("number"));
                room.setLevel(rs.getInt("level"));
                rooms.add(room);
            }
        } catch (SQLException ex) {
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }

        return rooms;
    }

    public Room Read(int ID) {
        String sql = "SELECT * FROM ROOM WHERE ID=" + ID;
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Room room = new Room();
                room.setId(rs.getInt("id"));
                room.setBlock(rs.getString("block"));
                room.setNumber(rs.getInt("number"));
                room.setLevel(rs.getInt("level"));
                return room;
            }
        } catch (SQLException ex) {
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }
        return null;
    }

    public List<Room> ReadAvailable() {
        String sql = "SELECT ROOM.id,block,number,level FROM ROOM,OCCUPY WHERE ROOM.id=OCCUPY.roomID  AND OCCUPY.dateIn>='2022-1-1'\n"
                + "GROUP BY ROOM.id\n"
                + "HAVING COUNT(ROOM.id)<4";
        ArrayList<Room> rooms = new ArrayList<Room>();
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Room room = new Room();
                room.setId(rs.getInt("id"));
                room.setBlock(rs.getString("block"));
                room.setNumber(rs.getInt("number"));
                room.setLevel(rs.getInt("level"));
                rooms.add(room);

            }
        } catch (SQLException ex) {
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }
        return rooms;
    }

    

    public List<Room> ReadAvailableMale() {
        String sql = "SELECT ROOM.id,block,number,level FROM ROOM,OCCUPY WHERE ROOM.id=OCCUPY.roomID AND ROOM.block!='A' AND ROOM.block!='B' AND OCCUPY.dateIn>='2022-1-1'\n"
                + "GROUP BY ROOM.id\n"
                + "HAVING COUNT(ROOM.id)<4";
        ArrayList<Room> rooms = new ArrayList<Room>();
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Room room = new Room();
                room.setId(rs.getInt("id"));
                room.setBlock(rs.getString("block"));
                room.setNumber(rs.getInt("number"));
                room.setLevel(rs.getInt("level"));
                rooms.add(room);

            }
        } catch (SQLException ex) {
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }
        return rooms;
    }

    public List<Room> ReadAvailableFemale() {
        String sql = "SELECT ROOM.id,block,number,level FROM ROOM,OCCUPY WHERE ROOM.id=OCCUPY.roomID AND (ROOM.block='A' || ROOM.block='B') AND OCCUPY.dateIn>='2022-1-1'\n"
                + "GROUP BY ROOM.id\n"
                + "HAVING COUNT(ROOM.id)<4";
        ArrayList<Room> rooms = new ArrayList<Room>();
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Room room = new Room();
                room.setId(rs.getInt("id"));
                room.setBlock(rs.getString("block"));
                room.setNumber(rs.getInt("number"));
                room.setLevel(rs.getInt("level"));
                rooms.add(room);
            }
        } catch (SQLException ex) {
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }
        return rooms;
    }

    public void Update(Room room) {
        String sql = "UPDATE ROOM SET block=?,number=?,level=? WHERE id=?";

        PreparedStatement ps;
        try {
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, room.getBlock());
            ps.setInt(2, room.getNumber());
            ps.setInt(3, room.getLevel());
            ps.setInt(4, room.getId());
            ps.executeUpdate();
        } catch (Exception ex) {
            System.out.println(ex);

        }
    }

    public void Delete(Room room) {
        String sql = "DELETE FROM ROOM WHERE id=?";

        PreparedStatement ps;
        try {
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, room.getId());
            ps.executeUpdate();
        } catch (Exception ex) {
            System.out.println(ex);

        }
    }
}
