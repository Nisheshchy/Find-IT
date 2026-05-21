/**
 * AdminCategoryController.java
 * Purpose: Handles admin category CRUD operations.
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.controller;

import com.findit.model.Category;
import com.findit.service.CategoryService;
import com.findit.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/categories")
public class AdminCategoryController extends HttpServlet {

    private final CategoryService categoryService = new CategoryService();

    /** Display all categories with add/edit form */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Category> categories = categoryService.getAllCategories();
        request.setAttribute("categories", categories);

        // If editing, load the category
        String editIdStr = request.getParameter("editId");
        if (editIdStr != null) {
            try {
                int editId = Integer.parseInt(editIdStr);
                Category editCategory = categoryService.getCategoryById(editId);
                request.setAttribute("editCategory", editCategory);
            } catch (NumberFormatException ignored) {}
        }

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

        request.getRequestDispatcher("/jsp/admin/manage-categories.jsp").forward(request, response);
    }

    /** Handle category CRUD actions (add, update, delete) */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if (action == null) {
            session.setAttribute("errorMessage", "Invalid request.");
            response.sendRedirect(request.getContextPath() + "/admin/categories");
            return;
        }

        switch (action) {
            case "add": {
                String name = request.getParameter("name");
                if (!ValidationUtil.isNotEmpty(name)) {
                    session.setAttribute("errorMessage", "Category name is required.");
                } else if (categoryService.categoryExists(name.trim())) {
                    session.setAttribute("errorMessage", "A category with this name already exists.");
                } else if (categoryService.addCategory(name.trim())) {
                    session.setAttribute("successMessage", "Category added successfully.");
                } else {
                    session.setAttribute("errorMessage", "Failed to add category.");
                }
                break;
            }

            case "update": {
                String idStr = request.getParameter("categoryId");
                String name = request.getParameter("name");
                if (!ValidationUtil.isNotEmpty(idStr) || !ValidationUtil.isNotEmpty(name)) {
                    session.setAttribute("errorMessage", "Category ID and name are required.");
                } else {
                    try {
                        int id = Integer.parseInt(idStr);
                        // Check if another category has the same name
                        Category existing = categoryService.getCategoryById(id);
                        if (existing != null && !existing.getName().equalsIgnoreCase(name.trim())
                                && categoryService.categoryExists(name.trim())) {
                            session.setAttribute("errorMessage", "A category with this name already exists.");
                        } else if (categoryService.updateCategory(id, name.trim())) {
                            session.setAttribute("successMessage", "Category updated successfully.");
                        } else {
                            session.setAttribute("errorMessage", "Failed to update category.");
                        }
                    } catch (NumberFormatException e) {
                        session.setAttribute("errorMessage", "Invalid category ID.");
                    }
                }
                break;
            }

            case "delete": {
                String idStr = request.getParameter("categoryId");
                if (!ValidationUtil.isNotEmpty(idStr)) {
                    session.setAttribute("errorMessage", "Category ID is required.");
                } else {
                    try {
                        int id = Integer.parseInt(idStr);
                        if (categoryService.hasLinkedItems(id)) {
                            session.setAttribute("errorMessage",
                                    "Cannot delete — items exist in this category.");
                        } else if (categoryService.deleteCategory(id)) {
                            session.setAttribute("successMessage", "Category deleted successfully.");
                        } else {
                            session.setAttribute("errorMessage", "Failed to delete category.");
                        }
                    } catch (NumberFormatException e) {
                        session.setAttribute("errorMessage", "Invalid category ID.");
                    }
                }
                break;
            }

            default:
                session.setAttribute("errorMessage", "Unknown action.");
        }

        response.sendRedirect(request.getContextPath() + "/admin/categories");
    }
}
