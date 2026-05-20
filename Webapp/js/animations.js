// animations.js
const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

document.addEventListener('DOMContentLoaded', () => {
    if (prefersReducedMotion) return;

    // Intersection Observer for scroll animations
    const observerOptions = {
        root: null,
        rootMargin: '0px',
        threshold: 0.15
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('is-visible');
                
                // Animate counters if present
                const counters = entry.target.querySelectorAll('[data-counter]');
                counters.forEach(counter => {
                    const target = parseInt(counter.getAttribute('data-counter'), 10);
                    if (!isNaN(target)) {
                        animateCounter(counter, target);
                        counter.removeAttribute('data-counter'); // Prevent re-animating
                    }
                });

                if (entry.target.hasAttribute('data-counter')) {
                     const target = parseInt(entry.target.getAttribute('data-counter'), 10);
                     if (!isNaN(target)) {
                         animateCounter(entry.target, target);
                         entry.target.removeAttribute('data-counter'); 
                     }
                }

                observer.unobserve(entry.target);
            }
        });
    }, observerOptions);

    document.querySelectorAll('.animate-on-scroll').forEach(el => {
        const delay = el.getAttribute('data-delay');
        if (delay) {
            el.style.transitionDelay = delay + 'ms';
        }
        observer.observe(el);
    });
});

function animateCounter(element, target, duration = 1200) {
    const start = performance.now();
    const startValue = 0;

    function update(currentTime) {
        const elapsed = currentTime - start;
        const progress = Math.min(elapsed / duration, 1);
        const eased = 1 - Math.pow(1 - progress, 3); // Cubic ease out
        const current = Math.round(startValue + (target - startValue) * eased);
        
        element.textContent = current.toLocaleString();
        
        if (progress < 1) {
            requestAnimationFrame(update);
        } else {
            element.textContent = target.toLocaleString();
        }
    }

    requestAnimationFrame(update);
}
