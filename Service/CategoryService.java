/**
 * CategoryService.java
 * Purpose: Business logic layer for category management operations.
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.service;

import com.findit.dao.CategoryDAO;
import com.findit.model.Category;

import java.util.List;

public class CategoryService {

    private final CategoryDAO categoryDAO = new CategoryDAO();

    /** Add a new category */
    public boolean addCategory(String name) {
        Category category = new Category(name);
        return categoryDAO.insert(category);
    }

    /** Update an existing category */
    public boolean updateCategory(int id, String name) {
        Category category = new Category(name);
        category.setId(id);
        return categoryDAO.update(category);
    }

    /** Delete a category if no items are linked to it */
    public boolean deleteCategory(int id) {
        return categoryDAO.delete(id);
    }

    /** Check if category has linked items */
    public boolean hasLinkedItems(int id) {
        return categoryDAO.hasLinkedItems(id);
    }

    /** Get all categories */
    public List<Category> getAllCategories() {
        return categoryDAO.findAll();
    }

    /** Get a category by ID */
    public Category getCategoryById(int id) {
        return categoryDAO.findById(id);
    }

    /** Check if a category name already exists */
    public boolean categoryExists(String name) {
        return categoryDAO.findByName(name) != null;
    }
}
