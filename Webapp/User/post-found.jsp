<%-- post-found.jsp — Post Found Item Form with Lost Item Matching --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find It — Report Found Item</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forms.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
    <style>
        .match-section { margin-top: var(--space-5); padding-top: var(--space-5); border-top: 1px solid var(--border-light); }
        .match-section h3 { font-size: var(--text-base); font-weight: 600; margin-bottom: var(--space-3); color: var(--text-primary); }
        .match-search { margin-bottom: var(--space-3); }
        .match-search input { width: 100%; padding: 10px 14px; border: 1px solid var(--border); border-radius: var(--radius-md); font-size: var(--text-sm); }
        .match-list { max-height: 280px; overflow-y: auto; border: 1px solid var(--border); border-radius: var(--radius-md); }
        .match-item { padding: var(--space-3) var(--space-4); border-bottom: 1px solid var(--border-light); cursor: pointer; transition: background 0.15s; display: flex; justify-content: space-between; align-items: flex-start; gap: var(--space-3); }
        .match-item:last-child { border-bottom: none; }
        .match-item:hover { background: var(--off-white); }
        .match-item.selected { background: var(--found-bg); border-left: 3px solid var(--found-color); }
        .match-item-info { flex: 1; }
        .match-item-title { font-weight: 600; font-size: var(--text-sm); color: var(--text-primary); }
        .match-item-meta { font-size: 12px; color: var(--text-muted); margin-top: 2px; }
        .match-item-desc { font-size: 12px; color: var(--text-secondary); margin-top: 4px; line-height: 1.4; }
        .match-selected-info { margin-top: var(--space-3); padding: var(--space-3) var(--space-4); background: var(--found-bg); border: 1px solid var(--found-color); border-radius: var(--radius-md); font-size: var(--text-sm); display: none; }
        .match-selected-info.visible { display: flex; align-items: center; justify-content: space-between; }
        .match-clear-btn { background: none; border: none; color: var(--error); cursor: pointer; font-size: 12px; font-weight: 500; }
        .match-empty { padding: var(--space-5); text-align: center; color: var(--text-muted); font-size: var(--text-sm); }
        .match-badge { font-size: 11px; padding: 2px 8px; border-radius: 999px; background: var(--lost-bg); color: var(--lost-color); font-weight: 600; white-space: nowrap; }
    </style>
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
                <h2 class="form-heading">Report a Found Item</h2>
                <p class="form-subheading">Help someone get their lost property back by listing it here.</p>

                <form action="${pageContext.request.contextPath}/user/post-item" method="POST">
                    
                    <input type="hidden" name="type" value="FOUND">
                    <input type="hidden" name="matchedLostItemId" id="matchedLostItemId" value="${matchedLostItemId}">

                    <!-- Title -->
                    <div class="form-group">
                        <label for="title" class="form-label">Item Title <span class="required">*</span></label>
                        <input type="text" id="title" name="title"
                               class="form-control ${not empty errors.title ? 'error' : ''}"
                               placeholder="e.g. Silver Spectacles in Case"
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
                        <label for="location" class="form-label">Location Found <span class="required">*</span></label>
                        <input type="text" id="location" name="location"
                               class="form-control ${not empty errors.location ? 'error' : ''}"
                               placeholder="e.g. Bus stop on Oxford Street"
                               value="${location}" maxlength="200" required>
                        <c:if test="${not empty errors.location}">
                            <span class="field-error">${errors.location}</span>
                        </c:if>
                    </div>

                    <!-- Date Occurred -->
                    <div class="form-group">
                        <label for="dateOccurred" class="form-label">Date Found <span class="required">*</span></label>
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
                                  placeholder="Provide basic details but withhold a key defining feature to verify the owner." required>${description}</textarea>
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

                    <!-- Match with Lost Item (Optional) -->
                    <div class="match-section">
                        <h3 style="display: flex; align-items: center; gap: 8px;">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                            Match with a Lost Item (Optional)
                        </h3>
                        <p style="font-size: 13px; color: var(--text-secondary); margin-bottom: var(--space-3);">
                            Does this item match something someone reported as lost? Select it below to notify the owner.
                        </p>

                        <!-- Selected indicator -->
                        <div class="match-selected-info" id="matchSelectedInfo">
                            <span style="display: flex; align-items: center; gap: 6px;">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                Matched: <strong id="matchSelectedTitle"></strong>
                            </span>
                            <button type="button" class="match-clear-btn" onclick="clearMatch()">Remove</button>
                        </div>

                        <!-- Search -->
                        <div class="match-search">
                            <input type="text" id="matchSearchInput" placeholder="Search lost items by name or location..." oninput="filterLostItems()">
                        </div>

                        <!-- Lost items list -->
                        <div class="match-list" id="matchList">
                            <c:choose>
                                <c:when test="${not empty lostItems}">
                                    <c:forEach var="lostItem" items="${lostItems}">
                                        <div class="match-item" data-id="${lostItem.id}" 
                                             data-title="${lostItem.title}" 
                                             data-search="${lostItem.title} ${lostItem.location} ${lostItem.categoryName} ${lostItem.description}"
                                             onclick="selectMatch(${lostItem.id}, '${lostItem.title}')">
                                            <div class="match-item-info">
                                                <div class="match-item-title">${lostItem.title}</div>
                                                <div class="match-item-meta">
                                                    ${lostItem.categoryName} &middot; ${lostItem.location} &middot; ${lostItem.dateOccurred}
                                                </div>
                                                <div class="match-item-desc">${lostItem.shortDescription}</div>
                                            </div>
                                            <span class="match-badge">LOST</span>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="match-empty">No lost items have been reported yet.</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Actions -->
                    <div class="form-actions" style="margin-top: var(--space-5);">
                        <a href="${pageContext.request.contextPath}/user/dashboard" class="btn btn-secondary">Cancel</a>
                        <button type="submit" class="btn btn-primary">Submit Report</button>
                    </div>

                </form>
            </div>

        </div>
    </main>

    <!-- Footer -->
    <jsp:include page="/jsp/includes/footer.jsp" />

    <script>
        function selectMatch(id, title) {
            document.getElementById('matchedLostItemId').value = id;
            document.getElementById('matchSelectedTitle').textContent = title;
            document.getElementById('matchSelectedInfo').classList.add('visible');
            // Highlight selected
            document.querySelectorAll('.match-item').forEach(function(el) {
                el.classList.remove('selected');
            });
            var selected = document.querySelector('.match-item[data-id="' + id + '"]');
            if (selected) selected.classList.add('selected');
        }

        function clearMatch() {
            document.getElementById('matchedLostItemId').value = '';
            document.getElementById('matchSelectedInfo').classList.remove('visible');
            document.querySelectorAll('.match-item').forEach(function(el) {
                el.classList.remove('selected');
            });
        }

        function filterLostItems() {
            var query = document.getElementById('matchSearchInput').value.toLowerCase();
            var items = document.querySelectorAll('.match-item');
            items.forEach(function(item) {
                var searchText = (item.getAttribute('data-search') || '').toLowerCase();
                item.style.display = searchText.indexOf(query) !== -1 ? '' : 'none';
            });
        }
    </script>
assa
</body>
</html>
