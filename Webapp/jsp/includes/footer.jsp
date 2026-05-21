<%-- footer.jsp — Global fat footer fragment --%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <footer class="fat-footer">
            <div class="container">
                <div class="footer-grid">
                    <!-- Col 1: Branding -->
                    <div class="footer-col brand-col">
                        <a href="${pageContext.request.contextPath}/" class="footer-logo">Find It.</a>
                        <p class="footer-desc">
                            The modern lost and found platform. Register your lost items, report what you've found, and
                            return property to its rightful owner.
                        </p>
                    </div>

                    <!-- Col 2: Platform Links -->
                    <div class="footer-col">
                        <span class="footer-heading">Platform</span>
                        <a href="${pageContext.request.contextPath}/browse">Browse Listings</a>
                        <a href="${pageContext.request.contextPath}/about">About FindIt / Team</a>
                        <a href="${pageContext.request.contextPath}/user/post-item?type=LOST">Report a Lost Item</a>
                        <a href="${pageContext.request.contextPath}/user/post-item?type=FOUND">Report a Found Item</a>
                    </div>

                    <!-- Col 3: Account -->
                    <div class="footer-col">
                        <span class="footer-heading">Account</span>
                        <a href="${pageContext.request.contextPath}/login">Sign In</a>
                        <a href="${pageContext.request.contextPath}/register">Register</a>
                    </div>
                </div>

                <div class="footer-bottom">
                    <span>&copy; 2026 Find It. All rights reserved.</span>
                    <span class="text-secondary" style="font-size: 12px;">Team Findit</span>
                </div>
            </div>
        </footer>

        <!-- Global Scripts -->
        <jsp:include page="/jsp/includes/scripts.jsp" />