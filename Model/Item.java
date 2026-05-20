/**
 * Item.java
 * Purpose: Model class representing a lost or found item report.
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Item {
    private int id;
    private String title;
    private String description;
    private int categoryId;
    private String type;              // LOST or FOUND
    private String location;
    private Date dateOccurred;
    private String contactPreference; // email, phone, both
    private String status;            // internal DB field (not displayed in UI)
    private int matchedLostItemId;    // for FOUND items: linked lost item ID (0 = none)
    private int userId;
    private Timestamp createdAt;

    // Transient fields for display (joined from other tables)
    private String categoryName;
    private String userName;

    /** Default constructor */
    public Item() {}

    /** Get item ID */
    public int getId() { return id; }

    /** Set item ID */
    public void setId(int id) { this.id = id; }

    /** Get item title */
    public String getTitle() { return title; }

    /** Set item title */
    public void setTitle(String title) { this.title = title; }

    /** Get item description */
    public String getDescription() { return description; }

    /** Set item description */
    public void setDescription(String description) { this.description = description; }

    /** Get category ID */
    public int getCategoryId() { return categoryId; }

    /** Set category ID */
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    /** Get item type (LOST or FOUND) */
    public String getType() { return type; }

    /** Set item type */
    public void setType(String type) { this.type = type; }

    /** Get location where item was lost or found */
    public String getLocation() { return location; }

    /** Set location */
    public void setLocation(String location) { this.location = location; }

    /** Get date the item was lost or found */
    public Date getDateOccurred() { return dateOccurred; }

    /** Set date occurred */
    public void setDateOccurred(Date dateOccurred) { this.dateOccurred = dateOccurred; }

    /** Get contact preference */
    public String getContactPreference() { return contactPreference; }

    /** Set contact preference */
    public void setContactPreference(String contactPreference) { this.contactPreference = contactPreference; }

    /** Get item status */
    public String getStatus() { return status; }

    /** Set item status */
    public void setStatus(String status) { this.status = status; }

    /** Get ID of the user who posted this item */
    public int getUserId() { return userId; }

    /** Set user ID */
    public void setUserId(int userId) { this.userId = userId; }

    /** Get creation timestamp */
    public Timestamp getCreatedAt() { return createdAt; }

    /** Set creation timestamp */
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    /** Get category name (transient, from JOIN) */
    public String getCategoryName() { return categoryName; }

    /** Set category name */
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    /** Get user name (transient, from JOIN) */
    public String getUserName() { return userName; }

    /** Set user name */
    public void setUserName(String userName) { this.userName = userName; }

    /** Get matched lost item ID (for FOUND items) */
    public int getMatchedLostItemId() { return matchedLostItemId; }

    /** Set matched lost item ID */
    public void setMatchedLostItemId(int matchedLostItemId) { this.matchedLostItemId = matchedLostItemId; }

    /** Get truncated description for card display */
    public String getShortDescription() {
        if (description == null) return "";
        return description.length() > 100 ? description.substring(0, 100) + "..." : description;
    }
}
