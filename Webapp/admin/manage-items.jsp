<%-- manage-items.jsp — Admin Item Management --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find It Admin — Manage Items</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
</head>
<body>

    <div class="admin-layout">

        <!-- Sidebar -->
        <jsp:include page="/jsp/includes/admin-sidebar.jsp">
            <jsp:param name="activePage" value="items" />
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
                    <h1 class="page-title">Manage Items</h1>
                    <p class="page-subtitle">Moderate all lost and found listings.</p>
                </div>
            </div>

            <!-- Items Table -->
            <div class="table-section">
                <div class="table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Type</th>
                                <th>Title</th>
                                <th>Category</th>
                                <th>Posted By</th>
                                <th>Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty items}">
                                    <c:forEach var="item" items="${items}">
                                        <tr>
                                            <td>
                                                <span class="badge ${item.type == 'LOST' ? 'badge-lost' : 'badge-found'}">
                                                    ${item.type}
                                                </span>
                                            </td>
                                            <td style="font-weight: 500;">
                                                <a href="${pageContext.request.contextPath}/item?id=${item.id}" title="View details">${item.title}</a>
                                            </td>
                                            <td>${item.categoryName}</td>
                                            <td>${item.userName}</td>
                                            <td class="text-secondary">${item.dateOccurred}</td>
                                            <td>
                                                <div class="table-actions">
                                                    <form action="${pageContext.request.contextPath}/admin/items" method="POST" style="display:inline;">
                                                        <input type="hidden" name="itemId" value="${item.id}">
                                                        <input type="hidden" name="action" value="delete">
                                                        <button type="submit" class="action-link action-delete" onclick="return confirm('Are you sure you want to delete this item?')">Delete</button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" class="text-center text-muted" style="padding: var(--space-5);">No items found.</td>
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
