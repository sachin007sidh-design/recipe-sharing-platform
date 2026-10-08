package com.recipe.dao;

import com.recipe.model.Recipe;
import com.recipe.util.DBConnection;
import com.recipe.util.DatabaseException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/** JDBC implementation of RecipeDAO. */
public class RecipeDAOImpl implements RecipeDAO {

    // Every query reuses this SELECT so each recipe also carries its author's name
    private static final String BASE_SELECT =
            "SELECT r.*, u.name AS author FROM recipes r JOIN users u ON r.user_id = u.id";

    @Override
    public boolean addRecipe(Recipe r) throws DatabaseException {
        String sql = "INSERT INTO recipes (user_id, title, description, ingredients, "
                + "instructions, category, image_path, prep_time, servings, difficulty, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, r.getUserId());
            ps.setString(2, r.getTitle());
            ps.setString(3, r.getDescription());
            ps.setString(4, r.getIngredients());
            ps.setString(5, r.getInstructions());
            ps.setString(6, r.getCategory());
            ps.setString(7, r.getImagePath());
            ps.setInt(8, r.getPrepTime());
            ps.setInt(9, r.getServings());
            ps.setString(10, r.getDifficulty());
            ps.setString(11, r.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new DatabaseException("Could not save recipe", e);
        }
    }

    @Override
    public Recipe findById(int id) throws DatabaseException {
        List<Recipe> list = query(BASE_SELECT + " WHERE r.id = ?", List.of(id));
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public List<Recipe> searchApproved(String keyword, String category) throws DatabaseException {
        StringBuilder sql = new StringBuilder(BASE_SELECT + " WHERE r.status = 'APPROVED'");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.isBlank()) {
            sql.append(" AND (r.title LIKE ? OR r.ingredients LIKE ? OR r.description LIKE ?)");
            String like = "%" + keyword.trim() + "%";
            params.add(like);
            params.add(like);
            params.add(like);
        }
        if (category != null && !category.isBlank()) {
            sql.append(" AND r.category = ?");
            params.add(category);
        }
        sql.append(" ORDER BY r.created_at DESC");
        return query(sql.toString(), params);
    }

    @Override
    public List<Recipe> getLatestApproved(int limit) throws DatabaseException {
        return query(BASE_SELECT + " WHERE r.status = 'APPROVED' ORDER BY r.created_at DESC LIMIT ?",
                List.of(limit));
    }

    @Override
    public List<Recipe> getByUser(int userId) throws DatabaseException {
        return query(BASE_SELECT + " WHERE r.user_id = ? ORDER BY r.created_at DESC", List.of(userId));
    }

    @Override
    public List<Recipe> getByStatus(String status) throws DatabaseException {
        return query(BASE_SELECT + " WHERE r.status = ? ORDER BY r.created_at DESC", List.of(status));
    }

    @Override
    public boolean updateStatus(int recipeId, String status) throws DatabaseException {
        String sql = "UPDATE recipes SET status = ? WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, recipeId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new DatabaseException("Could not update recipe status", e);
        }
    }

    @Override
    public int count(String status) throws DatabaseException {
        String sql = "SELECT COUNT(*) FROM recipes" + (status == null ? "" : " WHERE status = ?");
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            if (status != null) {
                ps.setString(1, status);
            }
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        } catch (SQLException e) {
            throw new DatabaseException("Could not count recipes", e);
        }
    }

    @Override
    public Map<String, Integer> countApprovedByCategory() throws DatabaseException {
        Map<String, Integer> counts = new LinkedHashMap<>();
        String sql = "SELECT category, COUNT(*) AS total FROM recipes "
                + "WHERE status = 'APPROVED' GROUP BY category";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                counts.put(rs.getString("category"), rs.getInt("total"));
            }
            return counts;
        } catch (SQLException e) {
            throw new DatabaseException("Could not count recipes per category", e);
        }
    }

    /** Runs any SELECT with the given parameters and converts rows to Recipe objects. */
    private List<Recipe> query(String sql, List<?> params) throws DatabaseException {
        List<Recipe> result = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    result.add(mapRow(rs));
                }
            }
            return result;
        } catch (SQLException e) {
            throw new DatabaseException("Could not load recipes", e);
        }
    }

    private Recipe mapRow(ResultSet rs) throws SQLException {
        Recipe r = new Recipe();
        r.setId(rs.getInt("id"));
        r.setUserId(rs.getInt("user_id"));
        r.setTitle(rs.getString("title"));
        r.setDescription(rs.getString("description"));
        r.setIngredients(rs.getString("ingredients"));
        r.setInstructions(rs.getString("instructions"));
        r.setCategory(rs.getString("category"));
        r.setImagePath(rs.getString("image_path"));
        r.setPrepTime(rs.getInt("prep_time"));
        r.setServings(rs.getInt("servings"));
        r.setDifficulty(rs.getString("difficulty"));
        r.setStatus(rs.getString("status"));
        r.setAuthorName(rs.getString("author"));
        return r;
    }
}
