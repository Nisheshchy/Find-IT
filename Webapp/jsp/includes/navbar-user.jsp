<%-- navbar-user.jsp — User navigation bar with notification bell --%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ page import="com.findit.service.NotificationService" %>
            <% // Load unread notification count for the bell badge Integer uid=(Integer)
                session.getAttribute("userId"); if (uid !=null) { NotificationService ns=new NotificationService(); int
                unreadCount=ns.getUnreadCount(uid); request.setAttribute("unreadNotifCount", unreadCount); } %>

                <div class="page-transition-overlay"></div>
                <a href="#main-content" class="skip-link">Skip to content</a>

                <div class="navbar-wrapper">
                    <nav class="navbar" id="mainNavbar">
                        <div class="container">
                            <!-- Logo -->
                            <a href="${pageContext.request.contextPath}/" class="navbar-logo">
                                Find It
                            </a>

                            <!-- Mobile Toggle Button -->
                            <button id="hamburgerBtn" class="mobile-menu-btn" aria-expanded="false"
                                aria-label="Toggle navigation">
                                <span class="hamburger-line"></span>
                                <span class="hamburger-line"></span>
                                <span class="hamburger-line"></span>
                            </button>

                            <!-- Nav Links (Desktop) -->
                            <div class="navbar-links" id="navLinks">
                                <a href="${pageContext.request.contextPath}/browse">Browse Items</a>
                                <a href="${pageContext.request.contextPath}/about">About Us</a>
                                <a href="${pageContext.request.contextPath}/user/dashboard">Dashboard</a>
                                <a href="${pageContext.request.contextPath}/user/post-item?type=LOST">Post Lost</a>
                                <a href="${pageContext.request.contextPath}/user/post-item?type=FOUND">Post Found</a>
                                <c:if test="${sessionScope.userRole == 'ADMIN'}">
                                    <a href="${pageContext.request.contextPath}/admin/dashboard">Admin Panel</a>
                                </c:if>

                                <div class="navbar-user">
                                    <a href="${pageContext.request.contextPath}/user/notifications" class="notif-bell"
                                        title="Notifications" aria-label="Notifications">
                                        <svg class="bell-icon" width="28" height="28" viewBox="0 0 24 24" fill="none"
                                            stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                            stroke-linejoin="round">
                                            <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
                                            <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
                                        </svg>
                                        <c:if test="${unreadNotifCount > 0}"><span
                                                class="notif-badge">${unreadNotifCount}</span></c:if>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/user/profile" class="user-name"
                                        style="text-decoration: none;">${sessionScope.userName}</a>
                                    <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a>
                                </div>
                            </div>
                        </div>
                    </nav>
                </div>

                <!-- Mobile Menu Panel -->
                <div class="mobile-menu-panel" id="mobileMenuPanel">
                    <a href="${pageContext.request.contextPath}/browse" tabindex="-1">Browse Items</a>
                    <a href="${pageContext.request.contextPath}/about" tabindex="-1">About Us</a>
                    <a href="${pageContext.request.contextPath}/user/dashboard" tabindex="-1">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/user/post-item?type=LOST" tabindex="-1">Post Lost</a>
                    <a href="${pageContext.request.contextPath}/user/post-item?type=FOUND" tabindex="-1">Post Found</a>
                    <a href="${pageContext.request.contextPath}/user/notifications" tabindex="-1">
                        Notifications<c:if test="${unreadNotifCount > 0}"> (${unreadNotifCount})</c:if>
                    </a>
                    <a href="${pageContext.request.contextPath}/user/profile" tabindex="-1">My Profile</a>
                    <c:if test="${sessionScope.userRole == 'ADMIN'}">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" tabindex="-1">Admin Panel</a>
                    </c:if>
                    <div class="navbar-user">
                        <span class="user-name" style="margin-left: 8px;">${sessionScope.userName}</span>
                        <a href="${pageContext.request.contextPath}/logout" class="btn-logout" tabindex="-1">Logout</a>
                    </div>
                </div>

                <style>
                    .notif-bell {
                        position: relative;
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        width: 44px;
                        height: 44px;
                        border-radius: 50%;
                        color: var(--text-secondary);
                        transition: background-color var(--dur-fast) var(--ease-out), color var(--dur-fast) var(--ease-out);
                        margin-right: 4px;
                    }

                    .notif-bell:hover {
                        background-color: var(--off-white);
                        color: var(--text-primary);
                    }

                    .notif-bell:hover .bell-icon {
                        animation: bell-ring 0.6s cubic-bezier(0.34, 1.56, 0.64, 1);
                        transform-origin: top center;
                    }

                    .notif-badge {
                        position: absolute;
                        top: 6px;
                        right: 4px;
                        background: #FF3B30;
                        color: #fff;
                        font-size: 11px;
                        font-weight: 800;
                        padding: 4px 7px;
                        border-radius: 12px;
                        line-height: 1;
                        min-width: 20px;
                        text-align: center;
                        border: 2px solid var(--surface);
                        box-shadow: 0 2px 4px rgba(255, 59, 48, 0.3);
                        transform: scale(1);
                        animation: badge-pop 0.4s var(--ease-spring);
                    }

                    @keyframes bell-ring {
                        0% {
                            transform: rotate(0deg);
                        }

                        20% {
                            transform: rotate(15deg);
                        }

                        40% {
                            transform: rotate(-10deg);
                        }

                        60% {
                            transform: rotate(5deg);
                        }

                        80% {
                            transform: rotate(-3deg);
                        }

                        100% {
                            transform: rotate(0deg);
                        }
                    }

                    @keyframes badge-pop {
                        0% {
                            transform: scale(0);
                        }

                        100% {
                            transform: scale(1);
                        }
                    }
                </style>