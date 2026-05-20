<%-- register.jsp — Registration Page (PUBLIC) --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Create your account to use the Find It platform.">
    <title>Find It — Register</title>
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

        <div class="form-card form-card-wide">
            <h2 class="form-heading">Create an account</h2>
            <p class="form-subheading">Join the Find It community.</p>

            <!-- General Error -->
            <c:if test="${not empty errors.general}">
                <div class="alert alert-error">${errors.general}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="POST" id="registerForm">

                <!-- Full Name -->
                <div class="form-group">
                    <label for="fullName" class="form-label">Full Name <span class="required">*</span></label>
                    <input type="text" id="fullName" name="fullName"
                           class="form-control ${not empty errors.fullName ? 'error' : ''}"
                           placeholder="Enter your full name"
                           value="${fullName}" maxlength="100" required>
                    <c:if test="${not empty errors.fullName}">
                        <span class="field-error">${errors.fullName}</span>
                    </c:if>
                </div>

                <!-- Email -->
                <div class="form-group">
                    <label for="email" class="form-label">Email Address <span class="required">*</span></label>
                    <input type="email" id="email" name="email"
                           class="form-control ${not empty errors.email ? 'error' : ''}"
                           placeholder="you@example.com"
                           value="${email}" maxlength="150" required>
                    <c:if test="${not empty errors.email}">
                        <span class="field-error">${errors.email}</span>
                    </c:if>
                </div>

                <!-- Phone -->
                <div class="form-group">
                    <label for="phone" class="form-label">Phone Number <span class="required">*</span></label>
                    <input type="tel" id="phone" name="phone"
                           class="form-control ${not empty errors.phone ? 'error' : ''}"
                           placeholder="10-digit phone number"
                           value="${phone}" maxlength="10" required>
                    <c:if test="${not empty errors.phone}">
                        <span class="field-error">${errors.phone}</span>
                    </c:if>
                </div>

                <!-- Password -->
                <div class="form-group">
                    <label for="password" class="form-label">Password <span class="required">*</span></label>
                    <input type="password" id="password" name="password"
                           class="form-control ${not empty errors.password ? 'error' : ''}"
                           placeholder="Minimum 8 characters" required>
                    <c:if test="${not empty errors.password}">
                        <span class="field-error">${errors.password}</span>
                    </c:if>
                </div>

                <!-- Confirm Password -->
                <div class="form-group">
                    <label for="confirmPassword" class="form-label">Confirm Password <span class="required">*</span></label>
                    <input type="password" id="confirmPassword" name="confirmPassword"
                           class="form-control ${not empty errors.confirmPassword ? 'error' : ''}"
                           placeholder="Re-enter your password" required>
                    <c:if test="${not empty errors.confirmPassword}">
                        <span class="field-error">${errors.confirmPassword}</span>
                    </c:if>
                </div>

                <!-- Submit -->
                <button type="submit" class="btn btn-primary btn-full">Create Account</button>
            </form>

            <div class="form-footer">
                Already have an account? <a href="${pageContext.request.contextPath}/login">Sign in</a>
            </div>
        </div>
    </main>

</body>
</html>
