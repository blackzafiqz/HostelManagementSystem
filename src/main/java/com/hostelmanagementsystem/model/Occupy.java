/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hostelmanagementsystem.model;

import java.util.Date;
import java.sql.Time;
import java.text.SimpleDateFormat;

/**
 *
 * @author black
 */
public class Occupy implements java.io.Serializable {

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public java.util.Date getDateIn() {
        return dateIn;
    }

    public void setDateIn(Date dateIn) {
        this.dateIn = dateIn;
    }

    public Date getDateOut() {
        return dateOut;
    }

    public void setDateOut(Date dateOut) {
        this.dateOut = dateOut;
    }
    private int id;
    private int userID;
    private int roomID;
    private Date dateIn;
    private Date dateOut;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
