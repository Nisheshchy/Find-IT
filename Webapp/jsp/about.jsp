<%-- about.jsp — About FindIt and Team Page (PUBLIC) --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib prefix="c" uri="jakarta.tags.core" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <meta name="description"
                    content="Find It — Learn about our platform, our mission to reunite lost items, and the dedicated team of five building this ecosystem.">
                <title>Find It — About Us &amp; Team</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/about.css">
            </head>

            <body>

                <!-- Navigation Header Selection -->
                <c:choose>
                    <c:when test="${not empty sessionScope.userId && sessionScope.userRole == 'ADMIN'}">
                        <jsp:include page="/jsp/includes/navbar-user.jsp" />
                    </c:when>
                    <c:when test="${not empty sessionScope.userId}">
                        <jsp:include page="/jsp/includes/navbar-user.jsp" />
                    </c:when>
                    <c:otherwise>
                        <jsp:include page="/jsp/includes/navbar-public.jsp" />
                    </c:otherwise>
                </c:choose>

                <!-- Main Content Area -->
                <main class="main-content" id="main-content">

                    <!-- ==================== About Hero Section ==================== -->
                    <section class="about-hero page-hero">
                        <div class="container">
                            <span class="about-hero-eyebrow">Our Vision</span>
                            <h1 class="about-hero-title">Reconnecting People With<br>What Matters Most</h1>
                            <p class="about-hero-subtitle">
                                FindIt is a modern lost and found platform designed to turn stressful losses into
                                successful returns. We leverage secure, real-time community tools to reunite users with
                                their lost belongings.
                            </p>
                        </div>
                    </section>

                    <!-- ==================== About Brand Section ==================== -->
                    <section class="about-brand-section page-section">
                        <div class="container">
                            <div class="about-brand-grid">

                                <!-- Left: Description and Story -->
                                <div class="about-brand-content">
                                    <h2>The FindIt Story</h2>
                                    <p>
                                        Every day, thousands of items are lost in public places, transit systems, and
                                        university campuses. Most of these belongings never find their way back home,
                                        not because people don't want to return them, but due to the lack of a
                                        centralized, modern communication network.
                                    </p>
                                    <p>
                                        FindIt was created to bridge this gap. Designed with simplicity and premium
                                        accessibility in mind, our platform provides a safe space where finders can list
                                        discovered items and owners can search, verify, and reclaim their missing assets
                                        safely and securely.
                                    </p>
                                    <p>
                                        Whether it's a critical study laptop, a high-value wallet, or an irreplaceable
                                        sentimental keepsake, FindIt makes the recovery process completely smooth,
                                        organized, and transparent.
                                    </p>
                                </div>

                                <!-- Right: Visual Core Values -->
                                <div class="about-brand-visual">
                                    <h3
                                        style="font-size: var(--text-md); font-weight: 700; margin-bottom: var(--space-4);">
                                        Our Core Pillars</h3>
                                    <div class="values-grid">

                                        <!-- Value 1: Community -->
                                        <div class="value-card">

                                            <h4 class="value-title">Community First</h4>
                                            <p class="value-desc">Built around trust, honesty, and local neighborhood
                                                support networks.</p>
                                        </div>

                                        <!-- Value 2: Security -->
                                        <div class="value-card">

                                            <h4 class="value-title">Secure Chats</h4>
                                            <p class="value-desc">Verifiably safe claims processes and encrypted
                                                internal messaging services.</p>
                                        </div>

                                        <!-- Value 3: Simplicity -->
                                        <div class="value-card">

                                            <h4 class="value-title">Instant Matches</h4>
                                            <p class="value-desc">Intelligent categories and filter tags to locate
                                                missing items rapidly.</p>
                                        </div>

                                        <!-- Value 4: Accessibility -->
                                        <div class="value-card">

                                            <h4 class="value-title">100% Free</h4>
                                            <p class="value-desc">Free for students, visitors, and administrators to use
                                                forever.</p>
                                        </div>

                                    </div>
                                </div>

                            </div>
                        </div>
                    </section>

                    <!-- ==================== Team Section ==================== -->
                    <section class="team-section">
                        <div class="container">

                            <!-- Team Section Header -->
                            <div class="team-header">
                                <span class="section-label">The Creators</span>
                                <h2 class="section-title">The Minds Behind FindIt</h2>
                                <p class="section-subtitle">
                                    Meet the passionate individuals behind FindIt, dedicated to making our university
                                    safer and more connected.
                                </p>
                            </div>

                            <!-- 3 Members in top row -->
                            <div class="team-grid">

                                <!-- Member 1: Samrat Bhandari -->
                                <article class="member-card animate-on-scroll" data-delay="0">
                                    <div class="member-photo-wrapper">
                                        <div class="member-photo">
                                            <img src="${pageContext.request.contextPath}/images/team/samrat.jpg"
                                                alt="Samrat Bhandari"
                                                onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';"
                                                style="width: 100%; height: 100%; object-fit: cover;">
                                            <div class="member-avatar-fallback" style="display: none;">SB</div>
                                        </div>
                                    </div>
                                    <div class="member-info">
                                        <h3 class="member-name">Samrat Bhandari</h3>
                                        <span class="member-role">Backend Developer &amp; Team Leader</span>
                                        <p class="member-bio">
                                            Samrat is a skilled Backend Developer with a strong focus on backend
                                            technologies and database management. He is an expert in designing
                                            secure authentication systems and ensuring data integrity.
                                        </p>
                                    </div>
                                    <div class="member-socials">
                                        <a href="#" class="social-btn" aria-label="LinkedIn Profile">
                                            <svg fill="currentColor" viewBox="0 0 24 24">
                                                <path
                                                    d="M19 3a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h14m-.5 15.5v-5.3a3.26 3.26 0 0 0-3.26-3.26c-.85 0-1.84.52-2.32 1.3v-1.11h-2.8v8h2.8v-4.87c0-.26.05-.5.14-.68a1.11 1.11 0 0 1 1-.74c.75 0 1 .56 1 .95v5.34h2.8M6.5 8.37a1.37 1.37 0 1 0 0-2.75 1.37 1.37 0 0 0 0 2.75M8 18.5v-8H5v8h3z" />
                                            </svg>
                                        </a>
                                        <a href="https://github.com/Samrat696254" class="social-btn"
                                            aria-label="GitHub Profile">
                                            <svg fill="currentColor" viewBox="0 0 24 24">
                                                <path
                                                    d="M12 2A10 10 0 0 0 2 12c0 4.42 2.87 8.17 6.84 9.5.5.08.66-.23.66-.5v-1.69c-2.77.6-3.36-1.34-3.36-1.34-.46-1.16-1.11-1.47-1.11-1.47-.9-.62.07-.6.07-.6 1 .07 1.53 1.03 1.53 1.03.9 1.52 2.34 1.07 2.91.83.09-.65.35-1.09.63-1.34-2.22-.25-4.55-1.11-4.55-4.92 0-1.11.38-2 1.03-2.71-.1-.25-.45-1.29.1-2.64 0 0 .84-.27 2.75 1.02.79-.22 1.65-.33 2.5-.33.85 0 1.71.11 2.5.33 1.91-1.29 2.75-1.02 2.75-1.02.55 1.35.2 2.39.1 2.64.65.71 1.03 1.6 1.03 2.71 0 3.82-2.34 4.66-4.57 4.91.36.31.69.92.69 1.85V21c0 .27.16.59.67.5C19.14 20.16 22 16.42 22 12A10 10 0 0 0 12 2z" />
                                            </svg>
                                        </a>
                                    </div>
                                </article>

                                <!-- Member 2: Saubhagya Jung Thapa -->
                                <article class="member-card animate-on-scroll" data-delay="100">
                                    <div class="member-photo-wrapper">
                                        <div class="member-photo">
                                            <img src="${pageContext.request.contextPath}/images/team/saubhagya.jpg"
                                                alt="Saubhagya Jung Thapa"
                                                onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';"
                                                style="width: 100%; height: 100%; object-fit: cover;">
                                            <div class="member-avatar-fallback" style="display: none;">SJT</div>
                                        </div>
                                    </div>
                                    <div class="member-info">
                                        <h3 class="member-name">Saubhagya Jung Thapa</h3>
                                        <span class="member-role">Authentication Specialist</span>
                                        <p class="member-bio">
                                            Saubhagya is a skilled Full-Stack Developer with a strong focus on backend
                                            technologies and database management. He is an expert in designing
                                            secure authentication systems and ensuring data integrity.
                                        </p>
                                    </div>
                                    <div class="member-socials">
                                        <a href="#" class="social-btn" aria-label="LinkedIn Profile">
                                            <svg fill="currentColor" viewBox="0 0 24 24">
                                                <path
                                                    d="M19 3a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h14m-.5 15.5v-5.3a3.26 3.26 0 0 0-3.26-3.26c-.85 0-1.84.52-2.32 1.3v-1.11h-2.8v8h2.8v-4.87c0-.26.05-.5.14-.68a1.11 1.11 0 0 1 1-.74c.75 0 1 .56 1 .95v5.34h2.8M6.5 8.37a1.37 1.37 0 1 0 0-2.75 1.37 1.37 0 0 0 0 2.75M8 18.5v-8H5v8h3z" />
                                            </svg>
                                        </a>
                                        <a href="https://github.com/SaubhagyaJung" class="social-btn"
                                            aria-label="GitHub Profile">
                                            <svg fill="currentColor" viewBox="0 0 24 24">
                                                <path
                                                    d="M12 2A10 10 0 0 0 2 12c0 4.42 2.87 8.17 6.84 9.5.5.08.66-.23.66-.5v-1.69c-2.77.6-3.36-1.34-3.36-1.34-.46-1.16-1.11-1.47-1.11-1.47-.9-.62.07-.6.07-.6 1 .07 1.53 1.03 1.53 1.03.9 1.52 2.34 1.07 2.91.83.09-.65.35-1.09.63-1.34-2.22-.25-4.55-1.11-4.55-4.92 0-1.11.38-2 1.03-2.71-.1-.25-.45-1.29.1-2.64 0 0 .84-.27 2.75 1.02.79-.22 1.65-.33 2.5-.33.85 0 1.71.11 2.5.33 1.91-1.29 2.75-1.02 2.75-1.02.55 1.35.2 2.39.1 2.64.65.71 1.03 1.6 1.03 2.71 0 3.82-2.34 4.66-4.57 4.91.36.31.69.92.69 1.85V21c0 .27.16.59.67.5C19.14 20.16 22 16.42 22 12A10 10 0 0 0 12 2z" />
                                            </svg>
                                        </a>
                                    </div>
                                </article>

                                <!-- Member 3: Nishesh Chaudhary -->
                                <article class="member-card animate-on-scroll" data-delay="200">
                                    <div class="member-photo-wrapper">
                                        <div class="member-photo">
                                            <img src="${pageContext.request.contextPath}/images/team/nishesh.jpg"
                                                alt="Nishesh Chaudhary"
                                                onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';"
                                                style="width: 100%; height: 100%; object-fit: cover;">
                                            <div class="member-avatar-fallback" style="display: none;">NC</div>
                                        </div>
                                    </div>
                                    <div class="member-info">
                                        <h3 class="member-name">Nishesh Chaudhary</h3>
                                        <span class="member-role">Full-Stack Developer</span>
                                        <p class="member-bio">
                                            Nishesh is a skilled Full-Stack Developer with a strong focus on frontend
                                            technologies and backend development. He is an expert in designing
                                            secure user interfaces and ensuring data integrity.
                                        </p>
                                    </div>
                                    <div class="member-socials">
                                        <a href="#" class="social-btn" aria-label="LinkedIn Profile">
                                            <svg fill="currentColor" viewBox="0 0 24 24">
                                                <path
                                                    d="M19 3a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h14m-.5 15.5v-5.3a3.26 3.26 0 0 0-3.26-3.26c-.85 0-1.84.52-2.32 1.3v-1.11h-2.8v8h2.8v-4.87c0-.26.05-.5.14-.68a1.11 1.11 0 0 1 1-.74c.75 0 1 .56 1 .95v5.34h2.8M6.5 8.37a1.37 1.37 0 1 0 0-2.75 1.37 1.37 0 0 0 0 2.75M8 18.5v-8H5v8h3z" />
                                            </svg>
                                        </a>
                                        <a href="https://github.com/Nisheshchy" class="social-btn"
                                            aria-label="GitHub Profile">
                                            <svg fill="currentColor" viewBox="0 0 24 24">
                                                <path
                                                    d="M12 2A10 10 0 0 0 2 12c0 4.42 2.87 8.17 6.84 9.5.5.08.66-.23.66-.5v-1.69c-2.77.6-3.36-1.34-3.36-1.34-.46-1.16-1.11-1.47-1.11-1.47-.9-.62.07-.6.07-.6 1 .07 1.53 1.03 1.53 1.03.9 1.52 2.34 1.07 2.91.83.09-.65.35-1.09.63-1.34-2.22-.25-4.55-1.11-4.55-4.92 0-1.11.38-2 1.03-2.71-.1-.25-.45-1.29.1-2.64 0 0 .84-.27 2.75 1.02.79-.22 1.65-.33 2.5-.33.85 0 1.71.11 2.5.33 1.91-1.29 2.75-1.02 2.75-1.02.55 1.35.2 2.39.1 2.64.65.71 1.03 1.6 1.03 2.71 0 3.82-2.34 4.66-4.57 4.91.36.31.69.92.69 1.85V21c0 .27.16.59.67.5C19.14 20.16 22 16.42 22 12A10 10 0 0 0 12 2z" />
                                            </svg>
                                        </a>
                                    </div>
                                </article>

                            </div>

                            <!-- 2 Members in bottom row -->
                            <div class="team-grid-bottom">

                                <!-- Member 4: Anurag Amagain -->
                                <article class="member-card animate-on-scroll" data-delay="400">
                                    <div class="member-photo-wrapper">
                                        <div class="member-photo">
                                            <img src="${pageContext.request.contextPath}/images/team/anurag.jpg"
                                                alt="Anurag Amagain"
                                                onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';"
                                                style="width: 100%; height: 100%; object-fit: cover;">
                                            <div class="member-avatar-fallback" style="display: none;">AA</div>
                                        </div>
                                    </div>
                                    <div class="member-info">
                                        <h3 class="member-name">Anurag Amagain</h3>
                                        <span class="member-role">Backend Developer</span>
                                        <p class="member-bio">
                                            Anurag is a solutions-focused Software Engineer with expertise in backend
                                            development. He has a strong foundation in application
                                            architecture, and building scalable web solutions.
                                        </p>
                                    </div>
                                    <div class="member-socials">
                                        <a href="#" class="social-btn" aria-label="LinkedIn Profile">
                                            <svg fill="currentColor" viewBox="0 0 24 24">
                                                <path
                                                    d="M19 3a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h14m-.5 15.5v-5.3a3.26 3.26 0 0 0-3.26-3.26c-.85 0-1.84.52-2.32 1.3v-1.11h-2.8v8h2.8v-4.87c0-.26.05-.5.14-.68a1.11 1.11 0 0 1 1-.74c.75 0 1 .56 1 .95v5.34h2.8M6.5 8.37a1.37 1.37 0 1 0 0-2.75 1.37 1.37 0 0 0 0 2.75M8 18.5v-8H5v8h3z" />
                                            </svg>
                                        </a>
                                        <a href="https://github.com/Anurag5500" class="social-btn"
                                            aria-label="GitHub Profile">
                                            <svg fill="currentColor" viewBox="0 0 24 24">
                                                <path
                                                    d="M12 2A10 10 0 0 0 2 12c0 4.42 2.87 8.17 6.84 9.5.5.08.66-.23.66-.5v-1.69c-2.77.6-3.36-1.34-3.36-1.34-.46-1.16-1.11-1.47-1.11-1.47-.9-.62.07-.6.07-.6 1 .07 1.53 1.03 1.53 1.03.9 1.52 2.34 1.07 2.91.83.09-.65.35-1.09.63-1.34-2.22-.25-4.55-1.11-4.55-4.92 0-1.11.38-2 1.03-2.71-.1-.25-.45-1.29.1-2.64 0 0 .84-.27 2.75 1.02.79-.22 1.65-.33 2.5-.33.85 0 1.71.11 2.5.33 1.91-1.29 2.75-1.02 2.75-1.02.55 1.35.2 2.39.1 2.64.65.71 1.03 1.6 1.03 2.71 0 3.82-2.34 4.66-4.57 4.91.36.31.69.92.69 1.85V21c0 .27.16.59.67.5C19.14 20.16 22 16.42 22 12A10 10 0 0 0 12 2z" />
                                            </svg>
                                        </a>
                                    </div>
                                </article>

                                <!-- Member 5: Raghav Timalsena -->
                                <article class="member-card animate-on-scroll" data-delay="300">
                                    <div class="member-photo-wrapper">
                                        <div class="member-photo">
                                            <img src="${pageContext.request.contextPath}/images/team/raghav.webp"
                                                alt="Raghav Timalsena"
                                                onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';"
                                                style="width: 100%; height: 100%; object-fit: cover;">
                                            <div class="member-avatar-fallback" style="display: none;">RT</div>
                                        </div>
                                    </div>
                                    <div class="member-info">
                                        <h3 class="member-name">Raghav Timalsena</h3>
                                        <span class="member-role">Software Developer</span>
                                        <p class="member-bio">
                                            Raghav is an adaptable Software Developer with expertise in System design
                                            and software architecture. He is proficient in building maintainable code.
                                        </p>
                                    </div>
                                    <div class="member-socials">
                                        <a href="#" class="social-btn" aria-label="LinkedIn Profile">
                                            <svg fill="currentColor" viewBox="0 0 24 24">
                                                <path
                                                    d="M19 3a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h14m-.5 15.5v-5.3a3.26 3.26 0 0 0-3.26-3.26c-.85 0-1.84.52-2.32 1.3v-1.11h-2.8v8h2.8v-4.87c0-.26.05-.5.14-.68a1.11 1.11 0 0 1 1-.74c.75 0 1 .56 1 .95v5.34h2.8M6.5 8.37a1.37 1.37 0 1 0 0-2.75 1.37 1.37 0 0 0 0 2.75M8 18.5v-8H5v8h3z" />
                                            </svg>
                                        </a>
                                        <a href="https://github.com/msdianraghav-a11y" class="social-btn"
                                            aria-label="GitHub Profile">
                                            <svg fill="currentColor" viewBox="0 0 24 24">
                                                <path
                                                    d="M12 2A10 10 0 0 0 2 12c0 4.42 2.87 8.17 6.84 9.5.5.08.66-.23.66-.5v-1.69c-2.77.6-3.36-1.34-3.36-1.34-.46-1.16-1.11-1.47-1.11-1.47-.9-.62.07-.6.07-.6 1 .07 1.53 1.03 1.53 1.03.9 1.52 2.34 1.07 2.91.83.09-.65.35-1.09.63-1.34-2.22-.25-4.55-1.11-4.55-4.92 0-1.11.38-2 1.03-2.71-.1-.25-.45-1.29.1-2.64 0 0 .84-.27 2.75 1.02.79-.22 1.65-.33 2.5-.33.85 0 1.71.11 2.5.33 1.91-1.29 2.75-1.02 2.75-1.02.55 1.35.2 2.39.1 2.64.65.71 1.03 1.6 1.03 2.71 0 3.82-2.34 4.66-4.57 4.91.36.31.69.92.69 1.85V21c0 .27.16.59.67.5C19.14 20.16 22 16.42 22 12A10 10 0 0 0 12 2z" />
                                            </svg>
                                        </a>
                                    </div>
                                </article>



                            </div>

                        </div>
                    </section>

                </main>

                <!-- Global Footer -->
                <jsp:include page="/jsp/includes/footer.jsp" />

                <!-- Entry Animations Hook -->
                <script>
                    document.addEventListener("DOMContentLoaded", () => {
                        // Mark page loaded for body transitions
                        document.body.classList.add("page-loaded");

                        // Simple IntersectionObserver for animate-on-scroll elements
                        const elements = document.querySelectorAll(".animate-on-scroll");
                        const observer = new IntersectionObserver((entries) => {
                            entries.forEach((entry) => {
                                if (entry.isIntersecting) {
                                    setTimeout(() => {
                                        entry.target.classList.add("is-visible");
                                    }, entry.target.dataset.delay || 0);
                                    observer.unobserve(entry.target);
                                }
                            });
                        }, { threshold: 0.1 });

                        elements.forEach((el) => observer.observe(el));
                    });
                </script>

            </body>

            </html>