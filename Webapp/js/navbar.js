// navbar.js
document.addEventListener('DOMContentLoaded', () => {
    const navbar = document.getElementById('mainNavbar');
    const hamburger = document.getElementById('hamburgerBtn');
    const mobileMenu = document.getElementById('mobileMenuPanel');

    if (!navbar) return;

    // Scroll state tracking
    window.addEventListener('scroll', () => {
        if (window.scrollY > 20) {
            navbar.classList.add('nav--scrolled');
        } else {
            navbar.classList.remove('nav--scrolled');
        }
    });

    // Mobile menu toggle logic
    if (hamburger && mobileMenu) {
        hamburger.addEventListener('click', () => {
            const isExpanded = hamburger.getAttribute('aria-expanded') === 'true';
            
            if (!isExpanded) {
                // Open menu
                hamburger.setAttribute('aria-expanded', 'true');
                hamburger.classList.add('nav--open');
                mobileMenu.classList.add('is-open');
                
                // Make links focusable
                mobileMenu.querySelectorAll('a').forEach(link => link.removeAttribute('tabindex'));
            } else {
                // Close menu
                hamburger.setAttribute('aria-expanded', 'false');
                hamburger.classList.remove('nav--open');
                mobileMenu.classList.remove('is-open');
                
                // Remove links from tab order to prevent invisible focusing
                mobileMenu.querySelectorAll('a').forEach(link => link.setAttribute('tabindex', '-1'));
            }
        });
    }
});
