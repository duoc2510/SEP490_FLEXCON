<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
    <%@include file="include/head.jsp" %>
    <body style="background: linear-gradient(135deg, #fff5f0 0%, #ffffff 100%);">
        <div class="container-fluid">
            <div class="row g-0">
                <%@include file="include/sidebar.jsp" %>

                <main class="col-12 col-lg-9 col-xl-10 p-4">
                    <!-- Header Section -->
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h2 class="h3 mb-1 text-dark">
                                <i class="bi bi-bell text-warning me-2"></i>Thông báo
                            </h2>
                            <p class="text-muted mb-0">Theo dõi các hoạt động và cập nhật mới nhất</p>
                        </div>

                        <div class="d-flex align-items-center gap-3">
                            <div class="dropdown">
                                <button class="btn btn-outline-warning dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                    <i class="bi bi-funnel me-1"></i>Lọc
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="?filter=all">Tất cả</a></li>
                                    <li><a class="dropdown-item" href="?filter=unread">Chưa đọc</a></li>
                                    <li><a class="dropdown-item" href="?filter=JOB">Công việc</a></li>
                                    <li><a class="dropdown-item" href="?filter=PROPOSAL">Đề xuất</a></li>
                                    <li><a class="dropdown-item" href="?filter=CONTRACT">Hợp đồng</a></li>
                                    <li><a class="dropdown-item" href="?filter=SYSTEM">Hệ thống</a></li>
                                </ul>
                            </div>
                            <button class="btn btn-warning text-white" id="btnMarkAllRead">
                                <i class="bi bi-check2-all me-1"></i>Đánh dấu đã đọc tất cả
                            </button>
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb mb-0">
                                    <li class="breadcrumb-item">
                                        <a href="${pageContext.request.contextPath}/dashboard/" class="text-warning text-decoration-none">Dashboard</a>
                                    </li>
                                    <li class="breadcrumb-item active">Thông báo</li>
                                </ol>
                            </nav>
                        </div>
                    </div>

                    <!-- Notification Area for AJAX responses -->
                    <div id="notificationArea"></div>

                    <!-- Stats Summary -->
                    <div class="row g-3 mb-4">
                        <div class="col-6 col-md-4">
                            <div class="card border-0 shadow-sm" style="background: linear-gradient(135deg, #fff8f0 0%, #ffffff 100%);">
                                <div class="card-body p-3 text-center">
                                    <div class="h4 mb-1 text-warning fw-bold" id="totalCount">${sumCount}</div>
                                    <small class="text-muted">Tổng số</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 col-md-4">
                            <div class="card border-0 shadow-sm" style="background: linear-gradient(135deg, #fff8f0 0%, #ffffff 100%);">
                                <div class="card-body p-3 text-center">
                                    <div class="h4 mb-1 text-danger fw-bold" id="unreadCount">
                                        <c:set var="unreadCount" value="${countNotification}" />
                                        <c:forEach items="${notifications}" var="notification">
                                            <c:if test="${!notification.isRead}">
                                                <c:set var="unreadCount" value="${unreadCount + 1}" />
                                            </c:if>
                                        </c:forEach>
                                        ${unreadCount}
                                    </div>
                                    <small class="text-muted">Chưa đọc</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 col-md-4">
                            <div class="card border-0 shadow-sm" style="background: linear-gradient(135deg, #fff8f0 0%, #ffffff 100%);">
                                <div class="card-body p-3 text-center">
                                    <div class="h4 mb-1 text-info fw-bold" id="highPriorityCount">
                                        <c:set var="highPriorityCount" value="${countHighPriority}" />
                                        <c:forEach items="${notifications}" var="notification">
                                            <c:if test="${notification.priority eq 'HIGH' || notification.priority eq 'URGENT'}">
                                                <c:set var="highPriorityCount" value="${highPriorityCount + 1}" />
                                            </c:if>
                                        </c:forEach>
                                        ${highPriorityCount}
                                    </div>
                                    <small class="text-muted">Quan trọng</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Notifications List -->
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-transparent border-0 p-4">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-1">
                                        <i class="bi bi-list-ul text-warning me-2"></i>Danh sách thông báo
                                    </h5>
                                    <p class="text-muted mb-0 small">Các thông báo được sắp xếp theo thời gian mới nhất</p>
                                </div>
                                <button class="btn btn-outline-warning btn-sm" id="btnRefresh">
                                    <i class="bi bi-arrow-clockwise me-1"></i>Làm mới
                                </button>
                            </div>
                        </div>
                        <div class="card-body p-0" id="notificationsContainer">
                            <c:choose>
                                <c:when test="${empty notificationAll}">
                                    <div class="text-center p-5">
                                        <div class="mb-3">
                                            <i class="bi bi-bell-slash text-muted" style="font-size: 3rem;"></i>
                                        </div>
                                        <h6 class="text-muted">Không có thông báo nào</h6>
                                        <p class="text-muted small">Các thông báo mới sẽ xuất hiện tại đây</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="list-group list-group-flush">
                                        <c:forEach items="${notificationAll}" var="notification" varStatus="status">
                                            <div class="list-group-item border-0 px-4 py-3 notification-item ${!notification.isRead ? 'unread' : ''}" 
                                                 data-id="${notification.id}" 
                                                 data-read="${notification.isRead}"
                                                 data-action-url="${notification.actionUrl}">
                                                <div class="d-flex align-items-start gap-3">
                                                    <!-- Icon based on type and priority -->
                                                    <div class="flex-shrink-0">
                                                        <div class="rounded-circle p-2 d-flex align-items-center justify-content-center
                                                             ${notification.type eq 'JOB' ? 'bg-primary bg-opacity-25' : 
                                                               notification.type eq 'PROPOSAL' ? 'bg-info bg-opacity-25' :
                                                               notification.type eq 'CONTRACT' ? 'bg-success bg-opacity-25' :
                                                               notification.type eq 'CHAT' ? 'bg-warning bg-opacity-25' :
                                                               notification.type eq 'WALLET' ? 'bg-secondary bg-opacity-25' :
                                                               'bg-dark bg-opacity-25'}" 
                                                             style="width: 40px; height: 40px;">
                                                            <c:choose>
                                                                <c:when test="${notification.type eq 'JOB'}">
                                                                    <i class="bi bi-briefcase ${notification.type eq 'JOB' ? 'text-primary' : ''}"></i>
                                                                </c:when>
                                                                <c:when test="${notification.type eq 'PROPOSAL'}">
                                                                    <i class="bi bi-file-earmark-text text-info"></i>
                                                                </c:when>
                                                                <c:when test="${notification.type eq 'CONTRACT'}">
                                                                    <i class="bi bi-file-earmark-check text-success"></i>
                                                                </c:when>
                                                                <c:when test="${notification.type eq 'CHAT'}">
                                                                    <i class="bi bi-chat-dots text-warning"></i>
                                                                </c:when>
                                                                <c:when test="${notification.type eq 'WALLET'}">
                                                                    <i class="bi bi-wallet2 text-secondary"></i>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <i class="bi bi-info-circle text-dark"></i>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <!-- Priority indicator -->
                                                        <c:if test="${notification.priority eq 'HIGH' || notification.priority eq 'URGENT'}">
                                                            <div class="position-relative">
                                                                <i class="bi bi-exclamation-circle position-absolute top-0 start-100 translate-middle 
                                                                   ${notification.priority eq 'URGENT' ? 'text-danger' : 'text-warning'}" 
                                                                   style="font-size: 0.8rem; margin-top: -20px; margin-left: -8px;"></i>
                                                            </div>
                                                        </c:if>
                                                    </div>

                                                    <!-- Content -->
                                                    <div class="flex-grow-1 min-w-0">
                                                        <div class="d-flex justify-content-between align-items-start mb-1">
                                                            <h6 class="mb-1 fw-semibold text-truncate" style="max-width: 70%;">
                                                                ${notification.title}
                                                                <c:if test="${!notification.isRead}">
                                                                    <span class="badge bg-warning text-dark ms-2" style="font-size: 0.6rem;">Mới</span>
                                                                </c:if>
                                                            </h6>
                                                            <div class="d-flex align-items-center gap-2">
                                                                <small class="text-muted">
                                                                    <fmt:formatDate value="${notification.createdAtDate}" pattern="HH:mm dd/MM/yyyy" />

                                                                </small>
                                                                <div class="dropdown">
                                                                    <button class="btn btn-sm btn-link text-muted p-0 dropdown-toggle"
                                                                            type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                                        <i class="bi bi-three-dots-vertical"></i>
                                                                    </button>

                                                                    <ul class="dropdown-menu dropdown-menu-end">
                                                                        <c:choose>
                                                                            <c:when test="${notification.isRead == false}">
                                                                                <li>
                                                                                    <a class="dropdown-item js-mark-read" href="#" 
                                                                                       data-id="${notification.id}">
                                                                                        <i class="bi bi-check2 me-2"></i>Đánh dấu đã đọc
                                                                                    </a>
                                                                                </li>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <li>
                                                                                    <span class="dropdown-item-text text-muted">
                                                                                        <i class="bi bi-check-circle me-2"></i>Đã đọc
                                                                                    </span>
                                                                                </li>
                                                                            </c:otherwise>
                                                                        </c:choose>

                                                                        <c:if test="${not empty notification.actionUrl}">
                                                                            <li>
                                                                                <a class="dropdown-item" href="${notification.actionUrl}">
                                                                                    <i class="bi bi-box-arrow-up-right me-2"></i>Xem chi tiết
                                                                                </a>
                                                                            </li>
                                                                        </c:if>

                                                                        <li><hr class="dropdown-divider"></li>

                                                                        <li>
                                                                            <a class="dropdown-item text-danger js-delete" href="#" 
                                                                               data-id="${notification.id}">
                                                                                <i class="bi bi-trash me-2"></i>Xóa
                                                                            </a>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <p class="mb-2 text-muted small" style="line-height: 1.4;">
                                                            ${fn:length(notification.content) > 100 ? 
                                                              fn:substring(notification.content, 0, 100).concat('...') : 
                                                              notification.content}
                                                        </p>

                                                        <!-- Tags -->
                                                        <div class="d-flex align-items-center gap-2">
                                                            <span class="badge bg-light text-dark border">${notification.type}</span>
                                                            <c:if test="${notification.priority ne 'NORMAL'}">
                                                                <span class="badge 
                                                                      ${notification.priority eq 'URGENT' ? 'bg-danger' : 
                                                                        notification.priority eq 'HIGH' ? 'bg-warning text-dark' : 'bg-secondary'}">
                                                                          ${notification.priority}
                                                                      </span>
                                                                </c:if>
                                                                <c:if test="${notification.expiresAt != null}">
                                                                    <span class="badge bg-info">
                                                                        <i class="bi bi-clock me-1"></i>Có thời hạn
                                                                    </span>
                                                                </c:if>
                                                            </div>
                                                        </div>

                                                        <!-- Read status indicator -->
                                                        <div class="flex-shrink-0">
                                                            <c:if test="${!notification.isRead}">
                                                                <div class="bg-warning rounded-circle" style="width: 8px; height: 8px;"></div>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>

                                        <!-- Load More Button (for pagination) -->
                                        <div class="text-center p-4 border-top">
                                            <button class="btn btn-outline-warning" id="loadMoreBtn">
                                                <i class="bi bi-arrow-down-circle me-1"></i>Tải thêm
                                            </button>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </main>
                </div>
            </div>

            <!-- Loading Modal -->
            <div class="modal fade" id="loadingModal" tabindex="-1" data-bs-backdrop="static">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-body text-center p-4">
                            <div class="spinner-border text-warning" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <p class="mt-2 mb-0">Đang xử lý...</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Toastr / jQuery / Bootstrap -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>


            <script>
                // =================== CONFIG ===================
                var CTX = '${pageContext.request.contextPath}';

                // Toastr config
                toastr.options = {
                    "closeButton": true,
                    "debug": false,
                    "newestOnTop": true,
                    "progressBar": true,
                    "positionClass": "toast-top-right",
                    "preventDuplicates": false,
                    "onclick": null,
                    "showDuration": "300",
                    "hideDuration": "1000",
                    "timeOut": "4000",
                    "extendedTimeOut": "1000",
                    "showEasing": "swing",
                    "hideEasing": "linear",
                    "showMethod": "fadeIn",
                    "hideMethod": "fadeOut"
                };

                // =================== GLOBAL STATE ===================
                var currentPage = 1;
                var isLoading = false;

                // =================== fetch HELPER (ES5-compatible style) ===================
                function fetchJson(method, url, bodyObj) {
                    var opts = {
                        method: method,
                        headers: {
                            'X-Requested-With': 'XMLHttpRequest',
                            'Accept': 'application/json'   // <- thêm
                        }
                    };
                    if (method === 'POST' || method === 'PUT' || method === 'DELETE') {
                        opts.headers['Content-Type'] = 'application/json';
                        opts.body = bodyObj ? JSON.stringify(bodyObj) : '{}';
                    }
                    return fetch(url, opts).then(function (response) {
                        return response.text().then(function (text) {
                            var data;
                            try {
                                data = text ? JSON.parse(text) : {};
                            } catch (e) {
                                data = {raw: text};
                            }
                            return {ok: response.ok, status: response.status, data: data};
                        });
                    });
                }
//                // loader 
//                var Loader = (function () {
//                    var modalEl, modalInst, active = 0, t0 = 0, timer = null;
//                    var MIN_MS = 300; // 0.3s
//
//                    function ensureModal() {
//                        if (!modalEl)
//                            modalEl = document.getElementById('loadingModal');
//                        if (!modalEl)
//                            return null;
//                        if (!modalInst) {
//                            modalInst = bootstrap.Modal.getOrCreateInstance(modalEl, {
//                                backdrop: 'static', keyboard: false
//                            });
//                        }
//                        return modalInst;
//                    }
//
//                    return {
//                        show: function () {
//                            var m = ensureModal();
//                            if (!m)
//                                return;
//                            if (active === 0) { // lần đầu tiên show trong chuỗi
//                                t0 = Date.now();
//                                m.show();
//                            }
//                            active++;
//                        },
//                        hide: function () {
//                            var m = ensureModal();
//                            if (!m)
//                                return;
//                            if (active > 0)
//                                active--;
//                            if (active === 0) {
//                                // đảm bảo hiển thị tối thiểu 0.3s
//                                var elapsed = Date.now() - t0;
//                                var wait = MIN_MS - elapsed;
//                                if (wait < 0)
//                                    wait = 0;
//                                if (timer) {
//                                    clearTimeout(timer);
//                                    timer = null;
//                                }
//                                timer = setTimeout(function () {
//                                    m.hide();
//                                    timer = null;
//                                }, wait);
//                            }
//                        },
//                        // optional: reset nếu cần
//                        reset: function () {
//                            active = 0;
//                            if (timer) {
//                                clearTimeout(timer);
//                                timer = null;
//                            }
//                            var m = ensureModal();
//                            if (m)
//                                m.hide();
//                        }
//                    };
//                })();
//





                // =================== CORE ACTIONS (dùng fetch) ===================
                function markAsReadAll() {
                    if (isLoading)
                        return;

                    if (!confirm('Bạn có chắc chắn muốn đánh dấu tất cả thông báo là đã đọc?')) {
                        return;
                    }

                    isLoading = true;
                    var url = CTX + '/dashboard/notifications/markReadAll';

                    fetchJson('POST', url, {}).then(function (res) {
                        if (res.ok && res.data && res.data.status === 'success') {
                            // Cập nhật tất cả notifications trong UI
                            var unreadItems = document.querySelectorAll('.notification-item.unread');
                            for (var i = 0; i < unreadItems.length; i++) {
                                var item = unreadItems[i];
                                item.classList.remove('unread');
                                item.setAttribute('data-read', 'true');

                                var newBadge = item.querySelector('.badge.bg-warning');
                                if (newBadge && newBadge.textContent === 'Mới')
                                    newBadge.remove();

                                var unreadDot = item.querySelector('.bg-warning.rounded-circle');
                                if (unreadDot)
                                    unreadDot.remove();
                            }

                            updateCounters();
                            toastr.success('Đã đánh dấu tất cả thông báo là đã đọc', 'Thành công');
                        } else {
                            console.error('markAsReadAll FAIL', res.status, res.data);
                            var msg = (res.data && res.data.message) ? res.data.message : 'Có lỗi khi cập nhật trạng thái thông báo';
                            toastr.error(msg, 'Lỗi [' + res.status + ']');
                        }
                    }).catch(function (err) {
                        console.error('markAsReadAll ERROR', err);
                        toastr.error('Lỗi kết nối. Vui lòng thử lại!', 'Lỗi kết nối');
                    }).finally(function () {
                        isLoading = false;
                    });
                }


                function markAsRead(notificationId) {
                    if (isLoading)
                        return;

                    var item = document.querySelector('[data-id="' + notificationId + '"]');
                    if (!item)
                        return;
                    if (item.getAttribute('data-read') === 'true')
                        return;

                    isLoading = true;
//                    Loader.show();

                    var url = CTX + '/dashboard/notifications/markRead?id=' + notificationId;

                    fetchJson('POST', url, {}).then(function (res) {
                        if (res.ok && res.data && res.data.status === 'success') {
                            item.classList.remove('unread');
                            item.setAttribute('data-read', 'true');
                            var newBadge = item.querySelector('.badge.bg-warning');
                            if (newBadge && newBadge.textContent === 'Mới')
                                newBadge.remove();
                            var unreadDot = item.querySelector('.bg-warning.rounded-circle');
                            if (unreadDot)
                                unreadDot.remove();
                            updateCounters();
                            toastr.success('Đã đánh dấu thông báo là đã đọc', 'Thành công');
                        } else {
                            // >>> Thêm 3 dòng dưới để debug
                            console.error('markAsRead FAIL', res.status, res.data);
                            var msg = (res.data && res.data.message) ? res.data.message : 'Có lỗi khi cập nhật trạng thái thông báo';
                            toastr.error(msg, 'Lỗi [' + res.status + ']');
                        }
                    }).catch(function (err) {
                        console.error('markAsRead ERROR', err);
                        toastr.error('Lỗi kết nối. Vui lòng thử lại!', 'Lỗi kết nối');
                    }).finally(function () {
                        isLoading = false;
//                        Loader.hide();
                    });
                }


                function deleteNotification(notificationId) {
                    if (isLoading)
                        return;
                    if (!confirm('Bạn có chắc chắn muốn xóa thông báo này?'))
                        return;

                    isLoading = true;
//                    Loader.show();

                    var url = CTX + '/dashboard/notifications/delete?id=' + notificationId;
                    fetchJson('DELETE', url, null).then(function (res) {
                        if (res.ok && res.data && res.data.status === 'success') {
                            var item = document.querySelector('[data-id="' + notificationId + '"]');
                            if (item) {
                                item.style.transition = 'all 0.3s ease';
                                item.style.opacity = '0';
                                item.style.transform = 'translateX(-100%)';
                                setTimeout(function () {
                                    if (item.parentNode)
                                        item.parentNode.removeChild(item);
                                    updateCounters();

                                    var remain = document.querySelectorAll('.notification-item').length;
                                    if (remain === 0) {
                                        showEmptyState();
                                    }
                                }, 300);
                            }
                            toastr.success('Đã xóa thông báo', 'Thành công');
                        } else {
                            toastr.error('Có lỗi khi xóa thông báo', 'Lỗi');
                        }
                    }).catch(function () {
                        toastr.error('Lỗi kết nối. Vui lòng thử lại!', 'Lỗi kết nối');
                    }).finally(function () {
                        isLoading = false;
//                        Loader.hide();
                    });
                }

                function loadMoreNotifications() {
                    if (isLoading)
                        return;

                    var btn = document.getElementById('loadMoreBtn');
                    if (!btn)
                        return;

                    isLoading = true;
                    var original = btn.innerHTML;
                    btn.innerHTML = '<div class="spinner-border spinner-border-sm me-1"></div>Đang tải...';
                    btn.disabled = true;

                    currentPage += 1;

                    var url = CTX + '/notifications?page=' + currentPage + '&ajax=true';
                    fetchJson('GET', url, null).then(function (res) {
                        if (res.ok && res.data && res.data.status === 'success' && res.data.notifications && res.data.notifications.length) {
                            var container = document.querySelector('#notificationsContainer .list-group');
                            if (container) {
                                for (var i = 0; i < res.data.notifications.length; i++) {
                                    container.appendChild(createNotificationElement(res.data.notifications[i]));
                                }
                                addHoverEffects();
                            }
                            if (!res.data.hasMore || !res.data.notifications.length) {
                                btn.style.display = 'none';
                            }
                        } else {
                            currentPage -= 1;
                            toastr.warning('Không thể tải thêm thông báo', 'Cảnh báo');
                        }
                    }).catch(function () {
                        currentPage -= 1;
                        toastr.error('Lỗi kết nối khi tải thêm thông báo', 'Lỗi kết nối');
                    }).finally(function () {
                        isLoading = false;
                        btn.innerHTML = original;
                        btn.disabled = false;
                    });
                }

                // =================== UI HELPERS ===================
                function updateCounters() {
                    var unreadItems = document.querySelectorAll('.notification-item.unread').length;
                    var totalItems = document.querySelectorAll('.notification-item').length;

                    // Đếm notifications quan trọng (HIGH hoặc URGENT)
                    var highPriorityItems = 0;
                    var allItems = document.querySelectorAll('.notification-item');
                    for (var i = 0; i < allItems.length; i++) {
                        var badges = allItems[i].querySelectorAll('.badge');
                        for (var j = 0; j < badges.length; j++) {
                            var badgeText = badges[j].textContent.trim();
                            if (badgeText === 'HIGH' || badgeText === 'URGENT') {
                                highPriorityItems++;
                                break;
                            }
                        }
                    }

                    var unreadEl = document.getElementById('unreadCount');
                    var totalEl = document.getElementById('totalCount');
                    var highPriorityEl = document.getElementById('highPriorityCount');

                    if (unreadEl)
                        unreadEl.textContent = String(unreadItems);
                    if (totalEl)
                        totalEl.textContent = String(totalItems);
                    if (highPriorityEl)
                        highPriorityEl.textContent = String(highPriorityItems);
                }

                function addHoverEffects() {
                    var items = document.querySelectorAll('.notification-item');
                    for (var i = 0; i < items.length; i++) {
                        items[i].addEventListener('mouseenter', function () {
                            this.style.backgroundColor = '#fff8f0';
                            this.style.cursor = 'pointer';
                        });
                        items[i].addEventListener('mouseleave', function () {
                            this.style.backgroundColor = '';
                        });
                    }
                }

                function showEmptyState() {
                    var container = document.getElementById('notificationsContainer');
                    if (!container)
                        return;
                    container.innerHTML =
                            '<div class="text-center p-5">' +
                            '<div class="mb-3">' +
                            '<i class="bi bi-bell-slash text-muted" style="font-size: 3rem;"></i>' +
                            '</div>' +
                            '<h6 class="text-muted">Không có thông báo nào</h6>' +
                            '<p class="text-muted small">Các thông báo mới sẽ xuất hiện tại đây</p>' +
                            '</div>';
                }

                function createNotificationElement(n) {
                    var div = document.createElement('div');
                    var unreadClass = n.isRead ? '' : ' unread';
                    var badgeNew = n.isRead ? '' : '<span class="badge bg-warning text-dark ms-2" style="font-size: 0.6rem;">Mới</span>';
                    var dot = n.isRead ? '' : '<div class="bg-warning rounded-circle" style="width: 8px; height: 8px;"></div>';
                    var priorityBadge = '';
                    if (n.priority && n.priority !== 'NORMAL') {
                        var cls = (n.priority === 'URGENT') ? 'bg-danger' : (n.priority === 'HIGH' ? 'bg-warning text-dark' : 'bg-secondary');
                        priorityBadge = '<span class="badge ' + cls + '">' + n.priority + '</span>';
                    }
                    var content = n.content || '';
                    if (content.length > 100)
                        content = content.substring(0, 100) + '...';

                    div.className = 'list-group-item border-0 px-4 py-3 notification-item' + unreadClass;
                    div.setAttribute('data-id', n.id);
                    div.setAttribute('data-read', n.isRead ? 'true' : 'false');
                    div.setAttribute('data-action-url', n.actionUrl || '');

                    div.innerHTML =
                            '<div class="d-flex align-items-start gap-3">' +
                            '<div class="flex-shrink-0">' +
                            '<div class="rounded-circle p-2 d-flex align-items-center justify-content-center bg-dark bg-opacity-25" style="width:40px;height:40px;">' +
                            '<i class="bi bi-info-circle text-dark"></i>' +
                            '</div>' +
                            '</div>' +
                            '<div class="flex-grow-1 min-w-0">' +
                            '<div class="d-flex justify-content-between align-items-start mb-1">' +
                            '<h6 class="mb-1 fw-semibold text-truncate" style="max-width:70%;">' + (n.title || '') + badgeNew + '</h6>' +
                            '<div class="d-flex align-items-center gap-2">' +
                            '<small class="text-muted">' + (n.createdAt || '') + '</small>' +
                            '<div class="dropdown">' +
                            '<button class="btn btn-sm btn-link text-muted p-0" type="button" data-bs-toggle="dropdown" aria-expanded="false">' +
                            '<i class="bi bi-three-dots-vertical"></i>' +
                            '</button>' +
                            '<ul class="dropdown-menu dropdown-menu-end">' +
                            (n.isRead ? '<li><span class="dropdown-item-text text-muted"><i class="bi bi-check-circle me-2"></i>Đã đọc</span></li>' :
                                    '<li><a class="dropdown-item js-mark-read" href="#" data-id="' + n.id + '"><i class="bi bi-check2 me-2"></i>Đánh dấu đã đọc</a></li>') +
                            (n.actionUrl ? '<li><a class="dropdown-item" href="' + n.actionUrl + '"><i class="bi bi-box-arrow-up-right me-2"></i>Xem chi tiết</a></li>' : '') +
                            '<li><hr class="dropdown-divider"></li>' +
                            '<li><a class="dropdown-item text-danger js-delete" href="#" data-id="' + n.id + '"><i class="bi bi-trash me-2"></i>Xóa</a></li>' +
                            '</ul>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '<p class="mb-2 text-muted small" style="line-height:1.4;">' + content + '</p>' +
                            '<div class="d-flex align-items-center gap-2">' +
                            '<span class="badge bg-light text-dark border">' + (n.type || 'SYSTEM') + '</span>' +
                            priorityBadge +
                            '</div>' +
                            '</div>' +
                            '<div class="flex-shrink-0">' + dot + '</div>' +
                            '</div>';

                    return div;
                }

//                function showLoadingModal() {
//                    var el = document.getElementById('loadingModal');
//                    if (!el)
//                        return;
//                    var modal = bootstrap.Modal.getOrCreateInstance(el);
//                    modal.show();
//                }
//
//                function hideLoadingModal() {
//                    var el = document.getElementById('loadingModal');
//                    if (!el)
//                        return;
//                    var modal = bootstrap.Modal.getInstance(el);
//                    if (modal)
//                        modal.hide();
//                }

                function showNotification(message, type) {
                    var area = document.getElementById('notificationArea');
                    if (!area) {
                        alert(message || 'Có thông báo');
                        return;
                    }
                    var div = document.createElement('div');
                    div.className = 'alert alert-' + (type || 'info') + ' alert-dismissible fade show';
                    div.setAttribute('role', 'alert');
                    var span = document.createElement('span');
                    span.textContent = message || 'Có thông báo nhưng trống nội dung';
                    div.appendChild(span);
                    var btn = document.createElement('button');
                    btn.type = 'button';
                    btn.className = 'btn-close';
                    btn.setAttribute('data-bs-dismiss', 'alert');
                    div.appendChild(btn);
                    area.insertBefore(div, area.firstChild);
                    setTimeout(function () {
                        var alertInst = bootstrap.Alert.getOrCreateInstance(div);
                        alertInst.close();
                    }, 4000);
                }

                // =================== EVENT DELEGATION ===================
                document.addEventListener('DOMContentLoaded', function () {
                    // 1) Khởi tạo dropdown rõ ràng
                    var toggles = [].slice.call(document.querySelectorAll('[data-bs-toggle="dropdown"]'));
                    for (var i = 0; i < toggles.length; i++) {
                        if (!toggles[i].classList.contains('dropdown-toggle')) {
                            toggles[i].classList.add('dropdown-toggle');
                        }
                        new bootstrap.Dropdown(toggles[i]);
                    }

                    // 1b) Nếu toggle là <a>, chặn nhảy trang nhưng KHÔNG stopPropagation
                    var anchorToggles = [].slice.call(document.querySelectorAll('a[data-bs-toggle="dropdown"]'));
                    for (var j = 0; j < anchorToggles.length; j++) {
                        anchorToggles[j].addEventListener('click', function (e) {
                            e.preventDefault();
                            // KHÔNG stopPropagation ở đây!
                        });
                    }

                    // 2) Không “động” vào click thuộc dropdown
                    document.addEventListener('click', function (e) {
                        var inDropdownContainer = e.target && e.target.closest ? e.target.closest('.dropdown') : null;
                        var inDropdownMenu = e.target && e.target.closest ? e.target.closest('.dropdown-menu') : null;
                        var isDropdownToggle = e.target && e.target.closest ? e.target.closest('[data-bs-toggle="dropdown"]') : null;
                        if (inDropdownContainer || inDropdownMenu || isDropdownToggle) {
                            return; // để Bootstrap xử lý dropdown
                        }

                        // Click trên notification-item -> mark read + điều hướng
                        var node = e.target;
                        while (node && node !== document && (!node.classList || !node.classList.contains('notification-item'))) {
                            node = node.parentNode;
                        }
                        if (node && node.classList && node.classList.contains('notification-item')) {
                            var id = node.getAttribute('data-id');
                            var actionUrl = node.getAttribute('data-action-url');
                            if (id) {
                                markAsRead(id);
                            }
                            if (actionUrl && actionUrl.replace(/\s/g, '').length > 0) {
                                setTimeout(function () {
                                    window.location.href = actionUrl;
                                }, 200);
                            }
                        }
                    });

                    // 3) Hành động trong dropdown (chặn default + chặn bubble để không “lọt” ra ngoài)
                    document.addEventListener('click', function (e) {
                        var a = e.target;
                        if (a && a.matches && a.matches('a.js-mark-read, a.js-mark-read *')) {
                            while (a && a.tagName && a.tagName.toLowerCase() !== 'a') {
                                a = a.parentNode;
                            }
                            if (a && a.classList.contains('js-mark-read')) {
                                e.preventDefault();
                                e.stopPropagation();
                                var id = a.getAttribute('data-id');
                                if (id) {
                                    markAsRead(id);
                                }
                            }
                        }
                    });

                    document.addEventListener('click', function (e) {
                        var a = e.target;
                        if (a && a.matches && a.matches('a.js-delete, a.js-delete *')) {
                            while (a && a.tagName && a.tagName.toLowerCase() !== 'a') {
                                a = a.parentNode;
                            }
                            if (a && a.classList.contains('js-delete')) {
                                e.preventDefault();
                                e.stopPropagation();
                                var id = a.getAttribute('data-id');
                                if (id) {
                                    deleteNotification(id);
                                }
                            }
                        }
                    });

                    // Buttons
                    var btnRefresh = document.getElementById('btnRefresh');
                    if (btnRefresh) {
                        btnRefresh.addEventListener('click', function () {
                            window.location.reload();
                        });
                    }
                    var btnMarkAll = document.getElementById('btnMarkAllRead');
                    if (btnMarkAll) {
                        btnMarkAll.addEventListener('click', function () {
                            markAsReadAll();
                        });
                    }
                    var btnLoadMore = document.getElementById('loadMoreBtn');
                    if (btnLoadMore) {
                        btnLoadMore.addEventListener('click', function () {
                            loadMoreNotifications();
                        });
                    }
                });
                // =================== CSS (inject) ===================
                (function injectStyles() {
                    var css =
                            '.notification-item{transition:all .2s ease;cursor:pointer;position:relative;}' +
                            '.notification-item.unread{background-color:#fff8f0!important;border-left:3px solid #ffc107!important;}' +
                            '.notification-item:hover:not(.unread){background-color:#fff8f0!important;transform:translateX(2px);}' +
                            '.notification-item:hover.unread{background-color:#fff0e6!important;transform:translateX(2px);}' +
                            '.notification-item .dropdown{position:static;}' +
                            '.notification-item .dropdown-menu{z-index:1050!important;position:absolute!important;' +
                            'box-shadow:0 .5rem 1rem rgba(0,0,0,.15)!important;border:1px solid rgba(0,0,0,.15)!important;background-color:#fff!important;}' +
                            '.notification-item .dropdown-toggle{position:relative;z-index:1051;}' +
                            '.notification-item .dropdown-toggle::after{display:none;}' +
                            '.dropdown-item{display:block!important;width:100%!important;padding:.375rem 1rem!important;clear:both!important;' +
                            'font-weight:400!important;color:#212529!important;text-align:inherit!important;white-space:nowrap!important;' +
                            'background-color:transparent!important;border:0!important;transition:all .15s ease-in-out!important;}' +
                            '.dropdown-item:hover,.dropdown-item:focus{background-color:#f8f9fa!important;color:#1e2125!important;}' +
                            '.dropdown-item.text-danger:hover{background-color:#dc3545!important;color:#fff!important;}' +
                            '@media (max-width:768px){.notification-item .d-flex{flex-direction:column;}.notification-item .flex-shrink-0{align-self:center;margin-bottom:10px;}}';
                    var style = document.createElement('style');
                    style.type = 'text/css';
                    if (style.styleSheet) {
                        style.styleSheet.cssText = css;
                    } else {
                        style.appendChild(document.createTextNode(css));
                    }
                    document.head.appendChild(style);
                })();
            </script>
        </body>
    </html>
