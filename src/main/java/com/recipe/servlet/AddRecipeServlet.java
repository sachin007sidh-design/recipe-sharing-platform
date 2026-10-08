package com.recipe.servlet;

import com.recipe.dao.RecipeDAO;
import com.recipe.dao.RecipeDAOImpl;
import com.recipe.model.Recipe;
import com.recipe.model.User;
import com.recipe.util.AppConstants;
import com.recipe.util.DatabaseException;
import com.recipe.util.RequestUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/** Lets a logged-in user submit a recipe. New recipes wait for admin approval. */
@WebServlet("/user/add-recipe")
public class AddRecipeServlet extends HttpServlet {

    private final RecipeDAO recipeDAO = new RecipeDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("categories", AppConstants.CATEGORIES);
        req.setAttribute("difficulties", AppConstants.DIFFICULTIES);
        req.getRequestDispatcher("/WEB-INF/views/user/add-recipe.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute(AppConstants.SESSION_USER);

        Recipe recipe = new Recipe();
        recipe.setUserId(user.getId());
        recipe.setTitle(RequestUtil.param(req, "title"));
        recipe.setDescription(RequestUtil.param(req, "description"));
        recipe.setIngredients(RequestUtil.param(req, "ingredients"));
        recipe.setInstructions(RequestUtil.param(req, "instructions"));
        recipe.setCategory(RequestUtil.param(req, "category"));
        recipe.setImagePath(RequestUtil.param(req, "imagePath"));
        recipe.setPrepTime(parseInt(RequestUtil.param(req, "prepTime"), 0));
        recipe.setServings(parseInt(RequestUtil.param(req, "servings"), 0));
        recipe.setDifficulty(RequestUtil.param(req, "difficulty"));
        recipe.setStatus("PENDING");

        List<String> errors = new ArrayList<>();
        if (recipe.getTitle().length() < 3) errors.add("Title must be at least 3 characters.");
        if (recipe.getIngredients().isEmpty()) errors.add("Please list the ingredients.");
        if (recipe.getInstructions().isEmpty()) errors.add("Please add the cooking instructions.");
        if (!AppConstants.CATEGORIES.contains(recipe.getCategory())) errors.add("Please choose a category.");
        if (recipe.getPrepTime() < 1 || recipe.getPrepTime() > 1440) errors.add("Prep time must be between 1 and 1440 minutes.");
        if (recipe.getServings() < 1 || recipe.getServings() > 50) errors.add("Servings must be between 1 and 50.");
        if (!AppConstants.DIFFICULTIES.contains(recipe.getDifficulty())) errors.add("Please choose a difficulty.");

        if (errors.isEmpty()) {
            try {
                recipeDAO.addRecipe(recipe);
            } catch (DatabaseException e) {
                throw new ServletException(e);
            }
            resp.sendRedirect(req.getContextPath() + "/user/dashboard?added=1");
            return;
        }

        req.setAttribute("errors", errors);
        req.setAttribute("recipe", recipe); // so the form keeps what the user typed
        req.setAttribute("categories", AppConstants.CATEGORIES);
        req.setAttribute("difficulties", AppConstants.DIFFICULTIES);
        req.getRequestDispatcher("/WEB-INF/views/user/add-recipe.jsp").forward(req, resp);
    }

    /** Converts text to a number; returns the fallback if it is not a valid number. */
    private int parseInt(String text, int fallback) {
        try {
            return Integer.parseInt(text);
        } catch (NumberFormatException e) {
            return fallback;
        }
    }
}
