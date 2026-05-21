<%-- 404.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find It — Page Not Found</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forms.css">
    <style>
        .error-page {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            text-align: center;
            background: var(--off-white);
            padding: var(--space-5);
        }
        .error-code {
            font-size: 96px;
            font-weight: 600;
            color: var(--border);
            letter-spacing: -0.04em;
            line-height: 1;
            margin-bottom: var(--space-2);
        }
        .error-title {
            font-size: var(--text-xl);
            font-weight: 600;
            color: var(--text-primary);
            letter-spacing: -0.02em;
            margin-bottom: var(--space-3);
        }
        .error-desc {
            font-size: var(--text-base);
            color: var(--text-secondary);
            margin-bottom: var(--space-6);
        }
    </style>
</head>
<body>
    <main class="error-page">
        <div class="error-code">404</div>
        <h1 class="error-title">Page not found</h1>
        <p class="error-desc">The page you are looking for doesn't exist or has been moved.</p>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Back to Home</a>
    </main>
</body>
</html>
