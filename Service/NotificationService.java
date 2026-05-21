/**
 * NotificationService.java
 * Purpose: Business logic layer for notification operations.
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.service;

import com.findit.dao.NotificationDAO;
import com.findit.model.Notification;

import java.util.List;

public class NotificationService {

    private final NotificationDAO notificationDAO = new NotificationDAO();

    /** Create a match notification for the lost item owner */
    public boolean createMatchNotification(int lostItemOwnerId, int fromUserId, int lostItemId, int foundItemId) {
        Notification n = new Notification();
        n.setUserId(lostItemOwnerId);
        n.setFromUserId(fromUserId);
        n.setItemId(lostItemId);
        n.setMatchedItemId(foundItemId);
        n.setMessage("Someone has posted a found item that may match your lost item. Please check the details.");
        return notificationDAO.insert(n);
    }

    /** Create a generic notification */
    public boolean createNotification(Notification n) {
        return notificationDAO.insert(n);
    }

    /** Get all notifications for a user */
    public List<Notification> getNotifications(int userId) {
        return notificationDAO.findByUserId(userId);
    }

    /** Get count of unread notifications */
    public int getUnreadCount(int userId) {
        return notificationDAO.countUnread(userId);
    }

    /** Mark a single notification as read */
    public boolean markAsRead(int notificationId) {
        return notificationDAO.markAsRead(notificationId);
    }

    /** Mark all notifications as read */
    public boolean markAllAsRead(int userId) {
        return notificationDAO.markAllAsRead(userId);
    }
}
