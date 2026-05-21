<%-- dashboard.jsp — Admin Dashboard --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find It Admin — Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
</head>
<body>

    <div class="admin-layout">

        <!-- Sidebar -->
        <jsp:include page="/jsp/includes/admin-sidebar.jsp">
            <jsp:param name="activePage" value="dashboard" />
        </jsp:include>

        <!-- Main Content -->
        <main class="admin-main">

            <div class="admin-header-row">
                <div>
                    <h1 class="page-title">Dashboard</h1>
                    <p class="page-subtitle">Overview of platform activity.</p>
                </div>
            </div>

            <!-- Dashboard Stats -->
            <div class="admin-stats">
                <div class="stat-card animate-on-scroll" data-delay="0">
                    <span class="stat-label">Total Users</span>
                    <div class="stat-number" data-counter="${not empty totalUsers ? totalUsers : '0'}">0</div>
                </div>
                <div class="stat-card animate-on-scroll" data-delay="80">
                    <span class="stat-label">Lost Reports</span>
                    <div class="stat-number" data-counter="${not empty totalLost ? totalLost : '0'}">0</div>
                </div>
                <div class="stat-card animate-on-scroll" data-delay="160">
                    <span class="stat-label">Found Reports</span>
                    <div class="stat-number" data-counter="${not empty totalFound ? totalFound : '0'}">0</div>
                </div>
                <div class="stat-card animate-on-scroll" data-delay="240">
                    <span class="stat-label">Pending Approvals</span>
                    <div class="stat-number" data-counter="${not empty pendingApprovals ? pendingApprovals : '0'}">0</div>
                </div>
            </div>

            <!-- Recent Activity Table -->
            <div class="table-section">
                <div class="table-header">
                    <h2 class="table-title">Recent Submissions</h2>
                    <a href="${pageContext.request.contextPath}/admin/items" class="action-link">View All</a>
                </div>

                <div class="table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Type</th>
                                <th>Title</th>
                                <th>User</th>
                                <th>Date</th>
                                <th>Location</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty recentItems}">
                                    <c:forEach var="item" items="${recentItems}">
                                        <tr>
                                            <td>
                                                <span class="badge ${item.type == 'LOST' ? 'badge-lost' : 'badge-found'}">
                                                    ${item.type}
                                                </span>
                                            </td>
                                            <td style="font-weight: 500;">${item.title}</td>
                                            <td class="text-secondary">${item.userName}</td>
                                            <td class="text-secondary">${item.dateOccurred}</td>
                                            <td class="text-secondary">${item.location}</td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="5" class="text-center text-muted" style="padding: var(--space-5);">No recent activity.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

        </main>
    </div>

    <!-- Global Scripts -->
    <jsp:include page="/jsp/includes/scripts.jsp" />
</body>
</html>
