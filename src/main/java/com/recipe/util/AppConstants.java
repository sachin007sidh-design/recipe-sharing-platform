package com.recipe.util;

import java.util.List;
import java.util.Map;

/** Values shared across the whole application. */
public final class AppConstants {

    public static final List<String> CATEGORIES =
            List.of("Breakfast", "Lunch", "Dinner", "Dessert", "Snacks", "Beverages", "Vegan");

    /** Bootstrap Icons class for each category tile on the home page. */
    public static final Map<String, String> CATEGORY_ICONS = Map.of(
            "Breakfast", "bi-cup-hot-fill",
            "Lunch", "bi-basket2-fill",
            "Dinner", "bi-moon-stars-fill",
            "Dessert", "bi-cake2-fill",
            "Snacks", "bi-cookie",
            "Beverages", "bi-cup-straw",
            "Vegan", "bi-flower1");

    public static final List<String> DIFFICULTIES = List.of("EASY", "MEDIUM", "HARD");

    /** Name of the session attribute that stores the logged-in user. */
    public static final String SESSION_USER = "user";

    private AppConstants() { }
}
