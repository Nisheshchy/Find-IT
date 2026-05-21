/**
 * AuthFilter.java
 * Purpose: Servlet filter that blocks unauthenticated access to /user/* URLs.
 *          Also handles remember-me cookie session restoration.
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

@WebFilter("/user/*")
public class AuthFilter implements Filter {

    /** Initialize the filter */
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialization needed
    }

    /** Filter incoming requests to check authentication */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpServletResponse httpRes = (HttpServletResponse) response;
        HttpSession session = httpReq.getSession(false);

        boolean loggedIn = (session != null && session.getAttribute("userId") != null);

        // If not logged in, try to restore session from remember-me cookie
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
                                // Restore session
                                session = httpReq.getSession(true);
                                session.setAttribute("userId", user.getId());
                                session.setAttribute("userRole", user.getRole());
                                session.setAttribute("userName", user.getFullName());
                                loggedIn = true;
                            }
                        } catch (NumberFormatException ignored) {
                            // Invalid cookie value, ignore
                        }
                        break;
                    }
                }
            }
        }

        if (loggedIn) {
            chain.doFilter(request, response);
        } else {
            httpRes.sendRedirect(httpReq.getContextPath() + "/login");
        }
    }

    /** Destroy the filter */
    @Override
    public void destroy() {
        // No cleanup needed
    }
}
