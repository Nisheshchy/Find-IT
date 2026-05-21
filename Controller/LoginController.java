/**
 * LoginController.java
 * Purpose: Handles user authentication, session creation, and remember-me cookies.
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.controller;

import com.findit.model.User;
import com.findit.service.UserService;
import com.findit.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    private final UserService userService = new UserService();

    /** Display the login form */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // If already logged in, redirect appropriately
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("userId") != null) {
            String role = (String) session.getAttribute("userRole");
            if ("ADMIN".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/user/dashboard");
            }
            return;
        }

        // Pass any success message from registration
        if (session != null) {
            String successMessage = (String) session.getAttribute("successMessage");
            if (successMessage != null) {
                request.setAttribute("successMessage", successMessage);
                session.removeAttribute("successMessage");
            }
        }

        request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
    }

    /** Process login form submission */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        // Basic validation
        if (!ValidationUtil.isNotEmpty(email) || !ValidationUtil.isNotEmpty(password)) {
            request.setAttribute("error", "Email and password are required.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
            return;
        }

        // Authenticate
        User user = userService.loginUser(email.trim(), password);

        if (user == null) {
            request.setAttribute("error", "Invalid email or password.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
            return;
        }

        // Create session
        HttpSession session = request.getSession(true);
        session.setAttribute("userId", user.getId());
        session.setAttribute("userRole", user.getRole());
        session.setAttribute("userName", user.getFullName());

        // Handle Remember Me cookie
        if ("on".equals(rememberMe) || "true".equals(rememberMe)) {
            Cookie cookie = new Cookie("findit_remember", String.valueOf(user.getId()));
            cookie.setMaxAge(604800); // 7 days
            cookie.setPath("/");
            cookie.setHttpOnly(true);
            response.addCookie(cookie);
        }

        // Redirect based on role
        if ("ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
        }
    }
}
