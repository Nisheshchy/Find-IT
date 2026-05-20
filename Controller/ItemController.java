/**
 * ItemController.java
 * Purpose: Handles posting lost and found items (form display and submission).
 *          For FOUND items, also loads existing LOST items for matching
 *          and sends notifications when a match is selected.
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.controller;

import com.findit.model.Category;
import com.findit.model.Item;
import com.findit.service.CategoryService;
import com.findit.service.ItemService;
import com.findit.service.NotificationService;
import com.findit.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/user/post-item")
public class ItemController extends HttpServlet {

    private final ItemService itemService = new ItemService();
    private final CategoryService categoryService = new CategoryService();
    private final NotificationService notificationService = new NotificationService();

    /** Display the post item form (lost or found based on type parameter) */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String type = request.getParameter("type");
        if (type == null || (!"LOST".equals(type) && !"FOUND".equals(type))) {
            type = "LOST";
        }

        List<Category> categories = categoryService.getAllCategories();
        request.setAttribute("categories", categories);
        request.setAttribute("itemType", type);

        // For FOUND form, load all LOST items for matching
        if ("FOUND".equals(type)) {
            List<Item> lostItems = itemService.getItemsByType("LOST");
            request.setAttribute("lostItems", lostItems);
            request.getRequestDispatcher("/jsp/user/post-found.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/jsp/user/post-lost.jsp").forward(request, response);
        }
    }

    /** Process the item submission */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");

        // ── Quick Found: 1-click "I Found This" from item detail page ──
        String quickFound = request.getParameter("quickFound");
        String quickLostIdStr = request.getParameter("lostItemId");
        if ("true".equals(quickFound) && quickLostIdStr != null) {
            try {
                int lostItemId = Integer.parseInt(quickLostIdStr);
                Item lostItem = itemService.getItemById(lostItemId);

                if (lostItem == null || !"LOST".equals(lostItem.getType())) {
                    session.setAttribute("errorMessage", "Item not found or is not a lost item.");
                    response.sendRedirect(request.getContextPath() + "/browse");
                    return;
                }
                if (lostItem.getUserId() == userId) {
                    session.setAttribute("errorMessage", "You cannot report finding your own item.");
                    response.sendRedirect(request.getContextPath() + "/item?id=" + lostItemId);
                    return;
                }

                Item foundItem = new Item();
                foundItem.setTitle("Found: " + lostItem.getTitle());
                foundItem.setDescription("I have found your lost item. Please contact me through the chat.");
                foundItem.setCategoryId(lostItem.getCategoryId());
                foundItem.setType("FOUND");
                foundItem.setLocation("Contact finder for location details");
                foundItem.setDateOccurred(new java.sql.Date(System.currentTimeMillis()));
                foundItem.setContactPreference("both");
                foundItem.setMatchedLostItemId(lostItem.getId());
                foundItem.setUserId(userId);

                if (itemService.postItem(foundItem)) {
                    notificationService.createMatchNotification(
                        lostItem.getUserId(), userId, lostItem.getId(), foundItem.getId()
                    );
                    session.setAttribute("successMessage", "Item reported as found! The owner has been notified.");
                    response.sendRedirect(request.getContextPath() + "/item?id=" + foundItem.getId());
                } else {
                    session.setAttribute("errorMessage", "Failed to process the request. Please try again.");
                    response.sendRedirect(request.getContextPath() + "/item?id=" + lostItemId);
                }
            } catch (NumberFormatException e) {
                session.setAttribute("errorMessage", "Invalid item ID.");
                response.sendRedirect(request.getContextPath() + "/browse");
            }
            return;
        }

        // ── Regular item posting flow ──
        String type = request.getParameter("type");
        String title = request.getParameter("title");
        String categoryIdStr = request.getParameter("categoryId");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
        String dateStr = request.getParameter("dateOccurred");
        String contactPreference = request.getParameter("contactPreference");
        String matchedLostItemIdStr = request.getParameter("matchedLostItemId");

        Map<String, String> errors = new HashMap<>();

        // Validate Title
        if (!ValidationUtil.isNotEmpty(title)) {
            errors.put("title", "Item title is required.");
        } else if (!ValidationUtil.isWithinLength(title, 150)) {
            errors.put("title", "Title must not exceed 150 characters.");
        }

        // Validate Category
        int categoryId = 0;
        if (!ValidationUtil.isNotEmpty(categoryIdStr)) {
            errors.put("categoryId", "Please select a category.");
        } else {
            try {
                categoryId = Integer.parseInt(categoryIdStr);
                if (categoryService.getCategoryById(categoryId) == null) {
                    errors.put("categoryId", "Invalid category selected.");
                }
            } catch (NumberFormatException e) {
                errors.put("categoryId", "Invalid category.");
            }
        }

        // Validate Description
        if (!ValidationUtil.isNotEmpty(description)) {
            errors.put("description", "Description is required.");
        } else if (!ValidationUtil.isWithinLength(description, 500)) {
            errors.put("description", "Description must not exceed 500 characters.");
        }

        // Validate Location
        if (!ValidationUtil.isNotEmpty(location)) {
            errors.put("location", "Location is required.");
        } else if (!ValidationUtil.isWithinLength(location, 200)) {
            errors.put("location", "Location must not exceed 200 characters.");
        }

        // Validate Date
        if (!ValidationUtil.isNotEmpty(dateStr)) {
            errors.put("dateOccurred", "Date is required.");
        } else if (!ValidationUtil.isValidDate(dateStr)) {
            errors.put("dateOccurred", "Please enter a valid date that is not in the future.");
        }

        // Validate Contact Preference
        if (!ValidationUtil.isNotEmpty(contactPreference)) {
            errors.put("contactPreference", "Contact preference is required.");
        }

        // Parse matched lost item ID (optional, FOUND items only)
        int matchedLostItemId = 0;
        if ("FOUND".equals(type) && matchedLostItemIdStr != null && !matchedLostItemIdStr.trim().isEmpty()) {
            try {
                matchedLostItemId = Integer.parseInt(matchedLostItemIdStr);
            } catch (NumberFormatException ignored) {}
        }

        if (errors.isEmpty()) {
            Item item = new Item();
            item.setTitle(title.trim());
            item.setCategoryId(categoryId);
            item.setDescription(description.trim());
            item.setType(type != null ? type : "LOST");
            item.setLocation(location.trim());
            item.setDateOccurred(Date.valueOf(dateStr));
            item.setContactPreference(contactPreference);
            item.setMatchedLostItemId(matchedLostItemId);
            item.setUserId(userId);

            boolean success = itemService.postItem(item);
            if (success) {
                // If a FOUND item matched a LOST item, notify the lost item owner
                if ("FOUND".equals(type) && matchedLostItemId > 0) {
                    Item lostItem = itemService.getItemById(matchedLostItemId);
                    if (lostItem != null && lostItem.getUserId() != userId) {
                        notificationService.createMatchNotification(
                            lostItem.getUserId(), userId, lostItem.getId(), item.getId()
                        );
                    }
                }

                session.setAttribute("successMessage", "Item reported successfully!");
                response.sendRedirect(request.getContextPath() + "/user/dashboard");
                return;
            } else {
                errors.put("general", "Failed to submit report. Please try again.");
            }
        }

        // Return to form with errors
        List<Category> categories = categoryService.getAllCategories();
        request.setAttribute("categories", categories);
        request.setAttribute("errors", errors);
        request.setAttribute("itemType", type);
        request.setAttribute("title", title);
        request.setAttribute("categoryId", categoryIdStr);
        request.setAttribute("description", description);
        request.setAttribute("location", location);
        request.setAttribute("dateOccurred", dateStr);
        request.setAttribute("contactPreference", contactPreference);
        request.setAttribute("matchedLostItemId", matchedLostItemIdStr);

        if ("FOUND".equals(type)) {
            List<Item> lostItems = itemService.getItemsByType("LOST");
            request.setAttribute("lostItems", lostItems);
            request.getRequestDispatcher("/jsp/user/post-found.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/jsp/user/post-lost.jsp").forward(request, response);
        }
    }
}
