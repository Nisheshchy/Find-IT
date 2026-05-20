/**
 * UserProfileController.java
 * Purpose: Handles user profile display and updates.
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.controller;

import com.findit.model.User;
import com.findit.service.UserService;
import com.findit.util.PasswordUtil;
import com.findit.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/user/profile")
public class UserProfileController extends HttpServlet {

    private final UserService userService = new UserService();

    /** Display the user profile page */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        User user = userService.getUserById(userId);

        request.setAttribute("user", user);

        // Flash messages
        String successMessage = (String) session.getAttribute("successMessage");
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage");
        }
        String errorMessage = (String) session.getAttribute("errorMessage");
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            session.removeAttribute("errorMessage");
        }

        request.getRequestDispatcher("/jsp/user/profile.jsp").forward(request, response);
    }

    /** Handle profile updates */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        User user = userService.getUserById(userId);

        String action = request.getParameter("action");

        if ("updateProfile".equals(action)) {
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");

            Map<String, String> errors = new HashMap<>();

            if (!ValidationUtil.isNotEmpty(fullName)) {
                errors.put("fullName", "Full name is required.");
            }
            if (!ValidationUtil.isNotEmpty(phone)) {
                errors.put("phone", "Phone number is required.");
            }

            if (errors.isEmpty()) {
                user.setFullName(fullName.trim());
                user.setPhone(phone.trim());

                if (userService.updateUser(user)) {
                    session.setAttribute("userName", fullName.trim());
                    session.setAttribute("successMessage", "Profile updated successfully!");
                } else {
                    session.setAttribute("errorMessage", "Failed to update profile.");
                }
            } else {
                session.setAttribute("errorMessage", "Please fill in all required fields.");
            }

        } else if ("changePassword".equals(action)) {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (!PasswordUtil.verifyPassword(currentPassword, user.getPasswordHash())) {
                session.setAttribute("errorMessage", "Current password is incorrect.");
            } else if (newPassword == null || newPassword.length() < 6) {
                session.setAttribute("errorMessage", "New password must be at least 6 characters.");
            } else if (!newPassword.equals(confirmPassword)) {
                session.setAttribute("errorMessage", "New passwords do not match.");
            } else {
                user.setPasswordHash(PasswordUtil.encryptSHA256(newPassword));
                if (userService.updateUserPassword(userId, user.getPasswordHash())) {
                    session.setAttribute("successMessage", "Password changed successfully!");
                } else {
                    session.setAttribute("errorMessage", "Failed to change password.");
                }
            }
        }

        response.sendRedirect(request.getContextPath() + "/user/profile");
    }
}
