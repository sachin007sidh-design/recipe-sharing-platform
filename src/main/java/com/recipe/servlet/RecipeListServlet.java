package com.recipe.servlet;

import com.recipe.dao.RecipeDAO;
import com.recipe.dao.RecipeDAOImpl;
import com.recipe.util.AppConstants;
import com.recipe.util.DatabaseException;
import com.recipe.util.RequestUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/** Browse and search approved recipes (/recipes?q=pasta&category=Dinner). */
@WebServlet("/recipes")
public class RecipeListServlet extends HttpServlet {

    private final RecipeDAO recipeDAO = new RecipeDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String q = RequestUtil.param(req, "q");
        String category = RequestUtil.param(req, "category");
        try {
            req.setAttribute("recipes", recipeDAO.searchApproved(q, category));
        } catch (DatabaseException e) {
            throw new ServletException(e);
        }
        req.setAttribute("q", q);
        req.setAttribute("selectedCategory", category);
        req.setAttribute("categories", AppConstants.CATEGORIES);
        req.getRequestDispatcher("/WEB-INF/views/recipes.jsp").forward(req, resp);
    }
}
