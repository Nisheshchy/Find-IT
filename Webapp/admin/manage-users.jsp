<%-- manage-users.jsp — Admin User Management --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find It Admin — Manage Users</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
</head>
<body>

    <div class="admin-layout">

        <!-- Sidebar -->
        <jsp:include page="/jsp/includes/admin-sidebar.jsp">
            <jsp:param name="activePage" value="users" />
        </jsp:include>

        <!-- Main Content -->
        <main class="admin-main">

            <!-- Alerts -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">${errorMessage}</div>
            </c:if>
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">${successMessage}</div>
            </c:if>

            <div class="admin-header-row">
                <div>
                    <h1 class="page-title">Manage Users</h1>
                    <p class="page-subtitle">View and moderate platform users.</p>
                </div>
            </div>

            <!-- Users Table -->
            <div class="table-section">
                <div class="table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty users}">
                                    <c:forEach var="user" items="${users}">
                                        <tr>
                                            <td style="font-weight: 500;">${user.fullName}</td>
                                            <td>${user.email}</td>
                                            <td>${user.phone}</td>
                                            <td>
                                                <span class="badge ${user.role == 'ADMIN' ? 'badge-lost' : 'badge-found'}">
                                                    ${user.role}
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge ${user.status == 'active' ? 'badge-active' : user.status == 'pending' ? 'badge-pending' : 'badge-suspended'}">
                                                    ${user.status}
                                                </span>
                                            </td>
                                            <td>
                                                <c:if test="${user.id != sessionScope.userId}">
                                                    <div class="table-actions">
                                                        <c:choose>
                                                            <c:when test="${user.status == 'active'}">
                                                                <form action="${pageContext.request.contextPath}/admin/users" method="POST" style="display:inline;">
                                                                    <input type="hidden" name="action" value="suspend">
                                                                    <input type="hidden" name="userId" value="${user.id}">
                                                                    <button type="submit" class="action-link action-delete" style="color: #ff9f0a;" onclick="return confirm('Are you sure you want to suspend this user?')">Suspend</button>
                                                                </form>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <form action="${pageContext.request.contextPath}/admin/users" method="POST" style="display:inline;">
                                                                    <input type="hidden" name="action" value="approve">
                                                                    <input type="hidden" name="userId" value="${user.id}">
                                                                    <button type="submit" class="action-link" onclick="return confirm('Are you sure you want to approve this user?')">Approve</button>
                                                                </form>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <span class="action-divider">|</span>
                                                        <form action="${pageContext.request.contextPath}/admin/users" method="POST" style="display:inline;">
                                                            <input type="hidden" name="action" value="delete">
                                                            <input type="hidden" name="userId" value="${user.id}">
                                                            <button type="submit" class="action-link action-delete" onclick="return confirm('Are you sure you want to permanently delete this user? All their items will also be removed.')">Delete</button>
                                                        </form>
                                                    </div>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" class="text-center text-muted" style="padding: var(--space-5);">No users found.</td>
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
