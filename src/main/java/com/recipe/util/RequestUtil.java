package com.recipe.util;

import jakarta.servlet.http.HttpServletRequest;

/** Small helpers for reading form data safely. */
public final class RequestUtil {

    private RequestUtil() { }

    /** Returns the trimmed parameter, or "" if it is missing. Never returns null. */
    public static String param(HttpServletRequest req, String name) {
        String value = req.getParameter(name);
        return value == null ? "" : value.trim();
    }
}
