<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html lang="vi">
<%@include file="include/admin_head.jsp" %>
<body style="background: linear-gradient(135deg, #f0f8ff 0%, #ffffff 100%);">
<div class="container-fluid">
    <div class="row g-0">
        <!-- Sidebar admin -->
        <%@include file="include/admin_sidebar.jsp" %>

        <!-- Main -->
        <main class="col-12 col-lg-9 col-xl-10 p-4">
            <!-- Header Section -->
            <div class="row align-items-center mb-4">
                <div class="col">
                    <h2 class="h3 mb-1 text-dark">
                        <i class="bi bi-bell text-primary me-2"></i>Quản lý thông báo
                    </h2>
                    <p class="text-muted mb-0">Gửi và quản lý thông báo tới người dùng hệ thống</p>
                </div>
                <div class="col-auto">
                    <div class="d-flex gap-2">
                        <select class="form-select form-select-sm" style="width: auto;"
                                onchange="filterNotifications(this.value)">
                            <option value="">Tất cả loại</option>
                            <option value="JOB">Công việc</option>
                            <option value="PROPOSAL">Đề xuất</option>
                            <option value="CONTRACT">Hợp đồng</option>
                            <option value="CHAT">Tin nhắn</option>
                            <option value="WALLET">Ví tiền</option>
                            <option value="SYSTEM">Hệ thống</option>
                        </select>
                        <button class="btn btn-primary btn-sm" data-bs-toggle="modal"
                                data-bs-target="#createNotificationModal">
                            <i class="bi bi-plus-lg me-1"></i>Tạo thông báo
                        </button>
                    </div>
                </div>
            </div>

            <!-- Statistics Cards -->
            <div class="row g-3 mb-4">
                <div class="col-12 col-md-3">
                    <div class="card border-0 shadow-sm bg-primary bg-opacity-10 border-primary border-opacity-25">
                        <div class="card-body text-center p-3">
                            <i class="bi bi-bell text-primary fs-3 mb-2"></i>
                            <div class="h4 mb-1 text-primary fw-bold">
                                <c:set var="totalCount" value="0"/>
                                <c:forEach var="notification" items="${notifications}">
                                    <c:set var="totalCount" value="${totalCount + 1}"/>
                                </c:forEach>
                                ${totalCount > 0 ? totalCount : '0'}
                            </div>
                            <small class="text-primary fw-medium">Tổng thông báo</small>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-3">
                    <div class="card border-0 shadow-sm bg-success bg-opacity-10 border-success border-opacity-25">
                        <div class="card-body text-center p-3">
                            <i class="bi bi-check-circle text-success fs-3 mb-2"></i>
                            <div class="h4 mb-1 text-success fw-bold">
                                <c:set var="readCount" value="0"/>
                                <c:forEach var="notification" items="${notifications}">
                                    <c:if test="${notification.isRead}">
                                        <c:set var="readCount" value="${readCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${readCount > 0 ? readCount : '0'}
                            </div>
                            <small class="text-success fw-medium">Đã đọc</small>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-3">
                    <div class="card border-0 shadow-sm bg-warning bg-opacity-10 border-warning border-opacity-25">
                        <div class="card-body text-center p-3">
                            <i class="bi bi-envelope text-warning fs-3 mb-2"></i>
                            <div class="h4 mb-1 text-warning fw-bold">
                                <c:set var="unreadCount" value="0"/>
                                <c:forEach var="notification" items="${notifications}">
                                    <c:if test="${!notification.isRead}">
                                        <c:set var="unreadCount" value="${unreadCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${unreadCount > 0 ? unreadCount : '0'}
                            </div>
                            <small class="text-warning fw-medium">Chưa đọc</small>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-3">
                    <div class="card border-0 shadow-sm bg-danger bg-opacity-10 border-danger border-opacity-25">
                        <div class="card-body text-center p-3">
                            <i class="bi bi-exclamation-triangle text-danger fs-3 mb-2"></i>
                            <div class="h4 mb-1 text-danger fw-bold">
                                <c:set var="urgentCount" value="0"/>
                                <c:forEach var="notification" items="${notifications}">
                                    <c:if test="${notification.priority eq 'URGENT' or notification.priority eq 'HIGH'}">
                                        <c:set var="urgentCount" value="${urgentCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${urgentCount > 0 ? urgentCount : '0'}
                            </div>
                            <small class="text-danger fw-medium">Ưu tiên cao</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Table Card -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-transparent border-0 p-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="mb-1">
                                <i class="bi bi-list-ul text-primary me-2"></i>Danh sách thông báo
                            </h5>
                            <p class="text-muted small mb-0">Quản lý tất cả thông báo trong hệ thống</p>
                        </div>
                        <div class="d-flex gap-2">
                            <button class="btn btn-outline-success btn-sm" onclick="markAllAsRead()"
                                    title="Đánh dấu tất cả đã đọc">
                                <i class="bi bi-check-all me-1"></i>Đánh dấu đã đọc
                            </button>
                            <button class="btn btn-outline-danger btn-sm" onclick="deleteExpired()"
                                    title="Xóa thông báo hết hạn">
                                <i class="bi bi-trash me-1"></i>Xóa hết hạn
                            </button>
                        </div>
                    </div>
                </div>

                <div class="card-body p-0">
                    <!-- Quick Filter Tabs -->
                    <c:if test="${not empty notifications}">
                        <div class="px-4 pt-3">
                            <ul class="nav nav-pills nav-fill"
                                style="background: #f8f9fa; border-radius: 8px; padding: 4px;">
                                <li class="nav-item">
                                    <a class="nav-link active small py-2" href="#"
                                       onclick="filterByReadStatus('', this)">
                                        <i class="bi bi-list-ul me-1"></i>Tất cả
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link small py-2" href="#"
                                       onclick="filterByReadStatus('unread', this)">
                                        <i class="bi bi-envelope me-1"></i>Chưa đọc
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link small py-2" href="#" onclick="filterByReadStatus('read', this)">
                                        <i class="bi bi-check-circle me-1"></i>Đã đọc
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link small py-2" href="#"
                                       onclick="filterByReadStatus('urgent', this)">
                                        <i class="bi bi-exclamation-triangle me-1"></i>Ưu tiên cao
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </c:if>

                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                            <tr>
                                <th class="ps-4 py-3 border-0">
                                    <input type="checkbox" class="form-check-input" id="selectAll">
                                </th>
                                <th class="py-3 border-0">ID</th>
                                <th class="py-3 border-0">Người nhận</th>
                                <th class="py-3 border-0">Tiêu đề</th>
                                <th class="py-3 border-0">Loại</th>
                                <th class="py-3 border-0">Ưu tiên</th>
                                <th class="py-3 border-0">Trạng thái</th>
                                <th class="py-3 border-0">Ngày tạo</th>
                                <th class="pe-4 py-3 border-0 text-end">Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="notification" items="${notifications}">
                                <tr class="notification-row"
                                    data-type="${notification.type}"
                                    data-read="${notification.isRead}"
                                    data-priority="${notification.priority}">
                                    <!-- Checkbox -->
                                    <td class="ps-4 py-3">
                                        <input type="checkbox" class="form-check-input notification-checkbox"
                                               value="${notification.id}">
                                    </td>

                                    <!-- ID -->
                                    <td class="py-3">
                                        <span class="badge bg-primary bg-opacity-15  fw-medium">#${notification.id}</span>
                                    </td>

                                    <!-- User -->
                                    <td class="py-3">
                                        <div class="d-flex align-items-center">
                                            <div class="bg-secondary bg-opacity-15 rounded-circle p-2 me-2">
                                                <i class="bi bi-person text-secondary"></i>
                                            </div>
                                            <div>
                                                <div class="fw-semibold text-dark">${notification.user.fullName}</div>
                                                <small class="text-muted">@${notification.user.username}</small>
                                            </div>
                                        </div>
                                    </td>

                                    <!-- Title -->
                                    <td class="py-3">
                                        <div class="fw-semibold text-dark mb-1">
                                            <c:choose>
                                                <c:when test="${!notification.isRead}">
                                                    <i class="bi bi-circle-fill text-primary me-1"
                                                       style="font-size: 0.5rem;"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-check-circle text-success me-1"></i>
                                                </c:otherwise>
                                            </c:choose>
                                                ${fn:substring(notification.title, 0, 50)}
                                            <c:if test="${fn:length(notification.title) > 50}">...</c:if>
                                        </div>
                                        <small class="text-muted">
                                                ${fn:substring(notification.content, 0, 80)}
                                            <c:if test="${fn:length(notification.content) > 80}">...</c:if>
                                        </small>
                                    </td>

                                    <!-- Type -->
                                    <td class="py-3">
                                        <c:choose>
                                            <c:when test="${notification.type eq 'JOB'}">
                                    <span class="badge bg-info bg-opacity-15">
                                        <i class="bi bi-briefcase me-1"></i>Công việc
                                    </span>
                                            </c:when>
                                            <c:when test="${notification.type eq 'PROPOSAL'}">
                                    <span class="badge bg-warning bg-opacity-15 text-warning">
                                        <i class="bi bi-file-text me-1"></i>Đề xuất
                                    </span>
                                            </c:when>
                                            <c:when test="${notification.type eq 'CONTRACT'}">
                                    <span class="badge bg-success bg-opacity-15 ">
                                        <i class="bi bi-file-earmark-text me-1"></i>Hợp đồng
                                    </span>
                                            </c:when>
                                            <c:when test="${notification.type eq 'CHAT'}">
                                    <span class="badge bg-primary bg-opacity-15 ">
                                        <i class="bi bi-chat me-1"></i>Tin nhắn
                                    </span>
                                            </c:when>
                                            <c:when test="${notification.type eq 'WALLET'}">
                                    <span class="badge bg-success bg-opacity-15 ">
                                        <i class="bi bi-wallet2 me-1"></i>Ví tiền
                                    </span>
                                            </c:when>
                                            <c:when test="${notification.type eq 'SYSTEM'}">
                                    <span class="badge bg-secondary bg-opacity-15 ">
                                        <i class="bi bi-gear me-1"></i>Hệ thống
                                    </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">${notification.type}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- Priority -->
                                    <td class="py-3">
                                        <c:choose>
                                            <c:when test="${notification.priority eq 'URGENT'}">
                                    <span class="badge bg-danger">
                                        <i class="bi bi-exclamation-triangle me-1"></i>Khẩn cấp
                                    </span>
                                            </c:when>
                                            <c:when test="${notification.priority eq 'HIGH'}">
                                    <span class="badge bg-warning">
                                        <i class="bi bi-arrow-up me-1"></i>Cao
                                    </span>
                                            </c:when>
                                            <c:when test="${notification.priority eq 'LOW'}">
                                    <span class="badge bg-secondary">
                                        <i class="bi bi-arrow-down me-1"></i>Thấp
                                    </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-light text-dark">Bình thường</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- Status -->
                                    <td class="py-3">
                                        <c:choose>
                                            <c:when test="${notification.isRead}">
                                    <span class="badge bg-success">
                                        <i class="bi bi-check-circle me-1"></i>Đã đọc
                                    </span>
                                            </c:when>
                                            <c:otherwise>
                                    <span class="badge bg-warning text-dark">
                                        <i class="bi bi-envelope me-1"></i>Chưa đọc
                                    </span>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:if test="${notification.isExpired()}">
                                            <br><small class="badge bg-danger">Hết hạn</small>
                                        </c:if>
                                    </td>

                                    <!-- Created Date -->
                                    <td class="py-3">
                                        <div class="fw-semibold text-dark">
                                            <fmt:formatDate value="${notification.createdAtDate}" pattern="dd/MM/yyyy"/>
                                        </div>
                                        <small class="text-muted">
                                            <fmt:formatDate value="${notification.createdAtDate}" pattern="HH:mm"/>
                                        </small>
                                        <c:if test="${notification.readAt != null}">
                                            <br><small class="text-success">
                                            Đọc: <fmt:formatDate value="${notification.readAtDate}"
                                                                 pattern="dd/MM HH:mm"/>
                                        </small>
                                        </c:if>
                                    </td>

                                    <!-- Actions -->
                                    <td class="pe-4 py-3 text-end">
                                        <div class="btn-group" role="group">
                                            <button class="btn btn-outline-primary btn-sm"
                                                    onclick="viewNotificationDetail(${notification.id})"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#notificationDetailModal"
                                                    title="Xem chi tiết">
                                                <i class="bi bi-eye"></i>
                                            </button>

                                            <c:if test="${!notification.isRead}">
                                                <button class="btn btn-outline-success btn-sm"
                                                        onclick="markAsRead(${notification.id})"
                                                        title="Đánh dấu đã đọc">
                                                    <i class="bi bi-check"></i>
                                                </button>
                                            </c:if>

                                            <button class="btn btn-outline-warning btn-sm"
                                                    onclick="editNotification(${notification.id})"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#editNotificationModal"
                                                    title="Chỉnh sửa">
                                                <i class="bi bi-pencil"></i>
                                            </button>

                                            <button class="btn btn-outline-danger btn-sm"
                                                    onclick="deleteNotification(${notification.id})"
                                                    title="Xóa">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Empty state -->
                    <c:if test="${empty notifications}">
                        <div class="text-center py-5">
                            <i class="bi bi-bell text-muted display-4"></i>
                            <h5 class="text-muted mt-3">Chưa có thông báo nào</h5>
                            <p class="text-muted">Tạo thông báo đầu tiên để gửi tới người dùng.</p>
                            <button class="btn btn-primary" data-bs-toggle="modal"
                                    data-bs-target="#createNotificationModal">
                                <i class="bi bi-plus-lg me-2"></i>Tạo thông báo
                            </button>
                        </div>
                    </c:if>

                    <!-- Pagination -->
                    <c:if test="${not empty notifications}">
                        <div class="px-4 py-3 border-top bg-light">
                            <div class="d-flex justify-content-between align-items-center">
                                <small class="text-muted">
                                    Trang ${currentPage} / ${totalPages} — ${totalElements} thông báo
                                </small>
                                <nav>
                                    <ul class="pagination pagination-sm mb-0">
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="?page=${currentPage - 1}&size=15">
                                                <i class="bi bi-chevron-left"></i>
                                            </a>
                                        </li>
                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="?page=${i}&size=15">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="?page=${currentPage + 1}&size=15">
                                                <i class="bi bi-chevron-right"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </main>
    </div>
</div>

<%@include file="modal/createNotificationModal.jsp" %>
<%@include file="modal/notificationDetailModal.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // ===== GLOBAL VARIABLES =====
    const contextPath = '<c:out value="${pageContext.request.contextPath}"/>';

    // ===== FILTERS =====
    function filterNotifications(type) {
        const rows = document.querySelectorAll('.notification-row');
        rows.forEach(row => {
            if (type === '' || row.dataset.type === type) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }

    function filterByReadStatus(status, element) {
        const rows = document.querySelectorAll('.notification-row');
        const navLinks = document.querySelectorAll('.nav-pills .nav-link');

        // Update active nav
        navLinks.forEach(link => link.classList.remove('active'));
        element.classList.add('active');

        // Filter rows
        rows.forEach(row => {
            let show = false;
            if (status === '') {
                show = true;
            } else if (status === 'unread') {
                show = row.dataset.read === 'false';
            } else if (status === 'read') {
                show = row.dataset.read === 'true';
            } else if (status === 'urgent') {
                show = row.dataset.priority === 'URGENT' || row.dataset.priority === 'HIGH';
            }

            row.style.display = show ? '' : 'none';
        });
    }

    // ===== SELECT ALL CHECKBOX =====
    document.getElementById('selectAll')?.addEventListener('change', function () {
        const checkboxes = document.querySelectorAll('.notification-checkbox');
        checkboxes.forEach(cb => cb.checked = this.checked);
    });

    // ===== NOTIFICATION ACTIONS =====
    async function markAsRead(id) {
        if (!confirm('Đánh dấu thông báo này là đã đọc?')) return;

        try {
            const response = await fetch(contextPath + '/admin/notifications/' + id + '/read', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
            });

            if (response.ok) {
                showToast('Đã đánh dấu thông báo là đã đọc', 'success');
                setTimeout(() => location.reload(), 1000);
            } else {
                const error = await response.text();
                showToast('Có lỗi xảy ra: ' + error, 'error');
            }
        } catch (error) {
            showToast('Có lỗi xảy ra: ' + error.message, 'error');
        }
    }

    async function deleteNotification(id) {
        if (!confirm('Bạn có chắc muốn xóa thông báo này?')) return;

        try {
            const response = await fetch(contextPath + '/admin/notifications/' + id, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                },
            });

            if (response.ok) {
                showToast('Đã xóa thông báo thành công', 'success');
                setTimeout(() => location.reload(), 1000);
            } else {
                const error = await response.text();
                showToast('Có lỗi xảy ra: ' + error, 'error');
            }
        } catch (error) {
            showToast('Có lỗi xảy ra: ' + error.message, 'error');
        }
    }

    async function markAllAsRead() {
        if (!confirm('Đánh dấu tất cả thông báo là đã đọc?')) return;

        try {
            const response = await fetch(contextPath + '/admin/notifications/mark-all-read', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
            });

            if (response.ok) {
                showToast('Đã đánh dấu tất cả thông báo là đã đọc', 'success');
                setTimeout(() => location.reload(), 1000);
            } else {
                showToast('Có lỗi xảy ra', 'error');
            }
        } catch (error) {
            showToast('Có lỗi xảy ra: ' + error.message, 'error');
        }
    }

    async function deleteExpired() {
        if (!confirm('Xóa tất cả thông báo hết hạn?')) return;

        try {
            const response = await fetch(contextPath + '/admin/notifications/delete-expired', {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                },
            });

            if (response.ok) {
                const result = await response.json();
                showToast('Đã xóa ' + result.deletedCount + ' thông báo hết hạn', 'success');
                setTimeout(() => location.reload(), 1000);
            } else {
                showToast('Có lỗi xảy ra khi xóa thông báo hết hạn', 'error');
            }
        } catch (error) {
            showToast('Có lỗi xảy ra: ' + error.message, 'error');
        }
    }

    function viewNotificationDetail(id) {
        const modal = document.getElementById('notificationDetailModal');
        const content = document.getElementById('notificationDetailContent');

        // Show loading
        content.innerHTML = '<div class="text-center py-4">' +
            '<div class="spinner-border text-primary" role="status">' +
            '<span class="visually-hidden">Đang tải...</span>' +
            '</div>' +
            '</div>';
        const url = contextPath + '/admin/notifications/' + id + '/detail';
        console.log("Fetching notification detail:", url);
        fetch(url)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Không thể tải thông tin');
                }
                return response.json();
            })
            .then(data => {
                console.log("Data nhận được", data)
                content.innerHTML =
                    '<div class="row g-3">' +
                    '<div class="col-md-6">' +
                    '<label class="form-label text-muted small fw-medium">ID</label>' +
                    '<div class="fw-bold">#' + data.id + '</div>' +
                    '</div>' +
                    '<div class="col-md-6">' +
                    '<label class="form-label text-muted small fw-medium">Người nhận</label>' +
                    '<div class="fw-bold">' + data.fullName + ' (@' + data.username + ')</div>' +
                    '</div>' +
                    '<div class="col-md-4">' +
                    '<label class="form-label text-muted small fw-medium">Loại</label>' +
                    '<div class="fw-bold">' + getTypeLabel(data.type) + '</div>' +
                    '</div>' +
                    '<div class="col-md-4">' +
                    '<label class="form-label text-muted small fw-medium">Ưu tiên</label>' +
                    '<div class="fw-bold">' + getPriorityLabel(data.priority) + '</div>' +
                    '</div>' +
                    '<div class="col-md-4">' +
                    '<label class="form-label text-muted small fw-medium">Trạng thái</label>' +
                    '<div class="fw-bold ' + (data.isRead ? 'text-success' : 'text-warning') + '">' +
                    (data.isRead ? 'Đã đọc' : 'Chưa đọc') +
                    '</div>' +
                    '</div>' +
                    '<div class="col-12">' +
                    '<label class="form-label text-muted small fw-medium">Tiêu đề</label>' +
                    '<div class="fw-bold">' + data.title + '</div>' +
                    '</div>' +
                    '<div class="col-12">' +
                    '<label class="form-label text-muted small fw-medium">Nội dung</label>' +
                    '<div class="border p-3 rounded bg-light">' + data.content + '</div>' +
                    '</div>' +
                    (data.actionUrl ?
                        '<div class="col-12">' +
                        '<label class="form-label text-muted small fw-medium">URL hành động</label>' +
                        '<div><a href="' + data.actionUrl + '" target="_blank" class="text-primary">' + data.actionUrl + '</a></div>' +
                        '</div>' : '') +
                    (data.metadata ?
                        '<div class="col-12">' +
                        '<label class="form-label text-muted small fw-medium">Metadata</label>' +
                        '<div class="border p-2 rounded bg-light">' +
                        '<code>' + data.metadata + '</code>' +
                        '</div>' +
                        '</div>' : '') +
                    '<div class="col-md-6">' +
                    '<label class="form-label text-muted small fw-medium">Ngày tạo</label>' +
                    '<div class="fw-bold">' + formatDate(data.createdAt) + '</div>' +
                    '</div>' +
                    (data.readAt ?
                        '<div class="col-md-6">' +
                        '<label class="form-label text-muted small fw-medium">Thời gian đọc</label>' +
                        '<div class="fw-bold text-success">' + formatDate(data.readAt) + '</div>' +
                        '</div>' : '') +
                    (data.expiresAt ?
                        '<div class="col-md-6">' +
                        '<label class="form-label text-muted small fw-medium">Hết hạn</label>' +
                        '<div class="fw-bold ' + (new Date(data.expiresAt) < new Date() ? 'text-danger' : 'text-info') + '">' +
                        formatDate(data.expiresAt) +
                        '</div>' +
                        '</div>' : '') +
                    (data.relatedEntityType && data.relatedEntityId ?
                        '<div class="col-md-6">' +
                        '<label class="form-label text-muted small fw-medium">Liên quan đến</label>' +
                        '<div class="fw-bold">' + data.relatedEntityType + ' #' + data.relatedEntityId + '</div>' +
                        '</div>' : '') +
                    '</div>';
            })
            .catch(error => {
                content.innerHTML =
                    '<div class="alert alert-danger">' +
                    '<i class="bi bi-exclamation-triangle me-2"></i>' +
                    'Không thể tải chi tiết thông báo: ' + error.message +
                    '</div>';
            });
    }

    function editNotification(id) {
        // Placeholder for edit functionality
        showToast('Chức năng chỉnh sửa thông báo đang được phát triển', 'info');
    }

    // ===== FORM SUBMISSION =====
    document.getElementById('createNotificationForm')?.addEventListener('submit', function (e) {
        e.preventDefault();
        const formData = new FormData(this);
        const submitBtn = this.querySelector('button[type="submit"]');
        const originalText = submitBtn.innerHTML;

        // Show loading
        submitBtn.disabled = true;
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span>Đang gửi...';

        fetch(this.action, {
            method: 'POST',
            body: formData
        })
            .then(response => {
                if (response.ok) {
                    showToast('Tạo thông báo thành công!', 'success');
                    bootstrap.Modal.getInstance(document.getElementById('createNotificationModal')).hide();
                    setTimeout(() => location.reload(), 1000);
                } else {
                    return response.text().then(text => {
                        throw new Error(text || 'Có lỗi xảy ra khi tạo thông báo');
                    });
                }
            })
            .catch(error => {
                showToast('Có lỗi xảy ra: ' + error.message, 'error');
            })
            .finally(() => {
                submitBtn.disabled = false;
                submitBtn.innerHTML = originalText;
            });
    });

    // ===== UTILITY FUNCTIONS =====
    function showToast(message, type = 'info') {
        // Create toast element
        const toastContainer = document.querySelector('.toast-container') || createToastContainer();
        const toastId = 'toast-' + Date.now();
        const bgClass = type === 'success' ? 'bg-success' : type === 'error' ? 'bg-danger' : 'bg-info';

        const toastHtml =
            '<div id="' + toastId + '" class="toast ' + bgClass + ' text-white" role="alert">' +
            '<div class="toast-body d-flex align-items-center">' +
            '<i class="bi bi-' + (type === 'success' ? 'check-circle' : type === 'error' ? 'x-circle' : 'info-circle') + ' me-2"></i>' +
            message +
            '<button type="button" class="btn-close btn-close-white ms-auto" data-bs-dismiss="toast"></button>' +
            '</div>' +
            '</div>';

        toastContainer.insertAdjacentHTML('beforeend', toastHtml);
        const toastElement = document.getElementById(toastId);
        const toast = new bootstrap.Toast(toastElement, {delay: 4000});
        toast.show();

        // Remove toast element after it's hidden
        toastElement.addEventListener('hidden.bs.toast', () => {
            toastElement.remove();
        });
    }

    function createToastContainer() {
        const container = document.createElement('div');
        container.className = 'toast-container position-fixed top-0 end-0 p-3';
        container.style.zIndex = '9999';
        document.body.appendChild(container);
        return container;
    }

    function formatDate(dateString) {
        if (!dateString) return '';
        const date = new Date(dateString);
        return date.toLocaleString('vi-VN', {
            year: 'numeric',
            month: '2-digit',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit'
        });
    }

    function getTypeLabel(type) {
        const typeLabels = {
            'JOB': 'Công việc',
            'PROPOSAL': 'Đề xuất',
            'CONTRACT': 'Hợp đồng',
            'CHAT': 'Tin nhắn',
            'WALLET': 'Ví tiền',
            'SYSTEM': 'Hệ thống'
        };
        return typeLabels[type] || type;
    }

    function getPriorityLabel(priority) {
        const priorityLabels = {
            'LOW': 'Thấp',
            'NORMAL': 'Bình thường',
            'HIGH': 'Cao',
            'URGENT': 'Khẩn cấp'
        };
        return priorityLabels[priority] || priority;
    }

    // ===== CHARACTER COUNTERS =====
    function setupCharacterCounters() {
        const titleInput = document.querySelector('input[name="title"]');
        const contentTextarea = document.querySelector('textarea[name="content"]');

        if (titleInput) {
            titleInput.addEventListener('input', function () {
                updateCharacterCounter(this, 200);
            });
        }

        if (contentTextarea) {
            contentTextarea.addEventListener('input', function () {
                updateCharacterCounter(this, 1000);
            });
        }
    }

    function updateCharacterCounter(element, maxLength) {
        const remaining = maxLength - element.value.length;
        let counter = element.parentElement.querySelector('.char-counter');

        if (!counter) {
            counter = document.createElement('small');
            counter.className = 'char-counter text-muted mt-1';
            element.parentElement.appendChild(counter);
        }

        counter.textContent = remaining + ' ký tự còn lại';
        counter.className = 'char-counter mt-1 ' + (remaining < maxLength * 0.1 ? 'text-danger' : 'text-muted');
    }

    // ===== INITIALIZATION =====
    document.addEventListener('DOMContentLoaded', function () {
        // Set active sidebar
        if (typeof setAdminSidebarActive === 'function') {
            setAdminSidebarActive('Notifications');
        }

        // Setup character counters
        setupCharacterCounters();

        // Auto refresh every 60 seconds
        setInterval(() => {
            if (!document.querySelector('.modal.show')) {
                location.reload();
            }
        }, 60000);
    });
</script>
</body>
</html>