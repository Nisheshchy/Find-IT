/**
 * UserDeleteItemController.java
 * Purpose: Allows users to delete their own items from their dashboard.
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

@WebServlet("/user/delete-item")
public class UserDeleteItemController extends HttpServlet {

    private final ItemService itemService = new ItemService();

    /** Handle item deletion by the item owner */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        String itemIdStr = request.getParameter("itemId");

        if (itemIdStr == null) {
            session.setAttribute("errorMessage", "Invalid request.");
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
            return;
        }

        try {
            int itemId = Integer.parseInt(itemIdStr);

            // Verify the item belongs to this user before deleting
            Item item = itemService.getItemById(itemId);
            if (item != null && item.getUserId() == userId) {
                if (itemService.deleteItem(itemId)) {
                    session.setAttribute("successMessage", "Item deleted successfully.");
                } else {
                    session.setAttribute("errorMessage", "Failed to delete item.");
                }
            } else {
                session.setAttribute("errorMessage", "You can only delete your own items.");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid item ID.");
        }

        response.sendRedirect(request.getContextPath() + "/user/dashboard");
    }
}
