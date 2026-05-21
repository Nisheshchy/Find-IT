<%-- navbar-public.jsp — Public navigation bar --%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

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
                        <div class="navbar-user"
                            style="padding-left: var(--space-4); border-left: 1px solid var(--border); display: flex; gap: var(--space-3); align-items: center;">
                            <a href="${pageContext.request.contextPath}/login" class="btn-signin-nav">Sign In</a>
                            <a href="${pageContext.request.contextPath}/register" class="btn-register-nav">Register</a>
                        </div>
                    </div>
                </div>
            </nav>
        </div>

        <!-- Mobile Menu Panel -->
        <div class="mobile-menu-panel" id="mobileMenuPanel">
            <a href="${pageContext.request.contextPath}/browse" tabindex="-1">Browse Items</a>
            <a href="${pageContext.request.contextPath}/about" tabindex="-1">About Us</a>
            <a href="${pageContext.request.contextPath}/login" class="btn-signin-nav" tabindex="-1">Sign In</a>
            <a href="${pageContext.request.contextPath}/register" class="btn-register-nav" tabindex="-1">Register</a>
        </div>