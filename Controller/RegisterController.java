/**
 * RegisterController.java
 * Purpose: Handles user registration form display and submission.
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
import java.util.HashMap;
import java.util.Map;

@WebServlet("/register")
public class RegisterController extends HttpServlet {

    private final UserService userService = new UserService();

    /** Display the registration form */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
    }

    /** Process the registration form submission */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        Map<String, String> errors = new HashMap<>();

        // Validate Full Name
        if (!ValidationUtil.isNotEmpty(fullName)) {
            errors.put("fullName", "Full name is required.");
        } else if (!ValidationUtil.isLettersOnly(fullName)) {
            errors.put("fullName", "Full name must contain only letters and spaces.");
        } else if (!ValidationUtil.isWithinLength(fullName, 100)) {
            errors.put("fullName", "Full name must not exceed 100 characters.");
        }

        // Validate Email
        if (!ValidationUtil.isNotEmpty(email)) {
            errors.put("email", "Email address is required.");
        } else if (!ValidationUtil.isValidEmail(email)) {
            errors.put("email", "Please enter a valid email address.");
        }

        // Validate Phone
        if (!ValidationUtil.isNotEmpty(phone)) {
            errors.put("phone", "Phone number is required.");
        } else if (!ValidationUtil.isValidPhone(phone)) {
            errors.put("phone", "Phone must be exactly 10 digits.");
        }

        // Validate Password
        if (!ValidationUtil.isNotEmpty(password)) {
            errors.put("password", "Password is required.");
        } else if (!ValidationUtil.isValidPassword(password)) {
            errors.put("password", "Password must be at least 8 characters with at least 1 letter and 1 number.");
        }

        // Validate Confirm Password
        if (!ValidationUtil.isNotEmpty(confirmPassword)) {
            errors.put("confirmPassword", "Please confirm your password.");
        } else if (password != null && !password.equals(confirmPassword)) {
            errors.put("confirmPassword", "Passwords do not match.");
        }

        // If no field errors, check for duplicates
        if (errors.isEmpty()) {
            User user = new User();
            user.setFullName(fullName.trim());
            user.setEmail(email.trim());
            user.setPhone(phone.trim());
            user.setPasswordHash(password); // Will be hashed in service

            String duplicateError = userService.validateUser(user, confirmPassword);
            if (duplicateError != null) {
                if (duplicateError.contains("Email")) {
                    errors.put("email", duplicateError);
                } else if (duplicateError.contains("Phone")) {
                    errors.put("phone", duplicateError);
                }
            }

            if (errors.isEmpty()) {
                boolean success = userService.registerUser(user);
                if (success) {
                    // PRG: redirect with success message
                    HttpSession session = request.getSession();
                    session.setAttribute("successMessage", "Registration successful! Please log in.");
                    response.sendRedirect(request.getContextPath() + "/login");
                    return;
                } else {
                    errors.put("general", "Registration failed. Please try again.");
                }
            }
        }

        // Return to form with errors and preserved values
        request.setAttribute("errors", errors);
        request.setAttribute("fullName", fullName);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
        request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
    }
}
