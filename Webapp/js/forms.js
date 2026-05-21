// forms.js
document.addEventListener('DOMContentLoaded', () => {
    // Label Shift on Focus
    const formControls = document.querySelectorAll('.form-control');
    formControls.forEach(control => {
        control.addEventListener('focus', () => {
            const group = control.closest('.form-group');
            if (group) group.classList.add('field--focused');
        });
        control.addEventListener('blur', () => {
            const group = control.closest('.form-group');
            if (group) group.classList.remove('field--focused');
            validateField(control); // Inline validation check
        });
    });

    // Textarea Character Counter
    const descriptions = document.querySelectorAll('textarea[name="description"]');
    descriptions.forEach(textarea => {
        const group = textarea.closest('.form-group');
        if (!group) return;
        
        const counter = document.createElement('div');
        counter.className = 'char-counter';
        // Assume 500 is max length if not specified
        const maxLength = textarea.getAttribute('maxlength') || 500;
        
        counter.textContent = maxLength + ' characters remaining';
        group.appendChild(counter);

        textarea.addEventListener('input', () => {
            const remaining = maxLength - textarea.value.length;
            counter.textContent = remaining + ' characters remaining';
            
            // Re-trigger scale pulse via CSS reflow trick
            counter.classList.remove('pulse');
            void counter.offsetWidth;
            counter.classList.add('pulse');

            if (remaining <= 0) {
                counter.style.color = 'var(--error)';
            } else if (remaining <= 20) {
                counter.style.color = 'var(--warning)';
            } else {
                counter.style.color = 'var(--text-muted)';
            }
        });
    });

    // Password Show/Hide Toggle
    const passwordFields = document.querySelectorAll('input[type="password"]');
    passwordFields.forEach(pwdField => {
        // Exclude fields not inside a standard form group layout if necessary, but standard assumes relative wrapper
        const wrapper = pwdField.closest('.form-group');
        if (!wrapper) return;
        
        const toggleBtn = document.createElement('button');
        toggleBtn.type = 'button';
        toggleBtn.className = 'pwd-toggle-btn';
        toggleBtn.textContent = 'Show';
        wrapper.style.position = 'relative'; // Ensure wrapper is positioned
        wrapper.appendChild(toggleBtn);

        toggleBtn.addEventListener('click', () => {
            const type = pwdField.getAttribute('type') === 'password' ? 'text' : 'password';
            pwdField.setAttribute('type', type);
            toggleBtn.textContent = type === 'password' ? 'Show' : 'Hide';
        });
    });

    // Button Loading State
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', (e) => {
            // Prevent if basic HTML5 validation fails natively
            if (!form.checkValidity()) return;
            const btn = form.querySelector('button[type="submit"]');
            if (btn) btn.classList.add('btn--loading');
        });
    });

    // Real-time Confirm Password Matching
    const cpwdField = document.getElementById('confirmPassword');
    if (cpwdField) {
        const pwdField = document.getElementById('password');
        cpwdField.addEventListener('input', () => {
            if (cpwdField.value !== pwdField.value && cpwdField.value.length > 0) {
                cpwdField.classList.add('error');
            } else {
                cpwdField.classList.remove('error');
                if (cpwdField.value.length > 0 && cpwdField.value === pwdField.value) {
                    cpwdField.classList.add('valid-success');
                }
            }
        });
    }

    // Basic Inline Validation Method
    function validateField(control) {
        const errorSpanId = 'err_' + (control.id || Math.random().toString(36).substring(7));
        let errorSpan = control.parentElement.querySelector('.field-error-inline');
        
        if (!errorSpan) {
            errorSpan = document.createElement('span');
            errorSpan.className = 'field-error field-error-inline';
            errorSpan.id = errorSpanId;
            control.parentElement.appendChild(errorSpan);
        }

        if (control.required && !control.value.trim()) {
            control.classList.add('error');
            control.classList.remove('valid-success');
            errorSpan.textContent = 'This field is required.';
            errorSpan.style.display = 'block';
        } else if (control.type === 'email' && control.value.trim() && !/^[^@]+@[^@]+\.[^@]+$/.test(control.value)) {
            control.classList.add('error');
            control.classList.remove('valid-success');
            errorSpan.textContent = 'Please enter a valid email address.';
            errorSpan.style.display = 'block';
        } else if (control.id === 'password' && control.value.length > 0 && control.value.length < 8) {
            control.classList.add('error');
            control.classList.remove('valid-success');
            errorSpan.textContent = 'Password must be at least 8 characters.';
            errorSpan.style.display = 'block';
        } else if (control.value.trim()) {
            control.classList.remove('error');
            control.classList.add('valid-success');
            errorSpan.style.display = 'none';
        }
    }
});
