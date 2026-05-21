/**
 * ChatController.java
 * Purpose: Handles sending chat messages on item detail pages.
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

@WebServlet("/item/chat")
public class ChatController extends HttpServlet {

    private final MessageService messageService = new MessageService();
    private final ItemService itemService = new ItemService();

    /** Process a chat message submission */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        // Must be logged in
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String itemIdStr = request.getParameter("itemId");
        String messageText = request.getParameter("messageText");

        if (itemIdStr == null || messageText == null || messageText.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/browse");
            return;
        }

        // Add the message limit

        messageText = messageText.trim();
        if (messageText.length() > 1000) {
            response.sendRedirect(request.getContextPath() + "/item?id=" + itemIdStr + "&error=Message too long (max 1000 chars)");
            return;
        }

        try {
            int itemId = Integer.parseInt(itemIdStr);
            Item item = itemService.getItemById(itemId);

            if (item == null) {
                response.sendRedirect(request.getContextPath() + "/browse");
                return;
            }

            // Cannot chat on own item
            if (item.getUserId() == userId) {
                response.sendRedirect(request.getContextPath() + "/item?id=" + itemId);
                return;
            }

            Message msg = new Message();
            msg.setItemId(itemId);
            msg.setSenderId(userId);
            msg.setReceiverId(item.getUserId());
            msg.setMessageText(messageText.trim());

            messageService.sendMessage(msg);

            response.sendRedirect(request.getContextPath() + "/item?id=" + itemId + "#chat-section");

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/browse");
        }
    }
}
