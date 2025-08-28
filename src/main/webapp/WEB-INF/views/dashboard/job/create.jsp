<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <%@include file="../include/head.jsp" %>
    <body style="background: linear-gradient(135deg, #fff5f0 0%, #ffffff 100%);">
        <div class="container-fluid">
            <div class="row g-0">
                <!-- Sidebar -->
                <%@include file="../include/sidebar.jsp" %>
                <!-- Main Content -->
                <main class="col-12 col-lg-9 col-xl-10 p-4">
                    <!-- Header -->
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h2 class="h3 mb-1 text-dark">
                                <i class="bi bi-plus-circle text-warning me-2"></i>Đăng Job Mới
                            </h2>
                            <p class="text-muted mb-0">Tạo dự án và tìm freelancer phù hợp</p>
                        </div>
                        <div class="d-flex align-items-center gap-3">
                            <!-- Nút chuyển sang trang nháp -->
                            <a href="<c:url value='/employer/draft'/>" class="btn btn-outline-secondary">
                                <i class="bi bi-folder2-open me-1"></i>Xem nháp
                            </a>

                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb mb-0">
                                    <li class="breadcrumb-item">
                                        <a href="#" class="text-warning text-decoration-none">Việc làm</a>
                                    </li>
                                    <li class="breadcrumb-item active">Tạo mới</li>
                                </ol>
                            </nav>
                        </div>
                    </div>

                    <!-- THÔNG BÁO THÀNH CÔNG/LỖI -->
                    <div id="notificationArea">
                        <!-- Flash message từ backend -->
                        <c:if test="${not empty success}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="bi bi-check-circle-fill me-2"></i>
                                <strong>Thành công!</strong> ${success}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                <strong>Lỗi!</strong> ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <!-- Thông báo lưu nháp thành công -->
                        <c:if test="${not empty draftSaved}">
                            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                <i class="bi bi-save-fill me-2"></i>
                                <strong>Đã lưu nháp!</strong> ${draftMessage}
                                <a href="<c:url value='/employer/drafts'/>" class="alert-link ms-2">
                                    <i class="bi bi-folder2-open"></i> Xem danh sách nháp
                                </a>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                    </div>

                    <!-- Dynamic Success Notification (JavaScript) -->
                    <div id="dynamicNotification" class="d-none">
                        <div class="alert alert-dismissible fade show" role="alert">
                            <i class="bi me-2"></i>
                            <span id="notificationMessage"></span>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </div>

                    <div class="row justify-content-center">
                        <div class="col-12 col-xl-10">
                            <!-- Progress Steps -->
                            <div class="card border-0 shadow-sm mb-4">
                                <div class="card-body p-4">
                                    <div class="row text-center">
                                        <div class="col-3">
                                            <div class="position-relative">
                                                <div class="bg-warning text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-2" style="width: 40px; height: 40px;">
                                                    <i class="bi bi-1-circle"></i>
                                                </div>
                                                <div class="small fw-bold text-warning">Thông tin cơ bản</div>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="position-relative">
                                                <div class="bg-light text-muted rounded-circle d-inline-flex align-items-center justify-content-center mb-2" style="width: 40px; height: 40px;">
                                                    <i class="bi bi-2-circle"></i>
                                                </div>
                                                <div class="small text-muted">Ngân sách & Thời gian</div>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="position-relative">
                                                <div class="bg-light text-muted rounded-circle d-inline-flex align-items-center justify-content-center mb-2" style="width: 40px; height: 40px;">
                                                    <i class="bi bi-3-circle"></i>
                                                </div>
                                                <div class="small text-muted">Yêu cầu</div>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="position-relative">
                                                <div class="bg-light text-muted rounded-circle d-inline-flex align-items-center justify-content-center mb-2" style="width: 40px; height: 40px;">
                                                    <i class="bi bi-4-circle"></i>
                                                </div>
                                                <div class="small text-muted">Xem lại & Đăng</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <form id="jobForm" action="<c:url value='/employer/job/create'/>" method="POST" novalidate>
                                <div class="row g-4">
                                    <!-- Main Form -->
                                    <div class="col-lg-8">
                                        <!-- Basic Information -->
                                        <div class="card border-0 shadow-sm mb-4">
                                            <div class="card-header bg-transparent border-0 p-4">
                                                <h5 class="mb-0">
                                                    <i class="bi bi-info-circle text-warning me-2"></i>Thông tin cơ bản
                                                </h5>
                                            </div>
                                            <div class="card-body p-4">
                                                <input type="hidden" name="employerId" value="${sessionScope.userId}"/>
                                                <input type="hidden" name="currency" value="VND"/>

                                                <div class="mb-4">
                                                    <label class="form-label fw-medium">Tiêu đề công việc <span class="text-danger">*</span></label>
                                                    <input type="text" name="title"
                                                           class="form-control form-control-lg ${not empty fieldErrors.titleError ? 'is-invalid' : ''}"
                                                           placeholder="VD: Phát triển website bán hàng"
                                                           maxlength="150" required
                                                           value="${oldTitle}">

                                                    <div class="form-text">
                                                        <i class="bi bi-info-circle me-1"></i>
                                                        5–150 ký tự. Hãy nêu cụ thể và rõ ràng nhu cầu của bạn.
                                                    </div>

                                                    <c:if test="${not empty fieldErrors.titleError}">
                                                        <div class="invalid-feedback d-block">
                                                            ${fieldErrors.titleError}
                                                        </div>
                                                    </c:if>
                                                </div>

                                                <!-- Job Type -->
                                                <div class="mb-4">
                                                    <label class="form-label fw-medium">Phân loại job <span class="text-danger">*</span></label>
                                                    <select class="form-select" name="type" id="jobTypeSelect" required>
                                                        <option value="">-- Chọn --</option>
                                                        <option value="BIDDING" ${oldType eq 'BIDDING' ? 'selected' : ''}>ĐẤU THẦU (BIDDING)</option>
                                                        <option value="CONTEST" ${oldType eq 'CONTEST' ? 'selected' : ''}>THI TUYỂN (CONTEST)</option>
                                                        <option value="MICROTASK" ${oldType eq 'MICROTASK' ? 'selected' : ''}>TASK NHỎ (MICROTASK)</option>
                                                    </select>
                                                    <div class="invalid-feedback">Vui lòng chọn phân loại job.</div>
                                                </div>


                                                <div class="mb-4">
                                                    <label class="form-label fw-medium">Mô tả dự án <span class="text-danger">*</span></label>
                                                    <textarea name="description"
                                                              rows="6"
                                                              class="form-control ${not empty fieldErrors.descriptionError ? 'is-invalid' : ''}"
                                                              placeholder="Mô tả chi tiết mục tiêu, phạm vi, đầu ra mong đợi, công nghệ sử dụng, yêu cầu cụ thể..."
                                                              maxlength="5000"
                                                              required>${oldDescription}</textarea>

                                                    <div class="d-flex justify-content-between">
                                                        <div class="form-text">
                                                            <i class="bi bi-info-circle me-1"></i>Tối thiểu 30 ký tự. Không chứa email/điện thoại/link ngoài.
                                                        </div>
                                                        <small class="text-muted"><span id="charCount">${fn:length(oldDescription)}</span>/5000</small>
                                                    </div>

                                                    <c:if test="${not empty fieldErrors.descriptionError}">
                                                        <div class="invalid-feedback d-block">
                                                            ${fieldErrors.descriptionError}
                                                        </div>
                                                    </c:if>
                                                </div>
                                                <!-- Currency (plaintext) & Deadline -->
                                                <div class="row g-3 mb-4">
                                                    <div class="col-md-6">
                                                        <label class="form-label fw-medium">Tiền tệ</label>
                                                        <div class="form-control-plaintext">VND (₫)</div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="form-label fw-medium">
                                                            Hạn chót nhận hồ sơ <span class="text-danger">*</span>
                                                        </label>
                                                        <input type="date"
                                                               name="deadline_at"
                                                               class="form-control ${not empty fieldErrors.deadlineError ? 'is-invalid' : ''}"
                                                               required
                                                               value="${oldDeadline}">

                                                        <div class="form-text">
                                                            <i class="bi bi-calendar me-1"></i>Nhận proposal đến hết ngày này (tối đa +12 tháng).
                                                        </div>

                                                        <c:if test="${not empty fieldErrors.deadlineError}">
                                                            <div class="invalid-feedback d-block">
                                                                ${fieldErrors.deadlineError}
                                                            </div>
                                                        </c:if>
                                                    </div>
                                                </div>

                                                <!-- Public switch -->
                                                <div class="mb-2">
                                                    <div class="form-check form-switch">
                                                        <input class="form-check-input" type="checkbox" name="is_public" id="isPublicSwitch" checked>
                                                        <label class="form-check-label fw-medium" for="isPublicSwitch">Hiển thị công khai trên marketplace</label>
                                                        <div class="form-text">TRUE: hiển thị công khai; FALSE: ẩn.</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- BIDDING configuration -->
                                        <div class="card border-0 shadow-sm mb-4 d-none" id="biddingConfig">
                                            <div class="card-header bg-transparent border-0 p-4">
                                                <h5 class="mb-0">
                                                    <i class="bi bi-currency-dollar text-warning me-2"></i>Cấu hình Đấu thầu
                                                </h5>
                                            </div>
                                            <div class="card-body p-4">
                                                <div class="row g-3 mb-3">
                                                    <div class="col-md-6">
                                                        <label class="form-label">Chế độ chọn freelancer <span class="text-danger">*</span></label>
                                                        <select class="form-select" name="selection_mode" id="selectionMode">
                                                            <option value="MANUAL" ${oldSelectionMode eq 'MANUAL' ? 'selected' : ''}>MANUAL (Thủ công)</option>
                                                            <option value="LOWEST_BID" ${oldSelectionMode eq 'LOWEST_BID' ? 'selected' : ''}>LOWEST_BID (Giá thấp nhất)</option>
                                                        </select>
                                                        <div class="invalid-feedback">Chế độ chọn không hợp lệ.</div>
                                                    </div>
                                                    <div class="col-md-6" id="deviationContainer">
                                                        <label class="form-label">% lệch giá cho auto-select <span id="deviationRequired" class="text-danger d-none">*</span></label>
                                                        <input type="number" class="form-control"
                                                               name="bid_deviation_pct"
                                                               id="bidDeviationPct"
                                                               placeholder="VD: 10" min="5" max="30"
                                                               value="${oldBidDeviationPct}">
                                                        <div class="form-text">Với LOWEST_BID: bắt buộc 5–30%.</div>
                                                        <div class="invalid-feedback">Với LOWEST_BID, % lệch giá phải từ 5 đến 30.</div>
                                                    </div>
                                                </div>
                                                <div class="mb-2">
                                                    <label class="form-label">Ngân sách tối đa 
                                                        <span id="budgetRequired" class="text-danger d-none">*</span>
                                                    </label>
                                                    <input type="text"
                                                           class="form-control ${not empty fieldErrors.budgetError ? 'is-invalid' : ''}"
                                                           id="budgetDisplay"
                                                           placeholder="VD: 2.000.000"
                                                           inputmode="numeric"
                                                           value="${oldBudget != null ? oldBudget : ''}">
                                                    <input type="hidden" name="budget" id="budgetInput" value="${oldBudget}">

                                                    <div class="form-text">
                                                        VND: tối thiểu 1.000. Với LOWEST_BID: bắt buộc và là mức trần.
                                                    </div>

                                                    <c:if test="${not empty fieldErrors.budgetError}">
                                                        <div class="invalid-feedback d-block">
                                                            ${fieldErrors.budgetError}
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Requirements & Skills -->
                                        <div class="card border-0 shadow-sm mb-4">
                                            <div class="card-header bg-transparent border-0 p-4">
                                                <h5 class="mb-0">
                                                    <i class="bi bi-list-check text-warning me-2"></i>Yêu cầu & Kỹ năng
                                                </h5>
                                            </div>
                                            <div class="card-body p-4">
                                                <div class="mb-4">
                                                    <label class="form-label fw-medium">Yêu cầu dự án</label>
                                                    <div id="requirement-list">
                                                        <c:choose>
                                                            <c:when test="${not empty oldRequirements}">
                                                                <c:forEach var="req" items="${oldRequirements}" varStatus="s">
                                                                    <div class="row mb-2 requirement-item">
                                                                        <!-- Cột 1: name_requirement -->
                                                                        <div class="col-md-5">
                                                                            <div class="input-group">
                                                                                <span class="input-group-text">${s.index + 1}.</span>
                                                                                <input type="text"
                                                                                       class="form-control ${not empty fieldErrors.requirementsError ? 'is-invalid' : ''}"
                                                                                       name="name_requirements[]"
                                                                                       value="${req.nameRequirement}"
                                                                                       placeholder="Tên yêu cầu (vd: min_experience_years)">
                                                                            </div>
                                                                        </div>

                                                                        <!-- Cột 2: requirement -->
                                                                        <div class="col-md-6">
                                                                            <input type="text"
                                                                                   class="form-control ${not empty fieldErrors.requirementsError ? 'is-invalid' : ''}"
                                                                                   name="requirements[]"
                                                                                   value="${req.requirement}"
                                                                                   placeholder="Chi tiết yêu cầu (vd: 3 năm, kỹ năng Java)">
                                                                        </div>

                                                                        <!-- Xóa -->
                                                                        <div class="col-md-1 d-flex align-items-center">
                                                                            <button class="btn btn-outline-danger remove-requirement" type="button">
                                                                                <i class="bi bi-x"></i>
                                                                            </button>
                                                                        </div>
                                                                    </div>
                                                                </c:forEach>
                                                            </c:when>

                                                            <c:otherwise>
                                                                <div class="row mb-2 requirement-item">
                                                                    <div class="col-md-5">
                                                                        <div class="input-group">
                                                                            <span class="input-group-text"></span>

                                                                            <input type="text" class="form-control"
                                                                                   name="name_requirements[]"
                                                                                   placeholder="Tên yêu cầu (vd: min_experience_years)">
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <input type="text" class="form-control"
                                                                               name="requirements[]"
                                                                               placeholder="Chi tiết yêu cầu (vd: 3 năm, kỹ năng Java)">
                                                                    </div>
                                                                    <div class="col-md-1 d-flex align-items-center">
                                                                        <button class="btn btn-outline-danger remove-requirement" type="button">
                                                                            <i class="bi bi-x"></i>
                                                                        </button>
                                                                    </div>
                                                                </div>

                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>

                                                    <button type="button" class="btn btn-outline-warning btn-sm" id="addRequirement">
                                                        <i class="bi bi-plus-circle me-1"></i>Thêm yêu cầu
                                                    </button>

                                                    <div class="form-text">
                                                        <i class="bi bi-info-circle me-1"></i>Thêm ít nhất 3 yêu cầu cụ thể, không trùng nhau.
                                                    </div>

                                                    <c:if test="${not empty fieldErrors.requirementsError}">
                                                        <div class="invalid-feedback d-block">
                                                            ${fieldErrors.requirementsError}
                                                        </div>
                                                    </c:if>
                                                </div>

                                            </div>
                                        </div>

                                        <!-- Additional Options -->
                                        <div class="card border-0 shadow-sm">
                                            <div class="card-header bg-transparent border-0 p-4">
                                                <h5 class="mb-0">
                                                    <i class="bi bi-gear text-warning me-2"></i>Tùy chọn bổ sung
                                                </h5>
                                            </div>
                                            <div class="card-body p-4">
                                                <div class="row g-3">
                                                    <div class="col-md-6">
                                                        <div class="form-check form-switch">
                                                            <input class="form-check-input" type="checkbox" name="featured">
                                                            <label class="form-check-label fw-medium">Gắn nổi bật (+$10)</label>
                                                            <div class="form-text">Tăng độ hiển thị và thu hút proposal tốt hơn.</div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-check form-switch">
                                                            <input class="form-check-input" type="checkbox" name="nda_required">
                                                            <label class="form-check-label fw-medium">Yêu cầu ký NDA</label>
                                                            <div class="form-text">Freelancer phải ký NDA trước khi xem chi tiết.</div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-check form-switch">
                                                            <input class="form-check-input" type="checkbox" name="milestone_payments">
                                                            <label class="form-check-label fw-medium">Thanh toán theo mốc</label>
                                                            <div class="form-text">Chia dự án thành nhiều mốc thanh toán.</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Sidebar -->
                                    <div class="col-lg-4">
                                        <!-- Preview -->
                                        <div class="card border-0 shadow-sm mb-4 position-sticky" style="top: 1rem;">
                                            <div class="card-header bg-transparent border-0 p-3">
                                                <h6 class="mb-0">
                                                    <i class="bi bi-eye text-warning me-2"></i>Xem trước Job
                                                </h6>
                                            </div>
                                            <div class="card-body p-3">
                                                <div class="mb-3">
                                                    <span class="badge bg-primary mb-2" id="previewType">Dự án đấu thầu</span>
                                                    <h6 id="previewTitle" class="text-muted">Tiêu đề công việc sẽ hiển thị ở đây</h6>
                                                </div>
                                                <p id="previewDescription" class="small text-muted">Mô tả dự án sẽ hiển thị ở đây...</p>

                                            </div>
                                        </div>

                                        <!-- Draft Management Card -->
                                        <div class="card border-0 shadow-sm mb-4">
                                            <div class="card-header bg-transparent border-0 p-3">
                                                <h6 class="mb-0">
                                                    <i class="bi bi-folder2-open text-warning me-2"></i>Quản lý nháp
                                                </h6>
                                            </div>
                                            <div class="card-body p-3">
                                                <div class="d-grid">
                                                    <a href="<c:url value='/employer/drafts'/>" class="btn btn-outline-secondary mb-2">
                                                        <i class="bi bi-list-ul me-1"></i>Xem tất cả nháp
                                                    </a>
                                                    <small class="text-muted text-center">
                                                        <i class="bi bi-info-circle me-1"></i>
                                                        Truy cập nhanh các job đã lưu nháp
                                                    </small>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Tips -->
                                        <div class="card border-0 shadow-sm">
                                            <div class="card-header bg-transparent border-0 p-3">
                                                <h6 class="mb-0">
                                                    <i class="bi bi-lightbulb text-warning me-2"></i>Mẹo đăng job hiệu quả
                                                </h6>
                                            </div>
                                            <div class="card-body p-3">
                                                <ul class="list-unstyled small mb-0">
                                                    <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Mô tả rõ ràng, chi tiết nhu cầu</li>
                                                    <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Đặt ngân sách phù hợp</li>
                                                    <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Thêm kỹ năng và yêu cầu liên quan</li>
                                                    <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Kèm thời gian thực hiện dự án</li>
                                                    <li><i class="bi bi-check-circle text-success me-2"></i>Xem lại kỹ trước khi đăng</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Action Buttons -->
                                <div class="d-flex justify-content-between align-items-center mt-4 pt-4 border-top">
                                    <div>
                                        <!-- Nút chuyển sang trang nháp bổ sung -->
                                        <a href="<c:url value='/employer/drafts'/>" class="btn btn-link text-decoration-none">
                                            <i class="bi bi-folder2-open me-1"></i>Quản lý nháp
                                        </a>
                                    </div>
                                    <div class="d-flex gap-3">
                                        <button type="reset" class="btn btn-outline-secondary">
                                            <i class="bi bi-x-circle me-1"></i>Làm lại
                                        </button>
                                        <!-- Nút lưu nháp -->
                                        <button type="submit" class="btn btn-outline-warning" 
                                                name="action" value="draft">
                                            <i class="bi bi-file-earmark me-1"></i>Lưu nháp
                                        </button>

                                        <!-- Nút đăng job -->
                                        <button type="submit" class="btn btn-warning text-white" 
                                                name="action" value="publish">
                                            <i class="bi bi-send me-1"></i>Đăng job
                                        </button>

                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {

                updateRequirementNumbers(); // cập nhật số ngay khi load
                const form = document.getElementById('jobForm');
                // === FUNCTION HIỂN THỊ THÔNG BÁO ĐỘNG ===
                function showNotification(message, type = 'success') {
                    const notificationArea = document.getElementById('notificationArea');
                    const alertDiv = document.createElement('div');
                    alertDiv.className = `alert alert-${type} alert-dismissible fade show`;
                    alertDiv.setAttribute('role', 'alert');
                    let icon = '';
                    switch (type) {
                        case 'success':
                            icon = 'bi-check-circle-fill';
                            break;
                        case 'warning':
                            icon = 'bi-exclamation-triangle-fill';
                            break;
                        case 'danger':
                            icon = 'bi-x-circle-fill';
                            break;
                        case 'info':
                            icon = 'bi-info-circle-fill';
                            break;
                    }

                    alertDiv.innerHTML = `
                        <i class="bi ${icon} me-2"></i>
            ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    `;
                    notificationArea.appendChild(alertDiv);
                    // Tự động ẩn sau 5 giây
                    setTimeout(() => {
                        alertDiv.classList.remove('show');
                        setTimeout(() => alertDiv.remove(), 300);
                    }, 5000);
                }


                // === Requirements add/remove ===
                // === FUNCTION CÂP NHẬT SỐ THỨ TỰ YÊU CẦU ===
                function updateRequirementNumbers() {
                    const requirements = document.querySelectorAll('#requirement-list .requirement-item');
                    requirements.forEach((req, index) => {
                        const numberSpan = req.querySelector('.input-group-text');
                        if (numberSpan) {
                            numberSpan.textContent = `${index + 1}.`;
                        }
                    });
                }

                // === XỬ LÝ NÚT THÊM YÊU CẦU ===
                const addBtn = document.getElementById('addRequirement');
                if (addBtn) {
                    addBtn.addEventListener('click', function () {
                        console.log('Add requirement button clicked'); // Debug log
                        const requirementList = document.getElementById('requirement-list');
                        if (!requirementList) {
                            console.error('Requirement list not found');
                            return;
                        }

                        const newRequirement = document.createElement('div');
                        newRequirement.className = 'row mb-2 requirement-item';
                        newRequirement.innerHTML = `
                <div class="col-md-5">
                    <div class="input-group">
                        <span class="input-group-text"></span>
                        <input type="text" class="form-control"
                               name="name_requirements[]"
                               placeholder="Tên yêu cầu (vd: min_experience_years)">
                    </div>
                </div>
                <div class="col-md-6">
                    <input type="text" class="form-control"
                           name="requirements[]"
                           placeholder="Chi tiết yêu cầu (vd: 3 năm, kỹ năng Java)">
                </div>
                <div class="col-md-1 d-flex align-items-center">
                    <button class="btn btn-outline-danger remove-requirement" type="button">
                        <i class="bi bi-x"></i>
                    </button>
                </div>
            `;
                        requirementList.appendChild(newRequirement);
                        updateRequirementNumbers();
                        console.log('New requirement added'); // Debug log
                    });
                } else {
                    console.error('Add requirement button not found');
                }

                // === XỬ LÝ NÚT XÓA YÊU CẦU ===
                document.addEventListener('click', function (e) {
                    if (e.target.closest('.remove-requirement')) {
                        const requirementDiv = e.target.closest('.requirement-item');
                        const allRequirements = document.querySelectorAll('#requirement-list .requirement-item');

                        if (allRequirements.length > 1) {
                            requirementDiv.remove();
                            updateRequirementNumbers();
                            console.log('Requirement removed'); // Debug log
                        } else {
                            showNotification('Phải có ít nhất 1 yêu cầu', 'warning');
                        }
                    }
                });

                // Gọi updateRequirementNumbers() khi DOM đã sẵn sàng
                updateRequirementNumbers();



                // === Char counter ===
                const descriptionTextarea = document.querySelector('textarea[name="description"]');
                const charCount = document.getElementById('charCount');
                if (descriptionTextarea && charCount) {
                    descriptionTextarea.addEventListener('input', function () {
                        charCount.textContent = this.value.length;
                        updatePreview();
                    });
                }

                // === Toggle bidding config by type ===
                const jobTypeSelect = document.getElementById('jobTypeSelect');
                const biddingConfig = document.getElementById('biddingConfig');
                const selectionMode = document.getElementById('selectionMode');
                const bidDeviationPct = document.getElementById('bidDeviationPct');
                const deviationRequired = document.getElementById('deviationRequired');
                const budgetRequired = document.getElementById('budgetRequired');
                const budgetDisplay = document.getElementById("budgetDisplay");
                const budgetInput = document.getElementById("budgetInput");
                budgetDisplay.addEventListener("input", function () {
                    let raw = this.value.replace(/\D/g, ""); // chỉ giữ số
                    if (!raw) {
                        budgetInput.value = "";
                        previewBudget.textContent = "VND 0";
                        return;
                    }
                    budgetInput.value = raw; // giá trị thực để submit
                    let formatted = new Intl.NumberFormat("vi-VN").format(raw);
                    this.value = formatted; // hiển thị đẹp
                    previewBudget.textContent = "VND " + formatted;
                });
                function toggleBiddingConfig() {
                    if (!biddingConfig)
                        return;
                    if (jobTypeSelect.value === 'BIDDING') {
                        biddingConfig.classList.remove('d-none');
                        toggleSelectionModeRequirements();
                    } else {
                        biddingConfig.classList.add('d-none');
                    }
                }

                // Handle selection mode changes
                function toggleSelectionModeRequirements() {
                    if (selectionMode.value === 'LOWEST_BID') {
                        // Show required indicators
                        deviationRequired.classList.remove('d-none');
                        budgetRequired.classList.remove('d-none');
                        // Set required attributes
                        bidDeviationPct.setAttribute('required', 'required');
                        budgetInput.setAttribute('required', 'required');
                        // Update min values
                        bidDeviationPct.setAttribute('min', '5');
                        bidDeviationPct.setAttribute('max', '30');
                        budgetInput.setAttribute('min', '1000');
                    } else {
                        // Hide required indicators
                        deviationRequired.classList.add('d-none');
                        budgetRequired.classList.add('d-none');
                        // Remove required attributes
                        bidDeviationPct.removeAttribute('required');
                        budgetInput.removeAttribute('required');
                        // Reset min values for MANUAL mode
                        bidDeviationPct.setAttribute('min', '0');
                        bidDeviationPct.setAttribute('max', '50');
                        budgetInput.setAttribute('min', '0');
                    }
                }

                jobTypeSelect.addEventListener('change', () => {
                    toggleBiddingConfig();
                    updatePreview();
                });
                selectionMode.addEventListener('change', () => {
                    toggleSelectionModeRequirements();
                    validateBudgetAndSelection();
                });
                bidDeviationPct.addEventListener('input', validateBudgetAndSelection);
                bidDeviationPct.addEventListener('blur', validateBudgetAndSelection);
                if (budgetInput) {
                    budgetInput.addEventListener('input', validateBudgetAndSelection);
                    budgetInput.addEventListener('blur', validateBudgetAndSelection);
                }

                // Initialize
                toggleBiddingConfig();
                // === Live preview ===
                function updatePreview() {
                    const type = document.querySelector('select[name="type"]').value || 'BIDDING';
                    const title = document.querySelector('input[name="title"]').value || 'Tiêu đề công việc sẽ hiển thị ở đây';
                    const description = document.querySelector('textarea[name="description"]').value || 'Mô tả dự án sẽ hiển thị ở đây...';
                    const budget = document.querySelector('input[name="budget"]')?.value || '0';
                    const duration = document.querySelector('select[name="duration"]')?.value || 'Chưa đặt';
                    const currency = (document.querySelector('input[name="currency"]')?.value || 'VND').toUpperCase();
                    document.getElementById('previewType').textContent =
                            (type === 'BIDDING') ? 'Dự án đấu thầu' :
                            (type === 'CONTEST') ? 'Cuộc thi tuyển' : 'Task nhỏ';
                    document.getElementById('previewTitle').textContent = title;
                    document.getElementById('previewDescription').textContent =
                            description.substring(0, 100) + (description.length > 100 ? '...' : '');
                    // Format budget with thousand separators
                    const formattedBudget = Number(budget).toLocaleString('vi-VN');
                    document.getElementById('previewBudget').textContent = `${currency} ${formattedBudget}`;
                                document.getElementById('previewDuration').textContent =
                                        duration.replace('-', ' ').replace(/\b\w/g, l => l.toUpperCase());
                                document.getElementById('previewSkills').textContent =
                                        (skills.length > 0 ? skills.join(', ') : 'Chưa thêm kỹ năng');
                            }

                            // ======= Validation rules =======
                            const SPAM_WORDS = ["FREE", "NO PAY"];
                            const CONTACT_REGEX = /((\+?\d{1,3}[-.\s]?)?(\d{3,4}[-.\s]?){2,3})|([A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,})|(https?:\/\/[^\s]+)|([a-z0-9.-]+\.[a-z]{2,}\/[^\s]*)/ig;
                            const PROFANITY_REGEX = /(scam|lừa đảo|fuck|shit|dm|đm)/ig;
                            const WEIRD_SCRIPT_REGEX = /[\u{1F300}-\u{1FAFF}\u{FE00}-\u{FE0F}\u{0900}-\u{0D7F}]/u;
                            function isAllUppercase(text) {
                                const letters = text.replace(/[^A-Za-z\u00C0-\u024F]/g, "");
                                return letters.length >= 4 && letters === letters.toUpperCase();
                            }

                            function hasSpamWords(text) {
                                const up = (text || "").toUpperCase();
                                return SPAM_WORDS.some(w => up.includes(w));
                            }

                            function containsContactInfo(text) {
                                return CONTACT_REGEX.test(text || "");
                            }

                            function containsProfanity(text) {
                                return PROFANITY_REGEX.test((text || "").toLowerCase());
                            }

                            function containsWeirdScriptOrEmoji(text) {
                                return WEIRD_SCRIPT_REGEX.test(text || "");
                            }

                            function setInvalid(el, msg) {
                                el.classList.add("is-invalid");
                                el.classList.remove("is-valid");
                                let fb = el.parentElement.querySelector(".invalid-feedback");
                                if (!fb) {
                                    fb = document.createElement("div");
                                    fb.className = "invalid-feedback";
                                    el.parentElement.appendChild(fb);
                                }
                                fb.textContent = msg;
                            }

                            function setValid(el) {
                                el.classList.remove("is-invalid");
                                el.classList.add("is-valid");
                            }

                            function clearInvalid(el) {
                                el.classList.remove("is-invalid");
                                el.classList.remove("is-valid");
                            }

                            function validateType() {
                                const el = document.querySelector('select[name="type"]');
                                const v = (el.value || "").toUpperCase();
                                if (!["BIDDING", "CONTEST", "MICROTASK"].includes(v)) {
                                    setInvalid(el, "Vui lòng chọn phân loại hợp lệ.");
                                    return false;
                                }
                                setValid(el);
                                return true;
                            }

                            function validateTitle() {
                                const el = document.querySelector('input[name="title"]');
                                const v = (el.value || "").trim();
                                if (v.length < 5 || v.length > 150) {
                                    setInvalid(el, "Tiêu đề phải 5–150 ký tự.");
                                    return false;
                                }
                                if (isAllUppercase(v)) {
                                    setInvalid(el, "Không được toàn chữ in hoa.");
                                    return false;
                                }
                                if (hasSpamWords(v)) {
                                    setInvalid(el, 'Không chứa từ khóa spam như "FREE", "NO PAY".');
                                    return false;
                                }
                                setValid(el);
                                return true;
                            }

                            function validateDescription() {
                                const el = document.querySelector('textarea[name="description"]');
                                const v = (el.value || "").trim();
                                if (v.length < 30) {
                                    setInvalid(el, "Mô tả tối thiểu 30 ký tự.");
                                    return false;
                                }
                                if (v.length > 5000) {
                                    setInvalid(el, "Mô tả tối đa 5000 ký tự.");
                                    return false;
                                }
                                if (containsContactInfo(v)) {
                                    setInvalid(el, "Không chứa email/số điện thoại/link ngoài.");
                                    return false;
                                }
                                if (containsProfanity(v)) {
                                    setInvalid(el, "Nội dung có từ ngữ không phù hợp.");
                                    return false;
                                }
                                setValid(el);
                                return true;
                            }

                            function getCurrency() {
                                const el = document.querySelector('input[name="currency"], select[name="currency"]');
                                return el ? (el.value || "VND").toUpperCase() : "VND";
                            }

                            function validateBudgetAndSelection() {
                                const jobType = document.querySelector('select[name="type"]').value;
                                // Only validate if BIDDING type is selected
                                if (jobType !== 'BIDDING') {
                                    return true;
                                }

                                const cur = getCurrency();
                                const sel = document.querySelector('select[name="selection_mode"]');
                                const selVal = sel ? (sel.value || "MANUAL").toUpperCase() : "MANUAL";
                                const dev = document.querySelector('input[name="bid_deviation_pct"]');
                                const devVal = dev && dev.value !== "" ? Number(dev.value) : null;
                                const budgetEl = document.querySelector('input[name="budget"]');
                                const budget = budgetEl && budgetEl.value !== "" ? Number(budgetEl.value) : 0;
                                // Clear previous validation states
                                if (budgetEl)
                                    clearInvalid(budgetEl);
                                if (dev)
                                    clearInvalid(dev);
                                if (sel)
                                    clearInvalid(sel);
                                // Validate selection mode
                                const allowed = ["MANUAL", "LOWEST_BID"];
                                if (sel && !allowed.includes(selVal)) {
                                    setInvalid(sel, "Chế độ chọn không hợp lệ.");
                                    return false;
                                }

                                // LOWEST_BID specific validations
                                if (selVal === "LOWEST_BID") {
                                    // Budget is required and must be > 0 for LOWEST_BID
                                    if (!budgetEl || budget <= 0) {
                                        setInvalid(budgetEl, "Với LOWEST_BID, ngân sách bắt buộc và phải > 0.");
                                        return false;
                                    }

                                    // For VND, minimum 1000
                                    if (cur === "VND" && budget < 1000) {
                                        setInvalid(budgetEl, "Với VND và LOWEST_BID, ngân sách tối thiểu 1.000.");
                                        return false;
                                    }

                                    // Deviation percentage is required and must be 5-30
                                    if (devVal === null || devVal === "") {
                                        setInvalid(dev, "Với LOWEST_BID, % lệch giá là bắt buộc.");
                                        return false;
                                    }

                                    if (devVal < 5 || devVal > 30) {
                                        setInvalid(dev, "Với LOWEST_BID, % lệch giá phải từ 5 đến 30.");
                                        return false;
                                    }

                                    setValid(dev);
                                } else {
                                    // MANUAL mode validations
                                    if (budget < 0) {
                                        setInvalid(budgetEl, "Ngân sách phải ≥ 0.");
                                        return false;
                                    }

                                    // For VND with MANUAL, if budget is provided, minimum 1000
                                    if (cur === "VND" && budget > 0 && budget < 1000) {
                                        setInvalid(budgetEl, "Với VND, ngân sách tối thiểu 1.000 (hoặc để trống).");
                                        return false;
                                    }

                                    // Deviation can be 0-50 for MANUAL mode but not required
                                    if (devVal !== null && devVal !== "" && (devVal < 0 || devVal > 50)) {
                                        setInvalid(dev, "Với MANUAL, % lệch giá từ 0 đến 50 (không bắt buộc).");
                                        return false;
                                    }

                                    if (dev && devVal !== null && devVal !== "")
                                        setValid(dev);
                                }

                                if (budgetEl && budget >= 0)
                                    setValid(budgetEl);
                                if (sel)
                                    setValid(sel);
                                return true;
                            }

                            function validateDeadline() {
                                const el = document.querySelector('input[name="deadline_at"]');
                                const v = el.value;
                                if (!v) {
                                    setInvalid(el, "Vui lòng chọn hạn chót.");
                                    return false;
                                }
                                const today = new Date();
                                const chosen = new Date(v + "T00:00:00");
                                const max = new Date();
                                max.setMonth(max.getMonth() + 12);
                                if (chosen < new Date(today.toDateString())) {
                                    setInvalid(el, "Hạn chót phải từ hôm nay trở đi.");
                                    return false;
                                }
                                if (chosen > max) {
                                    setInvalid(el, "Hạn chót không được quá 12 tháng.");
                                    return false;
                                }
                                // Flag urgent nếu < 7 ngày
                                const diffDays = Math.ceil((chosen - today) / (1000 * 60 * 60 * 24));
                                let urgent = document.getElementById("urgentHidden");
                                if (diffDays < 7) {
                                    if (!urgent) {
                                        urgent = document.createElement("input");
                                        urgent.type = "hidden";
                                        urgent.name = "urgent";
                                        urgent.id = "urgentHidden";
                                        form.appendChild(urgent);
                                    }
                                    urgent.value = "true";
                                } else if (urgent) {
                                    urgent.remove();
                                }
                                setValid(el);
                                return true;
                            }

                            function validateRequirements() {
                                const inputs = Array.from(document.querySelectorAll('input[name="requirements[]"]'));
                                inputs.forEach(i => clearInvalid(i));
                                const values = inputs.map(i => (i.value || "").trim()).filter(Boolean);
                                if (values.length < 3) {
                                    setInvalid(inputs[0], "Cần tối thiểu 3 yêu cầu.");
                                    return false;
                                }
                                const uniq = new Set(values.map(v => v.toLowerCase()));
                                if (uniq.size !== values.length) {
                                    setInvalid(inputs[0], "Không được trùng lặp yêu cầu.");
                                    return false;
                                }
                                if (values.some(v => containsWeirdScriptOrEmoji(v))) {
                                    setInvalid(inputs[0], "Yêu cầu chứa ký tự/emoji không hợp lệ.");
                                    return false;
                                }
                                setValid(inputs[0]);
                                return true;
                            }

                            // === Real-time validation khi người dùng nhập ===
                            const titleInput = document.querySelector('input[name="title"]');
                            const descriptionInput = document.querySelector('textarea[name="description"]');
                            const deadlineInput = document.querySelector('input[name="deadline_at"]');
                            const typeSelect = document.querySelector('select[name="type"]');
                            if (titleInput) {
                                titleInput.addEventListener('input', validateTitle);
                                titleInput.addEventListener('blur', validateTitle);
                            }

                            if (descriptionInput) {
                                descriptionInput.addEventListener('input', validateDescription);
                                descriptionInput.addEventListener('blur', validateDescription);
                            }

                            if (deadlineInput) {
                                deadlineInput.addEventListener('change', validateDeadline);
                                deadlineInput.addEventListener('blur', validateDeadline);
                            }

                            if (typeSelect) {
                                typeSelect.addEventListener('change', validateType);
                            }

                            // === Hook for preview updates ===
                            document.querySelectorAll('input, select, textarea').forEach(el => {
                                el.addEventListener('input', updatePreview);
                                el.addEventListener('change', updatePreview);
                            });
                            // === FORM SUBMIT HANDLER - QUAN TRỌNG ===
                            form.addEventListener('submit', function (e) {
                                const ok =
                                        validateType() &&
                                        validateTitle() &&
                                        validateDescription() &&
                                        validateDeadline() &&
                                        validateRequirements() &&
                                        validateBudgetAndSelection();
                                if (!ok) {
                                    e.preventDefault();
                                    e.stopPropagation();
                                    form.classList.add('was-validated');
                                    // Scroll đến field đầu tiên có lỗi
                                    const firstInvalid = form.querySelector('.is-invalid');
                                    if (firstInvalid) {
                                        firstInvalid.scrollIntoView({behavior: 'smooth', block: 'center'});
                                        firstInvalid.focus();
                                    }

                                    // Hiển thị thông báo lỗi
                                    showNotification('❌ Vui lòng kiểm tra và sửa các lỗi trong form!', 'danger');
                                    return;
                                }

                                const action = e.submitter?.value || "";
                                const statusHidden = document.getElementById('statusHidden');
                                // XỬ LÝ STATUS THEO ACTION
                                if (action === "publish") {
                                    statusHidden.value = "PENDING_REVIEW";
                                    if (!confirm('✅ Bạn có chắc muốn đăng job này?\n\n⚠️ Lưu ý: Hệ thống sẽ thu phí đăng bài và job sẽ hiển thị công khai.')) {
                                        e.preventDefault();
                                        return;
                                    }

                                    // Hiển thị loading
                                    e.submitter.disabled = true;
                                    e.submitter.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span>Đang đăng...';
                                } else if (action === "draft") {
                                    // LƯU NHÁP - status = DRAFT
                                    statusHidden.value = "DRAFT";
                                    // Hiển thị loading
                                    e.submitter.disabled = true;
                                    e.submitter.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span>Đang lưu...';
                                }

                                // Form sẽ submit bình thường với status đã set
                            });
                            // === XỬ LÝ THÀNH CÔNG TỪ BACKEND (dựa vào session attributes) ===
                            // Check if there's a success message in session (set by backend)

            <c:if test="${not empty sessionScope.jobCreatedSuccess}">
                            showNotification('${sessionScope.jobCreatedSuccess}', 'success');
                <c:remove var="jobCreatedSuccess" scope="session"/>
            </c:if>

            <c:if test="${not empty sessionScope.draftSavedSuccess}">
                            showNotification('${sessionScope.draftSavedSuccess}', 'info');
                <c:remove var="draftSavedSuccess" scope="session"/>
            </c:if>

                            // Min date for deadline
                            const todayStr = new Date().toISOString().split('T')[0];
                            document.querySelector('input[name="deadline_at"]').setAttribute('min', todayStr);
                            // Initial preview
                            updatePreview();
                        });
        </script>
    </body>
</html>