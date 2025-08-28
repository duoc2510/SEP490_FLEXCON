<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- Admin Sidebar -->
<aside class="col-12 col-lg-3 col-xl-2 bg-white shadow-sm vh-100 position-sticky top-0 overflow-auto">
    <c:set var="cu" value="${sessionScope.currentUser}"/>

    <!-- Check if user is admin -->
    <%--    <c:set var="isAdmin" value="${cu.role eq 'Admin' or cu.role eq 'Super_admin'}"/>--%>

    <%--    <!-- If not admin, redirect or show error -->--%>
    <%--    <c:if test="${not isAdmin}">--%>
    <%--        <c:redirect url="/access-denied"/>--%>
    <%--    </c:if>--%>

    <!-- Admin Profile Section -->
    <c:choose>
        <c:when test="${not empty cu}">
            <c:set var="displayName" value="${not empty cu.fullName ? cu.fullName : cu.username}"/>
            <c:set var="statusRaw" value="${empty cu.activeStatus ? 'ONLINE' : cu.activeStatus}"/>
            <c:set var="adminBadge" value="${cu.role eq 'SUPER_ADMIN' ? 'Super Admin' : 'Admin'}"/>
        </c:when>
        <c:otherwise>
            <c:set var="displayName" value="Admin"/>
            <c:set var="statusRaw" value="ONLINE"/>
            <c:set var="adminBadge" value="Admin"/>
        </c:otherwise>
    </c:choose>

    <c:set var="statusLower" value="${fn:toLowerCase(statusRaw)}"/>
    <c:set var="statusColor" value="${statusLower eq 'online' ? 'success' : 'secondary'}"/>
    <c:set var="statusText"
           value="${statusLower eq 'online' ? 'Online' : (statusLower eq 'offline' ? 'Offline' : statusRaw)}"/>

    <!-- Admin Header -->
    <div class="p-3 border-bottom">
        <div class="d-flex align-items-center gap-3 mb-0">
            <div class="position-relative">
                <img src="https://i.pravatar.cc/100?img=68" alt="admin avatar" class="rounded-circle shadow-sm"
                     width="48" height="48">
                <span class="position-absolute bottom-0 end-0 border border-white rounded-circle bg-${statusColor}"
                      style="width:12px; height:12px;"></span>
            </div>
            <div>
                <div class="fw-bold fs-6 mb-0">${displayName}</div>
                <div class="d-flex align-items-center gap-2">
                    <small class="text-${statusColor} fw-medium">
                        <i class="bi bi-circle-fill" style="font-size:6px;"></i> ${statusText}
                    </small>
                    <span class="badge bg-danger rounded-pill" style="font-size:9px;">${adminBadge}</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Admin Navigation -->
    <nav class="p-3">
        <div class="nav flex-column gap-1">
            <!-- Dashboard -->
            <a class="nav-link d-flex align-items-center gap-3 px-3 py-3 rounded-3 text-dark text-decoration-none"
               href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="bi bi-speedometer2 fs-5 text-primary"></i>
                <span>Dashboard</span>
            </a>

            <!-- User Management -->
            <div class="nav-item">
                <a class="nav-link d-flex align-items-center gap-3 px-3 py-3 rounded-3 text-dark text-decoration-none"
                   href="#" data-bs-toggle="collapse" data-bs-target="#userManagementSubmenu" aria-expanded="false">
                    <i class="bi bi-people fs-5 text-primary"></i>
                    <span>User Management</span>
                    <i class="bi bi-chevron-down ms-auto transition-rotate"></i>
                </a>
                <div class="collapse" id="userManagementSubmenu">
                    <div class="ps-4 py-2">
                        <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none submenu-item"
                           href="${pageContext.request.contextPath}/admin/users">
                            <i class="bi bi-person-lines-fill fs-6 text-muted"></i>
                            <span>All Users</span>
                        </a>
                        <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none submenu-item"
                           href="${pageContext.request.contextPath}/admin/users/pending">
                            <i class="bi bi-person-check fs-6 text-muted"></i>
                            <span>Pending Approval</span>
                        </a>
                        <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none submenu-item"
                           href="${pageContext.request.contextPath}/admin/users/suspended">
                            <i class="bi bi-person-x fs-6 text-muted"></i>
                            <span>Suspended Users</span>
                        </a>
                        <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none submenu-item"
                           href="${pageContext.request.contextPath}/admin/users/roles">
                            <i class="bi bi-shield-check fs-6 text-muted"></i>
                            <span>Role Management</span>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Project Management -->
            <div class="nav-item">
                <a class="nav-link d-flex align-items-center gap-3 px-3 py-3 rounded-3 text-dark text-decoration-none"
                   href="#" data-bs-toggle="collapse" data-bs-target="#projectManagementSubmenu" aria-expanded="false">
                    <i class="bi bi-kanban fs-5 text-primary"></i>
                    <span>Project Management</span>
                    <i class="bi bi-chevron-down ms-auto transition-rotate"></i>
                </a>
                <div class="collapse" id="projectManagementSubmenu">
                    <div class="ps-4 py-2">
                        <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none submenu-item"
                           href="${pageContext.request.contextPath}/admin/projects">
                            <i class="bi bi-folder2-open fs-6 text-muted"></i>
                            <span>All Projects</span>
                        </a>
                        <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none submenu-item"
                           href="${pageContext.request.contextPath}/admin/projects/active">
                            <i class="bi bi-play-circle fs-6 text-muted"></i>
                            <span>Active Projects</span>
                        </a>
                        <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none submenu-item"
                           href="${pageContext.request.contextPath}/admin/projects/completed">
                            <i class="bi bi-check-circle fs-6 text-muted"></i>
                            <span>Completed Projects</span>
                        </a>
                        <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none submenu-item"
                           href="${pageContext.request.contextPath}/admin/projects/categories">
                            <i class="bi bi-tags fs-6 text-muted"></i>
                            <span>Categories</span>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Financial Management -->
            <div class="nav-item">
                <a class="nav-link d-flex align-items-center gap-3 px-3 py-3 rounded-3 text-dark text-decoration-none"
                   href="#" data-bs-toggle="collapse" data-bs-target="#financialSubmenu" aria-expanded="false">
                    <i class="bi bi-cash-stack fs-5 text-primary"></i>
                    <span>Financial</span>
                    <i class="bi bi-chevron-down ms-auto transition-rotate"></i>
                </a>
                <div class="collapse" id="financialSubmenu">
                    <div class="ps-4 py-2">
                        <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none submenu-item"
                           href="${pageContext.request.contextPath}/admin/transactions">
                            <i class="bi bi-credit-card fs-6 text-muted"></i>
                            <span>Transactions</span>
                        </a>
                        <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none submenu-item"
                           href="${pageContext.request.contextPath}/admin/payments">
                            <i class="bi bi-wallet2 fs-6 text-muted"></i>
                            <span>Payments</span>
                        </a>
                        <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none submenu-item"
                           href="${pageContext.request.contextPath}/admin/withdraws">
                            <i class="bi bi-arrow-up-circle fs-6 text-muted"></i>
                            <span>Withdrawals</span>
                        </a>
                        <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none submenu-item"
                           href="${pageContext.request.contextPath}/admin/commissions">
                            <i class="bi bi-percent fs-6 text-muted"></i>
                            <span>Commission Settings</span>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Dispute Management -->
            <a class="nav-link d-flex align-items-center gap-3 px-3 py-3 rounded-3 text-dark text-decoration-none"
               href="${pageContext.request.contextPath}/admin/disputes">
                <i class="bi bi-shield-exclamation fs-5 text-primary"></i>
                <span>Disputes</span>
                <c:if test="${not empty sessionScope.pendingDisputesCount and sessionScope.pendingDisputesCount > 0}">
                    <span class="badge bg-danger rounded-pill ms-auto">${sessionScope.pendingDisputesCount}</span>
                </c:if>
            </a>

            <!-- Reports -->
            <div class="nav-item">
                <a class="nav-link d-flex align-items-center gap-3 px-3 py-3 rounded-3 text-dark text-decoration-none"
                   href="#" data-bs-toggle="collapse" data-bs-target="#reportsSubmenu" aria-expanded="false">
                    <i class="bi bi-graph-up fs-5 text-primary"></i>
                    <span>Reports</span>
                    <i class="bi bi-chevron-down ms-auto transition-rotate"></i>
                </a>
                <div class="collapse" id="reportsSubmenu">
                    <div class="ps-4 py-2">
                        <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none submenu-item"
                           href="${pageContext.request.contextPath}/admin/reports/revenue">
                            <i class="bi bi-currency-dollar fs-6 text-muted"></i>
                            <span>Revenue Report</span>
                        </a>
                        <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none submenu-item"
                           href="${pageContext.request.contextPath}/admin/reports/users">
                            <i class="bi bi-people fs-6 text-muted"></i>
                            <span>User Analytics</span>
                        </a>
                        <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none submenu-item"
                           href="${pageContext.request.contextPath}/admin/reports/projects">
                            <i class="bi bi-bar-chart fs-6 text-muted"></i>
                            <span>Project Statistics</span>
                        </a>
                        <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none submenu-item"
                           href="${pageContext.request.contextPath}/admin/reports/export">
                            <i class="bi bi-download fs-6 text-muted"></i>
                            <span>Export Data</span>
                        </a>
                    </div>
                </div>
            </div>

            <!-- System Settings -->
            <c:if test="${cu.role eq 'SUPER_ADMIN'}">
                <div class="nav-item">
                    <a class="nav-link d-flex align-items-center gap-3 px-3 py-3 rounded-3 text-dark text-decoration-none"
                       href="#" data-bs-toggle="collapse" data-bs-target="#systemSubmenu" aria-expanded="false">
                        <i class="bi bi-gear fs-5 text-primary"></i>
                        <span>System Settings</span>
                        <i class="bi bi-chevron-down ms-auto transition-rotate"></i>
                    </a>
                    <div class="collapse" id="systemSubmenu">
                        <div class="ps-4 py-2">
                            <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none submenu-item"
                               href="${pageContext.request.contextPath}/admin/settings/general">
                                <i class="bi bi-sliders fs-6 text-muted"></i>
                                <span>General Settings</span>
                            </a>
                            <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none submenu-item"
                               href="${pageContext.request.contextPath}/admin/settings/email">
                                <i class="bi bi-envelope-gear fs-6 text-muted"></i>
                                <span>Email Settings</span>
                            </a>
                            <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none submenu-item"
                               href="${pageContext.request.contextPath}/admin/settings/security">
                                <i class="bi bi-shield-lock fs-6 text-muted"></i>
                                <span>Security Settings</span>
                            </a>
                            <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none submenu-item"
                               href="${pageContext.request.contextPath}/admin/settings/backup">
                                <i class="bi bi-cloud-download fs-6 text-muted"></i>
                                <span>Backup & Restore</span>
                            </a>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Logs & Monitoring -->
            <a class="nav-link d-flex align-items-center gap-3 px-3 py-3 rounded-3 text-dark text-decoration-none"
               href="${pageContext.request.contextPath}/admin/logs">
                <i class="bi bi-file-text fs-5 text-primary"></i>
                <span>System Logs</span>
            </a>
        </div>

        <hr class="my-3">

        <!-- Admin Notifications -->
        <div class="nav flex-column gap-1">
            <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none"
               href="${pageContext.request.contextPath}/admin/notifications">
                <i class="bi bi-bell fs-5 text-muted"></i>
                <span>Admin Alerts</span>
                <c:if test="${not empty sessionScope.adminNotificationCount and sessionScope.adminNotificationCount > 0}">
                    <span class="badge bg-danger rounded-pill ms-auto">${sessionScope.adminNotificationCount}</span>
                </c:if>
            </a>
            <a class="nav-link d-flex align-items-center gap-3 px-3 py-2 rounded-3 text-dark text-decoration-none"
               href="${pageContext.request.contextPath}/admin/messages">
                <i class="bi bi-chat-dots fs-5 text-muted"></i>
                <span>Admin Messages</span>
                <c:if test="${not empty sessionScope.adminMessageCount and sessionScope.adminMessageCount > 0}">
                    <span class="badge bg-warning rounded-pill ms-auto">${sessionScope.adminMessageCount}</span>
                </c:if>
            </a>
        </div>
    </nav>

    <!-- System Status & Quick Actions -->
    <div class="mt-auto p-3">
        <!-- System Status Card -->
        <div class="card border-0 shadow-sm mb-3"
             style="background: linear-gradient(135deg, #e3f2fd 0%, #ffffff 100%);">
            <div class="card-body p-3">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <small class="text-muted fw-medium">System Status</small>
                    <i class="bi bi-server text-primary"></i>
                </div>
                <div class="d-flex align-items-center gap-2 mb-2">
                    <span class="badge bg-success rounded-pill" style="font-size:8px;">Online</span>
                    <small class="text-muted">All services running</small>
                </div>

                <!-- Quick Actions -->
                <div class="d-grid gap-2">
                    <button class="btn btn-primary btn-sm"
                            onclick="window.location.href = '${pageContext.request.contextPath}/admin/quick-actions'">
                        <i class="bi bi-lightning me-2"></i>Quick Actions
                    </button>
                </div>
            </div>
        </div>

        <!-- User View Switch & Logout -->
        <div class="card border-0 shadow-sm" style="background: linear-gradient(135deg, #fff3e0 0%, #ffffff 100%);">
            <div class="card-body p-3">
                <!-- Switch to User View -->
                <a href="${pageContext.request.contextPath}/users/dashboard"
                   class="btn btn-outline-primary w-100 btn-sm mb-2">
                    <i class="bi bi-person-circle me-2"></i>Switch to User View
                </a>

                <!-- Logout -->
                <form action="<c:url value='/logout'/>" method="post" class="d-grid" style="margin:0;">
                    <c:if test="${not empty _csrf}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </c:if>
                    <button type="submit" class="btn btn-outline-danger w-100 btn-sm">
                        <i class="bi bi-box-arrow-right me-2"></i>Logout
                    </button>
                </form>
            </div>
        </div>
    </div>
</aside>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Admin Sidebar Navigation Script
    document.addEventListener('DOMContentLoaded', function () {
        // Lấy tất cả các nav-link trong admin sidebar
        const navLinks = document.querySelectorAll('aside nav .nav-link:not([data-bs-toggle="collapse"])');
        const submenuItems = document.querySelectorAll('aside nav .submenu-item');
        const allNavItems = [...navLinks, ...submenuItems];

        // Admin URL Mapping
        function getAdminUrlMapping() {
            return {
                // ===== DASHBOARD =====
                '/admin/dashboard': 'Dashboard',

                // ===== USER MANAGEMENT =====
                '/admin/users': 'All Users',
                '/admin/users/pending': 'Pending Approval',
                '/admin/users/suspended': 'Suspended Users',
                '/admin/users/roles': 'Role Management',

                // ===== PROJECT MANAGEMENT =====
                '/admin/projects': 'All Projects',
                '/admin/projects/active': 'Active Projects',
                '/admin/projects/completed': 'Completed Projects',
                '/admin/projects/categories': 'Categories',

                // ===== FINANCE & TRANSACTIONS =====
                '/admin/transactions': 'Transactions',
                '/admin/payments': 'Payments',
                '/admin/withdraws': 'Withdrawals',
                '/admin/commissions': 'Commission Settings',

                // ===== DISPUTES & REPORTS =====
                '/admin/disputes': 'Disputes',
                '/admin/reports/revenue': 'Revenue Report',
                '/admin/reports/users': 'User Analytics',
                '/admin/reports/projects': 'Project Statistics',
                '/admin/reports/export': 'Export Data',

                // ===== SETTINGS =====
                '/admin/settings/general': 'General Settings',
                '/admin/settings/email': 'Email Settings',
                '/admin/settings/security': 'Security Settings',
                '/admin/settings/backup': 'Backup & Restore',

                // ===== SYSTEM & COMMUNICATION =====
                '/admin/logs': 'System Logs',
                '/admin/notifications': 'Admin Alerts',
                '/admin/messages': 'Admin Messages'
            };
        }


        // Khôi phục trạng thái dropdown từ localStorage
        function restoreDropdownState() {
            const openDropdowns = JSON.parse(localStorage.getItem('admin_open_dropdowns') || '[]');

            openDropdowns.forEach(dropdownId => {
                const dropdown = document.getElementById(dropdownId);
                const toggle = document.querySelector(`[data-bs-target="#${dropdownId}"]`);

                if (dropdown && toggle) {
                    dropdown.classList.add('show');
                    const chevron = toggle.querySelector('.bi-chevron-down');
                    if (chevron) {
                        chevron.style.transform = 'rotate(180deg)';
                        chevron.style.transition = 'transform 0.3s ease';
                    }
                    toggle.setAttribute('aria-expanded', 'true');
                }
            });
        }

        // Lưu trạng thái dropdown vào localStorage
        function saveDropdownState() {
            const openDropdowns = [];
            document.querySelectorAll('.collapse.show').forEach(dropdown => {
                if (dropdown.id) {
                    openDropdowns.push(dropdown.id);
                }
            });
            localStorage.setItem('admin_open_dropdowns', JSON.stringify(openDropdowns));
        }

        // Khôi phục active menu từ localStorage hoặc current URL
        function restoreActiveState() {
            const currentPath = window.location.pathname;
            const urlMapping = getAdminUrlMapping();

            let foundActiveFromURL = false;
            const expectedMenuName = urlMapping[currentPath];

            if (expectedMenuName) {
                allNavItems.forEach(link => {
                    const linkText = link.querySelector('span')?.textContent;
                    if (linkText === expectedMenuName) {
                        setActiveMenu(link);
                        foundActiveFromURL = true;

                        // Nếu là submenu, tự động mở dropdown
                        if (link.classList.contains('submenu-item')) {
                            const submenuContainer = link.closest('.collapse');
                            if (submenuContainer) {
                                submenuContainer.classList.add('show');
                                const toggle = document.querySelector(`[data-bs-target="#${submenuContainer.id}"]`);
                                if (toggle) {
                                    const chevron = toggle.querySelector('.bi-chevron-down');
                                    if (chevron) {
                                        chevron.style.transform = 'rotate(180deg)';
                                        chevron.style.transition = 'transform 0.3s ease';
                                    }
                                    toggle.setAttribute('aria-expanded', 'true');
                                    saveDropdownState();
                                }
                            }
                        }
                        return;
                    }
                });
            }

            // Fallback: sử dụng saved state
            if (!foundActiveFromURL) {
                const savedActiveMenu = localStorage.getItem('admin_active_menu');
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

        // Set active menu với màu primary cho admin
        function setActiveMenu(activeLink) {
            // Xóa active state khỏi tất cả nav-link
            allNavItems.forEach(item => {
                item.classList.remove('position-relative', 'overflow-hidden');
                item.style.background = '';
                item.style.color = '';
                item.classList.add('text-dark');

                // Xóa overlay nếu có
                const overlay = item.querySelector('.position-absolute');
                if (overlay && overlay.style.background === 'rgba(255, 255, 255, 0.1)') {
                    overlay.remove();
                }
            });

            // Thêm active state cho item được chọn (màu primary cho admin)
            activeLink.classList.remove('text-dark');
            activeLink.classList.add('position-relative', 'overflow-hidden');
            activeLink.style.background = 'linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%)';
            activeLink.style.color = 'white';

            // Thêm overlay effect
            const overlay = document.createElement('div');
            overlay.className = 'position-absolute top-0 start-0 w-100 h-100';
            overlay.style.background = 'rgba(255,255,255,0.1)';
            activeLink.appendChild(overlay);

            // Lưu active menu
            const menuText = activeLink.querySelector('span')?.textContent;
            if (menuText) {
                localStorage.setItem('admin_active_menu', menuText);
            }
        }

        // Thêm event listener cho mỗi nav-link
        allNavItems.forEach(link => {
            link.addEventListener('click', function (e) {
                if (this.getAttribute('href') === '#') {
                    e.preventDefault();
                }

                setActiveMenu(this);

                // Dispatch custom event cho admin navigation
                const menuText = this.querySelector('span')?.textContent;
                const customEvent = new CustomEvent('adminSidebarNavigation', {
                    detail: {
                        menuItem: menuText,
                        element: this,
                        isSubmenu: this.classList.contains('submenu-item'),
                        href: this.getAttribute('href')
                    }
                });
                document.dispatchEvent(customEvent);
            });
        });

        // Hover effects với màu primary
        allNavItems.forEach(link => {
            link.addEventListener('mouseenter', function () {
                if (!this.style.background.includes('linear-gradient')) {
                    this.style.backgroundColor = 'rgba(13, 110, 253, 0.1)';
                    this.style.transition = 'background-color 0.2s ease';
                }
            });

            link.addEventListener('mouseleave', function () {
                if (!this.style.background.includes('linear-gradient')) {
                    this.style.backgroundColor = '';
                }
            });
        });

        // Dropdown toggle functionality
        const dropdownToggles = document.querySelectorAll('aside nav [data-bs-toggle="collapse"]');
        dropdownToggles.forEach(toggle => {
            toggle.addEventListener('click', function (e) {
                e.preventDefault();

                const target = document.querySelector(this.getAttribute('data-bs-target'));
                const chevron = this.querySelector('.bi-chevron-down');

                if (target.classList.contains('show')) {
                    target.classList.remove('show');
                    chevron.style.transform = 'rotate(0deg)';
                    this.setAttribute('aria-expanded', 'false');
                } else {
                    target.classList.add('show');
                    chevron.style.transform = 'rotate(180deg)';
                    this.setAttribute('aria-expanded', 'true');
                }

                chevron.style.transition = 'transform 0.3s ease';
                saveDropdownState();
            });
        });

        // Admin-specific functions
        window.setAdminSidebarActive = function (menuText) {
            allNavItems.forEach(link => {
                const linkText = link.querySelector('span')?.textContent;
                if (linkText === menuText) {
                    setActiveMenu(link);
                }
            });
        };

        window.getAdminSidebarActive = function () {
            const activeLink = document.querySelector('aside nav .nav-link[style*="linear-gradient"], aside nav .submenu-item[style*="linear-gradient"]');
            return activeLink ? activeLink.querySelector('span')?.textContent : null;
        };

        window.clearAdminSidebarState = function () {
            localStorage.removeItem('admin_open_dropdowns');
            localStorage.removeItem('admin_active_menu');
        };

        // Khôi phục trạng thái khi page load
        restoreDropdownState();
        restoreActiveState();

        // Lưu trạng thái trước khi rời trang
        window.addEventListener('beforeunload', function () {
            saveDropdownState();
        });
    });

    // Admin notification handlers
    function refreshAdminNotifications() {
        // Có thể implement AJAX call để refresh notification counts
        fetch('${pageContext.request.contextPath}/admin/api/notification-count')
            .then(response => response.json())
            .then(data => {
                // Update notification badges
                if (data.disputes > 0) {
                    // Update dispute badge
                }
                if (data.notifications > 0) {
                    // Update notification badge
                }
            })
            .catch(error => console.error('Error refreshing notifications:', error));
    }

    // Refresh notifications every 30 seconds
    setInterval(refreshAdminNotifications, 30000);
</script>