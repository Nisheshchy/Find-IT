/**
 * NotificationDAO.java
 * Purpose: Data access object for notification CRUD operations.
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.dao;

import com.findit.model.Notification;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {

    /** Insert a new notification */
    public boolean insert(Notification n) {
        String sql = "INSERT INTO notifications (user_id, from_user_id, item_id, matched_item_id, message) " +
                     "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, n.getUserId());
            ps.setInt(2, n.getFromUserId());
            ps.setInt(3, n.getItemId());
            if (n.getMatchedItemId() > 0) {
                ps.setInt(4, n.getMatchedItemId());
            } else {
                ps.setNull(4, Types.INTEGER);
            }
            ps.setString(5, n.getMessage());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Find all notifications for a user, newest first */
    public List<Notification> findByUserId(int userId) {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT n.*, u.full_name AS from_user_name " +
                     "FROM notifications n " +
                     "LEFT JOIN users u ON n.from_user_id = u.id " +
                     "WHERE n.user_id = ? ORDER BY n.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /** Count unread notifications for a user */
    public int countUnread(int userId) {
        String sql = "SELECT COUNT(*) FROM notifications WHERE user_id = ? AND is_read = 0";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /** Mark a single notification as read */
    public boolean markAsRead(int notificationId) {
        String sql = "UPDATE notifications SET is_read = 1 WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, notificationId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Mark all notifications as read for a user */
    public boolean markAllAsRead(int userId) {
        String sql = "UPDATE notifications SET is_read = 1 WHERE user_id = ? AND is_read = 0";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() >= 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Map a ResultSet row to a Notification object */
    private Notification mapRow(ResultSet rs) throws SQLException {
        Notification n = new Notification();
        n.setId(rs.getInt("id"));
        n.setUserId(rs.getInt("user_id"));
        n.setFromUserId(rs.getInt("from_user_id"));
        n.setItemId(rs.getInt("item_id"));
        n.setMatchedItemId(rs.getInt("matched_item_id"));
        n.setMessage(rs.getString("message"));
        n.setRead(rs.getBoolean("is_read"));
        n.setCreatedAt(rs.getTimestamp("created_at"));
        try {
            n.setFromUserName(rs.getString("from_user_name"));
        } catch (SQLException ignored) {}
        return n;
    }
}
