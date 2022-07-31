/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hostelmanagementsystem.dao;

import com.hostelmanagementsystem.model.User;
import com.hostelmanagementsystem.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author black
 */
public class UserDAO {
    public Connection conn = DBConnection.createConnection();

    public int Create(User user) {

        String sql = "insert into USER(name,password,email,role) values(?,?,?)";

        PreparedStatement ps;
        try {
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, user.getName());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getRole());
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

    public ArrayList<User> Read() {
        String sql = "SELECT * FROM USER";
        ArrayList<User> users = new ArrayList<User>();
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs=stmt.executeQuery(sql);
            
            while(rs.next())
            {
                User user =new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role "));
                user.setPassword(rs.getString("password"));
                users.add(user);
                return users;
            }
        } catch (SQLException ex) {
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }
        return null;
    }
    
    public User Read(int ID)
    {
        String sql = "SELECT * FROM USER WHERE id="+ID;
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs=stmt.executeQuery(sql);
            
            while(rs.next())
            {
                User user =new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setPassword(rs.getString("password"));
                return user;
            }
        } catch (SQLException ex) {
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }
        return null;
    }
    public User Read(User us)
    {
        String sql = "SELECT * FROM USER WHERE email='" +us.getEmail()+"'";
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs=stmt.executeQuery(sql);
            User user=new User();
            while(rs.next())
            {
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setPassword(rs.getString("password"));
                return user;
            }
        } catch (SQLException ex) {
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }
        return null;
    }
    
    public void Update(User user)
    {
        String sql = "UPDATE USER SET email=?,password=? WHERE id=?";

        PreparedStatement ps;
        try {
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());
            ps.setInt(3, user.getId());
            ps.executeUpdate();
        } catch (Exception ex) {
            System.out.println(ex);

        }
    }
    
    public void Delete(User user)
    {
        String sql = "DELETE FROM USER WHERE id=?";

        PreparedStatement ps;
        try {
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, user.getId());
            ps.executeUpdate();
        } catch (Exception ex) {
            System.out.println(ex);

        }
    }
}
