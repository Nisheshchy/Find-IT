<%-- index.jsp — Home Page (PUBLIC) --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Find It — Reuniting people with what matters. Report lost or found items and connect with your community.">
    <title>Find It — Home</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cards.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
</head>
<body>

    <!-- Navigation -->
    <c:choose>
        <c:when test="${not empty sessionScope.userId && sessionScope.userRole == 'ADMIN'}">
            <jsp:include page="/jsp/includes/navbar-user.jsp" />
        </c:when>
        <c:when test="${not empty sessionScope.userId}">
            <jsp:include page="/jsp/includes/navbar-user.jsp" />
        </c:when>
        <c:otherwise>
            <jsp:include page="/jsp/includes/navbar-public.jsp" />
        </c:otherwise>
    </c:choose>

    <main class="main-content">

        <!-- ==================== Hero Section ==================== -->
        <section class="hero" id="hero">
            <div class="container hero-container">
                <div class="hero-content">
                    <span class="hero-eyebrow">Lost &amp; Found Platform</span>
                    <h1 class="hero-title">
                        <span class="word">Find</span>
                        <span class="word accent-dot">It</span>
                    </h1>
                    <p class="hero-subtitle">
                        Report lost items, browse found listings, and reconnect with what matters to you.
                    </p>
                    <div class="hero-actions">
                        <a href="${pageContext.request.contextPath}/user/post-item?type=LOST"
                           class="btn btn-primary" id="heroReportBtn">Report Lost Item</a>
                        <a href="${pageContext.request.contextPath}/browse"
                           class="btn btn-secondary" id="heroBrowseBtn">Browse Listings</a>
                    </div>
                </div>

                <!-- Inline Stats -->
                <div class="hero-stats-row animate-on-scroll" data-delay="300">
                    <div class="hero-stat-pill">
                        <span class="hero-stat-number" data-counter="${not empty totalLost ? totalLost : '0'}">0</span>
                        <span class="hero-stat-label">Lost</span>
                    </div>
                    <span class="stat-divider"></span>
                    <div class="hero-stat-pill">
                        <span class="hero-stat-number" data-counter="${not empty totalFound ? totalFound : '0'}">0</span>
                        <span class="hero-stat-label">Found</span>
                    </div>
                    <span class="stat-divider"></span>
                    <div class="hero-stat-pill">
                        <span class="hero-stat-number" data-counter="${not empty itemsResolved ? itemsResolved : '0'}">0</span>
                        <span class="hero-stat-label">Reunited</span>
                    </div>
                </div>
            </div>

            <!-- Scroll indicator -->
            <div class="scroll-hint" id="scrollHint">
                <span class="scroll-hint-line"></span>
            </div>
        </section>

        <!-- ==================== How It Works ==================== -->
        <section class="how-it-works" id="howItWorks">
            <div class="container">
                <div class="section-header">
                    <span class="section-label">How It Works</span>
                    <h2 class="section-title">Three simple steps.</h2>
                </div>

                <div class="steps-grid">
                    <div class="step-item animate-on-scroll" data-delay="0">
                        <div class="step-number">01</div>
                        <h3 class="step-title">Register</h3>
                        <p class="step-desc">Create your free account with just your name, email, and phone number.</p>
                    </div>
                    <div class="step-item animate-on-scroll" data-delay="120">
                        <div class="step-number">02</div>
                        <h3 class="step-title">Post</h3>
                        <p class="step-desc">Report a lost or found item with location, date, and description details.</p>
                    </div>
                    <div class="step-item animate-on-scroll" data-delay="240">
                        <div class="step-number">03</div>
                        <h3 class="step-title">Reunite</h3>
                        <p class="step-desc">Browse listings, connect with others, and get reunited with what you lost.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- ==================== Recent Items ==================== -->
        <section class="recent-items" id="recentItems">
            <div class="container">
                <div class="section-header">
                    <span class="section-label">Recent Activity</span>
                    <h2 class="section-title">Recently Reported</h2>
                </div>

                <c:choose>
                    <c:when test="${not empty recentItems}">
                        <div class="item-grid">
                            <c:forEach var="item" items="${recentItems}" varStatus="loop">
                                <div class="item-card animate-on-scroll" data-delay="${loop.index * 80}">
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
                            <h3 class="empty-title">No items reported yet</h3>
                            <p class="empty-desc">Be the first to report a lost or found item.</p>
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
