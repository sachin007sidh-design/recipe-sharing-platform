package com.recipe.dao;

import com.recipe.model.User;
import com.recipe.util.DatabaseException;

import java.util.List;

/** Contract for everything we can do with users in the database (interface). */
public interface UserDAO {

    /** Saves a new user; returns true if inserted. */
    boolean addUser(User user) throws DatabaseException;

    /** Finds a user by email, or null if none exists. */
    User findByEmail(String email) throws DatabaseException;

    /** Returns all users (generic List of User). */
    List<User> getAllUsers() throws DatabaseException;

    /** Total number of users. */
    int countUsers() throws DatabaseException;
}
