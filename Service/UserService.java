/**
 * UserService.java
 * Purpose: Business logic layer for user-related operations.
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.service;

import com.findit.dao.UserDAO;
import com.findit.model.User;
import com.findit.util.PasswordUtil;

import java.util.List;

public class UserService {

    private final UserDAO userDAO = new UserDAO();

    /** Register a new user with encrypted password */
    public boolean registerUser(User user) {
        user.setPasswordHash(PasswordUtil.encryptSHA256(user.getPasswordHash()));
        user.setRole("USER");
        user.setStatus("pending");
        return userDAO.insert(user);
    }

    /** Authenticate user by email and raw password, return user if valid */
    public User loginUser(String email, String password) {
        User user = userDAO.findByEmail(email);
        if (user != null && PasswordUtil.verifyPassword(password, user.getPasswordHash())) {
            // Only active users can log in (admin is always active)
            if ("active".equals(user.getStatus()) || "ADMIN".equals(user.getRole())) {
                return user;
            }
        }
        return null;
    }

    /** Validate registration fields and return error messages */
    public String validateUser(User user, String confirmPassword) {
        // Check duplicate email
        if (userDAO.findByEmail(user.getEmail()) != null) {
            return "Email is already registered.";
        }
        // Check duplicate phone
        if (userDAO.findByPhone(user.getPhone()) != null) {
            return "Phone number is already registered.";
        }
        return null; // no errors
    }

    /** Get a user by their ID */
    public User getUserById(int id) {
        return userDAO.findById(id);
    }

    /** Get all users */
    public List<User> getAllUsers() {
        return userDAO.findAll();
    }

    /** Update user status (approve, suspend, etc.) */
    public boolean updateUserStatus(int id, String status) {
        return userDAO.updateStatus(id, status);
    }

    /** Delete a user by ID */
    public boolean deleteUser(int id) {
        return userDAO.delete(id);
    }

    /** Get total number of users */
    public int getTotalUsers() {
        return userDAO.countAll();
    }

    /** Get count of users with a specific status */
    public int getUserCountByStatus(String status) {
        return userDAO.countByStatus(status);
    }

    /** Encrypt a plaintext password */
    public String encryptPassword(String password) {
        return PasswordUtil.encryptSHA256(password);
    }

    /** Update user profile (name, phone) */
    public boolean updateUser(User user) {
        return userDAO.update(user);
    }

    /** Update user password */
    public boolean updateUserPassword(int userId, String passwordHash) {
        return userDAO.updatePassword(userId, passwordHash);
    }
}
