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
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/** Shows one recipe (/recipe?id=3). Unapproved recipes are visible only to the owner and admins. */
@WebServlet("/recipe")
public class RecipeDetailServlet extends HttpServlet {

    private final RecipeDAO recipeDAO = new RecipeDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id;
        try {
            id = Integer.parseInt(req.getParameter("id"));
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Recipe not found");
            return;
        }

        try {
            Recipe recipe = recipeDAO.findById(id);
            if (recipe == null || !canView(recipe, req)) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Recipe not found");
                return;
            }
            req.setAttribute("recipe", recipe);
            // Ingredients become a checklist, instructions become numbered steps
            req.setAttribute("ingredientList", toLines(recipe.getIngredients(), false));
            req.setAttribute("stepList", toLines(recipe.getInstructions(), true));
        } catch (DatabaseException e) {
            throw new ServletException(e);
        }
        req.getRequestDispatcher("/WEB-INF/views/recipe-detail.jsp").forward(req, resp);
    }

    /**
     * Splits multi-line text into a list of non-empty lines.
     * If stripNumbers is true, a leading "1." or "2)" is removed (the page numbers steps itself).
     */
    private List<String> toLines(String text, boolean stripNumbers) {
        List<String> lines = new ArrayList<>();
        if (text == null) {
            return lines;
        }
        for (String line : text.split("\\R")) {
            String trimmed = line.trim();
            if (stripNumbers) {
                trimmed = trimmed.replaceFirst("^\\d+[.)]\\s*", "");
            }
            if (!trimmed.isEmpty()) {
                lines.add(trimmed);
            }
        }
        return lines;
    }

    private boolean canView(Recipe recipe, HttpServletRequest req) {
        if ("APPROVED".equals(recipe.getStatus())) {
            return true;
        }
        HttpSession session = req.getSession(false);
        User user = (session == null) ? null : (User) session.getAttribute(AppConstants.SESSION_USER);
        return user != null && ("ADMIN".equals(user.getRole()) || user.getId() == recipe.getUserId());
    }
}
