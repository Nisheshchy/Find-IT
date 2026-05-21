/**
 * ItemDetailController.java
 * Purpose: Handles displaying the details of a specific item,
 *          including chat messages for logged-in users.
 * Author: Nishesh Chaudhary
 */
package com.findit.controller;

import com.findit.model.Item;
import com.findit.model.Message;
import com.findit.service.ItemService;
import com.findit.service.MessageService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/item")
public class ItemDetailController extends HttpServlet {

    private final ItemService itemService = new ItemService();
    private final MessageService messageService = new MessageService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/browse");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            Item item = itemService.getItemById(id);

            if (item == null) {
                response.sendRedirect(request.getContextPath() + "/browse");
                return;
            }

            request.setAttribute("item", item);

            // Load chat messages for this item
            List<Message> messages = messageService.getMessagesForItem(id);
            request.setAttribute("messages", messages);

            // If user is logged in, mark messages directed to them as read
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("userId") != null) {
                int userId = (int) session.getAttribute("userId");
                messageService.markMessagesAsRead(id, userId);
            }

            // If this is a FOUND item with a match, load the matched lost item
            if ("FOUND".equals(item.getType()) && item.getMatchedLostItemId() > 0) {
                Item matchedLostItem = itemService.getItemById(item.getMatchedLostItemId());
                request.setAttribute("matchedLostItem", matchedLostItem);
            }

            request.getRequestDispatcher("/jsp/item-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/browse");
        }
    }
}
