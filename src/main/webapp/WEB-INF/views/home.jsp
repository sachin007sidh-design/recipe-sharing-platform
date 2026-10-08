<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Home" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>

<%-- ============ HERO (photo + colour overlay) ============ --%>
<section class="hero hero-photo"
         style="--hero-img: url('https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=1800&q=80')">
  <div class="container text-center">
    <span class="eyebrow"><i class="bi bi-stars me-1"></i>Cook &middot; Share &middot; Enjoy</span>
    <h1 class="mb-3">Discover &amp; share recipes you'll love</h1>
    <p class="lead mb-4 mx-auto" style="max-width: 560px">
      Home-cooked ideas from real kitchens. Search, save and share your own.
    </p>
    <form class="row g-2 justify-content-center" action="${ctx}/recipes" method="get">
      <div class="col-12 col-md-6">
        <input class="form-control form-control-lg" type="text" name="q"
               placeholder="Search by dish or ingredient...">
      </div>
      <div class="col-12 col-md-auto">
        <button class="btn btn-dark btn-lg w-100" type="submit"><i class="bi bi-search me-1"></i>Search</button>
      </div>
    </form>
    <div class="hero-tags mt-4">
      <span>Popular:</span>
      <a href="${ctx}/recipes?category=Dessert">Dessert</a>
      <a href="${ctx}/recipes?category=Vegan">Vegan</a>
      <a href="${ctx}/recipes?category=Dinner">Dinner</a>
      <a href="${ctx}/recipes?category=Breakfast">Breakfast</a>
    </div>
  </div>
</section>

<%-- ============ STATS BAND (overlaps the hero) ============ --%>
<section class="container stats-band">
  <div class="card stat-strip">
    <div class="row text-center g-0">
      <div class="col-4 stat-cell">
        <div class="stat-big"><span class="count" data-target="${recipeTotal}">${recipeTotal}</span>+</div>
        <div class="stat-label"><i class="bi bi-journal-richtext me-1"></i>Recipes</div>
      </div>
      <div class="col-4 stat-cell">
        <div class="stat-big"><span class="count" data-target="${cookTotal}">${cookTotal}</span></div>
        <div class="stat-label"><i class="bi bi-people-fill me-1"></i>Home cooks</div>
      </div>
      <div class="col-4 stat-cell">
        <div class="stat-big"><span class="count" data-target="${categories.size()}">${categories.size()}</span></div>
        <div class="stat-label"><i class="bi bi-grid-fill me-1"></i>Categories</div>
      </div>
    </div>
  </div>
</section>

<%-- ============ CATEGORY TILES ============ --%>
<section class="container mt-5 pt-3">
  <h2 class="section-title">Browse by category</h2>
  <div class="row g-3">
    <c:forEach var="cat" items="${categories}">
      <div class="col-6 col-sm-4 col-md-3 col-lg">
        <a class="category-tile" href="${ctx}/recipes?category=${cat}">
          <span class="tile-icon"><i class="bi ${categoryIcons[cat]}"></i></span>
          <span class="tile-name">${cat}</span>
          <span class="tile-count">${empty categoryCounts[cat] ? 0 : categoryCounts[cat]} recipes</span>
        </a>
      </div>
    </c:forEach>
  </div>
</section>

<%-- ============ LATEST RECIPES ============ --%>
<main class="container my-5 pt-3">
  <div class="d-flex justify-content-between align-items-end flex-wrap gap-2">
    <h2 class="section-title mb-0">Latest recipes</h2>
    <a class="btn btn-outline-brand btn-sm mb-2" href="${ctx}/recipes">View all <i class="bi bi-arrow-right ms-1"></i></a>
  </div>
  <hr class="mt-2 mb-4 opacity-0">
  <c:choose>
    <c:when test="${empty latest}">
      <div class="alert alert-warning">No recipes yet. Sign up and share the first one!</div>
    </c:when>
    <c:otherwise>
      <div class="row g-4">
        <c:forEach var="r" items="${latest}">
          <%@ include file="/WEB-INF/views/common/recipe-card.jspf" %>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>
</main>

<%-- ============ HOW IT WORKS ============ --%>
<section class="how-section py-5">
  <div class="container">
    <h2 class="section-title text-center section-title-center">How it works</h2>
    <div class="row g-4 mt-1">
      <div class="col-12 col-md-4">
        <div class="step-card">
          <span class="step-number">1</span>
          <div class="step-icon"><i class="bi bi-person-plus-fill"></i></div>
          <h5>Create your account</h5>
          <p class="text-muted mb-0">Sign up for free in seconds. No credit card, no fuss.</p>
        </div>
      </div>
      <div class="col-12 col-md-4">
        <div class="step-card">
          <span class="step-number">2</span>
          <div class="step-icon"><i class="bi bi-pencil-square"></i></div>
          <h5>Share your recipe</h5>
          <p class="text-muted mb-0">Add ingredients, steps, a photo, and how long it takes to cook.</p>
        </div>
      </div>
      <div class="col-12 col-md-4">
        <div class="step-card">
          <span class="step-number">3</span>
          <div class="step-icon"><i class="bi bi-patch-check-fill"></i></div>
          <h5>Get approved &amp; discovered</h5>
          <p class="text-muted mb-0">Our admins review it, then it goes live for everyone to enjoy.</p>
        </div>
      </div>
    </div>
  </div>
</section>

<%-- ============ CALL TO ACTION ============ --%>
<section class="container mb-5">
  <div class="cta-band text-center">
    <h2 class="mb-2">Got a recipe worth sharing?</h2>
    <p class="mb-4">Join our community of home cooks and show the world what's cooking in your kitchen.</p>
    <c:choose>
      <c:when test="${not empty sessionScope.user}">
        <a class="btn btn-light btn-lg" href="${ctx}/user/add-recipe"><i class="bi bi-plus-lg me-1"></i>Share a recipe</a>
      </c:when>
      <c:otherwise>
        <a class="btn btn-light btn-lg" href="${ctx}/register"><i class="bi bi-person-plus-fill me-1"></i>Join RecipeShare</a>
      </c:otherwise>
    </c:choose>
  </div>
</section>

<script>
  // Count-up animation for the stats: runs when the band scrolls into view
  (function () {
    var counters = document.querySelectorAll('.count');
    if (!('IntersectionObserver' in window)) return; // keep the real numbers as they are
    function animate(el) {
      var target = parseInt(el.dataset.target, 10) || 0, start = null, duration = 1200;
      function step(ts) {
        if (start === null) start = ts;
        var p = Math.min((ts - start) / duration, 1);
        el.textContent = Math.floor(p * target);
        if (p < 1) requestAnimationFrame(step); else el.textContent = target;
      }
      el.textContent = 0;
      requestAnimationFrame(step);
    }
    var seen = new IntersectionObserver(function (entries) {
      entries.forEach(function (e) {
        if (e.isIntersecting) { animate(e.target); seen.unobserve(e.target); }
      });
    }, { threshold: 0.6 });
    counters.forEach(function (c) { seen.observe(c); });
  })();
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
