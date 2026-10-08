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
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/** Admin dashboard: statistics, chart data, recipes waiting for approval, and all users. */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAOImpl();
    private final RecipeDAO recipeDAO = new RecipeDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            req.setAttribute("totalUsers", userDAO.countUsers());
            req.setAttribute("totalRecipes", recipeDAO.count(null));
            req.setAttribute("approvedCount", recipeDAO.count("APPROVED"));
            req.setAttribute("pendingCount", recipeDAO.count("PENDING"));
            req.setAttribute("rejectedCount", recipeDAO.count("REJECTED"));
            req.setAttribute("pendingRecipes", recipeDAO.getByStatus("PENDING"));
            req.setAttribute("users", userDAO.getAllUsers());

            // Chart data: one value per category, in the same order as the fixed category list
            Map<String, Integer> perCategory = recipeDAO.countApprovedByCategory();
            List<Integer> categoryValues = new ArrayList<>();
            for (String category : AppConstants.CATEGORIES) {
                categoryValues.add(perCategory.getOrDefault(category, 0));
            }
            req.setAttribute("categoryLabels", AppConstants.CATEGORIES);
            req.setAttribute("categoryValues", categoryValues);
        } catch (DatabaseException e) {
            throw new ServletException(e);
        }
        req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, resp);
    }
}
