/**
 * ItemService.java
 * Purpose: Business logic layer for item-related operations.
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.service;

import com.findit.dao.ItemDAO;
import com.findit.model.Item;

import java.util.List;

public class ItemService {

    private final ItemDAO itemDAO = new ItemDAO();

    /** Post a new lost or found item */
    public boolean postItem(Item item) {
        return itemDAO.insert(item);
    }

    /** Get all items posted by a specific user */
    public List<Item> getItemsByUser(int userId) {
        return itemDAO.findByUserId(userId);
    }

    /** Get all items in the system */
    public List<Item> getAllItems() {
        return itemDAO.findAll();
    }

    /** Get all items of a specific type (LOST or FOUND) */
    public List<Item> getItemsByType(String type) {
        return itemDAO.findByType(type);
    }

    /** Get most recent n items for homepage display */
    public List<Item> getRecentItems(int n) {
        return itemDAO.findRecent(n);
    }

    /** Get a single item by ID */
    public Item getItemById(int id) {
        return itemDAO.findById(id);
    }

    /** Delete an item by ID */
    public boolean deleteItem(int id) {
        return itemDAO.delete(id);
    }

    /** Update an existing item */
    public boolean updateItem(Item item) {
        return itemDAO.update(item);
    }

    /** Update only the status of an item */
    public boolean updateItemStatus(int id, String status) {
        return itemDAO.updateStatus(id, status);
    }

    /** Get count of lost items */
    public int getLostCount() {
        return itemDAO.countByType("LOST");
    }

    /** Get count of found items */
    public int getFoundCount() {
        return itemDAO.countByType("FOUND");
    }

    /** Get count of resolved items */
    public int getResolvedCount() {
        return itemDAO.countByStatus("resolved");
    }

    /** Get count of items by user and type */
    public int getCountByUserAndType(int userId, String type) {
        return itemDAO.countByUserAndType(userId, type);
    }

    /** Search items by keyword across title, description, and location */
    public List<Item> searchItems(String query) {
        return itemDAO.search(query);
    }

    /** Search items by keyword filtered by type */
    public List<Item> searchItemsByType(String type, String query) {
        return itemDAO.searchByType(type, query);
    }
}
