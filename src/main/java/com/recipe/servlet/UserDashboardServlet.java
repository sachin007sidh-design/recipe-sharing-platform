package com.recipe.servlet;

import com.recipe.dao.RecipeDAO;
import com.recipe.dao.RecipeDAOImpl;
import com.recipe.model.Recipe;
import com.recipe.model.User;
import com.recipe.util.AppConstants;
import com.recipe.util.DatabaseException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/** Dashboard for a logged-in user: their recipes and a count per status. */
@WebServlet("/user/dashboard")
public class UserDashboardServlet extends HttpServlet {

    private final RecipeDAO recipeDAO = new RecipeDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute(AppConstants.SESSION_USER);
        try {
            List<Recipe> mine = recipeDAO.getByUser(user.getId());

            // Collections: a Map of status -> how many recipes have it
            Map<String, Integer> stats = new LinkedHashMap<>();
            stats.put("PENDING", 0);
            stats.put("APPROVED", 0);
            stats.put("REJECTED", 0);
            for (Recipe r : mine) {
                stats.merge(r.getStatus(), 1, Integer::sum);
            }

            req.setAttribute("myRecipes", mine);
            req.setAttribute("stats", stats);
        } catch (DatabaseException e) {
            throw new ServletException(e);
        }
        req.getRequestDispatcher("/WEB-INF/views/user/dashboard.jsp").forward(req, resp);
    }
}
