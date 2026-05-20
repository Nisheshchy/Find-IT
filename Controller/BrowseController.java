/**
 * BrowseController.java
 * Purpose: Handles public browse page to display all lost and found items
 *          with type filtering and keyword search.
 * Author:Nishesh Chaudhary
 */
package com.findit.controller;

import com.findit.model.Item;
import com.findit.service.ItemService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/browse")
public class BrowseController extends HttpServlet {

    private final ItemService itemService = new ItemService();

    /** Display the browse items page with optional type filter and search */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String type = request.getParameter("type");
        String query = request.getParameter("q");
        List<Item> items;

        boolean hasSearch = query != null && !query.trim().isEmpty();
        boolean hasType = "LOST".equals(type) || "FOUND".equals(type);

        if (hasSearch && hasType) {
            items = itemService.searchItemsByType(type, query.trim());
        } else if (hasSearch) {
            items = itemService.searchItems(query.trim());
            type = "ALL";
        } else if (hasType) {
            items = itemService.getItemsByType(type);
        } else {
            items = itemService.getAllItems();
            type = "ALL";
        }

        request.setAttribute("items", items);
        request.setAttribute("activeType", type);
        request.setAttribute("searchQuery", hasSearch ? query.trim() : "");

        request.getRequestDispatcher("/jsp/browse.jsp").forward(request, response);
    }


}
