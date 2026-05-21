/**
 * Category.java
 * Purpose: Model class representing an item category (e.g., Electronics, Clothing).
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.model;

import java.sql.Timestamp;

public class Category {
    private int id;
    private String name;
    private Timestamp createdAt;

    /** Default constructor */
    public Category() {}

    /** Parameterized constructor */
    public Category(String name) {
        this.name = name;
    }

    /** Get category ID */
    public int getId() { return id; }

    /** Set category ID */
    public void setId(int id) { this.id = id; }

    /** Get category name */
    public String getName() { return name; }

    /** Set category name */
    public void setName(String name) { this.name = name; }

    /** Get creation timestamp */
    public Timestamp getCreatedAt() { return createdAt; }

    /** Set creation timestamp */
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
