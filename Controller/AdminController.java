/**
 * AdminController.java
 * Purpose: Handles the admin dashboard with summary statistics.
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.controller;

import com.findit.model.Item;
import com.findit.service.ItemService;
import com.findit.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminController extends HttpServlet {

    private final UserService userService = new UserService();
    private final ItemService itemService = new ItemService();

    /** Display the admin dashboard with statistics and recent items */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int totalUsers = userService.getTotalUsers();
        int totalLost = itemService.getLostCount();
        int totalFound = itemService.getFoundCount();
        int pendingApprovals = userService.getUserCountByStatus("pending");

        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalLost", totalLost);
        request.setAttribute("totalFound", totalFound);
        request.setAttribute("pendingApprovals", pendingApprovals);

        // Recent items for the dashboard table
        List<Item> recentItems = itemService.getRecentItems(5);
        request.setAttribute("recentItems", recentItems);

        request.getRequestDispatcher("/jsp/admin/dashboard.jsp").forward(request, response);
    }
}
