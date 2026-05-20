/**
 * UserDashboardController.java
 * Purpose: Handles user dashboard display with item counts and listings.
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.controller;

import com.findit.model.Item;
import com.findit.service.ItemService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/user/dashboard")
public class UserDashboardController extends HttpServlet {

    private final ItemService itemService = new ItemService();

    /** Display the user dashboard */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");

        // Get user's items
        List<Item> userItems = itemService.getItemsByUser(userId);

        // Get counts
        int lostCount = itemService.getCountByUserAndType(userId, "LOST");
        int foundCount = itemService.getCountByUserAndType(userId, "FOUND");

        request.setAttribute("userItems", userItems);
        request.setAttribute("lostCount", lostCount);
        request.setAttribute("foundCount", foundCount);

        // Check for flash messages from redirects
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

        request.getRequestDispatcher("/jsp/user/dashboard.jsp").forward(request, response);
    }
}
