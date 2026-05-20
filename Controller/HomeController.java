/**
 * HomeController.java
 * Purpose: Handles the home page with recent items for display.
 * Author: Nishesh Chaudhary
 */
package com.findit.controller;

import com.findit.model.Item;
import com.findit.service.ItemService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeController extends HttpServlet {

    private final ItemService itemService = new ItemService();

    /** Display the home page with 6 most recent items and stats */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Item> recentItems = itemService.getRecentItems(6);
        request.setAttribute("recentItems", recentItems);

        // Hero stats
        request.setAttribute("totalLost", itemService.getLostCount());
        request.setAttribute("totalFound", itemService.getFoundCount());
        request.setAttribute("itemsResolved", itemService.getResolvedCount());

        request.getRequestDispatcher("/jsp/index.jsp").forward(request, response);
    }
}
