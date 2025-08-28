<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html lang="vi">
<%@include file="include/admin_head.jsp" %>
<body style="background: linear-gradient(135deg, #f0f8ff 0%, #ffffff 100%);">
<div class="container-fluid">
    <div class="row g-0">
        <!-- Admin Sidebar -->
        <%@include file="include/admin_sidebar.jsp" %>

        <!-- Main Content -->
        <main class="col-12 col-lg-9 col-xl-10 p-4">
            <!-- Header -->
            <div class="row align-items-center mb-4">
                <div class="col">
                    <h2 class="h3 mb-1 text-dark">Admin Dashboard</h2>
                    <p class="text-muted mb-0">System overview and management controls</p>
                </div>
                <div class="col-auto">
                    <div class="d-flex gap-2">
                        <button class="btn btn-outline-primary"
                                onclick="window.location.href='${pageContext.request.contextPath}/admin/reports/export'">
                            <i class="bi bi-download me-2"></i>Export Data
                        </button>
                        <button class="btn btn-primary text-white"
                                onclick="window.location.href='${pageContext.request.contextPath}/admin/quick-actions'">
                            <i class="bi bi-lightning me-2"></i>Quick Actions
                        </button>
                    </div>
                </div>
            </div>

            <!-- System Stats Cards -->
            <div class="row g-4 mb-4">
                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="card border-0 shadow-sm h-100"
                         style="background: linear-gradient(135deg, #ffffff 0%, #f0f8ff 100%);">
                        <div class="card-body p-4">
                            <div class="d-flex align-items-start justify-content-between mb-3">
                                <div class="p-3 rounded-3"
                                     style="background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);">
                                    <i class="bi bi-people text-white fs-4"></i>
                                </div>
                            </div>
                            <h3 class="h4 mb-1 text-primary fw-bold">${totalUsers}</h3>
                            <p class="text-muted mb-3 small">Total Users</p>
                            <button class="btn btn-outline-primary btn-sm"
                                    onclick="window.location.href='${pageContext.request.contextPath}/admin/users'">
                                <i class="bi bi-arrow-right me-1"></i>Manage
                            </button>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-body p-4">
                            <div class="d-flex align-items-start justify-content-between mb-3">
                                <div class="p-3 bg-warning bg-opacity-25 rounded-3">
                                    <i class="bi bi-kanban text-warning fs-4"></i>
                                </div>
                            </div>
                            <h3 class="h4 mb-1 fw-bold">${totalProjects != null ? totalProjects : '1,234'}</h3>
                            <p class="text-muted mb-3 small">Active Projects</p>
                            <button class="btn btn-outline-secondary btn-sm"
                                    onclick="window.location.href='${pageContext.request.contextPath}/admin/projects'">
                                <i class="bi bi-list-ul me-1"></i>View All
                            </button>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="card border-0 shadow-sm h-100"
                         style="background: linear-gradient(135deg, #ffffff 0%, #f0fff0 100%);">
                        <div class="card-body p-4">
                            <div class="d-flex align-items-start justify-content-between mb-3">
                                <div class="p-3 rounded-3"
                                     style="background: linear-gradient(135deg, #198754 0%, #146c43 100%);">
                                    <i class="bi bi-currency-dollar text-white fs-4"></i>
                                </div>
                            </div>
                            <h3 class="h4 mb-1 text-success fw-bold">
                                $${totalRevenue != null ? totalRevenue : '89,432'}</h3>
                            <p class="text-muted mb-3 small">Platform Revenue</p>
                            <button class="btn btn-outline-success btn-sm"
                                    onclick="window.location.href='${pageContext.request.contextPath}/admin/reports/revenue'">
                                <i class="bi bi-graph-up me-1"></i>View Report
                            </button>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-body p-4">
                            <div class="d-flex align-items-start justify-content-between mb-3">
                                <div class="p-3 bg-danger bg-opacity-25 rounded-3">
                                    <i class="bi bi-shield-exclamation text-danger fs-4"></i>
                                </div>
                                <c:choose>
                                    <c:when test="${pendingDisputes > 0}">
                                        <span class="badge bg-danger bg-opacity-25 text-danger">Action Required</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-success bg-opacity-25 text-success">All Clear</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <h3 class="h4 mb-1 fw-bold">${pendingDisputes != null ? pendingDisputes : '3'}</h3>
                            <p class="text-muted mb-3 small">Pending Disputes</p>
                            <button class="btn btn-outline-danger btn-sm"
                                    onclick="window.location.href='${pageContext.request.contextPath}/admin/disputes'">
                                <i class="bi bi-arrow-right me-1"></i>Resolve
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- System Overview & Recent Activity -->
            <div class="row g-4 mb-4">
                <!-- System Status -->
                <div class="col-12 col-xl-8">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-header bg-transparent border-0 p-4">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-1">System Overview</h5>
                                    <p class="text-muted mb-0 small">Monitor key system metrics and performance</p>
                                </div>
                                <button class="btn btn-outline-primary btn-sm"
                                        onclick="window.location.href='${pageContext.request.contextPath}/admin/logs'">
                                    View Logs
                                </button>
                            </div>
                        </div>
                        <div class="card-body p-4 pt-0">
                            <div class="row g-3">
                                <div class="col-6 col-lg-4">
                                    <div class="text-center p-3 rounded-3 border border-success border-opacity-25 bg-success bg-opacity-10">
                                        <div class="h2 mb-1 text-success fw-bold">156</div>
                                        <small class="text-success fw-medium">New Users (30d)</small>
                                    </div>
                                </div>
                                <div class="col-6 col-lg-4">
                                    <div class="text-center p-3 rounded-3 border border-primary border-opacity-25 bg-primary bg-opacity-10">
                                        <div class="h2 mb-1 text-primary fw-bold">89</div>
                                        <small class="text-primary fw-medium">Active Projects</small>
                                    </div>
                                </div>
                                <div class="col-6 col-lg-4">
                                    <div class="text-center p-3 rounded-3 border border-warning border-opacity-25 bg-warning bg-opacity-10">
                                        <div class="h2 mb-1 text-warning fw-bold">12</div>
                                        <small class="text-warning fw-medium">Pending Approvals</small>
                                    </div>
                                </div>
                                <div class="col-6 col-lg-4">
                                    <div class="text-center p-3 rounded-3 border border-info border-opacity-25 bg-info bg-opacity-10">
                                        <div class="h2 mb-1 text-info fw-bold">$15.2K</div>
                                        <small class="text-info fw-medium">Daily Revenue</small>
                                    </div>
                                </div>
                                <div class="col-6 col-lg-4">
                                    <div class="text-center p-3 rounded-3 border border-success border-opacity-25 bg-success bg-opacity-10">
                                        <div class="h2 mb-1 text-success fw-bold">98.5%</div>
                                        <small class="text-success fw-medium">System Uptime</small>
                                    </div>
                                </div>
                                <div class="col-6 col-lg-4">
                                    <div class="text-center p-3 rounded-3 border border-secondary border-opacity-25 bg-secondary bg-opacity-10">
                                        <div class="h2 mb-1 text-secondary fw-bold">347</div>
                                        <small class="text-secondary fw-medium">Transactions</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions & Alerts -->
                <div class="col-12 col-xl-4">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-header bg-transparent border-0 p-4">
                            <h5 class="mb-1">
                                <i class="bi bi-lightning text-primary me-2"></i>Quick Actions
                            </h5>
                            <p class="text-muted mb-0 small">Frequently used admin functions</p>
                        </div>
                        <div class="card-body p-4 pt-0">
                            <div class="d-flex flex-column gap-3">
                                <button class="btn btn-outline-primary w-100 text-start"
                                        onclick="window.location.href='${pageContext.request.contextPath}/admin/users/pending'">
                                    <i class="bi bi-person-check me-2"></i>
                                    <span>Approve Users</span>
                                    <span class="badge bg-primary rounded-pill ms-auto">12</span>
                                </button>

                                <button class="btn btn-outline-warning w-100 text-start"
                                        onclick="window.location.href='${pageContext.request.contextPath}/admin/disputes'">
                                    <i class="bi bi-shield-exclamation me-2"></i>
                                    <span>Resolve Disputes</span>
                                    <span class="badge bg-warning rounded-pill ms-auto">3</span>
                                </button>

                                <button class="btn btn-outline-success w-100 text-start"
                                        onclick="window.location.href='${pageContext.request.contextPath}/admin/withdrawals'">
                                    <i class="bi bi-arrow-up-circle me-2"></i>
                                    <span>Process Withdrawals</span>
                                    <span class="badge bg-success rounded-pill ms-auto">7</span>
                                </button>

                                <button class="btn btn-outline-info w-100 text-start"
                                        onclick="window.location.href='${pageContext.request.contextPath}/admin/projects/categories'">
                                    <i class="bi bi-tags me-2"></i>
                                    <span>Manage Categories</span>
                                </button>

                                <button class="btn btn-outline-secondary w-100 text-start"
                                        onclick="window.location.href='${pageContext.request.contextPath}/admin/settings/general'">
                                    <i class="bi bi-gear me-2"></i>
                                    <span>System Settings</span>
                                </button>
                            </div>

                            <div class="alert alert-info bg-info bg-opacity-25 border-info border-opacity-25 mt-3"
                                 role="alert">
                                <div class="d-flex">
                                    <i class="bi bi-info-circle me-2 mt-1"></i>
                                    <small>
                                        System running smoothly. Last backup: 2 hours ago.
                                        <a href="${pageContext.request.contextPath}/admin/settings/backup"
                                           class="alert-link fw-medium">View details</a>
                                    </small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Activity & User Management -->
            <div class="row g-4 mb-4">
                <!-- Recent Users -->
                <div class="col-12 col-xl-6">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-header bg-transparent border-0 p-4">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-1">
                                        <i class="bi bi-person-plus text-primary me-2"></i>Recent Users
                                    </h5>
                                    <p class="text-muted mb-0 small">Latest user registrations</p>
                                </div>
                                <button class="btn btn-outline-primary btn-sm"
                                        onclick="window.location.href='${pageContext.request.contextPath}/admin/users'">
                                    View All
                                </button>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <div class="list-group list-group-flush">
                                <div class="list-group-item border-0 p-4">
                                    <div class="d-flex align-items-center gap-3">
                                        <img src="https://i.pravatar.cc/40?img=10" alt="user" class="rounded-circle"
                                             width="40" height="40">
                                        <div class="flex-grow-1">
                                            <div class="fw-medium">John Smith</div>
                                            <small class="text-muted">john.smith@email.com</small>
                                        </div>
                                        <div class="text-end">
                                            <small class="text-muted d-block">2 hours ago</small>
                                            <span class="badge bg-warning bg-opacity-25 text-warning">Pending</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="list-group-item border-0 p-4">
                                    <div class="d-flex align-items-center gap-3">
                                        <img src="https://i.pravatar.cc/40?img=20" alt="user" class="rounded-circle"
                                             width="40" height="40">
                                        <div class="flex-grow-1">
                                            <div class="fw-medium">Sarah Johnson</div>
                                            <small class="text-muted">sarah.j@email.com</small>
                                        </div>
                                        <div class="text-end">
                                            <small class="text-muted d-block">5 hours ago</small>
                                            <span class="badge bg-success bg-opacity-25 text-success">Active</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="list-group-item border-0 p-4">
                                    <div class="d-flex align-items-center gap-3">
                                        <img src="https://i.pravatar.cc/40?img=30" alt="user" class="rounded-circle"
                                             width="40" height="40">
                                        <div class="flex-grow-1">
                                            <div class="fw-medium">Mike Wilson</div>
                                            <small class="text-muted">mike.w@email.com</small>
                                        </div>
                                        <div class="text-end">
                                            <small class="text-muted d-block">1 day ago</small>
                                            <span class="badge bg-success bg-opacity-25 text-success">Active</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Projects -->
                <div class="col-12 col-xl-6">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-header bg-transparent border-0 p-4">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-1">
                                        <i class="bi bi-folder-plus text-warning me-2"></i>Recent Projects
                                    </h5>
                                    <p class="text-muted mb-0 small">Latest project submissions</p>
                                </div>
                                <button class="btn btn-outline-primary btn-sm"
                                        onclick="window.location.href='${pageContext.request.contextPath}/admin/projects'">
                                    View All
                                </button>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <div class="list-group list-group-flush">
                                <div class="list-group-item border-0 p-4">
                                    <div class="d-flex align-items-start gap-3">
                                        <div class="p-2 bg-primary bg-opacity-25 rounded">
                                            <i class="bi bi-code-slash text-primary"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="fw-medium">E-commerce Website</div>
                                            <small class="text-muted">Web Development • $2,500</small>
                                        </div>
                                        <div class="text-end">
                                            <small class="text-muted d-block">1 hour ago</small>
                                            <span class="badge bg-info bg-opacity-25 text-info">In Progress</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="list-group-item border-0 p-4">
                                    <div class="d-flex align-items-start gap-3">
                                        <div class="p-2 bg-success bg-opacity-25 rounded">
                                            <i class="bi bi-palette text-success"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="fw-medium">Brand Identity Design</div>
                                            <small class="text-muted">Graphic Design • $800</small>
                                        </div>
                                        <div class="text-end">
                                            <small class="text-muted d-block">3 hours ago</small>
                                            <span class="badge bg-success bg-opacity-25 text-success">Completed</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="list-group-item border-0 p-4">
                                    <div class="d-flex align-items-start gap-3">
                                        <div class="p-2 bg-warning bg-opacity-25 rounded">
                                            <i class="bi bi-megaphone text-warning"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="fw-medium">Social Media Campaign</div>
                                            <small class="text-muted">Digital Marketing • $1,200</small>
                                        </div>
                                        <div class="text-end">
                                            <small class="text-muted d-block">1 day ago</small>
                                            <span class="badge bg-warning bg-opacity-25 text-warning">Review</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- System Logs & Transactions -->
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-transparent border-0 p-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="mb-1">
                                <i class="bi bi-activity text-primary me-2"></i>Recent System Activity
                            </h5>
                            <p class="text-muted mb-0 small">Monitor system events and user activities</p>
                        </div>
                        <div class="d-flex gap-2">
                            <button class="btn btn-outline-secondary btn-sm" onclick="refreshSystemActivity()">
                                <i class="bi bi-arrow-clockwise me-1"></i>Refresh
                            </button>
                            <button class="btn btn-outline-primary btn-sm"
                                    onclick="window.location.href='${pageContext.request.contextPath}/admin/logs'">
                                <i class="bi bi-file-text me-1"></i>Full Logs
                            </button>
                        </div>
                    </div>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                            <tr>
                                <th scope="col" class="ps-4 py-3 border-0">Time</th>
                                <th scope="col" class="py-3 border-0">User</th>
                                <th scope="col" class="py-3 border-0">Action</th>
                                <th scope="col" class="py-3 border-0">Details</th>
                                <th scope="col" class="py-3 border-0">Status</th>
                                <th scope="col" class="pe-4 py-3 border-0 text-end">Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr class="border-bottom border-opacity-25">
                                <td class="ps-4 py-4">
                                    <div class="fw-medium">14:32</div>
                                    <small class="text-muted">2 min ago</small>
                                </td>
                                <td class="py-4">
                                    <div class="d-flex align-items-center gap-2">
                                        <img src="https://i.pravatar.cc/24?img=15" alt="user" class="rounded-circle"
                                             width="24" height="24">
                                        <span class="fw-medium">Alex Parker</span>
                                    </div>
                                </td>
                                <td class="py-4">
                                    <div class="fw-medium">Project Submission</div>
                                    <small class="text-muted">New project posted</small>
                                </td>
                                <td class="py-4">
                                    <span class="text-primary">Mobile App Development</span>
                                </td>
                                <td class="py-4">
                                    <span class="badge bg-success bg-opacity-25 text-success px-3 py-2">Success</span>
                                </td>
                                <td class="pe-4 py-4 text-end">
                                    <button class="btn btn-outline-primary btn-sm">
                                        <i class="bi bi-eye me-1"></i>View
                                    </button>
                                </td>
                            </tr>
                            <tr class="border-bottom border-opacity-25">
                                <td class="ps-4 py-4">
                                    <div class="fw-medium">14:15</div>
                                    <small class="text-muted">19 min ago</small>
                                </td>
                                <td class="py-4">
                                    <div class="d-flex align-items-center gap-2">
                                        <img src="https://i.pravatar.cc/24?img=25" alt="user" class="rounded-circle"
                                             width="24" height="24">
                                        <span class="fw-medium">Emma Davis</span>
                                    </div>
                                </td>
                                <td class="py-4">
                                    <div class="fw-medium">Payment Request</div>
                                    <small class="text-muted">Withdrawal requested</small>
                                </td>
                                <td class="py-4">
                                    <span class="text-warning">$850.00</span>
                                </td>
                                <td class="py-4">
                                    <span class="badge bg-warning bg-opacity-25 text-warning px-3 py-2">Pending</span>
                                </td>
                                <td class="pe-4 py-4 text-end">
                                    <button class="btn btn-outline-warning btn-sm">
                                        <i class="bi bi-check-circle me-1"></i>Approve
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td class="ps-4 py-4">
                                    <div class="fw-medium">13:45</div>
                                    <small class="text-muted">49 min ago</small>
                                </td>
                                <td class="py-4">
                                    <div class="d-flex align-items-center gap-2">
                                        <i class="bi bi-robot text-muted"></i>
                                        <span class="fw-medium text-muted">System</span>
                                    </div>
                                </td>
                                <td class="py-4">
                                    <div class="fw-medium">Auto Backup</div>
                                    <small class="text-muted">Database backup completed</small>
                                </td>
                                <td class="py-4">
                                    <span class="text-info">backup_20250822.sql</span>
                                </td>
                                <td class="py-4">
                                    <span class="badge bg-success bg-opacity-25 text-success px-3 py-2">Success</span>
                                </td>
                                <td class="pe-4 py-4 text-end">
                                    <button class="btn btn-outline-info btn-sm">
                                        <i class="bi bi-download me-1"></i>Download
                                    </button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Auto-refresh system stats every 30 seconds
    function refreshSystemStats() {
        fetch('${pageContext.request.contextPath}/admin/api/dashboard-stats')
            .then(response => response.json())
            .then(data => {
                // Update stats cards
                if (data.success) {
                    // Update DOM elements with new data
                    console.log('Stats refreshed:', data);
                }
            })
            .catch(error => console.error('Error refreshing stats:', error));
    }

    // Refresh recent activity
    function refreshSystemActivity() {
        fetch('${pageContext.request.contextPath}/admin/api/recent-activity')
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Update activity table
                    console.log('Activity refreshed:', data);
                }
            })
            .catch(error => console.error('Error refreshing activity:', error));
    }

    // Auto-refresh every 30 seconds
    setInterval(refreshSystemStats, 30000);

    // Initialize dashboard
    document.addEventListener('DOMContentLoaded', function () {
        console.log('Admin Dashboard loaded');

        // Set active sidebar menu
        if (typeof setAdminSidebarActive === 'function') {
            setAdminSidebarActive('Dashboard');
        }
    });
</script>
</body>
</html>