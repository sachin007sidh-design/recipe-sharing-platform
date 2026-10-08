package com.recipe.servlet;

import com.recipe.dao.RecipeDAO;
import com.recipe.dao.RecipeDAOImpl;
import com.recipe.dao.UserDAO;
import com.recipe.dao.UserDAOImpl;
import com.recipe.util.AppConstants;
import com.recipe.util.DatabaseException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/** Landing page: newest recipes, category tiles with counts, and site statistics. */
@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private final RecipeDAO recipeDAO = new RecipeDAOImpl();
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            req.setAttribute("latest", recipeDAO.getLatestApproved(6));
            req.setAttribute("categoryCounts", recipeDAO.countApprovedByCategory());
            req.setAttribute("recipeTotal", recipeDAO.count("APPROVED"));
            req.setAttribute("cookTotal", userDAO.countUsers());
        } catch (DatabaseException e) {
            throw new ServletException(e);
        }
        req.setAttribute("categories", AppConstants.CATEGORIES);
        req.setAttribute("categoryIcons", AppConstants.CATEGORY_ICONS);
        req.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(req, resp);
    }
}
