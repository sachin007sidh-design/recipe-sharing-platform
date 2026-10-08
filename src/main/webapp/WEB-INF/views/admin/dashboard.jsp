<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Admin Dashboard" />
<c:set var="activeNav" value="overview" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>

<main class="container-xl my-4 my-lg-5">
  <div class="row g-4">
    <div class="col-lg-3 col-xl-2"><%@ include file="/WEB-INF/views/common/dash-sidebar.jspf" %></div>

    <div class="col-lg-9 col-xl-10">
      <div class="mb-4">
        <h2 class="fw-bold mb-0">Admin dashboard</h2>
        <p class="text-muted mb-0">Moderate recipes and keep an eye on the community.</p>
      </div>

      <%-- Stat cards --%>
      <div class="row g-3 mb-4">
        <div class="col-12 col-sm-6 col-xl-3"><div class="card stat-card stat-orange"><div class="card-body d-flex align-items-center gap-3">
          <div class="stat-icon icon-orange"><i class="bi bi-people-fill"></i></div>
          <div><div class="text-muted small">Users</div><div class="stat-number">${totalUsers}</div></div>
        </div></div></div>
        <div class="col-12 col-sm-6 col-xl-3"><div class="card stat-card stat-green"><div class="card-body d-flex align-items-center gap-3">
          <div class="stat-icon icon-green"><i class="bi bi-journal-richtext"></i></div>
          <div><div class="text-muted small">Total recipes</div><div class="stat-number">${totalRecipes}</div></div>
        </div></div></div>
        <div class="col-12 col-sm-6 col-xl-3"><div class="card stat-card stat-green"><div class="card-body d-flex align-items-center gap-3">
          <div class="stat-icon icon-green"><i class="bi bi-check-circle-fill"></i></div>
          <div><div class="text-muted small">Approved</div><div class="stat-number">${approvedCount}</div></div>
        </div></div></div>
        <div class="col-12 col-sm-6 col-xl-3"><div class="card stat-card stat-yellow"><div class="card-body d-flex align-items-center gap-3">
          <div class="stat-icon icon-yellow"><i class="bi bi-hourglass-split"></i></div>
          <div><div class="text-muted small">Awaiting approval</div><div class="stat-number">${pendingCount}</div></div>
        </div></div></div>
      </div>

      <%-- Charts --%>
      <div class="row g-3 mb-5">
        <div class="col-12 col-xl-5">
          <div class="card stat-card h-100"><div class="card-body">
            <h6 class="fw-bold mb-3">Recipes by status</h6>
            <div class="chart-box"><canvas id="statusChart"></canvas></div>
          </div></div>
        </div>
        <div class="col-12 col-xl-7">
          <div class="card stat-card h-100"><div class="card-body">
            <h6 class="fw-bold mb-3">Approved recipes by category</h6>
            <div class="chart-box"><canvas id="categoryChart"></canvas></div>
          </div></div>
        </div>
      </div>

      <%-- Pending approvals --%>
      <h4 class="section-title" id="pending">Recipes awaiting approval</h4>
      <c:choose>
        <c:when test="${empty pendingRecipes}">
          <div class="empty-state mb-5">
            <i class="bi bi-patch-check"></i>
            <h5>All caught up</h5>
            <p class="text-muted mb-0">No recipes are waiting for review.</p>
          </div>
        </c:when>
        <c:otherwise>
          <div class="table-responsive mb-5">
            <table class="table table-hover align-middle mb-0">
              <thead><tr><th>Recipe</th><th>Author</th><th>Category</th><th class="text-end">Action</th></tr></thead>
              <tbody>
                <c:forEach var="r" items="${pendingRecipes}">
                  <tr>
                    <td>
                      <div class="d-flex align-items-center gap-3">
                        <c:choose>
                          <c:when test="${not empty r.imagePath}"><img class="thumb" src="<c:out value='${r.imagePath}' />" alt="" onerror="this.style.visibility='hidden'"></c:when>
                          <c:otherwise><span class="thumb thumb-ph"><i class="bi bi-egg-fried"></i></span></c:otherwise>
                        </c:choose>
                        <a class="fw-semibold text-decoration-none" href="${ctx}/recipe?id=${r.id}"><c:out value="${r.title}" /></a>
                      </div>
                    </td>
                    <td><c:out value="${r.authorName}" /></td>
                    <td><c:out value="${r.category}" /></td>
                    <td class="text-end">
                      <form class="d-inline" action="${ctx}/admin/recipe-action" method="post">
                        <input type="hidden" name="id" value="${r.id}">
                        <button class="btn btn-success btn-sm" name="action" value="approve"><i class="bi bi-check-lg me-1"></i>Approve</button>
                        <button class="btn btn-outline-danger btn-sm" name="action" value="reject"><i class="bi bi-x-lg me-1"></i>Reject</button>
                      </form>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </c:otherwise>
      </c:choose>

      <%-- Users --%>
      <h4 class="section-title" id="users">All users</h4>
      <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
          <thead><tr><th>User</th><th>Email</th><th>Role</th></tr></thead>
          <tbody>
            <c:forEach var="u" items="${users}">
              <tr>
                <td>
                  <div class="d-flex align-items-center gap-2">
                    <span class="nav-avatar"><c:out value="${fn:toUpperCase(fn:substring(u.name, 0, 1))}" /></span>
                    <span class="fw-semibold"><c:out value="${u.name}" /></span>
                  </div>
                </td>
                <td><c:out value="${u.email}" /></td>
                <td><span class="badge ${u.role == 'ADMIN' ? 'text-bg-dark' : 'text-bg-secondary'}">${u.role}</span></td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js"></script>
<script>
  // Charts need the Chart.js library from the CDN (internet connection)
  if (window.Chart) {
    Chart.defaults.font.family = "'Poppins', sans-serif";

    // Chart text/grid colours follow the light/dark theme
    function applyChartTheme() {
      var dark = document.documentElement.getAttribute('data-bs-theme') === 'dark';
      Chart.defaults.color = dark ? '#ced4da' : '#495057';
      Chart.defaults.borderColor = dark ? 'rgba(255,255,255,.1)' : 'rgba(0,0,0,.08)';
    }
    applyChartTheme();
    document.addEventListener('themechange', function () {
      applyChartTheme();
      Object.values(Chart.instances).forEach(function (c) { c.update(); });
    });

    new Chart(document.getElementById('statusChart'), {
      type: 'doughnut',
      data: {
        labels: ['Approved', 'Pending', 'Rejected'],
        datasets: [{
          data: [${approvedCount}, ${pendingCount}, ${rejectedCount}],
          backgroundColor: ['#2f9e44', '#f59f00', '#e03131'],
          borderWidth: 0
        }]
      },
      options: { maintainAspectRatio: false, cutout: '68%', plugins: { legend: { position: 'bottom' } } }
    });

    new Chart(document.getElementById('categoryChart'), {
      type: 'bar',
      data: {
        labels: [<c:forEach var="l" items="${categoryLabels}" varStatus="st">'${l}'${st.last ? '' : ','}</c:forEach>],
        datasets: [{
          label: 'Approved recipes',
          data: [<c:forEach var="v" items="${categoryValues}" varStatus="st">${v}${st.last ? '' : ','}</c:forEach>],
          backgroundColor: '#e8590c',
          borderRadius: 8
        }]
      },
      options: {
        maintainAspectRatio: false,
        scales: { y: { beginAtZero: true, ticks: { precision: 0 } }, x: { grid: { display: false } } },
        plugins: { legend: { display: false } }
      }
    });
  }
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
