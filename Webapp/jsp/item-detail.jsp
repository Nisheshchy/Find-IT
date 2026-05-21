<%-- item-detail.jsp — Item Details Page with Chat --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find It — ${item.title}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cards.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
    <style>
        .item-detail-section { padding: var(--space-8) 0; max-width: 800px; margin: 0 auto; }
        .item-detail-card { background: var(--white); border: 1px solid var(--border); border-radius: var(--radius-xl); padding: var(--space-8); box-shadow: var(--shadow-sm); }
        .detail-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: var(--space-6); padding-bottom: var(--space-6); border-bottom: 1px solid var(--border-light); }
        .detail-title { font-size: var(--text-2xl); font-weight: 700; color: var(--text-primary); margin-bottom: var(--space-2); }
        .detail-category { color: var(--text-secondary); font-size: var(--text-base); font-weight: 500; }
        .detail-grid { display: grid; grid-template-columns: 1fr 1fr; gap: var(--space-6); margin-bottom: var(--space-6); }
        .detail-group { display: flex; flex-direction: column; gap: var(--space-2); }
        .detail-label { font-size: 11px; font-weight: 600; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.1em; }
        .detail-value { font-size: var(--text-base); color: var(--text-primary); font-weight: 500; }
        .detail-description { margin-top: var(--space-6); padding-top: var(--space-6); border-top: 1px solid var(--border-light); }
        .detail-desc-text { color: var(--text-secondary); line-height: 1.6; margin-top: var(--space-3); }
        .contact-box { margin-top: var(--space-6); padding: var(--space-5); background: var(--off-white); border-radius: var(--radius-lg); border: 1px solid var(--border); }
        .contact-box h4 { margin-bottom: var(--space-3); font-size: var(--text-base); font-weight: 600; }
        /* Match info */
        .match-info-box { margin-top: var(--space-6); padding: var(--space-5); background: var(--found-bg); border: 1px solid var(--found-color); border-radius: var(--radius-lg); }
        .match-info-box h4 { color: var(--found-color); margin-bottom: var(--space-3); font-size: var(--text-base); font-weight: 600; }
        .match-info-box a { color: var(--found-color); font-weight: 600; text-decoration: underline; }
        /* Chat section */
        .chat-section { margin-top: var(--space-6); padding-top: var(--space-6); border-top: 1px solid var(--border-light); }
        .chat-section h4 { font-size: var(--text-base); font-weight: 600; margin-bottom: var(--space-4); }
        .chat-messages { max-height: 400px; overflow-y: auto; margin-bottom: var(--space-4); display: flex; flex-direction: column; gap: var(--space-3); }
        .chat-msg { padding: var(--space-3) var(--space-4); border-radius: var(--radius-lg); max-width: 85%; }
        .chat-msg-other { background: var(--off-white); border: 1px solid var(--border-light); align-self: flex-start; }
        .chat-msg-self { background: var(--accent-light); border: 1px solid var(--border); align-self: flex-end; }
        .chat-msg-sender { font-size: 12px; font-weight: 600; color: var(--text-primary); margin-bottom: 2px; }
        .chat-msg-text { font-size: var(--text-sm); color: var(--text-secondary); line-height: 1.5; }
        .chat-msg-time { font-size: 11px; color: var(--text-muted); margin-top: 4px; }
        .chat-form { display: flex; gap: var(--space-3); }
        .chat-form textarea { flex: 1; resize: none; padding: 10px 14px; border: 1px solid var(--border); border-radius: var(--radius-md); font-size: var(--text-sm); font-family: inherit; min-height: 44px; }
        .chat-form button { padding: 10px 20px; }
        .chat-empty { padding: var(--space-5); text-align: center; color: var(--text-muted); font-size: var(--text-sm); border: 1px dashed var(--border); border-radius: var(--radius-md); }
        .chat-own-notice { padding: var(--space-4); text-align: center; color: var(--text-muted); font-size: var(--text-sm); background: var(--off-white); border-radius: var(--radius-md); }
        @media (max-width: 600px) {
            .detail-grid { grid-template-columns: 1fr; }
            .item-detail-card { padding: var(--space-5); }
        }
    </style>
</head>
<body>

    <!-- Navigation -->
    <c:choose>
        <c:when test="${not empty sessionScope.userId}">
            <jsp:include page="/jsp/includes/navbar-user.jsp" />
        </c:when>
        <c:otherwise>
            <jsp:include page="/jsp/includes/navbar-public.jsp" />
        </c:otherwise>
    </c:choose>

    <main class="main-content">
        <section class="item-detail-section">
            <div class="container">
                <div style="margin-bottom: var(--space-5);">
                    <a href="javascript:history.back()" class="action-link" style="display:inline-flex; align-items:center; gap:4px;">
                        &larr; Back to browsing
                    </a>
                </div>

                <div class="item-detail-card animate-on-scroll" data-delay="0">
                    <div class="detail-header">
                        <div>
                            <h1 class="detail-title">${item.title}</h1>
                            <div class="detail-category">${item.categoryName}</div>
                        </div>
                        <span class="badge ${item.type == 'LOST' ? 'badge-lost' : 'badge-found'}">
                            ${item.type}
                        </span>
                    </div>

                    <div class="detail-grid">
                        <div class="detail-group">
                            <span class="detail-label">Location</span>
                            <span class="detail-value">${item.location}</span>
                        </div>
                        <div class="detail-group">
                            <span class="detail-label">Date Occurred</span>
                            <span class="detail-value">${item.dateOccurred}</span>
                        </div>
                        <div class="detail-group">
                            <span class="detail-label">Posted By</span>
                            <span class="detail-value">${item.userName}</span>
                        </div>
                        <div class="detail-group">
                            <span class="detail-label">Report Date</span>
                            <span class="detail-value">${item.createdAt}</span>
                        </div>
                    </div>

                    <div class="detail-description">
                        <span class="detail-label">Description</span>
                        <p class="detail-desc-text">${item.description}</p>
                    </div>

                    <!-- Matched Lost Item Info (for FOUND items) -->
                    <c:if test="${not empty matchedLostItem}">
                        <div class="match-info-box">
                            <h4 style="display: flex; align-items: center; gap: 8px;">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"></path><path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"></path></svg>
                                Matched Lost Item
                            </h4>
                            <p style="font-size: 14px; color: var(--text-secondary); margin-bottom: var(--space-2);">
                                This found item has been matched with a lost report:
                                <a href="${pageContext.request.contextPath}/item?id=${matchedLostItem.id}">${matchedLostItem.title}</a>
                                (posted by ${matchedLostItem.userName})
                            </p>
                        </div>
                    </c:if>

                    <!-- Quick Found Action -->
                    <c:if test="${item.type == 'LOST' && item.status == 'active' && not empty sessionScope.userId && item.userId != sessionScope.userId}">
                        <div class="quick-found-card" style="margin-bottom: var(--space-6); display: flex; flex-direction: column; gap: 8px; padding: var(--space-5); background: linear-gradient(135deg, #f0fdf4, #ecfdf5); border-radius: var(--radius-lg); border: 1px solid #bbf7d0;">
                            <h4 style="margin-bottom: 4px; font-size: 16px; display: flex; align-items: center; gap: 8px;">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#16a34a" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line></svg>
                                Have you found this item?
                            </h4>
                            <p style="font-size: 13.5px; color: var(--text-secondary); margin-bottom: var(--space-3);">Click below to instantly generate a matching 'Found' report and notify the owner. No form required.</p>
                            <form id="quickFoundForm" action="${pageContext.request.contextPath}/user/post-item" method="POST">
                                <input type="hidden" name="quickFound" value="true">
                                <input type="hidden" name="lostItemId" value="${item.id}">
                                <button type="button" id="quickFoundBtn" class="btn btn-primary" style="width: 100%; display: flex; align-items: center; justify-content: center; gap: 8px; background: #16a34a; border-color: #16a34a;">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>
                                    I Found This Item
                                </button>
                            </form>
                        </div>

                        <!-- Custom Confirmation Modal -->
                        <div id="quickFoundModal" class="qf-modal-overlay" style="display:none;">
                            <div class="qf-modal">
                                <div class="qf-modal-icon">
                                    <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#16a34a" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>
                                </div>
                                <h3 class="qf-modal-title">Confirm Found Report</h3>
                                <p class="qf-modal-desc">You are about to report that you found <strong>${item.title}</strong>. This will:</p>
                                <ul class="qf-modal-list">
                                    <li>Create a matched 'Found' report linked to this item</li>
                                    <li>Instantly notify <strong>${item.userName}</strong></li>
                                    <li>Open a chat so you can coordinate the return</li>
                                </ul>
                                <div class="qf-modal-actions">
                                    <button type="button" id="qfCancel" class="btn btn-secondary" style="flex: 1;">Cancel</button>
                                    <button type="button" id="qfConfirm" class="btn btn-primary" style="flex: 1; background: #16a34a; border-color: #16a34a;">Yes, I Found It</button>
                                </div>
                            </div>
                        </div>

                        <style>
                            .qf-modal-overlay { position: fixed; inset: 0; background: rgba(0,0,0,0.45); backdrop-filter: blur(6px); -webkit-backdrop-filter: blur(6px); z-index: 9999; display: flex; align-items: center; justify-content: center; animation: qfFadeIn 0.2s ease-out; }
                            .qf-modal { background: var(--white); border-radius: 20px; padding: 36px 32px 28px; max-width: 420px; width: 90%; text-align: center; box-shadow: 0 24px 48px rgba(0,0,0,0.15); animation: qfSlideUp 0.3s ease-out; }
                            .qf-modal-icon { margin-bottom: 16px; }
                            .qf-modal-title { font-size: 20px; font-weight: 700; margin-bottom: 8px; color: var(--text-primary); }
                            .qf-modal-desc { font-size: 14px; color: var(--text-secondary); margin-bottom: 16px; line-height: 1.5; }
                            .qf-modal-list { text-align: left; font-size: 13.5px; color: var(--text-secondary); margin: 0 auto 24px; padding-left: 20px; max-width: 320px; line-height: 1.8; }
                            .qf-modal-list li { margin-bottom: 4px; }
                            .qf-modal-actions { display: flex; gap: 12px; }
                            @keyframes qfFadeIn { from { opacity: 0; } to { opacity: 1; } }
                            @keyframes qfSlideUp { from { opacity: 0; transform: translateY(24px) scale(0.96); } to { opacity: 1; transform: translateY(0) scale(1); } }
                        </style>

                        <script>
                            document.addEventListener('DOMContentLoaded', function() {
                                var btn = document.getElementById('quickFoundBtn');
                                var modal = document.getElementById('quickFoundModal');
                                var cancelBtn = document.getElementById('qfCancel');
                                var confirmBtn = document.getElementById('qfConfirm');
                                var form = document.getElementById('quickFoundForm');

                                if (btn && modal && form) {
                                    btn.addEventListener('click', function() { modal.style.display = 'flex'; });
                                    cancelBtn.addEventListener('click', function() { modal.style.display = 'none'; });
                                    modal.addEventListener('click', function(e) { if (e.target === modal) modal.style.display = 'none'; });
                                    confirmBtn.addEventListener('click', function() {
                                        confirmBtn.disabled = true;
                                        confirmBtn.textContent = 'Processing...';
                                        form.submit();
                                    });
                                }
                            });
                        </script>
                    </c:if>

                    <!-- Contact Information -->
                    <div class="contact-box">
                        <h4>Contact Information</h4>
                        <p class="text-secondary" style="font-size: 14px; margin-bottom: var(--space-4);">
                            <c:choose>
                                <c:when test="${not empty sessionScope.userId}">
                                    <strong style="color: var(--text-primary);">Preferred Contact Method:</strong>
                                    <span style="text-transform: capitalize;">${item.contactPreference}</span>
                                    <br><br>
                                    <strong style="color: var(--text-primary);">Posted By:</strong> ${item.userName}
                                    <br>
                                    <em style="font-size: 13px;">Use the chat section below to communicate with this user about the item.</em>
                                </c:when>
                                <c:otherwise>
                                    Please <a href="${pageContext.request.contextPath}/login" style="color: var(--accent); font-weight: 500;">sign in</a> to view contact preferences and connect with the user.
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>

                    <!-- Chat Section (Logged-in users only) -->
                    <c:if test="${not empty sessionScope.userId}">
                        <div class="chat-section" id="chat-section">
                            <h4 style="display: flex; align-items: center; gap: 8px;">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path></svg>
                                Conversation
                            </h4>

                            <c:choose>
                                <c:when test="${item.userId == sessionScope.userId}">
                                    <!-- Item owner sees messages but cannot send to themselves -->
                                    <c:choose>
                                        <c:when test="${not empty messages}">
                                            <div class="chat-messages">
                                                <c:forEach var="msg" items="${messages}">
                                                    <div class="chat-msg ${msg.senderId == sessionScope.userId ? 'chat-msg-self' : 'chat-msg-other'}">
                                                        <div class="chat-msg-sender">${msg.senderName}</div>
                                                        <div class="chat-msg-text">${msg.messageText}</div>
                                                        <div class="chat-msg-time">${msg.createdAt}</div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                            <div class="chat-own-notice">
                                                This is your item. You will see messages from other users here. Use the item detail page of their items to reply.
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="chat-own-notice">
                                                This is your item. Messages from interested users will appear here.
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <!-- Other users can chat -->
                                    <div class="chat-messages">
                                        <c:choose>
                                            <c:when test="${not empty messages}">
                                                <c:forEach var="msg" items="${messages}">
                                                    <div class="chat-msg ${msg.senderId == sessionScope.userId ? 'chat-msg-self' : 'chat-msg-other'}">
                                                        <div class="chat-msg-sender">${msg.senderName}</div>
                                                        <div class="chat-msg-text">${msg.messageText}</div>
                                                        <div class="chat-msg-time">${msg.createdAt}</div>
                                                    </div>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="chat-empty">No messages yet. Start the conversation!</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <form class="chat-form" action="${pageContext.request.contextPath}/item/chat" method="POST">
                                        <input type="hidden" name="itemId" value="${item.id}">
                                        <textarea name="messageText" placeholder="Type your message..." required></textarea>
                                        <button type="submit" class="btn btn-primary">Send</button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>

                </div>
            </div>
        </section>
    </main>

    <!-- Footer -->
    <jsp:include page="/jsp/includes/footer.jsp" />

</body>
</html>
