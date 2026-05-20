<%-- post-lost.jsp — Post Lost Item Form --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find It — Report Lost Item</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forms.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
</head>
<body>

    <!-- Navigation -->
    <jsp:include page="/jsp/includes/navbar-user.jsp" />

    <main class="main-content" style="padding: var(--space-7) 0;">
        <div class="container">
        
            <!-- General Alert -->
            <c:if test="${not empty errors.general}">
                <div class="alert alert-error" style="max-width: 560px; margin: 0 auto var(--space-5);">${errors.general}</div>
            </c:if>

            <div class="form-card form-card-wide">
                <h2 class="form-heading">Report a Lost Item</h2>
                <p class="form-subheading">Provide detailed information so the community can help you find it.</p>

                <form action="${pageContext.request.contextPath}/user/post-item" method="POST">
                    
                    <input type="hidden" name="type" value="LOST">

                    <!-- Title -->
                    <div class="form-group">
                        <label for="title" class="form-label">Item Title <span class="required">*</span></label>
                        <input type="text" id="title" name="title"
                               class="form-control ${not empty errors.title ? 'error' : ''}"
                               placeholder="e.g. Black Leather Wallet"
                               value="${title}" maxlength="150" required>
                        <c:if test="${not empty errors.title}">
                            <span class="field-error">${errors.title}</span>
                        </c:if>
                    </div>

                    <!-- Category -->
                    <div class="form-group">
                        <label for="categoryId" class="form-label">Category <span class="required">*</span></label>
                        <select id="categoryId" name="categoryId" class="form-control ${not empty errors.categoryId ? 'error' : ''}" required>
                            <option value="">Select a category</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.id}" ${categoryId == cat.id ? 'selected' : ''}>
                                    ${cat.name}
                                </option>
                            </c:forEach>
                        </select>
                        <c:if test="${not empty errors.categoryId}">
                            <span class="field-error">${errors.categoryId}</span>
                        </c:if>
                    </div>

                    <!-- Location -->
                    <div class="form-group">
                        <label for="location" class="form-label">Location Lost <span class="required">*</span></label>
                        <input type="text" id="location" name="location"
                               class="form-control ${not empty errors.location ? 'error' : ''}"
                               placeholder="e.g. Central Park near the fountain"
                               value="${location}" maxlength="200" required>
                        <c:if test="${not empty errors.location}">
                            <span class="field-error">${errors.location}</span>
                        </c:if>
                    </div>

                    <!-- Date Occurred -->
                    <div class="form-group">
                        <label for="dateOccurred" class="form-label">Date Lost <span class="required">*</span></label>
                        <input type="date" id="dateOccurred" name="dateOccurred"
                               class="form-control ${not empty errors.dateOccurred ? 'error' : ''}"
                               value="${dateOccurred}" required>
                        <c:if test="${not empty errors.dateOccurred}">
                            <span class="field-error">${errors.dateOccurred}</span>
                        </c:if>
                    </div>

                    <!-- Description -->
                    <div class="form-group">
                        <label for="description" class="form-label">Description & Additional Details <span class="required">*</span></label>
                        <textarea id="description" name="description"
                                  class="form-control ${not empty errors.description ? 'error' : ''}"
                                  placeholder="Describe any unique markings, contents, or circumstances." required>${description}</textarea>
                        <c:if test="${not empty errors.description}">
                            <span class="field-error">${errors.description}</span>
                        </c:if>
                    </div>

                    <!-- Contact Preference -->
                    <div class="form-group">
                        <label for="contactPreference" class="form-label">Contact Preference <span class="required">*</span></label>
                        <select id="contactPreference" name="contactPreference"
                                class="form-control ${not empty errors.contactPreference ? 'error' : ''}" required>
                            <option value="">How should people reach you?</option>
                            <option value="email" ${contactPreference == 'email' ? 'selected' : ''}>Email</option>
                            <option value="phone" ${contactPreference == 'phone' ? 'selected' : ''}>Phone</option>
                            <option value="both" ${contactPreference == 'both' ? 'selected' : ''}>Both (Email & Phone)</option>
                        </select>
                        <c:if test="${not empty errors.contactPreference}">
                            <span class="field-error">${errors.contactPreference}</span>
                        </c:if>
                    </div>

                    <!-- Actions -->
                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/user/dashboard" class="btn btn-secondary">Cancel</a>
                        <button type="submit" class="btn btn-primary">Submit Report</button>
                    </div>

                </form>
            </div>

        </div>
    </main>

    <!-- Footer -->
    <jsp:include page="/jsp/includes/footer.jsp" />

</body>
</html>
