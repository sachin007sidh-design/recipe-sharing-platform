<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Browse Recipes" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>

<main class="container my-5">
  <h2 class="section-title">Browse Recipes</h2>

  <form class="row g-2 mb-4" action="${ctx}/recipes" method="get">
    <div class="col-12 col-md-6">
      <input class="form-control" type="text" name="q" value="<c:out value='${q}' />"
             placeholder="Search by dish or ingredient...">
    </div>
    <div class="col-8 col-md-3">
      <select class="form-select" name="category">
        <option value="">All categories</option>
        <c:forEach var="cat" items="${categories}">
          <option value="${cat}" ${cat == selectedCategory ? 'selected' : ''}>${cat}</option>
        </c:forEach>
      </select>
    </div>
    <div class="col-4 col-md-3">
      <button class="btn btn-brand w-100" type="submit"><i class="bi bi-search me-1"></i>Search</button>
    </div>
  </form>

  <c:choose>
    <c:when test="${empty recipes}">
      <div class="alert alert-warning">No recipes found. Try a different search.</div>
    </c:when>
    <c:otherwise>
      <p class="text-muted">${recipes.size()} recipe(s) found</p>
      <div class="row g-4">
        <c:forEach var="r" items="${recipes}">
          <%@ include file="/WEB-INF/views/common/recipe-card.jspf" %>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>
</main>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
