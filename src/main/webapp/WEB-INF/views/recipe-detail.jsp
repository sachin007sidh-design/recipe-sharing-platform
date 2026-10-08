<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="${recipe.title}" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>

<main class="container my-4 my-lg-5">

  <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-3 no-print">
    <a href="${ctx}/recipes" class="text-decoration-none"><i class="bi bi-arrow-left me-1"></i>Back to recipes</a>
    <div class="d-flex gap-2">
      <button type="button" class="btn btn-outline-brand btn-sm" id="copyLink"><i class="bi bi-link-45deg me-1"></i><span>Copy link</span></button>
      <button type="button" class="btn btn-brand btn-sm" onclick="window.print()"><i class="bi bi-printer me-1"></i>Print</button>
    </div>
  </div>

  <%-- ============ HERO ============ --%>
  <section class="detail-hero">
    <c:if test="${not empty recipe.imagePath}">
      <img class="detail-hero-img" src="<c:out value='${recipe.imagePath}' />"
           alt="<c:out value='${recipe.title}' />" onerror="this.style.display='none'">
    </c:if>
    <div class="detail-hero-overlay"></div>
    <div class="detail-hero-content">
      <span class="badge category-badge mb-2"><c:out value="${recipe.category}" /></span>
      <c:if test="${recipe.status != 'APPROVED'}">
        <span class="badge text-bg-warning mb-2 ms-1">${recipe.status}</span>
      </c:if>
      <h1><c:out value="${recipe.title}" /></h1>
      <div class="d-flex align-items-center gap-2">
        <span class="nav-avatar"><c:out value="${fn:toUpperCase(fn:substring(recipe.authorName, 0, 1))}" /></span>
        <span>by <strong><c:out value="${recipe.authorName}" /></strong></span>
      </div>
    </div>
  </section>

  <%-- ============ SUMMARY ============ --%>
  <div class="mt-4">
    <p class="lead mb-3"><c:out value="${recipe.description}" /></p>
    <div class="chips chips-lg">
      <span class="chip"><i class="bi bi-clock"></i>${recipe.prepTime} min</span>
      <span class="chip"><i class="bi bi-people"></i>${recipe.servings} servings</span>
      <span class="chip chip-${fn:toLowerCase(recipe.difficulty)}"><i class="bi bi-speedometer2"></i>${fn:substring(recipe.difficulty, 0, 1)}${fn:toLowerCase(fn:substring(recipe.difficulty, 1, -1))}</span>
    </div>
  </div>

  <div class="row g-4 mt-1">

    <%-- ============ INGREDIENTS CHECKLIST ============ --%>
    <div class="col-12 col-lg-4">
      <div class="card stat-card detail-side">
        <div class="card-body p-4">
          <div class="d-flex justify-content-between align-items-center mb-3">
            <h4 class="mb-0"><i class="bi bi-basket2-fill text-success me-2"></i>Ingredients</h4>
            <small class="text-muted no-print" id="ingProgress"></small>
          </div>
          <c:forEach var="line" items="${ingredientList}" varStatus="st">
            <div class="form-check ing-item">
              <input class="form-check-input" type="checkbox" id="ing${st.index}">
              <label class="form-check-label" for="ing${st.index}"><c:out value="${line}" /></label>
            </div>
          </c:forEach>
        </div>
      </div>
    </div>

    <%-- ============ STEPS ============ --%>
    <div class="col-12 col-lg-8">
      <div class="card stat-card">
        <div class="card-body p-4">
          <h4 class="mb-4"><i class="bi bi-journal-text me-2" style="color:var(--brand)"></i>Instructions</h4>
          <ol class="step-list">
            <c:forEach var="step" items="${stepList}">
              <li><c:out value="${step}" /></li>
            </c:forEach>
          </ol>
        </div>
      </div>
    </div>
  </div>
</main>

<script>
  (function () {
    // Ingredient checklist progress ("2 / 8")
    var boxes = document.querySelectorAll('.ing-item input');
    var progress = document.getElementById('ingProgress');
    function update() {
      var done = 0;
      boxes.forEach(function (b) { if (b.checked) done++; });
      if (progress) progress.textContent = done + ' / ' + boxes.length;
    }
    boxes.forEach(function (b) { b.addEventListener('change', update); });
    update();

    // Copy the page link
    var btn = document.getElementById('copyLink');
    if (btn) {
      btn.addEventListener('click', function () {
        var label = btn.querySelector('span');
        function done() { label.textContent = 'Copied!'; setTimeout(function () { label.textContent = 'Copy link'; }, 1800); }
        if (navigator.clipboard) { navigator.clipboard.writeText(window.location.href).then(done); }
        else { window.prompt('Copy this link:', window.location.href); }
      });
    }
  })();
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
