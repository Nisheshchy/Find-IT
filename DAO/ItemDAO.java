/**
 * ItemDAO.java
 * Purpose: Data access object for item CRUD operations against the database.
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.dao;

import com.findit.model.Item;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {

    /** Insert a new item into the database */
    public boolean insert(Item item) {
        String sql = "INSERT INTO items (title, description, category_id, type, location, " +
                     "date_occurred, contact_preference, matched_lost_item_id, user_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, item.getTitle());
            ps.setString(2, item.getDescription());
            ps.setInt(3, item.getCategoryId());
            ps.setString(4, item.getType());
            ps.setString(5, item.getLocation());
            ps.setDate(6, item.getDateOccurred());
            ps.setString(7, item.getContactPreference());
            if (item.getMatchedLostItemId() > 0) {
                ps.setInt(8, item.getMatchedLostItemId());
            } else {
                ps.setNull(8, java.sql.Types.INTEGER);
            }
            ps.setInt(9, item.getUserId());
            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) {
                        item.setId(keys.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Find an item by its ID */
    public Item findById(int id) {
        String sql = "SELECT i.*, c.name AS category_name, u.full_name AS user_name " +
                     "FROM items i " +
                     "LEFT JOIN categories c ON i.category_id = c.id " +
                     "LEFT JOIN users u ON i.user_id = u.id " +
                     "WHERE i.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /** Find all items ordered by most recent */
    public List<Item> findAll() {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT i.*, c.name AS category_name, u.full_name AS user_name " +
                     "FROM items i " +
                     "LEFT JOIN categories c ON i.category_id = c.id " +
                     "LEFT JOIN users u ON i.user_id = u.id " +
                     "ORDER BY i.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                items.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    /** Find all items posted by a specific user */
    public List<Item> findByUserId(int userId) {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT i.*, c.name AS category_name, u.full_name AS user_name " +
                     "FROM items i " +
                     "LEFT JOIN categories c ON i.category_id = c.id " +
                     "LEFT JOIN users u ON i.user_id = u.id " +
                     "WHERE i.user_id = ? ORDER BY i.created_at DESC LIMIT 10";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    /** Find all items of a specific type (LOST or FOUND) */
    public List<Item> findByType(String type) {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT i.*, c.name AS category_name, u.full_name AS user_name " +
                     "FROM items i " +
                     "LEFT JOIN categories c ON i.category_id = c.id " +
                     "LEFT JOIN users u ON i.user_id = u.id " +
                     "WHERE i.type = ? ORDER BY i.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, type);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    /** Update an existing item */
    public boolean update(Item item) {
        String sql = "UPDATE items SET title = ?, description = ?, category_id = ?, type = ?, " +
                     "location = ?, date_occurred = ?, contact_preference = ?, status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, item.getTitle());
            ps.setString(2, item.getDescription());
            ps.setInt(3, item.getCategoryId());
            ps.setString(4, item.getType());
            ps.setString(5, item.getLocation());
            ps.setDate(6, item.getDateOccurred());
            ps.setString(7, item.getContactPreference());
            ps.setString(8, item.getStatus());
            ps.setInt(9, item.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Delete an item by ID */
    public boolean delete(int id) {
        String sql = "DELETE FROM items WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Find n most recent items for homepage preview */
    public List<Item> findRecent(int n) {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT i.*, c.name AS category_name, u.full_name AS user_name " +
                     "FROM items i " +
                     "LEFT JOIN categories c ON i.category_id = c.id " +
                     "LEFT JOIN users u ON i.user_id = u.id " +
                     "ORDER BY i.created_at DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, n);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    /** Search items by keyword across title, description, and location */
    public List<Item> search(String query) {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT i.*, c.name AS category_name, u.full_name AS user_name " +
                     "FROM items i " +
                     "LEFT JOIN categories c ON i.category_id = c.id " +
                     "LEFT JOIN users u ON i.user_id = u.id " +
                     "WHERE (i.title LIKE ? OR i.description LIKE ? OR i.location LIKE ?) " +
                     "ORDER BY i.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String like = "%" + query + "%";
            ps.setString(1, like);
            ps.setString(2, like);
            ps.setString(3, like);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    /** Search items by keyword filtered by type (LOST or FOUND) */
    public List<Item> searchByType(String type, String query) {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT i.*, c.name AS category_name, u.full_name AS user_name " +
                     "FROM items i " +
                     "LEFT JOIN categories c ON i.category_id = c.id " +
                     "LEFT JOIN users u ON i.user_id = u.id " +
                     "WHERE i.type = ? AND (i.title LIKE ? OR i.description LIKE ? OR i.location LIKE ?) " +
                     "ORDER BY i.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String like = "%" + query + "%";
            ps.setString(1, type);
            ps.setString(2, like);
            ps.setString(3, like);
            ps.setString(4, like);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    /** Count items by type (LOST or FOUND) */
    public int countByType(String type) {
        String sql = "SELECT COUNT(*) FROM items WHERE type = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, type);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /** Count items by user and type */
    public int countByUserAndType(int userId, String type) {
        String sql = "SELECT COUNT(*) FROM items WHERE user_id = ? AND type = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, type);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /** Update only the status of an item */
    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE items SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Count items by status (active, resolved, removed) */
    public int countByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM items WHERE status = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /** Map a ResultSet row to an Item object */
    private Item mapRow(ResultSet rs) throws SQLException {
        Item item = new Item();
        item.setId(rs.getInt("id"));
        item.setTitle(rs.getString("title"));
        item.setDescription(rs.getString("description"));
        item.setCategoryId(rs.getInt("category_id"));
        item.setType(rs.getString("type"));
        item.setLocation(rs.getString("location"));
        item.setDateOccurred(rs.getDate("date_occurred"));
        item.setContactPreference(rs.getString("contact_preference"));
        item.setStatus(rs.getString("status"));
        item.setMatchedLostItemId(rs.getInt("matched_lost_item_id"));
        item.setUserId(rs.getInt("user_id"));
        item.setCreatedAt(rs.getTimestamp("created_at"));
        // Joined fields
        try {
            item.setCategoryName(rs.getString("category_name"));
        } catch (SQLException ignored) {}
        try {
            item.setUserName(rs.getString("user_name"));
        } catch (SQLException ignored) {}
        return item;
    }
}
