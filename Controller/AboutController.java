/**
 * AboutController.java
 * Purpose: Handles the about page of FindIt including team member profiles.
 * @Author Nishesh Chaudhary

 */
package com.findit.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/about")
public class AboutController extends HttpServlet {

    /** Display the About Us and Team page */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/about.jsp").forward(request, response);
    }
}
