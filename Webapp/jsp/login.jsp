<%-- login.jsp — Login Page (PUBLIC) --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Sign in to your Find It account.">
    <title>Find It — Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forms.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
    <style>
        .auth-page {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--off-white);
            flex-direction: column;
            padding: var(--space-5) 0;
        }
        .auth-logo {
            font-size: 24px;
            font-weight: 600;
            color: var(--accent);
            letter-spacing: -0.02em;
            margin-bottom: var(--space-7);
            text-decoration: none;
        }
    </style>
</head>
<body>

    <main class="auth-page">
        <a href="${pageContext.request.contextPath}/" class="auth-logo">Find It</a>

        <div class="form-card">
            <h2 class="form-heading">Welcome back</h2>
            <p class="form-subheading">Sign in to your account to continue.</p>

            <!-- Success Message (from registration) -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">${successMessage}</div>
            </c:if>

            <!-- Error Message -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="POST" id="loginForm">

                <!-- Email -->
                <div class="form-group">
                    <label for="email" class="form-label">Email Address <span class="required">*</span></label>
                    <input type="email" id="email" name="email"
                           class="form-control"
                           placeholder="you@example.com"
                           value="${email}" required>
                </div>

                <!-- Password -->
                <div class="form-group">
                    <label for="password" class="form-label">Password <span class="required">*</span></label>
                    <input type="password" id="password" name="password"
                           class="form-control"
                           placeholder="Enter your password" required>
                </div>

                <!-- Remember Me -->
                <div class="form-group">
                    <div class="checkbox-group">
                        <input type="checkbox" id="rememberMe" name="rememberMe">
                        <label for="rememberMe" class="checkbox-label">Remember me for 7 days</label>
                    </div>
                </div>

                <!-- Submit -->
                <button type="submit" class="btn btn-primary btn-full">Sign In</button>
            </form>

            <div class="form-footer">
                Don't have an account? <a href="${pageContext.request.contextPath}/register">Register</a>
            </div>
        </div>
    </main>

</body>
</html>
