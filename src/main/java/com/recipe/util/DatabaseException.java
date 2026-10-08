package com.recipe.util;

/**
 * Custom checked exception for all database problems.
 * Wrapping SQLException keeps the rest of the app independent of JDBC details.
 */
public class DatabaseException extends Exception {
    public DatabaseException(String message, Throwable cause) {
        super(message, cause);
    }

    public DatabaseException(String message) {
        super(message);
    }
}
