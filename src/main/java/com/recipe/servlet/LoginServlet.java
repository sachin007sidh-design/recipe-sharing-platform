package com.recipe.servlet;

import com.recipe.dao.UserDAO;
import com.recipe.dao.UserDAOImpl;
import com.recipe.model.User;
import com.recipe.util.AppConstants;
import com.recipe.util.DatabaseException;
import com.recipe.util.PasswordUtil;
import com.recipe.util.RequestUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/** Handles login. On success the User object is stored in the HTTP session. */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute(AppConstants.SESSION_USER) != null) {
            User user = (User) session.getAttribute(AppConstants.SESSION_USER);
            resp.sendRedirect(req.getContextPath() + user.getDashboardPath());
            return;
        }
        req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String email = RequestUtil.param(req, "email").toLowerCase();
        String password = req.getParameter("password") == null ? "" : req.getParameter("password");

        try {
            User user = userDAO.findByEmail(email);
            if (user != null && user.getPasswordHash().equals(PasswordUtil.hash(password))) {
                req.changeSessionId(); // protects against session fixation
                req.getSession().setAttribute(AppConstants.SESSION_USER, user);
                // Polymorphism: Admin and User each return their own dashboard path
                resp.sendRedirect(req.getContextPath() + user.getDashboardPath());
                return;
            }
        } catch (DatabaseException e) {
            throw new ServletException(e);
        }

        req.setAttribute("error", "Incorrect email or password.");
        req.setAttribute("email", email);
        req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
    }
}
