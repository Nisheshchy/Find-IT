/**
 * UserQuickFoundController.java
 * Purpose: Allows users to 1-click report that they found a lost item.
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.controller;

import com.findit.model.Item;
import com.findit.service.ItemService;
import com.findit.service.NotificationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/user/quick-found")
public class UserQuickFoundController extends HttpServlet {

    private final ItemService itemService = new ItemService();
    private final NotificationService notificationService = new NotificationService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        String lostItemIdStr = request.getParameter("lostItemId");

        if (lostItemIdStr == null || lostItemIdStr.trim().isEmpty()) {
            session.setAttribute("errorMessage", "Invalid request.");
            response.sendRedirect(request.getContextPath() + "/browse");
            return;
        }

        try {
            int lostItemId = Integer.parseInt(lostItemIdStr);
            Item lostItem = itemService.getItemById(lostItemId);

            if (lostItem == null || !"LOST".equals(lostItem.getType()) || !"active".equals(lostItem.getStatus())) {
                session.setAttribute("errorMessage", "Item not found or already resolved.");
                response.sendRedirect(request.getContextPath() + "/browse");
                return;
            }

            if (lostItem.getUserId() == userId) {
                session.setAttribute("errorMessage", "You cannot report finding your own item this way. Use the dashboard to mark it as resolved.");
                response.sendRedirect(request.getContextPath() + "/item?id=" + lostItemId);
                return;
            }

            // Generate a Found item
            Item foundItem = new Item();
            foundItem.setTitle("Found: " + lostItem.getTitle());
            foundItem.setDescription("I have found your lost item. Please contact me through the chat.");
            foundItem.setCategoryId(lostItem.getCategoryId());
            foundItem.setType("FOUND");
            foundItem.setLocation("Contact finder for location details.");
            foundItem.setDateOccurred(new java.sql.Date(System.currentTimeMillis()));
            foundItem.setContactPreference("both");
            foundItem.setStatus("active");
            foundItem.setMatchedLostItemId(lostItem.getId());
            foundItem.setUserId(userId);

            if (itemService.postItem(foundItem)) {
                // Send notification to the lost item owner
                notificationService.createMatchNotification(
                        lostItem.getUserId(),
                        userId,
                        lostItem.getId(),
                        foundItem.getId()
                );

                session.setAttribute("successMessage", "Item successfully reported as found! The owner has been notified.");
                response.sendRedirect(request.getContextPath() + "/item?id=" + foundItem.getId());
            } else {
                session.setAttribute("errorMessage", "Failed to process the request. Please try again.");
                response.sendRedirect(request.getContextPath() + "/item?id=" + lostItemId);
            }

        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid item ID format.");
            response.sendRedirect(request.getContextPath() + "/browse");
        }
    }
}
