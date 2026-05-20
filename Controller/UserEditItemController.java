/**
 * UserEditItemController.java
 * Purpose: Handles editing existing items by the item owner.
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.controller;

import com.findit.model.Category;
import com.findit.model.Item;
import com.findit.service.CategoryService;
import com.findit.service.ItemService;
import com.findit.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/user/edit-item")
public class UserEditItemController extends HttpServlet {

    private final ItemService itemService = new ItemService();
    private final CategoryService categoryService = new CategoryService();

    /** Display the edit form with pre-populated item data */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        String idStr = request.getParameter("id");

        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
            return;
        }

        try {
            int itemId = Integer.parseInt(idStr);
            Item item = itemService.getItemById(itemId);

            if (item == null || item.getUserId() != userId) {
                session.setAttribute("errorMessage", "You can only edit your own items.");
                response.sendRedirect(request.getContextPath() + "/user/dashboard");
                return;
            }

            List<Category> categories = categoryService.getAllCategories();
            request.setAttribute("item", item);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/jsp/user/edit-item.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
        }
    }

    /** Process the item update */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");

        String itemIdStr = request.getParameter("itemId");
        String type = request.getParameter("type");
        String title = request.getParameter("title");
        String categoryIdStr = request.getParameter("categoryId");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
        String dateStr = request.getParameter("dateOccurred");
        String contactPreference = request.getParameter("contactPreference");

        int itemId;
        try {
            itemId = Integer.parseInt(itemIdStr);
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid item.");
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
            return;
        }

        // Verify ownership
        Item existing = itemService.getItemById(itemId);
        if (existing == null || existing.getUserId() != userId) {
            session.setAttribute("errorMessage", "You can only edit your own items.");
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
            return;
        }

        Map<String, String> errors = new HashMap<>();

        // Validate Title
        if (!ValidationUtil.isNotEmpty(title)) {
            errors.put("title", "Item title is required.");
        } else if (!ValidationUtil.isWithinLength(title, 150)) {
            errors.put("title", "Title must not exceed 150 characters.");
        }

        // Validate Type
        if (!"LOST".equals(type) && !"FOUND".equals(type)) {
            errors.put("type", "Type must be Lost or Found.");
        }

        // Validate Category
        int categoryId = 0;
        if (!ValidationUtil.isNotEmpty(categoryIdStr)) {
            errors.put("categoryId", "Please select a category.");
        } else {
            try {
                categoryId = Integer.parseInt(categoryIdStr);
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

        if (errors.isEmpty()) {
            existing.setTitle(title.trim());
            existing.setType(type);
            existing.setCategoryId(categoryId);
            existing.setDescription(description.trim());
            existing.setLocation(location.trim());
            existing.setDateOccurred(Date.valueOf(dateStr));
            existing.setContactPreference(contactPreference);

            if (itemService.updateItem(existing)) {
                session.setAttribute("successMessage", "Item updated successfully!");
                response.sendRedirect(request.getContextPath() + "/user/dashboard");
                return;
            } else {
                errors.put("general", "Failed to update item. Please try again.");
            }
        }

        // Return to form with errors
        existing.setTitle(title);
        existing.setType(type);
        existing.setDescription(description);
        existing.setLocation(location);
        existing.setContactPreference(contactPreference);

        List<Category> categories = categoryService.getAllCategories();
        request.setAttribute("item", existing);
        request.setAttribute("categories", categories);
        request.setAttribute("errors", errors);
        request.setAttribute("categoryId", categoryIdStr);
        request.setAttribute("dateOccurred", dateStr);
        request.getRequestDispatcher("/jsp/user/edit-item.jsp").forward(request, response);
    }
}
