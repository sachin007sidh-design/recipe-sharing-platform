<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Share a Recipe" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>

<c:set var="activeNav" value="add" />
<main class="container-xl my-4 my-lg-5">
  <div class="row g-4">
    <div class="col-lg-3 col-xl-2"><%@ include file="/WEB-INF/views/common/dash-sidebar.jspf" %></div>
    <div class="col-lg-9 col-xl-8">
  <h2 class="fw-bold mb-4">Share a new recipe</h2>

  <c:if test="${not empty errors}">
    <div class="alert alert-danger">
      <ul class="mb-0 ps-3">
        <c:forEach var="e" items="${errors}"><li><c:out value="${e}" /></li></c:forEach>
      </ul>
    </div>
  </c:if>

  <form action="${ctx}/user/add-recipe" method="post" class="card stat-card"><div class="card-body p-4">
    <div class="mb-3">
      <label class="form-label" for="title">Recipe title</label>
      <input class="form-control" id="title" name="title" value="<c:out value='${recipe.title}' />" required>
    </div>
    <div class="row g-3 mb-3">
      <div class="col-12 col-md-6">
        <label class="form-label" for="category">Category</label>
        <select class="form-select" id="category" name="category" required>
          <option value="">Choose...</option>
          <c:forEach var="cat" items="${categories}">
            <option value="${cat}" ${cat == recipe.category ? 'selected' : ''}>${cat}</option>
          </c:forEach>
        </select>
      </div>
      <div class="col-12 col-md-6">
        <label class="form-label" for="imagePath">Image URL (optional)</label>
        <input class="form-control" type="url" id="imagePath" name="imagePath"
               value="<c:out value='${recipe.imagePath}' />" placeholder="https://...">
      </div>
    </div>
    <div class="row g-3 mb-3">
      <div class="col-12 col-md-4">
        <label class="form-label" for="prepTime">Prep time (minutes)</label>
        <input class="form-control" type="number" id="prepTime" name="prepTime" min="1" max="1440"
               value="${empty recipe ? 30 : recipe.prepTime}" required>
      </div>
      <div class="col-12 col-md-4">
        <label class="form-label" for="servings">Servings</label>
        <input class="form-control" type="number" id="servings" name="servings" min="1" max="50"
               value="${empty recipe ? 2 : recipe.servings}" required>
      </div>
      <div class="col-12 col-md-4">
        <label class="form-label" for="difficulty">Difficulty</label>
        <select class="form-select" id="difficulty" name="difficulty" required>
          <c:forEach var="d" items="${difficulties}">
            <option value="${d}" ${d == recipe.difficulty ? 'selected' : ''}>${fn:substring(d, 0, 1)}${fn:toLowerCase(fn:substring(d, 1, -1))}</option>
          </c:forEach>
        </select>
      </div>
    </div>
    <div class="mb-3">
      <label class="form-label" for="description">Short description</label>
      <input class="form-control" id="description" name="description" maxlength="250"
             value="<c:out value='${recipe.description}' />">
    </div>
    <div class="mb-3">
      <label class="form-label" for="ingredients">Ingredients (one per line)</label>
      <textarea class="form-control" id="ingredients" name="ingredients" rows="5" required><c:out value="${recipe.ingredients}" /></textarea>
    </div>
    <div class="mb-4">
      <label class="form-label" for="instructions">Instructions</label>
      <textarea class="form-control" id="instructions" name="instructions" rows="6" required><c:out value="${recipe.instructions}" /></textarea>
    </div>
    <div class="d-flex gap-2">
      <button class="btn btn-brand" type="submit">Submit for approval</button>
      <a class="btn btn-outline-secondary" href="${ctx}/user/dashboard">Cancel</a>
    </div>
  </div></form>
    </div>
  </div>
</main>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
