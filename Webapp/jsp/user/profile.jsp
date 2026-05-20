<%-- profile.jsp — User Profile Page --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find It — My Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forms.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
</head>
<body>

    <!-- Navigation -->
    <jsp:include page="/jsp/includes/navbar-user.jsp" />

    <main class="main-content" style="padding: var(--space-7) 0;">
        <div class="container" style="max-width: 640px;">

            <!-- Alert Messages -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">${successMessage}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">${errorMessage}</div>
            </c:if>

            <!-- Profile Header -->
            <div class="page-header">
                <h1 class="page-title">My Profile</h1>
                <p class="page-subtitle">Manage your account details.</p>
            </div>

            <!-- Profile Info Card -->
            <div class="form-card" style="margin-bottom: var(--space-6);">
                <h3 class="form-heading" style="font-size: var(--text-lg);">Account Information</h3>

                <form action="${pageContext.request.contextPath}/user/profile" method="POST">
                    <input type="hidden" name="action" value="updateProfile">

                    <div class="form-group">
                        <label for="fullName" class="form-label">Full Name <span class="required">*</span></label>
                        <input type="text" id="fullName" name="fullName"
                               class="form-control" value="${user.fullName}" required>
                    </div>

                    <div class="form-group">
                        <label for="email" class="form-label">Email Address</label>
                        <input type="email" id="email" class="form-control"
                               value="${user.email}" disabled
                               style="background: var(--off-white); cursor: not-allowed;">
                        <span class="form-hint" style="font-size: 12px; color: var(--text-muted);">Email cannot be changed.</span>
                    </div>

                    <div class="form-group">
                        <label for="phone" class="form-label">Phone Number <span class="required">*</span></label>
                        <input type="text" id="phone" name="phone"
                               class="form-control" value="${user.phone}" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Member Since</label>
                        <input type="text" class="form-control"
                               value="${user.createdAt}" disabled
                               style="background: var(--off-white); cursor: not-allowed;">
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>

            <!-- Change Password Card -->
            <div class="form-card">
                <h3 class="form-heading" style="font-size: var(--text-lg);">Change Password</h3>

                <form action="${pageContext.request.contextPath}/user/profile" method="POST">
                    <input type="hidden" name="action" value="changePassword">

                    <div class="form-group">
                        <label for="currentPassword" class="form-label">Current Password <span class="required">*</span></label>
                        <input type="password" id="currentPassword" name="currentPassword"
                               class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label for="newPassword" class="form-label">New Password <span class="required">*</span></label>
                        <input type="password" id="newPassword" name="newPassword"
                               class="form-control" minlength="6" required>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword" class="form-label">Confirm New Password <span class="required">*</span></label>
                        <input type="password" id="confirmPassword" name="confirmPassword"
                               class="form-control" minlength="6" required>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-secondary">Change Password</button>
                    </div>
                </form>
            </div>

        </div>
    </main>

    <!-- Footer -->
    <jsp:include page="/jsp/includes/footer.jsp" />

</body>
</html>
