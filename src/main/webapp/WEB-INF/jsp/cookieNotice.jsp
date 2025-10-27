<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Cookie Consent CSS -->
<link rel="stylesheet" href="/platform/js/cookieconsent/dist/cookieconsent.css">

<!-- Cookie Consent Script -->
<script src="/platform/js/cookieconsent/dist/cookieconsent.js"></script>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Initialize Cookie Consent v2.9.1
    const cc = initCookieConsent();

    // Check if user has already made a choice
    const userChoice = localStorage.getItem('scge_cookie_consent');
    console.log('Cookie consent choice:', userChoice);

    // Only show banner if user hasn't accepted
    if (userChoice !== 'accepted') {
        console.log('Showing cookie banner');
        cc.run({
            current_lang: 'en',
            autoclear_cookies: true,
            page_scripts: true,
            cookie_expiration: 0, // Don't use cookies for consent tracking

            onFirstAction: function(user_preferences, cookie) {
                // Only store acceptance in localStorage, not decline
                if (user_preferences.accept_type === 'all') {
                    localStorage.setItem('scge_cookie_consent', 'accepted');
                }
                // If declined, don't store anything - banner will show again on next page

                // Always clear the consent cookie since we're using localStorage
                document.cookie = 'cc_cookie=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;';
            },

            gui_options: {
                consent_modal: {
                    layout: 'box',
                    position: 'bottom right',
                    transition: 'slide'
                }
            },

            languages: {
                en: {
                    consent_modal: {
                        description: 'This website uses cookies to enhance your browsing experience, analyze site traffic, and personalize content. By continuing to use this site, you consent to our use of cookies in accordance with our <a href="/platform/privacy" class="cc-link">Privacy Policy</a>',
                        primary_btn: {
                            text: 'Accept',
                            role: 'accept_all'
                        },
                        secondary_btn: {
                            text: 'Decline',
                            role: 'accept_necessary'
                        }
                    },
                    settings_modal: {
                        title: 'Cookie preferences',
                        save_settings_btn: 'Save settings',
                        accept_all_btn: 'Accept all',
                        reject_all_btn: 'Reject all',
                        close_btn_label: 'Close',
                        blocks: [
                            {
                                title: 'Cookie usage',
                                description: 'We use cookies to ensure the basic functionalities of the website and to enhance your online experience. You can choose for each category to opt-in/out whenever you want.'
                            },
                            {
                                title: 'Strictly necessary cookies',
                                description: 'These cookies are essential for the proper functioning of our website. Without these cookies, the website would not work properly.',
                                toggle: {
                                    value: 'necessary',
                                    enabled: true,
                                    readonly: true
                                }
                            },
                            {
                                title: 'Analytics cookies',
                                description: 'These cookies collect information about how you use our website to help us improve it.',
                                toggle: {
                                    value: 'analytics',
                                    enabled: false,
                                    readonly: false
                                }
                            }
                        ]
                    }
                }
            }
        });
    }
});
</script>

<!-- Custom CSS for cookie banner styling -->
<style>
:root {
    --cc-bg: #1b80b6;
    --cc-text: #ffffff;
    --cc-btn-primary-bg: #ffffff;
    --cc-btn-primary-text: #1b80b6;
    --cc-btn-secondary-bg: transparent;
    --cc-btn-secondary-text: #ffffff;
    --cc-btn-secondary-border: #ffffff;
}

#cc--main {
    font-family: 'Roboto', sans-serif !important;
    font-size: 14px !important;
}

.cc_div {
    background-color: var(--cc-bg) !important;
    color: var(--cc-text) !important;
    box-shadow: 0 2px 5px 0 rgba(0,0,0,0.16), 0 2px 10px 0 rgba(0,0,0,0.12) !important;
}

.c-bn {
    border-radius: 4px !important;
    font-weight: 500 !important;
    padding: 8px 16px !important;
    transition: all 0.3s ease !important;
    border: 1px solid transparent !important;
}

#c-p-bn {
    background-color: var(--cc-btn-primary-bg) !important;
    color: var(--cc-btn-primary-text) !important;
}

#c-s-bn {
    background-color: var(--cc-btn-secondary-bg) !important;
    color: var(--cc-btn-secondary-text) !important;
    border-color: var(--cc-btn-secondary-border) !important;
}

.c-bn:hover {
    opacity: 0.8 !important;
}

.cc-link {
    color: var(--cc-text) !important;
    text-decoration: underline !important;
}

.cc-link:hover {
    opacity: 0.8 !important;
}
</style>