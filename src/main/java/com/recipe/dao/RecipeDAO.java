package com.recipe.dao;

import com.recipe.model.Recipe;
import com.recipe.util.DatabaseException;

import java.util.List;
import java.util.Map;

/** Contract for all recipe-related database operations. */
public interface RecipeDAO {

    boolean addRecipe(Recipe recipe) throws DatabaseException;

    /** Returns the recipe or null if it does not exist. */
    Recipe findById(int id) throws DatabaseException;

    /** Approved recipes matching an optional keyword and optional category. */
    List<Recipe> searchApproved(String keyword, String category) throws DatabaseException;

    List<Recipe> getLatestApproved(int limit) throws DatabaseException;

    List<Recipe> getByUser(int userId) throws DatabaseException;

    List<Recipe> getByStatus(String status) throws DatabaseException;

    /** How many approved recipes exist in each category (category name -> count). */
    Map<String, Integer> countApprovedByCategory() throws DatabaseException;

    boolean updateStatus(int recipeId, String status) throws DatabaseException;

    /** Number of recipes with the given status; pass null to count all recipes. */
    int count(String status) throws DatabaseException;
}
