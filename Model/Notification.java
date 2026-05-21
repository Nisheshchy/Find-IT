/**
 * Notification.java
 * Purpose: Model class representing a user notification.
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.model;

import java.sql.Timestamp;

public class Notification {
    private int id;
    private int userId;
    private int fromUserId;
    private int itemId;
    private int matchedItemId;
    private String message;
    private boolean isRead;
    private Timestamp createdAt;

    // Transient fields
    private String fromUserName;

    public Notification() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getFromUserId() { return fromUserId; }
    public void setFromUserId(int fromUserId) { this.fromUserId = fromUserId; }

    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }

    public int getMatchedItemId() { return matchedItemId; }
    public void setMatchedItemId(int matchedItemId) { this.matchedItemId = matchedItemId; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public boolean isRead() { return isRead; }
    public void setRead(boolean read) { isRead = read; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getFromUserName() { return fromUserName; }
    public void setFromUserName(String fromUserName) { this.fromUserName = fromUserName; }
}
