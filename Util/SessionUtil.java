/**
 * SessionUtil.java
 * Purpose: Utility class for managing user session data.
 * @author Nishesh Chaudhary
 */
package com.findit.util;

import com.findit.model.User;
import com.findit.dao.UserDAO;
import jakarta.servlet.http.HttpSession;

public class SessionUtil {

    /** Get the currently logged-in user from session */
    public static User getCurrentUser(HttpSession session) {
        if (session == null)
            return null;
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null)
            return null;
        UserDAO userDAO = new UserDAO();
        return userDAO.findById(userId);
    }

    /** Check if a user is currently logged in */
    public static boolean isLoggedIn(HttpSession session) {
        return session != null && session.getAttribute("userId") != null;
    }

    /** Check if the logged-in user is an admin */
    public static boolean isAdmin(HttpSession session) {
        if (session == null)
            return false;
        String role = (String) session.getAttribute("userRole");
        return "ADMIN".equals(role);
    }
}
