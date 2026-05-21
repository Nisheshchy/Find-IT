<%-- notifications.jsp — User Notifications Page --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find It — Notifications</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
    <style>
        .notif-list { display: flex; flex-direction: column; gap: var(--space-3); }
        .notif-item { display: flex; align-items: flex-start; gap: var(--space-4); padding: var(--space-4) var(--space-5); background: var(--white); border: 1px solid var(--border); border-radius: var(--radius-lg); transition: background 0.15s; }
        .notif-item.unread { background: var(--warning-bg); border-color: var(--warning); }
        .notif-icon { width: 36px; height: 36px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 18px; flex-shrink: 0; }
        .notif-icon-match { background: var(--found-bg); color: var(--found-color); }
        .notif-icon-default { background: var(--accent-light); color: var(--accent); }
        .notif-content { flex: 1; }
        .notif-text { font-size: var(--text-sm); color: var(--text-primary); line-height: 1.5; }
        .notif-text strong { font-weight: 600; }
        .notif-meta { font-size: 12px; color: var(--text-muted); margin-top: 4px; display: flex; gap: var(--space-3); align-items: center; flex-wrap: wrap; }
        .notif-actions { display: flex; gap: var(--space-3); align-items: center; flex-shrink: 0; }
        .notif-empty { text-align: center; padding: var(--space-8); color: var(--text-muted); font-size: var(--text-sm); }
        .notif-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: var(--space-5); flex-wrap: wrap; gap: var(--space-3); }
    </style>
</head>
<body>

    <!-- Navigation -->
    <jsp:include page="/jsp/includes/navbar-user.jsp" />

    <main class="main-content" style="padding: var(--space-7) 0;">
        <div class="container" style="max-width: 720px;">

            <div class="notif-header">
                <div>
                    <h1 class="page-title">Notifications</h1>
                    <p class="page-subtitle">Stay updated on matches and activity.</p>
                </div>
                <c:if test="${not empty notifications}">
                    <form action="${pageContext.request.contextPath}/user/notifications" method="POST" style="display:inline;">
                        <input type="hidden" name="action" value="markAllRead">
                        <button type="submit" class="btn btn-secondary btn-sm">Mark all as read</button>
                    </form>
                </c:if>
            </div>

            <div class="notif-list">
                <c:choose>
                    <c:when test="${not empty notifications}">
                        <c:forEach var="notif" items="${notifications}">
                            <div class="notif-item ${!notif.read ? 'unread' : ''}">
                                <div class="notif-icon ${notif.matchedItemId > 0 ? 'notif-icon-match' : 'notif-icon-default'}">
                                    <c:choose>
                                        <c:when test="${notif.matchedItemId > 0}"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"></path><path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"></path></svg></c:when>
                                        <c:otherwise><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path><path d="M13.73 21a2 2 0 0 1-3.46 0"></path></svg></c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="notif-content">
                                    <div class="notif-text">
                                        <c:if test="${not empty notif.fromUserName}">
                                            <strong>${notif.fromUserName}</strong>:
                                        </c:if>
                                        ${notif.message}
                                    </div>
                                    <div class="notif-meta">
                                        <span>${notif.createdAt}</span>
                                        <c:if test="${notif.matchedItemId > 0}">
                                            <a href="${pageContext.request.contextPath}/item?id=${notif.matchedItemId}" style="color: var(--found-color); font-weight: 500;">View found item</a>
                                        </c:if>
                                        <c:if test="${notif.itemId > 0}">
                                            <a href="${pageContext.request.contextPath}/item?id=${notif.itemId}" style="color: var(--accent); font-weight: 500;">View your item</a>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="notif-actions">
                                    <c:if test="${!notif.read}">
                                        <form action="${pageContext.request.contextPath}/user/notifications" method="POST" style="display:inline;">
                                            <input type="hidden" name="action" value="markRead">
                                            <input type="hidden" name="notificationId" value="${notif.id}">
                                            <button type="submit" class="action-link" style="font-size: 12px;">Mark read</button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="notif-empty">
                            <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" style="margin-bottom: 16px; opacity: 0.5; display: block; margin-left: auto; margin-right: auto;"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path><path d="M13.73 21a2 2 0 0 1-3.46 0"></path></svg>
                            No notifications yet. You'll be notified when someone matches a found item with your lost report.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>
    </main>

    <!-- Footer -->
    <jsp:include page="/jsp/includes/footer.jsp" />

</body>
</html>
