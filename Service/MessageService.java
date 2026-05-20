/**
 * MessageService.java
 * Purpose: Business logic layer for item chat message operations.
 * Author: Nishesh Chaudhary
 */
package com.findit.service;

import com.findit.dao.MessageDAO;
import com.findit.model.Message;

import java.util.List;

public class MessageService {

    private final MessageDAO messageDAO = new MessageDAO();

    /** Send a message */
    public boolean sendMessage(Message m) {
        return messageDAO.insert(m);
    }

    /** Get all messages for an item */
    public List<Message> getMessagesForItem(int itemId) {
        return messageDAO.findByItemId(itemId);
    }

    /** Get count of unread messages for a user */
    public int getUnreadMessageCount(int userId) {
        return messageDAO.countUnreadForUser(userId);
    }

    /** Mark messages as read for a user on a specific item */
    public boolean markMessagesAsRead(int itemId, int userId) {
        return messageDAO.markAsRead(itemId, userId);
    }
}
