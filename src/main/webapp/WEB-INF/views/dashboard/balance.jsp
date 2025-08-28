<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@include file="include/head.jsp" %>
<html>
<body style="background: linear-gradient(135deg, #fff5f0 0%, #ffffff 100%);">
<div class="container-fluid">
    <div class="row g-0">
        <!-- Sidebar -->
        <%@include file="include/sidebar.jsp" %>

        <!-- Notification Modal -->
        <c:if test="${not empty withdrawError}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const modal = new bootstrap.Modal(document.getElementById("withdrawModal"));
                    modal.show();
                    const errorDiv = document.createElement("div");
                    errorDiv.className = "alert alert-danger mt-2";
                    errorDiv.innerText = "${withdrawError}";
                    document.querySelector("#withdrawForm .modal-body").prepend(errorDiv);
                });
            </script>
        </c:if>

        <div class="modal fade" id="notificationModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 shadow-lg">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title">Thông báo</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <c:if test="${not empty msgSuccess}">
                            <div class="alert alert-success mb-2">${msgSuccess}</div>
                        </c:if>
                        <c:if test="${not empty msgError}">
                            <div class="alert alert-danger mb-2">${msgError}</div>
                        </c:if>
                        <c:if test="${not empty msgWarning}">
                            <div class="alert alert-warning mb-2">${msgWarning}</div>
                        </c:if>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const hasMessage =
                    document.querySelector(".alert-success") ||
                    document.querySelector(".alert-danger") ||
                    document.querySelector(".alert-warning");
                if (hasMessage) {
                    const modal = new bootstrap.Modal(document.getElementById("notificationModal"));
                    modal.show();
                }
            });
        </script>

        <!-- Main Content -->
        <main class="col-12 col-lg-9 col-xl-10 p-4">
            <!-- Header Section -->
            <div class="mb-4">
                <div class="d-flex flex-column flex-lg-row justify-content-between align-items-start align-items-lg-center gap-3">
                    <div>
                        <h2 class="h3 mb-2 text-dark">
                            <i class="bi bi-wallet2 text-warning me-2"></i>Số dư của tôi
                        </h2>
                        <p class="text-muted mb-2">Quản lý ví, theo dõi thu nhập và giám sát giao dịch</p>

                    </div>
                    <div class="d-flex gap-2 flex-wrap">
                        <button class="btn btn-warning text-white" data-bs-toggle="modal"
                                data-bs-target="#depositModal">
                            <i class="bi bi-plus-lg me-1"></i>Nạp tiền
                        </button>
                    </div>
                </div>
            </div>

            <!-- Balance Overview Cards -->
            <div class="row g-4 mb-4">
                <!-- Available Balance -->
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-body p-4">
                            <div class="d-flex align-items-start justify-content-between mb-3">
                                <div class="d-flex align-items-center">
                                    <div class="bg-success bg-opacity-15 p-3 rounded-3 me-3">
                                        <i class="bi bi-wallet2 text-success fs-4"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-1 text-dark fw-semibold">Số dư khả dụng</h6>
                                        <small class="text-muted">Sẵn sàng sử dụng</small>
                                    </div>
                                </div>
                                <span class="badge bg-success bg-opacity-20  px-2 py-1">Khả dụng</span>
                            </div>
                            <h3 class="h2 text-success fw-bold mb-3">
                                <fmt:formatNumber value="${wallet.balanceAvailable}" type="number"
                                                  minFractionDigits="2"/>₫
                            </h3>
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <small class="text-muted">VND</small>
                            </div>
                            <div class="d-grid gap-2">
                                <button class="btn btn-success btn-sm" data-bs-toggle="modal"
                                        data-bs-target="#withdrawModal">
                                    <i class="bi bi-download me-1"></i>Rút tiền
                                </button>
                                <button class="btn btn-outline-success btn-sm" data-bs-toggle="modal"
                                        data-bs-target="#depositModal">
                                    <i class="bi bi-send me-1"></i>Nạp tiền
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Frozen Balance -->
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-body p-4">
                            <div class="d-flex align-items-start justify-content-between mb-3">
                                <div class="d-flex align-items-center">
                                    <div class="bg-warning bg-opacity-15 p-3 rounded-3 me-3">
                                        <i class="bi bi-lock text-warning fs-4"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-1 text-dark fw-semibold">Số dư bị đóng băng</h6>
                                        <small class="text-muted">Tạm thời giữ lại</small>
                                    </div>
                                </div>
                                <span class="badge bg-warning bg-opacity-20 px-2 py-1">Đóng băng</span>
                            </div>
                            <h3 class="h2 text-warning fw-bold mb-3">
                                <fmt:formatNumber value="${wallet.balanceFrozen}" type="number" minFractionDigits="2"/>₫
                            </h3>
                            <div class="mb-3">
                                <small class="text-muted d-block mb-2">Lý do đóng băng</small>
                                <small class="text-dark">Đang xử lý giao dịch</small>
                            </div>
                            <button class="btn btn-warning btn-sm w-100" data-bs-toggle="modal"
                                    data-bs-target="#frozenDetailsModal">
                                <i class="bi bi-info-circle me-1"></i>Xem chi tiết
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Total Earnings -->
                <div class="col-12 col-lg-4">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-body p-4">
                            <div class="d-flex align-items-start justify-content-between mb-3">
                                <div class="d-flex align-items-center">
                                    <div class="bg-primary bg-opacity-15 p-3 rounded-3 me-3">
                                        <i class="bi bi-graph-up-arrow text-primary fs-4"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-1 text-dark fw-semibold">Tổng thu nhập</h6>
                                        <small class="text-muted">Tổng thu nhập toàn thời gian</small>
                                    </div>
                                </div>
                                <span class="badge bg-primary bg-opacity-20 px-2 py-1">Cả đời</span>
                            </div>
                            <h3 class="h2 text-primary fw-bold mb-3">
                                <fmt:formatNumber value="${wallet.totalEarning}" type="number" minFractionDigits="2"/>₫
                            </h3>
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <small class="text-muted">Tháng này: 10.500.000₫</small>
                                <small class="text-primary">
                                    <i class="bi bi-arrow-up me-1"></i>+12.5%
                                </small>
                            </div>
                            <div class="d-grid gap-2">
                                <button class="btn btn-primary btn-sm">
                                    <i class="bi bi-bar-chart me-1"></i>Xem báo cáo
                                </button>
                                <button class="btn btn-outline-primary btn-sm">
                                    <i class="bi bi-download me-1"></i>Báo cáo thuế
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Balance Breakdown Chart -->
            <div class="row g-4 mb-4">
                <div class="col-12 col-lg-5">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-header bg-transparent border-0 p-4 pb-2">
                            <h5 class="mb-0">
                                <i class="bi bi-pie-chart text-info me-2"></i>Phân bổ số dư
                            </h5>
                        </div>
                        <div class="card-body p-4">
                            <c:set var="totalBalance" value="${wallet.balanceAvailable + wallet.balanceFrozen}"/>
                            <c:if test="${totalBalance > 0}">
                                <c:set var="availablePercent"
                                       value="${(wallet.balanceAvailable * 100.0) / totalBalance}"/>
                                <c:set var="frozenPercent" value="${(wallet.balanceFrozen * 100.0) / totalBalance}"/>
                            </c:if>

                            <!-- Available Balance Progress -->
                            <div class="mb-4">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-success rounded-circle me-2"
                                             style="width: 10px; height: 10px;"></div>
                                        <span class="text-dark fw-medium">Khả dụng</span>
                                    </div>
                                    <span class="fw-bold text-success">
                                        <fmt:formatNumber value="${availablePercent}" maxFractionDigits="1"/>%
                                    </span>
                                </div>
                                <div class="progress mb-2" style="height: 8px;">
                                    <div class="progress-bar bg-success"
                                         style="width: <fmt:formatNumber value='${availablePercent}'
                                                                         maxFractionDigits='1'/>%">
                                    </div>
                                </div>
                                <small class="text-muted">
                                    <fmt:formatNumber value="${wallet.balanceAvailable}" pattern="#,###"/>₫
                                </small>
                            </div>

                            <!-- Frozen Balance Progress -->
                            <div class="mb-4">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-warning rounded-circle me-2"
                                             style="width: 10px; height: 10px;"></div>
                                        <span class="text-dark fw-medium">Đóng băng</span>
                                    </div>
                                    <span class="fw-bold text-warning">
                                        <fmt:formatNumber value="${frozenPercent}" maxFractionDigits="1"/>%
                                    </span>
                                </div>
                                <div class="progress mb-2" style="height: 8px;">
                                    <div class="progress-bar bg-warning"
                                         style="width: <fmt:formatNumber value='${frozenPercent}'
                                                                         maxFractionDigits='1'/>%">
                                    </div>
                                </div>
                                <small class="text-muted">
                                    <fmt:formatNumber value="${wallet.balanceFrozen}" pattern="#,###"/>₫
                                </small>
                            </div>

                            <!-- Total Balance -->
                            <div class="text-center mt-4 pt-3 border-top">
                                <h4 class="fw-bold text-dark mb-1">
                                    <fmt:formatNumber value="${totalBalance}" pattern="#,###"/>₫
                                </h4>
                                <small class="text-muted">Tổng số dư</small>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Stats -->
                <div class="col-12 col-lg-7">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-header bg-transparent border-0 p-4 pb-2">
                            <h5 class="mb-0">
                                <i class="bi bi-speedometer2 text-primary me-2"></i>Thống kê nhanh
                            </h5>
                        </div>
                        <div class="card-body p-4">
                            <div class="row g-3">
                                <div class="col-6 col-lg-4">
                                    <div class="text-center p-3 bg-light rounded-3">
                                        <i class="bi bi-arrow-up-circle text-success fs-3 mb-2"></i>
                                        <div class="fw-bold text-success">
                                            <c:set var="depositCount" value="0"/>
                                            <c:forEach var="txn" items="${transactions}">
                                                <c:if test="${txn.type eq 'DEPOSIT'}">
                                                    <c:set var="depositCount" value="${depositCount + 1}"/>
                                                </c:if>
                                            </c:forEach>
                                            ${depositCount}
                                        </div>
                                        <small class="text-muted">Giao dịch nạp</small>
                                    </div>
                                </div>
                                <div class="col-6 col-lg-4">
                                    <div class="text-center p-3 bg-light rounded-3">
                                        <i class="bi bi-arrow-down-circle text-danger fs-3 mb-2"></i>
                                        <div class="fw-bold text-danger">
                                            <c:set var="withdrawCount" value="0"/>
                                            <c:forEach var="txn" items="${transactions}">
                                                <c:if test="${txn.type eq 'WITHDRAW'}">
                                                    <c:set var="withdrawCount" value="${withdrawCount + 1}"/>
                                                </c:if>
                                            </c:forEach>
                                            ${withdrawCount}
                                        </div>
                                        <small class="text-muted">Giao dịch rút</small>
                                    </div>
                                </div>
                                <div class="col-12 col-lg-4">
                                    <div class="text-center p-3 bg-light rounded-3">
                                        <i class="bi bi-clock text-warning fs-3 mb-2"></i>
                                        <div class="fw-bold text-warning">
                                            <c:set var="pendingCount" value="0"/>
                                            <c:forEach var="txn" items="${transactions}">
                                                <c:if test="${txn.status eq 'PENDING'}">
                                                    <c:set var="pendingCount" value="${pendingCount + 1}"/>
                                                </c:if>
                                            </c:forEach>
                                            ${pendingCount}
                                        </div>
                                        <small class="text-muted">Đang xử lý</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Transaction History -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-transparent border-0 p-4">
                    <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center gap-3">
                        <div>
                            <h5 class="mb-1">
                                <i class="bi bi-clock-history text-primary me-2"></i>Lịch sử giao dịch
                            </h5>
                            <p class="text-muted small mb-0">Theo dõi tất cả các giao dịch của bạn</p>
                        </div>
                        <div class="d-flex gap-2 flex-wrap">
                            <select class="form-select form-select-sm" style="width: auto;">
                                <option>Tất cả loại</option>
                                <option>DEPOSIT</option>
                                <option>WITHDRAW</option>
                                <option>FROZEN</option>
                            </select>
                            <button class="btn btn-outline-primary btn-sm">
                                <i class="bi bi-funnel me-1"></i>Lọc
                            </button>
                        </div>
                    </div>
                </div>

                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                            <tr>
                                <th class="ps-4 py-3 border-0">ID</th>
                                <th class="py-3 border-0">Ngày & Giờ</th>
                                <th class="py-3 border-0">Loại</th>
                                <th class="py-3 border-0">Mô tả</th>
                                <th class="py-3 border-0 text-end">Số tiền</th>
                                <th class="py-3 border-0">Trạng thái</th>
                                <th class="py-3 border-0">Cập nhật</th>
                                <th class="pe-4 py-3 border-0 text-end">Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="txn" items="${transactions}">
                                <tr>
                                    <td class="ps-4 py-3">
                                        <span class="badge bg-primary bg-opacity-15  fw-medium">#${txn.id}</span>
                                    </td>
                                    <td class="py-3">
                                        <div class="fw-semibold text-dark">
                                            <fmt:formatDate value="${txn.createdAt}" pattern="dd MMM, yyyy"/>
                                        </div>
                                        <small class="text-muted">
                                            <fmt:formatDate value="${txn.createdAt}" pattern="hh:mm a"/>
                                        </small>
                                    </td>
                                    <td class="py-3">
                                        <c:choose>
                                            <c:when test="${txn.type eq 'DEPOSIT'}">
                                                <span class="badge bg-success bg-opacity-15  px-2 py-1">
                                                    <i class="bi bi-arrow-down-circle me-1"></i>Nạp tiền
                                                </span>
                                            </c:when>
                                            <c:when test="${txn.type eq 'WITHDRAW'}">
                                                <span class="badge bg-danger bg-opacity-15  px-2 py-1">
                                                    <i class="bi bi-arrow-up-circle me-1"></i>Rút tiền
                                                </span>
                                            </c:when>
                                            <c:when test="${txn.type eq 'FROZEN'}">
                                                <span class="badge bg-warning bg-opacity-15  px-2 py-1">
                                                    <i class="bi bi-lock me-1"></i>Đóng băng
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-info bg-opacity-15  px-2 py-1">${txn.type}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="py-3">
                                        <span class="text-dark" title="${txn.notes}">${fn:substring(txn.notes, 0, 30)}
                                            <c:if test="${fn:length(txn.notes) > 30}">...</c:if></span>
                                    </td>
                                    <td class="py-3 text-end">
                                        <c:choose>
                                            <c:when test="${txn.type eq 'WITHDRAW' or txn.type eq 'FROZEN'}">
                                                <span class="fw-bold text-danger">
                                                    -<fmt:formatNumber value="${txn.amount}" pattern="#,###"/>₫
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="fw-bold text-success">
                                                    +<fmt:formatNumber value="${txn.amount}" pattern="#,###"/>₫
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="py-3">
                                        <c:choose>
                                            <c:when test="${txn.status eq 'COMPLETED' or txn.status eq 'SUCCESS' or txn.status eq 'DONE'}">
                                                <span class="badge bg-success">Hoàn thành</span>
                                            </c:when>
                                            <c:when test="${txn.status eq 'APPROVED'}">
                                                <span class="badge bg-primary">Đã duyệt</span>
                                            </c:when>
                                            <c:when test="${txn.status eq 'PENDING'}">
                                                <span class="badge bg-warning">Chờ xử lý</span>
                                            </c:when>
                                            <c:when test="${txn.status eq 'FAILED' or txn.status eq 'ERROR'}">
                                                <span class="badge bg-danger">Thất bại</span>
                                            </c:when>
                                            <c:when test="${txn.status eq 'REJECTED'}">
                                                <span class="badge bg-danger">Bị từ chối</span>
                                            </c:when>
                                            <c:when test="${txn.status eq 'CANCELLED'}">
                                                <span class="badge bg-secondary">Đã hủy</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-dark">${txn.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="py-3">
                                        <c:if test="${txn.updatedAt != null}">
                                            <div class="small text-muted">
                                                <fmt:formatDate value="${txn.updatedAt}" pattern="dd/MM"/>
                                            </div>
                                            <div class="small text-muted">
                                                <fmt:formatDate value="${txn.updatedAt}" pattern="HH:mm"/>
                                            </div>
                                        </c:if>
                                    </td>
                                    <td class="pe-4 py-3 text-end">
                                        <div class="btn-group btn-group-sm">
                                            <button class="btn btn-outline-primary btn-sm" title="Xem hóa đơn">
                                                <i class="bi bi-receipt"></i>
                                            </button>
                                            <button class="btn btn-outline-secondary btn-sm" title="Thêm thao tác">
                                                <i class="bi bi-three-dots-vertical"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                        <c:if test="${empty transactions}">
                            <div class="text-center py-5">
                                <i class="bi bi-clock-history text-muted display-4"></i>
                                <h5 class="text-muted mt-3">Chưa có giao dịch nào</h5>
                                <p class="text-muted">Các giao dịch của bạn sẽ hiển thị tại đây</p>
                            </div>
                        </c:if>
                    </div>

                    <!-- Transaction Pagination -->
                    <c:if test="${not empty transactions}">
                        <div class="px-4 py-3 border-top bg-light">
                            <div class="d-flex flex-column flex-md-row justify-content-between align-items-center gap-2">
                                <div class="d-flex align-items-center gap-3">
                                    <small class="text-muted">
                                        Hiển thị trang ${txCurrentPage} / ${txTotalPages}
                                    </small>
                                    <small class="text-muted">
                                        Tổng cộng ${txTotalElements} giao dịch
                                    </small>
                                </div>
                                <nav aria-label="Transaction pagination">
                                    <ul class="pagination pagination-sm mb-0">
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="?page=${currentPage-1}&size=10">
                                                <i class="bi bi-chevron-left"></i>
                                            </a>
                                        </li>
                                        <c:if test="${totalPages <= 7}">
                                            <c:forEach var="i" begin="1" end="${totalPages}">
                                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                    <a class="page-link" href="?page=${i}&size=10">${i}</a>
                                                </li>
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${totalPages > 7}">
                                            <li class="page-item ${currentPage == 1 ? 'active' : ''}">
                                                <a class="page-link" href="?page=1&size=10">1</a>
                                            </li>
                                            <c:if test="${currentPage > 4}">
                                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                            </c:if>
                                            <c:set var="beginPage" value="${currentPage-2}"/>
                                            <c:set var="endPage" value="${currentPage+2}"/>
                                            <c:forEach var="i" begin="${beginPage}" end="${endPage}">
                                                <c:if test="${i > 1 && i < totalPages}">
                                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                        <a class="page-link" href="?page=${i}&size=10">${i}</a>
                                                    </li>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${currentPage < totalPages-3}">
                                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                            </c:if>
                                            <li class="page-item ${currentPage == totalPages ? 'active' : ''}">
                                                <a class="page-link"
                                                   href="?page=${totalPages}&size=10">${totalPages}</a>
                                            </li>
                                        </c:if>
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="?page=${currentPage+1}&size=10">
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

            <!-- Withdraw Requests -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-transparent border-0 p-4">
                    <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center gap-3">
                        <div>
                            <h5 class="mb-1">
                                <i class="bi bi-arrow-down-circle text-danger me-2"></i>Yêu cầu rút tiền
                            </h5>
                            <p class="text-muted small mb-0">Danh sách yêu cầu rút tiền gần đây</p>
                        </div>
                        <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#withdrawModal">
                            <i class="bi bi-plus-lg me-1"></i>Tạo yêu cầu
                        </button>
                    </div>
                </div>

                <div class="card-body p-0">
                    <c:choose>
                        <c:when test="${not empty withdrawRequests}">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-light">
                                    <tr>
                                        <th class="ps-4 py-3 border-0">ID</th>
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
                                        <tr>
                                            <td class="ps-4 py-3">
                                                <span class="badge bg-danger bg-opacity-15 fw-medium">#WD${withdraw.id}</span>
                                            </td>
                                            <td class="py-3">
                                                <div class="fw-semibold text-dark">
                                                    <fmt:formatDate value="${withdraw.createdAtDate}"
                                                                    pattern="dd/MM/yyyy"/>
                                                </div>
                                                <small class="text-muted">
                                                    <fmt:formatDate value="${withdraw.createdAtDate}" pattern="HH:mm"/>
                                                </small>
                                            </td>
                                            <td class="py-3 text-end fw-bold text-danger">
                                                <fmt:formatNumber value="${withdraw.amount}" pattern="#,###"/>₫
                                            </td>
                                            <td class="py-3">
                                                <c:choose>
                                                    <c:when test="${withdraw.method eq 'BANK'}">
                                                        <span class="badge bg-primary bg-opacity-15  px-2 py-1">
                                                            <i class="bi bi-bank me-1"></i>Ngân hàng
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${withdraw.method eq 'QR'}">
                                                        <span class="badge bg-info bg-opacity-15  px-2 py-1">
                                                            <i class="bi bi-qr-code me-1"></i>QR Code
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">${withdraw.method}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="py-3">
                                                <div class="fw-semibold text-dark">${withdraw.bankName}</div>
                                                <div class="small text-muted">${withdraw.accountName}</div>
                                                <div class="small text-muted">
                                                    ***${fn:substring(withdraw.accountNumber, fn:length(withdraw.accountNumber)-4, fn:length(withdraw.accountNumber))}
                                                </div>
                                            </td>
                                            <td class="py-3">
                                                <c:choose>
                                                    <c:when test="${withdraw.status eq 'PENDING'}">
                                                        <span class="badge bg-warning">Chờ duyệt</span>
                                                    </c:when>
                                                    <c:when test="${withdraw.status eq 'APPROVED'}">
                                                        <span class="badge bg-info">Đã duyệt</span>
                                                    </c:when>
                                                    <c:when test="${withdraw.status eq 'DONE'}">
                                                        <span class="badge bg-success">Hoàn thành</span>
                                                    </c:when>
                                                    <c:when test="${withdraw.status eq 'REJECTED'}">
                                                        <span class="badge bg-danger">Từ chối</span>
                                                    </c:when>
                                                    <c:when test="${withdraw.status eq 'CANCELLED'}">
                                                        <span class="badge bg-secondary">Đã hủy</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">${withdraw.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="pe-4 py-3 text-end">
                                                <div class="btn-group btn-group-sm">
                                                    <button class="btn btn-outline-primary btn-sm view-detail-btn"
                                                            data-id="${withdraw.id}"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#withdrawDetailModal"
                                                            title="Xem chi tiết">
                                                        <i class="bi bi-eye"></i>
                                                    </button>
                                                    <c:if test="${withdraw.status eq 'PENDING'}">
                                                        <form method="post"
                                                              action="${pageContext.request.contextPath}/withdraws/${withdraw.id}/cancel"
                                                              style="display:inline">
                                                            <button class="btn btn-outline-warning btn-sm"
                                                                    title="Hủy yêu cầu"
                                                                    onclick="return confirm('Bạn có chắc chắn muốn hủy yêu cầu này?')">
                                                                <i class="bi bi-x-lg"></i>
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Withdraw Pagination -->
                            <div class="px-4 py-3 border-top bg-light">
                                <div class="d-flex flex-column flex-md-row justify-content-between align-items-center gap-2">
                                    <small class="text-muted">
                                        Trang ${withdrawCurrentPage} / ${withdrawTotalPages} — ${withdrawTotalElements}
                                        yêu cầu
                                    </small>
                                    <nav>
                                        <ul class="pagination pagination-sm mb-0">
                                            <li class="page-item ${withdrawCurrentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link"
                                                   href="?withdrawPage=${withdrawCurrentPage - 1}&withdrawSize=5">
                                                    <i class="bi bi-chevron-left"></i>
                                                </a>
                                            </li>
                                            <c:forEach var="i" begin="1" end="${withdrawTotalPages}">
                                                <li class="page-item ${i == withdrawCurrentPage ? 'active' : ''}">
                                                    <a class="page-link"
                                                       href="?withdrawPage=${i}&withdrawSize=5">${i}</a>
                                                </li>
                                            </c:forEach>
                                            <li class="page-item ${withdrawCurrentPage == withdrawTotalPages ? 'disabled' : ''}">
                                                <a class="page-link"
                                                   href="?withdrawPage=${withdrawCurrentPage + 1}&withdrawSize=5">
                                                    <i class="bi bi-chevron-right"></i>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <i class="bi bi-arrow-down-circle text-muted display-4 mb-3"></i>
                                <h5 class="text-muted">Chưa có yêu cầu rút tiền nào</h5>
                                <p class="text-muted mb-4">Tạo yêu cầu rút tiền để chuyển số dư về tài khoản ngân
                                    hàng</p>
                                <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#withdrawModal">
                                    <i class="bi bi-plus-lg me-2"></i>Tạo yêu cầu rút tiền
                                </button>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
    </div>
</div>

<!-- Modal includes -->
<%@include file="modal/deposit.jsp" %>
<%@include file="modal/withdraw.jsp" %>
<%@include file="modal/withdrawDetail.jsp" %>
<%@include file="modal/frozenDetail.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>

<script>
    // Initialize tooltips
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
    });

    // Add confirmation for cancel withdraw
    document.querySelectorAll('form[action*="/cancel"]').forEach(form => {
        form.addEventListener('submit', function (e) {
            if (!confirm('Bạn có chắc chắn muốn hủy yêu cầu rút tiền này?')) {
                e.preventDefault();
            }
        });
    });

    // Table row hover effects
    document.querySelectorAll('.table-hover tr').forEach(row => {
        row.addEventListener('mouseenter', function () {
            this.style.backgroundColor = 'var(--bs-gray-100)';
        });
        row.addEventListener('mouseleave', function () {
            this.style.backgroundColor = '';
        });
    });
</script>
</body>
</html>