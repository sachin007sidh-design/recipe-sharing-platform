package com.recipe.model;

/** One recipe shared on the platform. */
public class Recipe {
    private int id;
    private int userId;
    private String title;
    private String description;
    private String ingredients;
    private String instructions;
    private String category;
    private String imagePath;
    private String status; // PENDING, APPROVED or REJECTED
    private int prepTime = 30;        // minutes
    private int servings = 2;
    private String difficulty = "EASY"; // EASY, MEDIUM or HARD
    private String authorName; // filled by a JOIN with users

    public Recipe() { }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getIngredients() { return ingredients; }
    public void setIngredients(String ingredients) { this.ingredients = ingredients; }
    public String getInstructions() { return instructions; }
    public void setInstructions(String instructions) { this.instructions = instructions; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }
    public int getPrepTime() { return prepTime; }
    public void setPrepTime(int prepTime) { this.prepTime = prepTime; }
    public int getServings() { return servings; }
    public void setServings(int servings) { this.servings = servings; }
    public String getDifficulty() { return difficulty; }
    public void setDifficulty(String difficulty) { this.difficulty = difficulty; }
    public String getAuthorName() { return authorName; }
    public void setAuthorName(String authorName) { this.authorName = authorName; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
