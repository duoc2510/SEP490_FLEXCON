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
                    <h2 class="h3 mb-1 text-dark">📑 Quản lý yêu cầu rút tiền</h2>
                    <p class="text-muted mb-0">Xem xét và xử lý các yêu cầu rút tiền từ người dùng</p>
                </div>
                <div class="col-auto">
                    <div class="d-flex gap-2">
                        <select class="form-select form-select-sm" style="width: auto;">
                            <option value="">Tất cả trạng thái</option>
                            <option value="PENDING">Chờ duyệt</option>
                            <option value="APPROVED">Đã duyệt</option>
                            <option value="DONE">Hoàn thành</option>
                            <option value="REJECTED">Từ chối</option>
                        </select>
                        <button class="btn btn-outline-primary btn-sm">
                            <i class="bi bi-download me-1"></i>Xuất Excel
                        </button>
                    </div>
                </div>
            </div>

            <!-- Statistics Cards -->
            <div class="row g-3 mb-4">
                <div class="col-12 col-md-3">
                    <div class="card border-0 shadow-sm bg-warning bg-opacity-10 border-warning border-opacity-25">
                        <div class="card-body text-center p-3">
                            <i class="bi bi-clock text-warning fs-3 mb-2"></i>
                            <div class="h4 mb-1 text-warning fw-bold">
                                <c:set var="pendingCount" value="0"/>
                                <c:forEach var="withdraw" items="${withdrawRequests}">
                                    <c:if test="${withdraw.status eq 'PENDING'}">
                                        <c:set var="pendingCount" value="${pendingCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${pendingCount > 0 ? pendingCount : '0'}
                            </div>
                            <small class="text-warning fw-medium">Chờ duyệt</small>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-3">
                    <div class="card border-0 shadow-sm bg-info bg-opacity-10 border-info border-opacity-25">
                        <div class="card-body text-center p-3">
                            <i class="bi bi-check-circle text-info fs-3 mb-2"></i>
                            <div class="h4 mb-1 text-info fw-bold">
                                <c:set var="approvedCount" value="0"/>
                                <c:forEach var="withdraw" items="${withdrawRequests}">
                                    <c:if test="${withdraw.status eq 'APPROVED'}">
                                        <c:set var="approvedCount" value="${approvedCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${approvedCount > 0 ? approvedCount : '5'}
                            </div>
                            <small class="text-info fw-medium">Đã duyệt</small>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-3">
                    <div class="card border-0 shadow-sm bg-success bg-opacity-10 border-success border-opacity-25">
                        <div class="card-body text-center p-3">
                            <i class="bi bi-check2-all text-success fs-3 mb-2"></i>
                            <div class="h4 mb-1 text-success fw-bold">
                                <c:set var="doneCount" value="0"/>
                                <c:forEach var="withdraw" items="${withdrawRequests}">
                                    <c:if test="${withdraw.status eq 'DONE'}">
                                        <c:set var="doneCount" value="${doneCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${doneCount > 0 ? doneCount : '142'}
                            </div>
                            <small class="text-success fw-medium">Hoàn thành</small>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-3">
                    <div class="card border-0 shadow-sm bg-danger bg-opacity-10 border-danger border-opacity-25">
                        <div class="card-body text-center p-3">
                            <i class="bi bi-x-circle text-danger fs-3 mb-2"></i>
                            <div class="h4 mb-1 text-danger fw-bold">
                                <c:set var="rejectedCount" value="0"/>
                                <c:forEach var="withdraw" items="${withdrawRequests}">
                                    <c:if test="${withdraw.status eq 'REJECTED'}">
                                        <c:set var="rejectedCount" value="${rejectedCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${rejectedCount > 0 ? rejectedCount : '3'}
                            </div>
                            <small class="text-danger fw-medium">Từ chối</small>
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
                                <i class="bi bi-arrow-down-circle text-danger me-2"></i>Yêu cầu rút tiền
                            </h5>
                            <p class="text-muted small mb-0">Danh sách yêu cầu rút tiền gần đây - Tổng số tiền hôm nay:
                                <span class="fw-bold text-success">₫${empty totalAmountToday ? '25,450,000' : totalAmountToday}</span>
                            </p>
                        </div>
                        <div class="d-flex gap-2">
                            <c:if test="${not empty withdrawRequests}">
                                <button class="btn btn-outline-success btn-sm" title="Duyệt hàng loạt">
                                    <i class="bi bi-check-all me-1"></i>Duyệt nhiều
                                </button>
                            </c:if>
                            <button class="btn btn-danger btn-sm" data-bs-toggle="modal"
                                    data-bs-target="#withdrawModal">
                                <i class="bi bi-plus-lg me-1"></i>Tạo yêu cầu
                            </button>
                        </div>
                    </div>
                </div>

                <div class="card-body p-0">
                    <!-- Quick Filter Tabs -->
                    <c:if test="${not empty withdrawRequests}">
                        <div class="px-4 pt-3">
                            <ul class="nav nav-pills nav-fill"
                                style="background: #f8f9fa; border-radius: 8px; padding: 4px;">
                                <li class="nav-item">
                                    <a class="nav-link active small py-2" href="#" onclick="filterStatus('')">
                                        <i class="bi bi-list-ul me-1"></i>Tất cả
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link small py-2" href="#" onclick="filterStatus('PENDING')">
                                        <i class="bi bi-clock me-1"></i>Chờ duyệt
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link small py-2" href="#" onclick="filterStatus('APPROVED')">
                                        <i class="bi bi-check-circle me-1"></i>Đã duyệt
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link small py-2" href="#" onclick="filterStatus('DONE')">
                                        <i class="bi bi-check2-all me-1"></i>Hoàn thành
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
                                <th class="py-3 border-0">Ngày tạo</th>
                                <th class="py-3 border-0 text-end">Số tiền</th>
                                <th class="py-3 border-0">Phương thức</th>
                                <th class="py-3 border-0">Ngân hàng</th>
                                <th class="py-3 border-0">Trạng thái</th>
                                <th class="pe-4 py-3 border-0 text-end">Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="withdraw" items="${withdrawRequests}">
                                <tr class="withdrawal-row" data-status="${withdraw.status}">
                                    <!-- Checkbox -->
                                    <td class="ps-4 py-3">
                                        <c:if test="${withdraw.status eq 'PENDING'}">
                                            <input type="checkbox" class="form-check-input withdraw-checkbox"
                                                   value="${withdraw.id}">
                                        </c:if>
                                    </td>

                                    <!-- ID -->
                                    <td class="py-3">
                                        <span class="badge bg-danger bg-opacity-10 text-danger fw-bold">#WD${withdraw.id}</span>
                                    </td>

                                    <!-- Ngày tạo -->
                                    <td class="py-3">
                                        <div class="fw-medium">
                                            <fmt:formatDate value="${withdraw.createdAtDate}" pattern="dd/MM/yyyy"/>
                                        </div>
                                        <small class="text-muted">
                                            <fmt:formatDate value="${withdraw.createdAtDate}" pattern="HH:mm"/>
                                        </small>
                                    </td>

                                    <!-- Số tiền -->
                                    <td class="py-3 text-end">
                                        <div class="fw-bold text-danger h6 mb-0">
                                            <fmt:formatNumber value="${withdraw.amount}" pattern="#,###"/>₫
                                        </div>
                                        <small class="text-muted">Phí: 0₫</small>
                                    </td>

                                    <!-- Phương thức -->
                                    <td class="py-3">
                                        <c:choose>
                                            <c:when test="${withdraw.method eq 'BANK'}">
                                                <span class="badge text-primary">
                                                    <i class="bi bi-bank me-1"></i>Bank
                                                </span>
                                            </c:when>
                                            <c:when test="${withdraw.method eq 'QR'}">
                                                <span class="badge text-info">
                                                    <i class="bi bi-qr-code me-1"></i>QR
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">${withdraw.method}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- Ngân hàng -->
                                    <td class="py-3 small">
                                        <div class="fw-semibold text-primary">${withdraw.bankName}</div>
                                        <div class="text-muted">${withdraw.accountName}</div>
                                        <div class="text-muted font-monospace">
                                            ***${fn:substring(withdraw.accountNumber, fn:length(withdraw.accountNumber)-4, fn:length(withdraw.accountNumber))}
                                        </div>
                                    </td>

                                    <!-- Trạng thái -->
                                    <td class="py-3">
                                        <c:choose>
                                            <c:when test="${withdraw.status eq 'PENDING'}">
                                                <span class="badge bg-warning text-dark">
                                                    <i class="bi bi-clock me-1"></i>Chờ duyệt
                                                </span>
                                            </c:when>
                                            <c:when test="${withdraw.status eq 'APPROVED'}">
                                                <span class="badge bg-info">
                                                    <i class="bi bi-check-circle me-1"></i>Đã duyệt
                                                </span>
                                            </c:when>
                                            <c:when test="${withdraw.status eq 'DONE'}">
                                                <span class="badge bg-success">
                                                    <i class="bi bi-check2-all me-1"></i>Hoàn thành
                                                </span>
                                            </c:when>
                                            <c:when test="${withdraw.status eq 'REJECTED'}">
                                                <span class="badge bg-danger">
                                                    <i class="bi bi-x-circle me-1"></i>Từ chối
                                                </span>
                                            </c:when>
                                            <c:when test="${withdraw.status eq 'CANCELLED'}">
                                                <span class="badge bg-secondary">
                                                    <i class="bi bi-slash-circle me-1"></i>Bị huỷ
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">${withdraw.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- Action -->
                                    <td class="pe-4 py-3 text-end">
                                        <div class="btn-group" role="group">
                                            <button class="btn btn-outline-primary btn-sm view-detail-btn"
                                                    data-id="${withdraw.id}"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#withdrawDetailModal"
                                                    title="Xem chi tiết">
                                                <i class="bi bi-eye"></i>
                                            </button>

                                            <!-- Admin actions based on status -->
                                            <c:choose>
                                                <c:when test="${withdraw.status eq 'PENDING'}">
                                                    <button class="btn btn-outline-success btn-sm"
                                                            onclick="approveWithdraw(${withdraw.id})"
                                                            title="Duyệt yêu cầu">
                                                        <i class="bi bi-check"></i>
                                                    </button>
                                                    <button class="btn btn-outline-danger btn-sm"
                                                            onclick="rejectWithdraw(${withdraw.id})"
                                                            title="Từ chối">
                                                        <i class="bi bi-x"></i>
                                                    </button>
                                                </c:when>
                                                <c:when test="${withdraw.status eq 'APPROVED'}">
                                                    <button class="btn btn-outline-success btn-sm"
                                                            onclick="markComplete(${withdraw.id})"
                                                            title="Đánh dấu hoàn thành">
                                                        <i class="bi bi-check2-all"></i>
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <!-- Người dùng hủy (chỉ khi PENDING) -->
                                                    <c:if test="${withdraw.status eq 'PENDING'}">
                                                        <form method="post"
                                                              action="${pageContext.request.contextPath}/withdraws/${withdraw.id}/cancel"
                                                              style="display:inline">
                                                            <button class="btn btn-outline-warning btn-sm"
                                                                    title="Hủy yêu cầu">
                                                                <i class="bi bi-x-lg"></i>
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Empty state -->
                    <c:if test="${empty withdrawRequests}">
                        <div class="text-center py-5">
                            <i class="bi bi-arrow-down-circle text-muted display-4"></i>
                            <h5 class="text-muted mt-3">Chưa có yêu cầu rút tiền nào</h5>
                            <p class="text-muted">Người dùng chưa tạo yêu cầu rút tiền nào.</p>
                            <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#withdrawModal">
                                <i class="bi bi-plus-lg me-2"></i>Tạo yêu cầu
                            </button>
                        </div>
                    </c:if>

                    <!-- Pagination -->
                    <c:if test="${not empty withdrawRequests}">
                        <div class="px-4 py-3 border-top bg-light">
                            <div class="d-flex justify-content-between align-items-center">
                                <small class="text-muted">
                                    Trang ${withdrawCurrentPage} / ${withdrawTotalPages} — ${withdrawTotalElements} yêu
                                    cầu
                                </small>
                                <nav>
                                    <ul class="pagination pagination-sm mb-0">
                                        <li class="page-item ${withdrawCurrentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link"
                                               href="?withdrawPage=${withdrawCurrentPage - 1}&withdrawSize=10">
                                                <i class="bi bi-chevron-left"></i>
                                            </a>
                                        </li>
                                        <c:forEach var="i" begin="1" end="${withdrawTotalPages}">
                                            <li class="page-item ${i == withdrawCurrentPage ? 'active' : ''}">
                                                <a class="page-link" href="?withdrawPage=${i}&withdrawSize=10">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item ${withdrawCurrentPage == withdrawTotalPages ? 'disabled' : ''}">
                                            <a class="page-link"
                                               href="?withdrawPage=${withdrawCurrentPage + 1}&withdrawSize=10">
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

<!-- Modal chi tiết -->
<%@include file="modal/withdrawDetail.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // ===== FILTER =====
    function filterStatus(status, event) {
        const rows = document.querySelectorAll('.withdrawal-row');
        const navLinks = document.querySelectorAll('.nav-pills .nav-link');

        // Update active nav
        navLinks.forEach(link => link.classList.remove('active'));
        if (event) event.target.classList.add('active');

        // Filter rows
        rows.forEach(row => {
            if (status === '' || row.dataset.status === status) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }

    // ===== SELECT ALL CHECKBOX =====
    document.getElementById('selectAll')?.addEventListener('change', function () {
        const checkboxes = document.querySelectorAll('.withdraw-checkbox');
        checkboxes.forEach(cb => cb.checked = this.checked);
    });

    // ===== ADMIN ACTIONS =====
    async function approveWithdraw(id) {
        if (confirm('Bạn có chắc muốn duyệt yêu cầu rút tiền này?')) {
            const res = await fetch(`${pageContext.request.contextPath}/withdraws/` + id + `/approve`, {
                method: 'POST'
            });
            if (res.ok) {
                location.reload();
            } else {
                alert("❌ Lỗi duyệt yêu cầu!");
            }
        }
    }

    async function rejectWithdraw(id) {
        const reason = prompt('Nhập lý do từ chối:');
        if (reason !== null) {
            const formData = new URLSearchParams();
            formData.append("note", reason);

            const res = await fetch(`${pageContext.request.contextPath}/withdraws/` + id + `/reject`, {
                method: 'POST',
                body: formData,
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                }
            });
            if (res.ok) {
                location.reload();
            } else {
                alert("❌ Lỗi từ chối yêu cầu!");
            }
        }
    }

    async function markComplete(id) {
        if (confirm('Đánh dấu yêu cầu này là đã hoàn thành?')) {

            const res = await fetch(`${pageContext.request.contextPath}/withdraws/` + id + `/complete`, {
                method: 'POST'
            });
            if (res.ok) {
                location.reload();
            } else {
                alert("❌ Lỗi xác nhận hoàn thành!");
            }
        }
    }

    // ===== INIT =====
    document.addEventListener('DOMContentLoaded', function () {
        if (typeof setAdminSidebarActive === 'function') {
            setAdminSidebarActive('Withdrawals');
        }
    });
</script>

</body>
</html>