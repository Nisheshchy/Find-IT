<%-- manage-categories.jsp — Admin Category Management --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find It Admin — Manage Categories</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forms.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
</head>
<body>

    <div class="admin-layout">

        <!-- Sidebar -->
        <jsp:include page="/jsp/includes/admin-sidebar.jsp">
            <jsp:param name="activePage" value="categories" />
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
                    <h1 class="page-title">Manage Categories</h1>
                    <p class="page-subtitle">Configure the types of items users can report.</p>
                </div>
            </div>

            <!-- Create New Category -->
            <div class="category-form-section">
                <h3>Add New Category</h3>
                <form action="${pageContext.request.contextPath}/admin/categories" method="POST" class="inline-form">
                    <input type="hidden" name="action" value="add">
                    <input type="text" name="name" placeholder="e.g. Electronics, Keys" class="form-control" style="max-width: 300px;" required>
                    <button type="submit" class="btn btn-primary">Add Category</button>
                </form>
            </div>

            <!-- Categories Table -->
            <div class="table-section">
                <div class="table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Category ID</th>
                                <th>Name</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty categories}">
                                    <c:forEach var="cat" items="${categories}">
                                        <tr>
                                            <td class="text-secondary">#${cat.id}</td>
                                            <td style="font-weight: 500;">${cat.name}</td>
                                            <td>
                                                <div class="table-actions">
                                                    <form action="${pageContext.request.contextPath}/admin/categories" method="POST" style="margin:0;">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="categoryId" value="${cat.id}">
                                                        <button type="submit" class="action-link action-delete" onclick="return confirm('Delete this category? Items linked to it may be affected or cause an error.');">
                                                            Delete
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="3" class="text-center text-muted" style="padding: var(--space-5);">No categories found.</td>
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
