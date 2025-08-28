<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<aside class="col-12 col-lg-3 col-xl-2 bg-white shadow-sm vh-100 position-sticky top-0 overflow-auto">
    <c:set var="cu" value="${sessionScope.currentUser}"/>

    <!-- User Info Setup -->
    <c:choose>
        <c:when test="${not empty cu}">
            <c:set var="displayName" value="${not empty cu.fullName ? cu.fullName : cu.username}"/>
            <c:set var="statusRaw" value="${empty cu.activeStatus ? 'ONLINE' : cu.activeStatus}"/>
        </c:when>
        <c:otherwise>
            <c:set var="displayName" value="User"/>
            <c:set var="statusRaw" value="ONLINE"/>
        </c:otherwise>
    </c:choose>

    <c:set var="statusLower" value="${fn:toLowerCase(statusRaw)}"/>
    <c:set var="statusColor" value="${statusLower eq 'online' ? 'success' : 'secondary'}"/>
    <c:set var="statusText"
           value="${statusLower eq 'online' ? 'Online' : (statusLower eq 'offline' ? 'Offline' : statusRaw)}"/>

    <!-- User Profile Header -->
    <div class="p-3 border-bottom">
        <div class="d-flex align-items-center gap-3 mb-0">
            <div class="position-relative">
                <img src="https://i.pravatar.cc/100?img=1" alt="avatar" class="rounded-circle shadow-sm" width="48"
                     height="48">
                <span class="position-absolute bottom-0 end-0 border border-white rounded-circle bg-${statusColor}"
                      style="width:12px; height:12px;"></span>
            </div>
            <div>
                <div class="fw-bold fs-6 mb-0">${displayName}</div>
                <small class="text-${statusColor} fw-medium">
                    <i class="bi bi-circle-fill" style="font-size:6px;"></i> ${statusText}
                </small>
            </div>
        </div>
    </div>

    <!-- Navigation Menu -->
    <nav class="p-3">
        <!-- Main Dashboard -->
        <div class="nav flex-column gap-1 mb-3">
            <a class="nav-link d-flex align-items-center gap-3 px-3 py-3 rounded-3 text-dark text-decoration-none"
               href="${pageContext.request.contextPath}/dashboard">
                <i class="bi bi-speedometer2 fs-5 text-warning"></i>
                <span>Dashboard</span>
            </a>
        </div>

        <!-- JOB POSTING SECTION -->
        <div class="mb-3">
            <div class="d-flex align-items-center gap-2 px-3 mb-2">
                <i class="bi bi-briefcase text-primary"></i>
                <span class="small fw-bold text-primary text-uppercase ls-1">Job Posting</span>
            </div>

            <div class="nav flex-column gap-1">
                <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none"
                   href="${pageContext.request.contextPath}/dashboard/jobs/create">
                    <i class="bi bi-plus-circle fs-6 text-primary"></i>
                    <span>Post New Job</span>
                </a>

                <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none"
                   href="${pageContext.request.contextPath}/dashboard/jobs/my-jobs">
                    <i class="bi bi-list-task fs-6 text-primary"></i>
                    <span>My Posted Jobs</span>
                </a>

                <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none"
                   href="${pageContext.request.contextPath}/dashboard/jobs/applications">
                    <i class="bi bi-person-lines-fill fs-6 text-primary"></i>
                    <span>Applications Received</span>
                </a>

                <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none"
                   href="${pageContext.request.contextPath}/dashboard/jobs/manage">
                    <i class="bi bi-kanban fs-6 text-primary"></i>
                    <span>Manage Projects</span>
                </a>
            </div>
        </div>

        <hr class="my-3">

        <!-- FREELANCING SECTION -->
        <div class="mb-3">
            <div class="d-flex align-items-center gap-2 px-3 mb-2">
                <i class="bi bi-person-workspace text-success"></i>
                <span class="small fw-bold text-success text-uppercase ls-1">Freelancing</span>
            </div>

            <div class="nav flex-column gap-1">
                <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none"
                   href="${pageContext.request.contextPath}/dashboard/browse-jobs">
                    <i class="bi bi-search fs-6 text-success"></i>
                    <span>Browse Jobs</span>
                </a>

                <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none"
                   href="${pageContext.request.contextPath}/dashboard/my-applications">
                    <i class="bi bi-file-earmark-text fs-6 text-success"></i>
                    <span>My Applications</span>
                </a>

                <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none"
                   href="${pageContext.request.contextPath}/dashboard/active-projects">
                    <i class="bi bi-play-circle fs-6 text-success"></i>
                    <span>Active Projects</span>
                </a>

                <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none"
                   href="${pageContext.request.contextPath}/dashboard/completed-work">
                    <i class="bi bi-check-circle fs-6 text-success"></i>
                    <span>Completed Work</span>
                </a>

                <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none"
                   href="${pageContext.request.contextPath}/dashboard/portfolio">
                    <i class="bi bi-collection fs-6 text-success"></i>
                    <span>My Portfolio</span>
                </a>
            </div>
        </div>

        <hr class="my-3">

        <!-- GENERAL FEATURES -->
        <div class="nav flex-column gap-1">
            <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none"
               href="${pageContext.request.contextPath}/dashboard/messages">
                <i class="bi bi-chat-dots fs-5 text-warning"></i>
                <span>Messages</span>
                <c:if test="${not empty sessionScope.unreadMessages and sessionScope.unreadMessages > 0}">
                    <span class="badge bg-danger rounded-pill ms-auto">${sessionScope.unreadMessages}</span>
                </c:if>
            </a>

            <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none"
               href="${pageContext.request.contextPath}/dashboard/notifications">
                <i class="bi bi-bell fs-5 text-warning"></i>
                <span>Notifications</span>
                <c:if test="${not empty sessionScope.unreadNotifications and sessionScope.unreadNotifications > 0}">
                    <span class="badge bg-primary rounded-pill ms-auto">${sessionScope.unreadNotifications}</span>
                </c:if>
            </a>

            <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none"
               href="${pageContext.request.contextPath}/dashboard/disputes">
                <i class="bi bi-shield-exclamation fs-5 text-warning"></i>
                <span>Disputes</span>
            </a>

            <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none"
               href="${pageContext.request.contextPath}/dashboard/transactions">
                <i class="bi bi-receipt fs-5 text-warning"></i>
                <span>Transactions</span>
            </a>

            <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none"
               href="${pageContext.request.contextPath}/dashboard/profile">
                <i class="bi bi-person-circle fs-5 text-warning"></i>
                <span>My Profile</span>
            </a>

            <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none"
               href="${pageContext.request.contextPath}/dashboard/settings">
                <i class="bi bi-gear fs-5 text-warning"></i>
                <span>Settings</span>
            </a>
        </div>
    </nav>

    <!-- Account Balance & Actions -->
    <div class="mt-auto p-3">
        <div class="card border-0 shadow-sm" style="background: linear-gradient(135deg, #fff5f0 0%, #ffffff 100%);">
            <div class="card-body p-3">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <small class="text-muted fw-medium">Balance</small>
                    <i class="bi bi-wallet2 text-warning"></i>
                </div>
                <div class="h4 mb-3 text-warning fw-bold">
                    ${sessionScope.userBalance != null ? sessionScope.userBalance : '1,080.00 VND'} </div>

                <!-- Balance Actions -->
                <div class="d-grid gap-2">
                    <button class="btn btn-warning btn-sm text-white"
                            onclick="window.location.href = '${pageContext.request.contextPath}/dashboard/wallet'">
                        <i class="bi bi-cash-coin me-2"></i>Manage Balance
                    </button>
                </div>

                <hr class="my-3">

                <!-- Logout -->
                <form action="<c:url value='/logout'/>" method="post" class="d-grid" style="margin:0;">
                    <c:if test="${not empty _csrf}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </c:if>
                    <button type="submit" class="btn btn-outline-secondary w-100 btn-sm">
                        <i class="bi bi-box-arrow-right me-2"></i>Logout
                    </button>
                </form>
            </div>
        </div>
    </div>
</aside>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
                                // Enhanced Sidebar Navigation Script for Dual Function User
                                document.addEventListener('DOMContentLoaded', function () {
                                    // Get all navigation links
                                    const navLinks = document.querySelectorAll('aside nav .nav-link');
                                    const allNavItems = [...navLinks];

                                    // Enhanced URL to Menu Mapping for dual function
                                    function getUrlToMenuMapping() {
                                        return {
                                            // Main
                                            '/dashboard': 'Dashboard',

                                            // Job Posting (Client Mode)
                                            '/dashboard/jobs/create': 'Post New Job',
                                            '/dashboard/jobs/my-jobs': 'My Posted Jobs',
                                            '/dashboard/jobs/applications': 'Applications Received',
                                            '/dashboard/jobs/manage': 'Manage Projects',

                                            // Freelancing (Freelancer Mode)
                                            '/dashboard/browse-jobs': 'Browse Jobs',
                                            '/dashboard/my-applications': 'My Applications',
                                            '/dashboard/active-projects': 'Active Projects',
                                            '/dashboard/completed-work': 'Completed Work',
                                            '/dashboard/portfolio': 'My Portfolio',

                                            // General
                                            '/dashboard/messages': 'Messages',
                                            '/dashboard/notifications': 'Notifications',
                                            '/dashboard/disputes': 'Disputes',
                                            '/dashboard/transactions': 'Transactions',
                                            '/dashboard/profile': 'My Profile',
                                            '/dashboard/settings': 'Settings',
                                            '/dashboard/wallet': 'Manage Balance',
                                        };
                                    }

                                    // Restore active state from URL or localStorage
                                    function restoreActiveState() {
                                        const currentPath = window.location.pathname;
                                        const urlMapping = getUrlToMenuMapping();

                                        let foundActiveFromURL = false;
                                        const expectedMenuName = urlMapping[currentPath];

                                        if (expectedMenuName) {
                                            allNavItems.forEach(link => {
                                                const linkText = link.querySelector('span')?.textContent;
                                                if (linkText === expectedMenuName) {
                                                    setActiveMenu(link);
                                                    foundActiveFromURL = true;
                                                    return;
                                                }
                                            });
                                        }

                                        // Fallback to saved state
                                        if (!foundActiveFromURL) {
                                            const savedActiveMenu = localStorage.getItem('user_active_menu');
                                            if (savedActiveMenu) {
                                                allNavItems.forEach(link => {
                                                    const linkText = link.querySelector('span')?.textContent;
                                                    if (linkText === savedActiveMenu) {
                                                        setActiveMenu(link);
                                                    }
                                                });
                                            }
                                        }
                                    }

                                    // Set active menu with appropriate styling
                                    function setActiveMenu(activeLink) {
                                        // Clear all active states
                                        allNavItems.forEach(item => {
                                            item.classList.remove('position-relative', 'overflow-hidden');
                                            item.style.background = '';
                                            item.style.color = '';
                                            item.classList.add('text-dark');

                                            // Remove overlay if exists
                                            const overlay = item.querySelector('.position-absolute');
                                            if (overlay && overlay.style.background === 'rgba(255, 255, 255, 0.1)') {
                                                overlay.remove();
                                            }
                                        });

                                        // Determine section color based on link
                                        const linkText = activeLink.querySelector('span')?.textContent;
                                        const isJobPosting = ['Post New Job', 'My Posted Jobs', 'Applications Received', 'Manage Projects'].includes(linkText);
                                        const isFreelancing = ['Browse Jobs', 'My Applications', 'Active Projects', 'Completed Work', 'My Portfolio'].includes(linkText);

                                        let gradientColor;
                                        if (isJobPosting) {
                                            gradientColor = 'linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%)'; // Primary blue
                                        } else if (isFreelancing) {
                                            gradientColor = 'linear-gradient(135deg, #198754 0%, #146c43 100%)'; // Success green
                                        } else {
                                            gradientColor = 'linear-gradient(135deg, #ff8c42 0%, #ffa726 100%)'; // Warning orange
                                        }

                                        // Set active state
                                        activeLink.classList.remove('text-dark');
                                        activeLink.classList.add('position-relative', 'overflow-hidden');
                                        activeLink.style.background = gradientColor;
                                        activeLink.style.color = 'white';

                                        // Add overlay effect
                                        const overlay = document.createElement('div');
                                        overlay.className = 'position-absolute top-0 start-0 w-100 h-100';
                                        overlay.style.background = 'rgba(255,255,255,0.1)';
                                        activeLink.appendChild(overlay);

                                        // Save active menu
                                        if (linkText) {
                                            localStorage.setItem('user_active_menu', linkText);
                                        }
                                    }

                                    // Add click event listeners
                                    allNavItems.forEach(link => {
                                        link.addEventListener('click', function (e) {
                                            if (this.getAttribute('href') === '#') {
                                                e.preventDefault();
                                            }

                                            setActiveMenu(this);

                                            // Dispatch custom event
                                            const menuText = this.querySelector('span')?.textContent;
                                            const customEvent = new CustomEvent('userSidebarNavigation', {
                                                detail: {
                                                    menuItem: menuText,
                                                    element: this,
                                                    href: this.getAttribute('href')
                                                }
                                            });
                                            document.dispatchEvent(customEvent);
                                        });
                                    });

                                    // Enhanced hover effects based on section
                                    allNavItems.forEach(link => {
                                        link.addEventListener('mouseenter', function () {
                                            if (!this.style.background.includes('linear-gradient')) {
                                                const linkText = this.querySelector('span')?.textContent;
                                                const isJobPosting = ['Post New Job', 'My Posted Jobs', 'Applications Received', 'Manage Projects'].includes(linkText);
                                                const isFreelancing = ['Browse Jobs', 'My Applications', 'Active Projects', 'Completed Work', 'My Portfolio'].includes(linkText);

                                                if (isJobPosting) {
                                                    this.style.backgroundColor = 'rgba(13, 110, 253, 0.1)';
                                                } else if (isFreelancing) {
                                                    this.style.backgroundColor = 'rgba(25, 135, 84, 0.1)';
                                                } else {
                                                    this.style.backgroundColor = 'rgba(255, 193, 7, 0.1)';
                                                }
                                                this.style.transition = 'background-color 0.2s ease';
                                            }
                                        });

                                        link.addEventListener('mouseleave', function () {
                                            if (!this.style.background.includes('linear-gradient')) {
                                                this.style.backgroundColor = '';
                                            }
                                        });
                                    });

                                    // Global functions
                                    window.setUserSidebarActive = function (menuText) {
                                        allNavItems.forEach(link => {
                                            const linkText = link.querySelector('span')?.textContent;
                                            if (linkText === menuText) {
                                                setActiveMenu(link);
                                            }
                                        });
                                    };

                                    window.getUserSidebarActive = function () {
                                        const activeLink = document.querySelector('aside nav .nav-link[style*="linear-gradient"]');
                                        return activeLink ? activeLink.querySelector('span')?.textContent : null;
                                    };

                                    window.clearUserSidebarState = function () {
                                        localStorage.removeItem('user_active_menu');
                                    };

                                    // Initialize
                                    restoreActiveState();

                                    // Save state before page unload
                                    window.addEventListener('beforeunload', function () {
                                        // Auto-save current state
                                    });
                                });

                                // Quick stats refresh for dashboard
                                function refreshUserStats() {
                                    fetch('${pageContext.request.contextPath}/dashboard/api/user-stats')
                                            .then(response => response.json())
                                            .then(data => {
                                                if (data.success) {
                                                    // Update balance if provided
                                                    if (data.balance !== undefined) {
                                                        const balanceElement = document.querySelector('.h4.text-warning');
                                                        if (balanceElement) {
                                                            balanceElement.textContent = '$' + data.balance.toFixed(2);
                                                        }
                                                    }

                                                    // Update notification badges
                                                    if (data.unreadMessages !== undefined) {
                                                        updateBadge('Messages', data.unreadMessages);
                                                    }
                                                    if (data.unreadNotifications !== undefined) {
                                                        updateBadge('Notifications', data.unreadNotifications);
                                                    }
                                                }
                                            })
                                            .catch(error => console.error('Error refreshing user stats:', error));
                                }

                                function updateBadge(menuText, count) {
                                    const menuLink = Array.from(document.querySelectorAll('aside nav .nav-link')).find(link =>
                                        link.querySelector('span')?.textContent === menuText
                                    );

                                    if (menuLink) {
                                        let badge = menuLink.querySelector('.badge');
                                        if (count > 0) {
                                            if (!badge) {
                                                badge = document.createElement('span');
                                                badge.className = 'badge rounded-pill ms-auto';
                                                badge.className += menuText === 'Messages' ? ' bg-danger' : ' bg-primary';
                                                menuLink.appendChild(badge);
                                            }
                                            badge.textContent = count;
                                        } else if (badge) {
                                            badge.remove();
                                        }
                                    }
                                }

                                // Refresh stats every 60 seconds
                                setInterval(refreshUserStats, 60000);
</script>