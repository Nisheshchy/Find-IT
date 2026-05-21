/**
 * NotificationController.java
 * Purpose: Handles notification display and mark-as-read actions.
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.controller;

import com.findit.model.Notification;
import com.findit.service.NotificationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/user/notifications")
public class NotificationController extends HttpServlet {

    private final NotificationService notificationService = new NotificationService();

    /** Display all notifications for the logged-in user */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");

        List<Notification> notifications = notificationService.getNotifications(userId);
        request.setAttribute("notifications", notifications);

        request.getRequestDispatcher("/jsp/user/notifications.jsp").forward(request, response);
    }

    /** Handle mark-as-read and mark-all-as-read actions */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        String action = request.getParameter("action");

        if ("markAllRead".equals(action)) {
            notificationService.markAllAsRead(userId);
        } else if ("markRead".equals(action)) {
            String idStr = request.getParameter("notificationId");
            if (idStr != null) {
                try {
                    notificationService.markAsRead(Integer.parseInt(idStr));
                } catch (NumberFormatException ignored) {}
            }
        }

        response.sendRedirect(request.getContextPath() + "/user/notifications");
    }
}
