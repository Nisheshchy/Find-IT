/**
 * MessageDAO.java
 * Purpose: Data access object for item chat message operations.
 * Author: Nishesh Chaudhary
 */
package com.findit.dao;

import com.findit.model.Message;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MessageDAO {

    /** Insert a new message */
    public boolean insert(Message m) {
        String sql = "INSERT INTO messages (item_id, sender_id, receiver_id, message_text) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, m.getItemId());
            ps.setInt(2, m.getSenderId());
            ps.setInt(3, m.getReceiverId());
            ps.setString(4, m.getMessageText());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Find all messages for an item, chronological order */
    public List<Message> findByItemId(int itemId) {
        List<Message> list = new ArrayList<>();
        String sql = "SELECT m.*, u.full_name AS sender_name " +
                     "FROM messages m " +
                     "LEFT JOIN users u ON m.sender_id = u.id " +
                     "WHERE m.item_id = ? ORDER BY m.created_at ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, itemId);
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

    /** Count unread messages where the user is the receiver */
    public int countUnreadForUser(int userId) {
        String sql = "SELECT COUNT(*) FROM messages WHERE receiver_id = ? AND is_read = 0";
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

    /** Mark messages as read for a specific user on a specific item */
    public boolean markAsRead(int itemId, int userId) {
        String sql = "UPDATE messages SET is_read = 1 WHERE item_id = ? AND receiver_id = ? AND is_read = 0";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, itemId);
            ps.setInt(2, userId);
            return ps.executeUpdate() >= 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Map a ResultSet row to a Message object */
    private Message mapRow(ResultSet rs) throws SQLException {
        Message m = new Message();
        m.setId(rs.getInt("id"));
        m.setItemId(rs.getInt("item_id"));
        m.setSenderId(rs.getInt("sender_id"));
        m.setReceiverId(rs.getInt("receiver_id"));
        m.setMessageText(rs.getString("message_text"));
        m.setRead(rs.getBoolean("is_read"));
        m.setCreatedAt(rs.getTimestamp("created_at"));
        try {
            m.setSenderName(rs.getString("sender_name"));
        } catch (SQLException ignored) {}
        return m;
    }
}
