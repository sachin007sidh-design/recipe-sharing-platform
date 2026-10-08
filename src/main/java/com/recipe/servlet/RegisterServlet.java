package com.recipe.servlet;

import com.recipe.dao.UserDAO;
import com.recipe.dao.UserDAOImpl;
import com.recipe.model.User;
import com.recipe.util.DatabaseException;
import com.recipe.util.PasswordUtil;
import com.recipe.util.RequestUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

/** Handles new account sign-ups (GET shows the form, POST processes it). */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final Pattern EMAIL = Pattern.compile("^[\\w.+-]+@[\\w-]+(\\.[\\w-]+)+$");
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String name = RequestUtil.param(req, "name");
        String email = RequestUtil.param(req, "email").toLowerCase();
        String password = req.getParameter("password") == null ? "" : req.getParameter("password");
        String confirm = req.getParameter("confirm") == null ? "" : req.getParameter("confirm");

        List<String> errors = new ArrayList<>();
        if (name.length() < 2) errors.add("Please enter your name (at least 2 characters).");
        if (!EMAIL.matcher(email).matches()) errors.add("Please enter a valid email address.");
        if (password.length() < 6) errors.add("Password must be at least 6 characters.");
        if (!password.equals(confirm)) errors.add("Passwords do not match.");

        try {
            if (errors.isEmpty() && userDAO.findByEmail(email) != null) {
                errors.add("This email is already registered. Try logging in.");
            }
            if (errors.isEmpty()) {
                userDAO.addUser(new User(0, name, email, PasswordUtil.hash(password), "USER"));
                resp.sendRedirect(req.getContextPath() + "/login?registered=1");
                return;
            }
        } catch (DatabaseException e) {
            throw new ServletException(e);
        }

        // Validation failed: show the form again, keeping what the user typed
        req.setAttribute("errors", errors);
        req.setAttribute("name", name);
        req.setAttribute("email", email);
        req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
    }
}
