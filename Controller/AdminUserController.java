/**
 * AdminUserController.java
 * Purpose: Handles admin user management (list, approve, delete).
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.controller;

import com.findit.model.User;
import com.findit.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUserController extends HttpServlet {

    private final UserService userService = new UserService();

    /** Display all users */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<User> users = userService.getAllUsers();
        request.setAttribute("users", users);

        // Check for session messages
        HttpSession session = request.getSession();
        String successMessage = (String) session.getAttribute("successMessage");
        String errorMessage = (String) session.getAttribute("errorMessage");
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage");
        }
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            session.removeAttribute("errorMessage");
        }

        request.getRequestDispatcher("/jsp/admin/manage-users.jsp").forward(request, response);
    }

    /** Handle user management actions (approve, delete) */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String userIdStr = request.getParameter("userId");

        if (action == null || userIdStr == null) {
            session.setAttribute("errorMessage", "Invalid request.");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        int userId;
        try {
            userId = Integer.parseInt(userIdStr);
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid user ID.");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        int adminId = (int) session.getAttribute("userId");

        switch (action) {
            case "approve":
                if (userService.updateUserStatus(userId, "active")) {
                    session.setAttribute("successMessage", "User approved successfully.");
                } else {
                    session.setAttribute("errorMessage", "Failed to approve user.");
                }
                break;

            case "suspend":
                if (userId == adminId) {
                    session.setAttribute("errorMessage", "You cannot suspend your own account.");
                } else if (userService.updateUserStatus(userId, "suspended")) {
                    session.setAttribute("successMessage", "User suspended successfully.");
                } else {
                    session.setAttribute("errorMessage", "Failed to suspend user.");
                }
                break;

            case "delete":
                // Admin cannot delete their own account
                if (userId == adminId) {
                    session.setAttribute("errorMessage", "You cannot delete your own account.");
                } else if (userService.deleteUser(userId)) {
                    session.setAttribute("successMessage", "User deleted successfully.");
                } else {
                    session.setAttribute("errorMessage", "Failed to delete user.");
                }
                break;

            default:
                session.setAttribute("errorMessage", "Unknown action.");
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}
