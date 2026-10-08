<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Sign Up" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>

<main class="container my-4 my-lg-5">
  <div class="auth-split">
    <div class="row g-0">

      <%-- Photo side (hidden on phones) --%>
      <div class="col-lg-6 d-none d-lg-block">
        <div class="auth-photo" style="--auth-img: url('https://images.unsplash.com/photo-1466637574441-749b8f19452f?auto=format&fit=crop&w=1000&q=80')">
          <div class="auth-photo-content">
            <span class="eyebrow"><i class="bi bi-people-fill me-1"></i>Join the community</span>
            <h2>Cook it. Share it. Love it.</h2>
            <p class="mb-3">Create a free account and start sharing your favourite recipes today.</p>
            <ul class="auth-perks">
              <li><i class="bi bi-check-circle-fill"></i>Share unlimited recipes</li>
              <li><i class="bi bi-check-circle-fill"></i>Search by dish or ingredient</li>
              <li><i class="bi bi-check-circle-fill"></i>Free, always</li>
            </ul>
          </div>
        </div>
      </div>

      <%-- Form side --%>
      <div class="col-lg-6">
        <div class="auth-form">
          <h2 class="fw-bold mb-1">Create your account</h2>
          <p class="text-muted mb-4">It only takes a few seconds</p>

          <c:if test="${not empty errors}">
            <div class="alert alert-danger">
              <ul class="mb-0 ps-3">
                <c:forEach var="e" items="${errors}"><li><c:out value="${e}" /></li></c:forEach>
              </ul>
            </div>
          </c:if>

          <form action="${ctx}/register" method="post">
            <div class="mb-3">
              <label class="form-label" for="name">Full name</label>
              <div class="input-group">
                <span class="input-group-text"><i class="bi bi-person"></i></span>
                <input class="form-control" type="text" id="name" name="name"
                       value="<c:out value='${name}' />" placeholder="Your name" required>
              </div>
            </div>
            <div class="mb-3">
              <label class="form-label" for="email">Email</label>
              <div class="input-group">
                <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                <input class="form-control" type="email" id="email" name="email"
                       value="<c:out value='${email}' />" placeholder="you@example.com" required>
              </div>
            </div>
            <div class="mb-3">
              <label class="form-label" for="password">Password</label>
              <div class="input-group">
                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                <input class="form-control" type="password" id="password" name="password" minlength="6" placeholder="At least 6 characters" required>
                <button class="btn btn-eye" type="button" data-toggle-pass="password" aria-label="Show or hide password"><i class="bi bi-eye"></i></button>
              </div>
              <div class="strength mt-2"><div id="strengthBar"></div></div>
              <div class="form-text" id="strengthLabel"></div>
            </div>
            <div class="mb-4">
              <label class="form-label" for="confirm">Confirm password</label>
              <div class="input-group">
                <span class="input-group-text"><i class="bi bi-shield-lock"></i></span>
                <input class="form-control" type="password" id="confirm" name="confirm" placeholder="Repeat your password" required>
                <button class="btn btn-eye" type="button" data-toggle-pass="confirm" aria-label="Show or hide password"><i class="bi bi-eye"></i></button>
              </div>
            </div>
            <button class="btn btn-brand btn-lg w-100" type="submit">Create Account <i class="bi bi-arrow-right ms-1"></i></button>
          </form>
          <p class="text-center mt-4 mb-0">Already have an account? <a class="fw-semibold" href="${ctx}/login">Log in</a></p>
        </div>
      </div>

    </div>
  </div>
</main>

<script src="${ctx}/js/auth.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jspf" %>
