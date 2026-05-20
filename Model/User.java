/**
 * User.java
 * Purpose: Model class representing a registered user in the Find It platform.
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.model;

import java.sql.Timestamp;

public class User {
    private int id;
    private String fullName;
    private String email;
    private String phone;
    private String passwordHash;
    private String role;       // ADMIN or USER
    private String status;     // active, pending, suspended
    private Timestamp createdAt;

    /** Default constructor */
    public User() {}

    /** Parameterized constructor for creating a new user */
    public User(String fullName, String email, String phone,
                String passwordHash, String role, String status) {
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.passwordHash = passwordHash;
        this.role = role;
        this.status = status;
    }

    /** Get user ID */
    public int getId() { return id; }

    /** Set user ID */
    public void setId(int id) { this.id = id; }

    /** Get full name */
    public String getFullName() { return fullName; }

    /** Set full name */
    public void setFullName(String fullName) { this.fullName = fullName; }

    /** Get email address */
    public String getEmail() { return email; }

    /** Set email address */
    public void setEmail(String email) { this.email = email; }

    /** Get phone number */
    public String getPhone() { return phone; }

    /** Set phone number */
    public void setPhone(String phone) { this.phone = phone; }

    /** Get password hash */
    public String getPasswordHash() { return passwordHash; }

    /** Set password hash */
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    /** Get user role (ADMIN or USER) */
    public String getRole() { return role; }

    /** Set user role */
    public void setRole(String role) { this.role = role; }

    /** Get account status */
    public String getStatus() { return status; }

    /** Set account status */
    public void setStatus(String status) { this.status = status; }

    /** Get account creation timestamp */
    public Timestamp getCreatedAt() { return createdAt; }

    /** Set account creation timestamp */
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
