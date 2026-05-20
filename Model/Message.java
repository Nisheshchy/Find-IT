/**
 * Message.java
 * Purpose: Model class representing a chat message on an item.
 * Author: Nishesh Chaudhary
 */
package com.findit.model;

import java.sql.Timestamp;

public class Message {
    private int id;
    private int itemId;
    private int senderId;
    private int receiverId;
    private String messageText;
    private boolean isRead;
    private Timestamp createdAt;

    // Transient fields
    private String senderName;

    public Message() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }

    public int getSenderId() { return senderId; }
    public void setSenderId(int senderId) { this.senderId = senderId; }

    public int getReceiverId() { return receiverId; }
    public void setReceiverId(int receiverId) { this.receiverId = receiverId; }

    public String getMessageText() { return messageText; }
    public void setMessageText(String messageText) { this.messageText = messageText; }

    public boolean isRead() { return isRead; }
    public void setRead(boolean read) { isRead = read; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getSenderName() { return senderName; }
    public void setSenderName(String senderName) { this.senderName = senderName; }
}
