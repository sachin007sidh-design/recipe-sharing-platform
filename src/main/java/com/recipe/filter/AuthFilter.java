package com.recipe.filter;

import com.recipe.model.User;
import com.recipe.util.AppConstants;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Runs before every /user/* and /admin/* request.
 *  - Not logged in      -> redirect to the login page
 *  - /admin/* by a USER -> 403 Forbidden
 */
@WebFilter(urlPatterns = {"/user/*", "/admin/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false); // do not create a new session
        User user = (session == null) ? null : (User) session.getAttribute(AppConstants.SESSION_USER);

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login?required=1");
            return;
        }

        String path = req.getServletPath();
        if (path.startsWith("/admin") && !"ADMIN".equals(user.getRole())) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Admins only");
            return;
        }
        chain.doFilter(request, response); // allowed, continue to the servlet
    }
}
