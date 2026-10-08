<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Oops" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>

<main class="container text-center my-5 py-5">
  <div style="font-size:4.5rem;color:var(--brand)"><i class="bi bi-emoji-dizzy"></i></div>
  <h1 class="fw-bold">Something went wrong</h1>
  <p class="text-muted">The page you wanted is missing, restricted, or hit a problem.</p>
  <a class="btn btn-brand btn-lg" href="${ctx}/home"><i class="bi bi-house-fill me-1"></i>Back to home</a>
</main>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
