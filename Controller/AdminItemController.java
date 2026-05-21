/**
 * AdminItemController.java
 * Purpose: Handles admin item management (list, delete, update status).
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

@WebServlet("/admin/items")
public class AdminItemController extends HttpServlet {

    private final ItemService itemService = new ItemService();

    /** Display all items */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Item> items = itemService.getAllItems();
        request.setAttribute("items", items);

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

        request.getRequestDispatcher("/jsp/admin/manage-items.jsp").forward(request, response);
    }

    /** Handle item management actions (delete, update status) */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String itemIdStr = request.getParameter("itemId");

        if (action == null || itemIdStr == null) {
            session.setAttribute("errorMessage", "Invalid request.");
            response.sendRedirect(request.getContextPath() + "/admin/items");
            return;
        }

        int itemId;
        try {
            itemId = Integer.parseInt(itemIdStr);
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid item ID.");
            response.sendRedirect(request.getContextPath() + "/admin/items");
            return;
        }

        switch (action) {
            case "delete":
                if (itemService.deleteItem(itemId)) {
                    session.setAttribute("successMessage", "Item deleted successfully.");
                } else {
                    session.setAttribute("errorMessage", "Failed to delete item.");
                }
                break;

            case "updateStatus":
                String newStatus = request.getParameter("status");
                if (newStatus != null && !newStatus.isEmpty()) {
                    if (itemService.updateItemStatus(itemId, newStatus)) {
                        session.setAttribute("successMessage", "Item status updated successfully.");
                    } else {
                        session.setAttribute("errorMessage", "Failed to update item status.");
                    }
                } else {
                    session.setAttribute("errorMessage", "Please select a valid status.");
                }
                break;

            default:
                session.setAttribute("errorMessage", "Unknown action.");
        }

        response.sendRedirect(request.getContextPath() + "/admin/items");
    }
}
