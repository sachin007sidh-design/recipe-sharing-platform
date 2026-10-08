package com.recipe.model;

/** The administrator. Inherits from User and changes the dashboard location. */
public class Admin extends User {

    public Admin(int id, String name, String email, String passwordHash) {
        super(id, name, email, passwordHash, "ADMIN");
    }

    @Override
    public String getDashboardPath() {
        return "/admin/dashboard";
    }
}
