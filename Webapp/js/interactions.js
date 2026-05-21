// interactions.js
document.addEventListener('DOMContentLoaded', () => {
    // 1. Page Transition Overlay
    // Mark page as loaded to fade out the overlay initially
    document.body.classList.add('page-loaded');

    const overlay = document.querySelector('.page-transition-overlay');
    if (overlay) {
        document.querySelectorAll('a[href]').forEach(link => {
            link.addEventListener('click', (e) => {
                const href = link.getAttribute('href');
                if (!href || href.startsWith('http') || href.startsWith('#') || href.startsWith('mailto') || href.startsWith('javascript')) {
                    return;
                }
                const targetPattern = link.getAttribute('target');
                if (targetPattern === '_blank') return; // Don't delay new tabs

                e.preventDefault();
                overlay.style.opacity = '1';
                setTimeout(() => {
                    window.location.href = href;
                }, 200);
            });
        });
    }

    // 2. Scroll Progress Bar
    const progressBar = document.createElement('div');
    progressBar.className = 'scroll-progress-bar';
    document.body.appendChild(progressBar);

    window.addEventListener('scroll', () => {
        const scrolled = window.scrollY;
        const total = document.documentElement.scrollHeight - window.innerHeight;
        const progress = total > 0 ? (scrolled / total) * 100 : 0;
        progressBar.style.width = progress + '%';
    });

    // 3. Tab Filter Sliding Indicator (Browse Page)
    const filterTabsContainer = document.querySelector('.filter-tabs');
    if (filterTabsContainer) {
        const indicator = document.createElement('div');
        indicator.className = 'tab-indicator';
        filterTabsContainer.insertBefore(indicator, filterTabsContainer.firstChild);

        const activeTab = filterTabsContainer.querySelector('.filter-tab.active');
        if (activeTab) {
            indicator.style.transform = `translateX(\${activeTab.offsetLeft}px)`;
            indicator.style.width = `\${activeTab.offsetWidth}px`;
        }

        // Handle clicks for animation (though navigation usually resets it, this handles pure visual fidelity before navigation)
        const tabs = filterTabsContainer.querySelectorAll('.filter-tab');
        tabs.forEach(tab => {
            tab.addEventListener('click', (e) => {
                const href = tab.getAttribute('href');
                if (href) {
                    e.preventDefault(); // Stop instant navigation
                    indicator.style.transform = `translateX(\${tab.offsetLeft}px)`;
                    indicator.style.width = `\${tab.offsetWidth}px`;
                    
                    // Fade out grid before navigating
                    const grid = document.querySelector('.item-grid, .empty-state');
                    if (grid) {
                        grid.style.transition = 'opacity 150ms ease-in, transform 150ms ease-in';
                        grid.style.opacity = '0';
                        grid.style.transform = 'translateY(8px)';
                    }

                    setTimeout(() => {
                        window.location.href = href;
                    }, 150);
                }
            });
        });
    }

    // 4. Magnetic Button Effect (Desktop Homepage CTA)
    const ctaBtn = document.querySelector('.hero-actions .btn-primary');
    if (ctaBtn && !window.matchMedia('(prefers-reduced-motion: reduce)').matches && window.matchMedia('(hover: hover)').matches) {
        const wrapper = ctaBtn.parentElement; // Need a boundary to track
        wrapper.addEventListener('mousemove', (e) => {
            const rect = ctaBtn.getBoundingClientRect();
            const centerX = rect.left + rect.width / 2;
            const centerY = rect.top + rect.height / 2;
            
            // Calculate distance
            const deltaX = e.clientX - centerX;
            const deltaY = e.clientY - centerY;
            
            // Only affect within a certain radius, approx parent wrapper size
            ctaBtn.style.transform = `translate(\${deltaX * 0.15}px, \${deltaY * 0.15}px)`;
            ctaBtn.style.transition = 'transform 50ms linear';
        });

        wrapper.addEventListener('mouseleave', () => {
            ctaBtn.style.transform = 'translate(0px, 0px)';
            ctaBtn.style.transition = 'transform 400ms var(--ease-out)';
        });
    }

    // 5. Auto-dismiss Flash Messages
    const flashes = document.querySelectorAll('.alert');
    flashes.forEach(message => {
        // Create close button
        const closeBtn = document.createElement('button');
        closeBtn.innerHTML = '&times;';
        closeBtn.className = 'alert-close-btn';
        message.appendChild(closeBtn);

        const dismiss = () => {
            message.style.opacity = '0';
            message.style.transform = 'translateY(-8px)';
            message.style.transition = 'all 300ms ease-in';
            setTimeout(() => message.remove(), 300);
        };

        closeBtn.addEventListener('click', dismiss);

        // Auto dismiss timer
        setTimeout(dismiss, 5000);
    });

    // 6. Inline Delete Confirmation
    const deleteButtons = document.querySelectorAll('.action-delete');
    deleteButtons.forEach(btn => {
        const form = btn.closest('form');
        if (!form) return;
        
        // Remove native confirm if it exists on the onclick attribute
        btn.removeAttribute('onclick');

        btn.addEventListener('click', (e) => {
            if (form.getAttribute('data-confirmed') !== 'true') {
                e.preventDefault(); // Stop submission
                
                // Save original content
                const originalHtml = form.parentElement.innerHTML;
                
                // Restyle cell to show inline confirmation
                const cell = form.parentElement;
                
                cell.innerHTML = `
                    <div class="inline-confirm animate-slide-in-right">
                        <span style="font-size: 13px; color: var(--text-secondary); margin-right: 8px;">Are you sure?</span>
                        <button class="btn btn-danger btn-sm confirm-yes">Yes, delete</button>
                        <button type="button" class="action-link confirm-cancel" style="margin-left: 8px; font-size:13px;">Cancel</button>
                    </div>
                `;
                
                // Re-bind listeners for the newly constructed elements
                cell.querySelector('.confirm-cancel').addEventListener('click', () => {
                    cell.innerHTML = originalHtml;
                    // Note: Would need to rebind the outer listener here, or use event delegation
                    window.location.reload(); // Simple reload logic to restore state and listeners cleanly without complex recursive delegation
                });
                
                cell.querySelector('.confirm-yes').addEventListener('click', () => {
                    form.setAttribute('data-confirmed', 'true');
                    // Create an invisible recreation of the form and submit it
                    const cloneForm = document.createElement('form');
                    cloneForm.method = form.getAttribute('method') || 'POST';
                    cloneForm.action = form.getAttribute('action');
                    cloneForm.style.display = 'none';
                    form.querySelectorAll('input').forEach(inp => {
                        const newInp = document.createElement('input');
                        newInp.type = 'hidden';
                        newInp.name = inp.name;
                        newInp.value = inp.value;
                        cloneForm.appendChild(newInp);
                    });
                    document.body.appendChild(cloneForm);
                    cloneForm.submit();
                });
            }
        });
    });
});
