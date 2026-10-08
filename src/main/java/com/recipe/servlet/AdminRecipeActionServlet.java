package com.recipe.servlet;

import com.recipe.dao.RecipeDAO;
import com.recipe.dao.RecipeDAOImpl;
import com.recipe.util.DatabaseException;
import com.recipe.util.RequestUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/** Admin approves or rejects a pending recipe (POST only). */
@WebServlet("/admin/recipe-action")
public class AdminRecipeActionServlet extends HttpServlet {

    private final RecipeDAO recipeDAO = new RecipeDAOImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = RequestUtil.param(req, "action");
        String status = switch (action) {
            case "approve" -> "APPROVED";
            case "reject" -> "REJECTED";
            default -> null;
        };

        try {
            int id = Integer.parseInt(RequestUtil.param(req, "id"));
            if (status != null) {
                recipeDAO.updateStatus(id, status);
            }
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid recipe id");
            return;
        } catch (DatabaseException e) {
            throw new ServletException(e);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
    }
}
