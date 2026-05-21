<%-- browse.jsp — Browse Items Page (PUBLIC) --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Browse all lost and found items on Find It.">
    <title>Find It — Browse Items</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cards.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
</head>
<body>

    <!-- Navigation -->
    <c:choose>
        <c:when test="${not empty sessionScope.userId}">
            <jsp:include page="/jsp/includes/navbar-user.jsp" />
        </c:when>
        <c:otherwise>
            <jsp:include page="/jsp/includes/navbar-public.jsp" />
        </c:otherwise>
    </c:choose>

    <main class="main-content">
        <section class="section">
            <div class="container">

                <!-- Page Header -->
                <div class="page-header" style="padding-top: var(--space-7);">
                    <h1>Browse Items</h1>
                    <p class="text-secondary">All lost and found reports from the community.</p>
                </div>

                <!-- Search Bar -->
                <div style="margin-bottom: var(--space-5);">
                    <form action="${pageContext.request.contextPath}/browse" method="GET" style="display: flex; gap: var(--space-3); align-items: center; flex-wrap: wrap;">
                        <c:if test="${activeType != 'ALL'}">
                            <input type="hidden" name="type" value="${activeType}">
                        </c:if>
                        <input type="text" name="q" value="${searchQuery}"
                               placeholder="Search by title, description, or location..."
                               class="form-control" style="flex: 1; min-width: 200px; padding: 10px 14px; border: 1px solid var(--border); border-radius: var(--radius-md); font-size: var(--text-sm);">
                        <button type="submit" class="btn btn-primary btn-sm">Search</button>
                        <c:if test="${not empty searchQuery}">
                            <a href="${pageContext.request.contextPath}/browse" class="action-link" style="font-size: 13px;">Clear</a>
                        </c:if>
                    </form>
                </div>

                <!-- Filter Tabs -->
                <div class="filter-tabs">
                    <a href="${pageContext.request.contextPath}/browse${not empty searchQuery ? '?q='.concat(searchQuery) : ''}"
                       class="filter-tab ${activeType == 'ALL' ? 'active' : ''}">All</a>
                    <a href="${pageContext.request.contextPath}/browse?type=LOST${not empty searchQuery ? '&q='.concat(searchQuery) : ''}"
                       class="filter-tab ${activeType == 'LOST' ? 'active' : ''}">Lost</a>
                    <a href="${pageContext.request.contextPath}/browse?type=FOUND${not empty searchQuery ? '&q='.concat(searchQuery) : ''}"
                       class="filter-tab ${activeType == 'FOUND' ? 'active' : ''}">Found</a>
                </div>

                <div class="filter-meta">
                    <c:choose>
                        <c:when test="${not empty searchQuery}">
                            Showing <c:choose><c:when test="${not empty items}">${items.size()}</c:when><c:otherwise>0</c:otherwise></c:choose> results for "<strong>${searchQuery}</strong>"
                        </c:when>
                        <c:otherwise>
                            Showing <c:choose><c:when test="${not empty items}">${items.size()}</c:when><c:otherwise>0</c:otherwise></c:choose> items
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Items Grid -->
                <c:choose>
                    <c:when test="${not empty items}">
                        <div class="item-grid">
                            <c:forEach var="item" items="${items}" varStatus="loop">
                                <div class="item-card animate-on-scroll" data-delay="${(loop.index % 12) * 60}">
                                    <div class="card-header">
                                        <h3 class="card-title">${item.title}</h3>
                                        <span class="badge ${item.type == 'LOST' ? 'badge-lost' : 'badge-found'}">
                                            ${item.type}
                                        </span>
                                    </div>
                                    <div class="card-meta">
                                        <div class="meta-item">
                                            <span>${item.categoryName}</span>
                                        </div>
                                        <div class="meta-item">
                                            <span>${item.location}</span>
                                        </div>
                                    </div>
                                    <p class="card-description">${item.shortDescription}</p>
                                    <div class="card-footer">
                                        <span class="card-date">${item.dateOccurred}</span>
                                        <a href="${pageContext.request.contextPath}/item?id=${item.id}" style="color: var(--text-primary); text-decoration: none; transition: color var(--dur-fast);" onmouseover="this.style.color='var(--accent)'" onmouseout="this.style.color='var(--text-primary)'">View Details</a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <h3 class="empty-title">No items found</h3>
                            <p class="empty-desc">There are no items matching your filter. Try a different category.</p>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>
        </section>
    </main>

    <!-- Footer -->
    <jsp:include page="/jsp/includes/footer.jsp" />

</body>
</html>
