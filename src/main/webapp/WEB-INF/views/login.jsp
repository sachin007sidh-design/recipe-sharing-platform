<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Login" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>

<main class="container my-4 my-lg-5">
  <div class="auth-split">
    <div class="row g-0">

      <%-- Photo side (hidden on phones) --%>
      <div class="col-lg-6 d-none d-lg-block">
        <div class="auth-photo" style="--auth-img: url('https://images.unsplash.com/photo-1556910103-1c02745aae4d?auto=format&fit=crop&w=1000&q=80')">
          <div class="auth-photo-content">
            <span class="eyebrow"><i class="bi bi-stars me-1"></i>Welcome back</span>
            <h2>Your kitchen stories live here</h2>
            <p class="mb-0">Log in to share new recipes and keep track of everything you've cooked up.</p>
          </div>
        </div>
      </div>

      <%-- Form side --%>
      <div class="col-lg-6">
        <div class="auth-form">
          <h2 class="fw-bold mb-1">Log in</h2>
          <p class="text-muted mb-4">Great to see you again</p>

          <c:if test="${param.registered == '1'}">
            <div class="alert alert-success"><i class="bi bi-check-circle-fill me-1"></i>Account created! Please log in.</div>
          </c:if>
          <c:if test="${param.required == '1'}">
            <div class="alert alert-info"><i class="bi bi-info-circle-fill me-1"></i>Please log in to continue.</div>
          </c:if>
          <c:if test="${not empty error}">
            <div class="alert alert-danger"><i class="bi bi-exclamation-triangle-fill me-1"></i><c:out value="${error}" /></div>
          </c:if>

          <form action="${ctx}/login" method="post">
            <div class="mb-3">
              <label class="form-label" for="email">Email</label>
              <div class="input-group">
                <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                <input class="form-control" type="email" id="email" name="email"
                       value="<c:out value='${email}' />" placeholder="you@example.com" required autofocus>
              </div>
            </div>
            <div class="mb-4">
              <label class="form-label" for="password">Password</label>
              <div class="input-group">
                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                <input class="form-control" type="password" id="password" name="password" placeholder="Your password" required>
                <button class="btn btn-eye" type="button" data-toggle-pass="password" aria-label="Show or hide password"><i class="bi bi-eye"></i></button>
              </div>
            </div>
            <button class="btn btn-brand btn-lg w-100" type="submit">Log In <i class="bi bi-arrow-right ms-1"></i></button>
          </form>
          <p class="text-center mt-4 mb-0">New here? <a class="fw-semibold" href="${ctx}/register">Create an account</a></p>
        </div>
      </div>

    </div>
  </div>
</main>

<script src="${ctx}/js/auth.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jspf" %>
