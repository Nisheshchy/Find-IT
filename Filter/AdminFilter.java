/**
 * AdminFilter.java
 * Purpose: Servlet filter that blocks non-admin access to /admin/* URLs.
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.filter;

import com.findit.dao.UserDAO;
import com.findit.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {

    /** Initialize the filter */
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialization needed
    }

    /** Filter incoming requests to check admin authorization */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpServletResponse httpRes = (HttpServletResponse) response;
        HttpSession session = httpReq.getSession(false);

        boolean loggedIn = (session != null && session.getAttribute("userId") != null);

        // Try to restore from remember-me cookie if not logged in
        if (!loggedIn) {
            Cookie[] cookies = httpReq.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("findit_remember".equals(cookie.getName())) {
                        try {
                            int userId = Integer.parseInt(cookie.getValue());
                            UserDAO userDAO = new UserDAO();
                            User user = userDAO.findById(userId);
                            if (user != null && "active".equals(user.getStatus())) {
                                session = httpReq.getSession(true);
                                session.setAttribute("userId", user.getId());
                                session.setAttribute("userRole", user.getRole());
                                session.setAttribute("userName", user.getFullName());
                                loggedIn = true;
                            }
                        } catch (NumberFormatException ignored) {}
                        break;
                    }
                }
            }
        }

        if (!loggedIn) {
            httpRes.sendRedirect(httpReq.getContextPath() + "/login");
            return;
        }

        String role = (String) session.getAttribute("userRole");
        if (!"ADMIN".equals(role)) {
            httpReq.getRequestDispatcher("/jsp/errors/403.jsp").forward(httpReq, httpRes);
            return;
        }

        chain.doFilter(request, response);
    }

    /** Destroy the filter */
    @Override
    public void destroy() {
        // No cleanup needed
    }
}
