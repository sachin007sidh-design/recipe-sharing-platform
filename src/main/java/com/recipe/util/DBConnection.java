package com.recipe.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Central place that creates JDBC connections.
 * Settings are read once from db.properties (src/main/resources).
 */
public final class DBConnection {

    private static final Properties CONFIG = new Properties();

    // Static block: runs once when the class is first used
    static {
        try (InputStream in = DBConnection.class.getClassLoader()
                .getResourceAsStream("db.properties")) {
            if (in == null) {
                throw new IllegalStateException("db.properties not found on classpath");
            }
            CONFIG.load(in);
            Class.forName("com.mysql.cj.jdbc.Driver"); // load MySQL driver
        } catch (IOException | ClassNotFoundException e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    private DBConnection() { } // utility class, no objects

    /** Opens a NEW connection. Callers must close it (use try-with-resources). */
    public static Connection getConnection() throws DatabaseException {
        try {
            return DriverManager.getConnection(
                    CONFIG.getProperty("db.url"),
                    CONFIG.getProperty("db.user"),
                    CONFIG.getProperty("db.password"));
        } catch (SQLException e) {
            throw new DatabaseException("Could not connect to the database", e);
        }
    }
}
