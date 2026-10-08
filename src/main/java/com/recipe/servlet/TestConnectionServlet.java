package com.recipe.servlet;

import com.recipe.dao.UserDAO;
import com.recipe.dao.UserDAOImpl;
import com.recipe.util.DatabaseException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

/** Visit /recipe/test-db to confirm Java can talk to MySQL. */
@WebServlet("/test-db")
public class TestConnectionServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = resp.getWriter()) {
            try {
                int count = userDAO.countUsers();
                out.println("<h2 style='color:green'>Database connected!</h2>");
                out.println("<p>Users in database: " + count + "</p>");
            } catch (DatabaseException e) {
                out.println("<h2 style='color:red'>Connection failed</h2>");
                out.println("<p>" + e.getMessage() + "</p>");
                out.println("<p>Cause: " + (e.getCause() != null ? e.getCause().getMessage() : "unknown") + "</p>");
            }
        }
    }
}
