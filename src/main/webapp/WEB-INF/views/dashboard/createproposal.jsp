<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="entities.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <%@ include file="/WEB-INF/views/dashboard/include/head.jsp" %>

    <body style="background: linear-gradient(135deg, #fff5f0 0%, #ffffff 100%);">
        <div class="container-fluid">
            <div class="row g-0">
                <!-- Sidebar -->
                <%@include file="/WEB-INF/views/dashboard/include/sidebar.jsp" %>
                <!-- Main Content -->
                <main class="col-12 col-lg-9 col-xl-10 p-4">
                    <!-- Header -->
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h2 class="h3 mb-1 text-dark">
                                <i class="bi bi-file-earmark-text text-warning me-2"></i>Gửi Proposal
                            </h2>
                            <p class="text-muted mb-0">Đăng ký tham gia dự án và thể hiện năng lực của bạn</p>
                        </div>
                        <div class="d-flex align-items-center gap-3">
                            <!-- Nút về danh sách jobs -->
                            <a href="${pageContext.request.contextPath}/dashboard/browse-jobs" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-1"></i>Về danh sách
                            </a>
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb mb-0">
                                    <li class="breadcrumb-item">
                                        <a href="#" class="text-warning text-decoration-none">Công việc</a>
                                    </li>
                                    <li class="breadcrumb-item active">Gửi proposal</li>
                                </ol>
                            </nav>
                        </div>
                    </div>

                    <!-- Flash toast container (success + error) -->
                    <div class="toast-container position-fixed top-0 end-0 p-3" style="z-index:1080;">
                        <c:if test="${not empty success}">
                            <div id="flashSuccessToast" class="toast text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
                                <div class="d-flex">
                                    <div class="toast-body">
                                        <i class="bi bi-check-circle-fill me-2"></i>
                                        <c:out value="${success}"/>
                                    </div>
                                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${not empty error}">
                            <div id="flashErrorToast" class="toast text-bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true">
                                <div class="d-flex">
                                    <div class="toast-body">
                                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                        <c:out value="${error}"/>
                                    </div>
                                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <!-- Auto show toasts when flash attributes exist -->
                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                        <%-- hiện success nếu có --%>
                        <c:if test="${not empty success}">
                            new bootstrap.Toast(document.getElementById('flashSuccessToast'), {delay: 4000, autohide: true}).show();
                        </c:if>
                        <%-- hiện error nếu có (để autohide=false cho người dùng đọc kỹ) --%>
                        <c:if test="${not empty error}">
                            new bootstrap.Toast(document.getElementById('flashErrorToast'), {delay: 7000, autohide: false}).show();
                        </c:if>
                        });
                    </script>

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
                                                <div class="small fw-bold text-warning">Thông tin đề xuất</div>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="position-relative">
                                                <div class="bg-light text-muted rounded-circle d-inline-flex align-items-center justify-content-center mb-2" style="width: 40px; height: 40px;">
                                                    <i class="bi bi-2-circle"></i>
                                                </div>
                                                <div class="small text-muted">Thư giới thiệu</div>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="position-relative">
                                                <div class="bg-light text-muted rounded-circle d-inline-flex align-items-center justify-content-center mb-2" style="width: 40px; height: 40px;">
                                                    <i class="bi bi-3-circle"></i>
                                                </div>
                                                <div class="small text-muted">Portfolio</div>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="position-relative">
                                                <div class="bg-light text-muted rounded-circle d-inline-flex align-items-center justify-content-center mb-2" style="width: 40px; height: 40px;">
                                                    <i class="bi bi-4-circle"></i>
                                                </div>
                                                <div class="small text-muted">Xem lại & Gửi</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <form id="proposalForm" action="<c:url value='/dashboard/createproposal'/>" method="POST" enctype="multipart/form-data" novalidate>
                                <div class="row g-4">
                                    <!-- Main Form -->
                                    <div class="col-lg-8">
                                        <!-- Job Information (Read-only) -->
                                        <style>
                                            .job-info-card {
                                                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                                border-radius: 20px;
                                                overflow: hidden;
                                                transition: all 0.3s ease;
                                                border: none !important;
                                                box-shadow: 0 15px 35px rgba(0,0,0,0.1);
                                            }

                                            .job-info-card:hover {
                                                transform: translateY(-3px);
                                                box-shadow: 0 20px 40px rgba(0,0,0,0.15);
                                            }

                                            .job-card-header {
                                                background: rgba(255,255,255,0.1);
                                                backdrop-filter: blur(10px);
                                                border: none;
                                                padding: 1.5rem 2rem;
                                            }

                                            .job-card-body {
                                                background: rgba(255,255,255,0.95);
                                                backdrop-filter: blur(10px);
                                                padding: 2rem;
                                                margin: 0 1rem 1rem 1rem;
                                                border-radius: 15px;
                                            }

                                            .job-title-main {
                                                font-size: 1.4rem;
                                                font-weight: 700;
                                                color: #2c3e50;
                                                margin-bottom: 1rem;
                                                line-height: 1.3;
                                            }

                                            .job-badge {
                                                padding: 0.5rem 0.8rem;
                                                border-radius: 25px;
                                                font-weight: 500;
                                                margin: 0.2rem 0.3rem 0.2rem 0;
                                                font-size: 0.8rem;
                                                transition: all 0.2s ease;
                                                display: inline-flex;
                                                align-items: center;
                                                gap: 0.3rem;
                                            }

                                            .job-badge:hover {
                                                transform: scale(1.05);
                                            }

                                            .badge-job-type {
                                                background: linear-gradient(45deg, #667eea, #764ba2);
                                                color: white;
                                                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
                                            }

                                            .badge-job-status {
                                                background: linear-gradient(45deg, #f093fb, #f5576c);
                                                color: white;
                                                box-shadow: 0 4px 15px rgba(245, 87, 108, 0.3);
                                            }

                                            .badge-job-public {
                                                background: linear-gradient(45deg, #4facfe, #00f2fe);
                                                color: white;
                                                box-shadow: 0 4px 15px rgba(79, 172, 254, 0.3);
                                            }

                                            .badge-job-private {
                                                background: linear-gradient(45deg, #43e97b, #38f9d7);
                                                color: #2c3e50;
                                                box-shadow: 0 4px 15px rgba(67, 233, 123, 0.3);
                                            }

                                            .badge-job-currency {
                                                background: linear-gradient(45deg, #fa709a, #fee140);
                                                color: #2c3e50;
                                                box-shadow: 0 4px 15px rgba(250, 112, 154, 0.3);
                                            }

                                            .badge-job-deadline {
                                                background: linear-gradient(45deg, #ffecd2, #fcb69f);
                                                color: #d63031;
                                                box-shadow: 0 4px 15px rgba(252, 182, 159, 0.3);
                                            }

                                            .badge-job-created {
                                                background: linear-gradient(45deg, #e3ffe7, #d9e7ff);
                                                color: #6c757d;
                                                box-shadow: 0 4px 15px rgba(227, 255, 231, 0.3);
                                            }

                                            .badge-job-views {
                                                background: linear-gradient(45deg, #d299c2, #fef9d7);
                                                color: #6c757d;
                                                box-shadow: 0 4px 15px rgba(210, 153, 194, 0.3);
                                            }

                                            .job-description {
                                                background: #f8f9fa;
                                                border-left: 4px solid #667eea;
                                                padding: 1rem 1.2rem;
                                                border-radius: 0 10px 10px 0;
                                                margin-top: 1.5rem;
                                                font-style: italic;
                                                color: #6c757d;
                                                line-height: 1.6;
                                            }

                                            .job-header-title {
                                                color: white;
                                                font-weight: 600;
                                                display: flex;
                                                align-items: center;
                                                gap: 0.5rem;
                                                margin: 0;
                                            }

                                            .job-header-icon {
                                                background: rgba(255,255,255,0.2);
                                                padding: 0.5rem;
                                                border-radius: 10px;
                                                font-size: 1.2rem;
                                            }

                                            .job-badges-container {
                                                display: flex;
                                                flex-wrap: wrap;
                                                gap: 0.3rem;
                                                margin-top: 0.5rem;
                                            }

                                            @media (max-width: 768px) {
                                                .job-info-card {
                                                    margin: 0;
                                                }

                                                .job-card-header,
                                                .job-card-body {
                                                    padding: 1rem;
                                                }

                                                .job-badges-container {
                                                    justify-content: center;
                                                }

                                                .job-title-main {
                                                    font-size: 1.2rem;
                                                    text-align: center;
                                                }
                                            }
                                        </style>

                                        <div class="card job-info-card mb-4">
                                            <div class="job-card-header">
                                                <h5 class="job-header-title">
                                                    <div class="job-header-icon">
                                                        <i class="bi bi-briefcase"></i>
                                                    </div>
                                                    Thông tin dự án
                                                </h5>
                                            </div>

                                            <div class="job-card-body">
                                                <!-- Hidden dành cho form tạo proposal -->
                                                <input type="hidden" name="job_id" value="${jobEntity.id}"/>
                                                <input type="hidden" name="jobseeker_id" value="${userid}"/>
                                                <input type="hidden" id="maxBudgetRaw" value="${maxBudget}" />
                                                <input type="hidden" id="maxDaysByDeadline" value="${maxDaysByDeadline}" />
                                                <!-- Nếu bạn dùng service mặc định SUBMITTED thì nên để SUBMITTED thay vì PENDING -->
                                                <input type="hidden" name="status" value="SUBMITTED"/>

                                                <div class="mb-4">
                                                    <h6 class="job-title-main">${jobEntity.title}</h6>

                                                    <div class="job-badges-container">
                                                        <span class="job-badge badge-job-type">
                                                            <i class="bi bi-tag"></i>
                                                            <c:out value="${jobEntity.type}"/>
                                                        </span>

                                                        <span class="job-badge badge-job-status">
                                                            <i class="bi bi-info-circle"></i>
                                                            Trạng thái: <c:out value="${jobEntity.status}"/>
                                                        </span>

                                                        <c:choose>
                                                            <c:when test="${jobEntity.isPublic}">
                                                                <span class="job-badge badge-job-public">
                                                                    <i class="bi bi-globe"></i>
                                                                    Công khai
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="job-badge badge-job-private">
                                                                    <i class="bi bi-lock"></i>
                                                                    Riêng tư
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>

                                                        <span class="job-badge badge-job-currency">
                                                            <i class="bi bi-currency-exchange"></i>
                                                            Tiền tệ: <c:out value="${jobEntity.currency}"/>
                                                        </span>

                                                        <c:if test="${not empty jobEntity.deadlineFormatted}">
                                                            <span class="job-badge badge-job-deadline">
                                                                <i class="bi bi-clock"></i>
                                                                Hạn chót: <c:out value="${jobEntity.deadlineFormatted}"/>
                                                            </span>
                                                        </c:if>

                                                        <c:if test="${not empty jobEntity.createdAtFormatted}">
                                                            <span class="job-badge badge-job-created">
                                                                <i class="bi bi-calendar-plus"></i>
                                                                Tạo: <c:out value="${jobEntity.createdAtFormatted}"/>
                                                            </span>
                                                        </c:if>

                                                        <span class="job-badge badge-job-views">
                                                            <i class="bi bi-eye"></i>
                                                            Lượt xem: <c:out value="${jobEntity.views}"/>
                                                        </span>
                                                    </div>
                                                </div>

                                                <div class="job-description">
                                                    <c:choose>
                                                        <c:when test="${not empty jobEntity.description}">
                                                            <c:choose>
                                                                <c:when test="${fn:length(jobEntity.description) > 220}">
                                                                    <c:out value="${fn:substring(jobEntity.description,0,220)}"/>...
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <c:out value="${jobEntity.description}"/>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <em><i class="bi bi-info-circle me-2"></i>Không có mô tả.</em>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Job Requirements Section -->
                                        <style>
                                            .job-requirements-card {
                                                background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                                                border-radius: 20px;
                                                overflow: hidden;
                                                transition: all 0.3s ease;
                                                border: none !important;
                                                box-shadow: 0 15px 35px rgba(0,0,0,0.1);
                                            }

                                            .job-requirements-card:hover {
                                                transform: translateY(-3px);
                                                box-shadow: 0 20px 40px rgba(0,0,0,0.15);
                                            }

                                            .requirements-card-header {
                                                background: rgba(255,255,255,0.15);
                                                backdrop-filter: blur(10px);
                                                border: none;
                                                padding: 1.5rem 2rem;
                                            }

                                            .requirements-card-body {
                                                background: rgba(255,255,255,0.95);
                                                backdrop-filter: blur(10px);
                                                padding: 2rem;
                                                margin: 0 1rem 1rem 1rem;
                                                border-radius: 15px;
                                            }

                                            .requirements-header-title {
                                                color: white;
                                                font-weight: 600;
                                                display: flex;
                                                align-items: center;
                                                gap: 0.5rem;
                                                margin: 0;
                                            }

                                            .requirements-header-icon {
                                                background: rgba(255,255,255,0.2);
                                                padding: 0.5rem;
                                                border-radius: 10px;
                                                font-size: 1.2rem;
                                            }

                                            .requirement-item {
                                                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                                border-radius: 15px;
                                                padding: 1.5rem;
                                                margin-bottom: 1rem;
                                                color: white;
                                                transition: all 0.3s ease;
                                                position: relative;
                                                overflow: hidden;
                                            }

                                            .requirement-item::before {
                                                content: '';
                                                position: absolute;
                                                top: 0;
                                                left: 0;
                                                right: 0;
                                                bottom: 0;
                                                background: rgba(255,255,255,0.1);
                                                opacity: 0;
                                                transition: opacity 0.3s ease;
                                            }

                                            .requirement-item:hover {
                                                transform: translateX(5px);
                                                box-shadow: 0 10px 25px rgba(102, 126, 234, 0.2);
                                            }

                                            .requirement-item:hover::before {
                                                opacity: 1;
                                            }

                                            .requirement-name {
                                                font-size: 1.1rem;
                                                font-weight: 700;
                                                margin-bottom: 0.8rem;
                                                display: flex;
                                                align-items: center;
                                                gap: 0.5rem;
                                                position: relative;
                                                z-index: 1;
                                            }

                                            .requirement-name .req-icon {
                                                background: rgba(255,255,255,0.2);
                                                border-radius: 8px;
                                                padding: 0.3rem;
                                                font-size: 0.9rem;
                                            }

                                            .requirement-description {
                                                line-height: 1.6;
                                                opacity: 0.95;
                                                position: relative;
                                                z-index: 1;
                                                margin: 0;
                                            }

                                            .no-requirements {
                                                text-align: center;
                                                padding: 3rem 2rem;
                                                color: #6c757d;
                                                background: #f8f9fa;
                                                border-radius: 15px;
                                                border: 2px dashed #dee2e6;
                                            }

                                            .no-requirements i {
                                                font-size: 3rem;
                                                margin-bottom: 1rem;
                                                color: #adb5bd;
                                            }

                                            .requirements-count {
                                                background: rgba(255,255,255,0.2);
                                                color: white;
                                                padding: 0.3rem 0.8rem;
                                                border-radius: 50px;
                                                font-size: 0.8rem;
                                                font-weight: 500;
                                            }

                                            @media (max-width: 768px) {
                                                .job-requirements-card {
                                                    margin: 0;
                                                }

                                                .requirements-card-header,
                                                .requirements-card-body {
                                                    padding: 1rem;
                                                }

                                                .requirement-item {
                                                    padding: 1rem;
                                                }

                                                .requirement-name {
                                                    font-size: 1rem;
                                                }
                                            }
                                        </style>

                                        <div class="card job-requirements-card mb-4">
                                            <div class="requirements-card-header">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <h5 class="requirements-header-title">
                                                        <div class="requirements-header-icon">
                                                            <i class="bi bi-list-check"></i>
                                                        </div>
                                                        Yêu cầu dự án
                                                    </h5>
                                                    <c:if test="${not empty jobRequirements}">
                                                        <span class="requirements-count">
                                                            ${fn:length(jobRequirements)} yêu cầu
                                                        </span>
                                                    </c:if>
                                                </div>
                                            </div>

                                            <div class="requirements-card-body">
                                                <c:choose>
                                                    <c:when test="${not empty jobRequirements}">
                                                        <c:forEach var="req" items="${jobRequirements}" varStatus="status">
                                                            <div class="requirement-item">
                                                                <div class="requirement-name">
                                                                    <span class="req-icon">
                                                                        <i class="bi bi-check-circle-fill"></i>
                                                                    </span>
                                                                    <c:out value="${req.nameRequirement}"/>
                                                                </div>
                                                                <c:if test="${not empty req.requirement}">
                                                                    <p class="requirement-description">
                                                                        <c:out value="${req.requirement}"/>
                                                                    </p>
                                                                </c:if>
                                                            </div>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="no-requirements">
                                                            <i class="bi bi-clipboard-x"></i>
                                                            <h6 class="mb-2">Chưa có yêu cầu cụ thể</h6>
                                                            <p class="mb-0">Dự án này chưa có danh sách yêu cầu chi tiết.</p>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>

                                        <!-- Proposal Details -->
                                        <div class="card border-0 shadow-sm mb-4">
                                            <div class="card-header bg-transparent border-0 p-4">
                                                <h5 class="mb-0">
                                                    <i class="bi bi-currency-dollar text-warning me-2"></i>Thông tin đề xuất
                                                </h5>
                                            </div>
                                            <div class="card-body p-4">
                                                <div class="row g-3 mb-4">
                                                    <div class="col-md-6">
                                                        <label class="form-label fw-medium">Giá đề xuất <span class="text-danger">*</span></label>
                                                        <div class="input-group">
                                                            <input type="text" class="form-control form-control-lg" id="priceDisplay" 
                                                                   placeholder="VD: 2.000.000" inputmode="numeric" required>
                                                            <input type="hidden" name="price" id="priceInput">
                                                            <span class="input-group-text">VND</span>
                                                        </div>
                                                        <div class="form-text">
                                                            <i class="bi bi-info-circle me-1"></i>Nhập giá bạn muốn nhận cho dự án này.
                                                        </div>
                                                        <div class="invalid-feedback">Vui lòng nhập giá đề xuất hợp lệ (tối thiểu 50.000 VND).</div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="form-label fw-medium">Thời gian hoàn thành <span class="text-danger">*</span></label>
                                                        <div class="input-group">
                                                            <input type="number" class="form-control form-control-lg" name="duration_days" 
                                                                   placeholder="VD: 15" min="1" max="365" required>
                                                            <span class="input-group-text">ngày</span>
                                                        </div>
                                                        <div class="form-text">
                                                            <i class="bi bi-calendar me-1"></i>Ước tính thời gian hoàn thành dự án.
                                                        </div>
                                                        <div class="invalid-feedback">Vui lòng nhập thời gian từ 1-365 ngày.</div>
                                                    </div>
                                                </div>

                                                <!-- Currency (fixed) -->
                                                <input type="hidden" name="currency" value="VND"/>
                                            </div>
                                        </div>

                                        <!-- Cover Letter -->
                                        <div class="card border-0 shadow-sm mb-4">
                                            <div class="card-header bg-transparent border-0 p-4">
                                                <h5 class="mb-0">
                                                    <i class="bi bi-envelope-heart text-warning me-2"></i>Thư giới thiệu
                                                </h5>
                                            </div>
                                            <div class="card-body p-4">
                                                <div class="mb-4">
                                                    <label class="form-label fw-medium">Thư xin việc <span class="text-danger">*</span></label>
                                                    <textarea class="form-control" name="cover_letter" rows="8"
                                                              placeholder="Giới thiệu bản thân, kinh nghiệm, kỹ năng liên quan đến dự án. Giải thích tại sao bạn phù hợp với dự án này và cách tiếp cận của bạn..."
                                                              maxlength="3000" required></textarea>
                                                    <div class="d-flex justify-content-between">
                                                        <div class="form-text">
                                                            <i class="bi bi-info-circle me-1"></i>Tối thiểu 100 ký tự. Hãy thể hiện sự chuyên nghiệp và nhiệt tình.
                                                        </div>
                                                        <small class="text-muted"><span id="coverLetterCount">0</span>/3000</small>
                                                    </div>
                                                    <div class="invalid-feedback">Vui lòng viết thư giới thiệu ≥ 100 ký tự, không chứa thông tin liên hệ bên ngoài.</div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Portfolio File Upload -->
                                        <style>
                                            .file-upload-container {
                                                position: relative;
                                                border: 2px dashed #dee2e6;
                                                border-radius: 15px;
                                                padding: 2rem;
                                                text-align: center;
                                                transition: all 0.3s ease;
                                                background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
                                            }

                                            .file-upload-container:hover {
                                                border-color: #ffc107;
                                                background: linear-gradient(135deg, #fff3cd 0%, #ffffff 100%);
                                            }

                                            .file-upload-container.dragover {
                                                border-color: #28a745;
                                                background: linear-gradient(135deg, #d4edda 0%, #ffffff 100%);
                                                transform: scale(1.02);
                                            }

                                            /* Portfolio validation styles */
                                            .file-upload-container.is-invalid {
                                                border-color: #dc3545 !important;
                                                background: linear-gradient(135deg, #f8d7da 0%, #ffffff 100%) !important;
                                            }

                                            .file-upload-container.is-valid {
                                                border-color: #28a745 !important;
                                                background: linear-gradient(135deg, #d4edda 0%, #ffffff 100%) !important;
                                            }

                                            .file-upload-container .invalid-feedback {
                                                display: none;
                                                width: 100%;
                                                margin-top: 0.25rem;
                                                font-size: 0.875rem;
                                                color: #dc3545;
                                            }

                                            .file-upload-container.is-invalid .invalid-feedback {
                                                display: block;
                                            }

                                            .file-input {
                                                position: absolute;
                                                width: 100%;
                                                height: 100%;
                                                opacity: 0;
                                                cursor: pointer;
                                                top: 0;
                                                left: 0;
                                            }

                                            .upload-icon {
                                                font-size: 3rem;
                                                color: #6c757d;
                                                margin-bottom: 1rem;
                                            }

                                            .file-info {
                                                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                                color: white;
                                                border-radius: 15px;
                                                padding: 1rem;
                                                margin-top: 1rem;
                                                display: none;
                                            }

                                            .file-info.show {
                                                display: block;
                                            }

                                            .file-name {
                                                font-weight: 600;
                                                margin-bottom: 0.5rem;
                                                display: flex;
                                                align-items: center;
                                                gap: 0.5rem;
                                            }

                                            .file-size {
                                                opacity: 0.8;
                                                font-size: 0.9rem;
                                            }

                                            .remove-file {
                                                background: rgba(255,255,255,0.2);
                                                border: none;
                                                color: white;
                                                border-radius: 8px;
                                                padding: 0.3rem 0.8rem;
                                                font-size: 0.8rem;
                                                cursor: pointer;
                                                transition: all 0.2s ease;
                                            }

                                            .remove-file:hover {
                                                background: rgba(255,255,255,0.3);
                                                transform: scale(1.05);
                                            }

                                            @media (max-width: 768px) {
                                                .file-upload-container {
                                                    padding: 1.5rem;
                                                }

                                                .upload-icon {
                                                    font-size: 2rem;
                                                }
                                            }
                                        </style>

                                        <div class="card border-0 shadow-sm mb-4">
                                            <div class="card-header bg-transparent border-0 p-4">
                                                <h5 class="mb-0">
                                                    <i class="bi bi-collection text-warning me-2"></i>Portfolio & Mẫu công việc
                                                </h5>
                                            </div>
                                            <div class="card-body p-4">
                                                <div class="mb-4">
                                                    <label class="form-label fw-medium">Tải lên file portfolio <span class="text-danger">*</span></label>

                                                    <div class="file-upload-container" id="fileUploadContainer">
                                                        <input type="file" name="portfolio_file" id="portfolioFile" class="file-input" 
                                                               accept=".pdf,.doc,.docx"
                                                               aria-label="Upload portfolio file" required>

                                                        <!-- Invalid feedback cho portfolio -->
                                                        <div class="invalid-feedback">Vui lòng tải lên file portfolio (PDF hoặc Word, ≤ 10MB).</div>

                                                        <div class="upload-content" id="uploadContent">
                                                            <i class="bi bi-cloud-upload upload-icon"></i>
                                                            <h6 class="mb-2">Kéo thả file hoặc nhấp để chọn</h6>
                                                            <p class="text-muted mb-0">
                                                                Chỉ hỗ trợ: PDF, Word (.doc, .docx)<br>
                                                                Tối đa: 10MB
                                                            </p>
                                                        </div>

                                                        <div class="file-info" id="fileInfo">
                                                            <div class="d-flex justify-content-between align-items-start">
                                                                <div class="flex-grow-1">
                                                                    <div class="file-name" id="fileName">
                                                                        <i class="bi bi-file-earmark"></i>
                                                                        <span></span>
                                                                    </div>
                                                                    <div class="file-size" id="fileSize"></div>
                                                                </div>
                                                                <button type="button" class="remove-file" id="removeFile">
                                                                    <i class="bi bi-x-lg"></i>
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-text mt-2">
                                                        <i class="bi bi-info-circle me-1"></i><strong>Bắt buộc:</strong> Upload portfolio, CV dạng PDF hoặc Word để tăng cơ hội được chọn.
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Proposal Attachments (nhiều khối động) -->
                                        <div class="card border-0 shadow-lg mb-4" id="extraDocsCard">
                                            <div class="card-header bg-gradient border-0 p-4 d-flex justify-content-between align-items-center">
                                                <h5 class="mb-0 text-dark fw-bold">
                                                    <i class="bi bi-paperclip me-2 text-warning"></i>Proposal Attachments
                                                </h5>
                                                <button type="button" class="btn btn-warning btn-lg shadow-sm text-white fw-semibold" id="addExtraDocBtn">
                                                    <i class="bi bi-plus-lg me-2"></i> Thêm Tài Liệu
                                                </button>
                                            </div>

                                            <div class="card-body p-4 bg-white">
                                                <div id="extraDocsContainer" class="vstack gap-4">
                                                    <!-- Khối mặc định ban đầu -->
                                                    <div class="extra-doc-item border-0 rounded-4 p-4 position-relative shadow-sm bg-gradient-light">
                                                        <button type="button" class="btn btn-sm btn-danger position-absolute shadow-sm remove-extra-doc" 
                                                                style="top: 12px; right: 12px; border-radius: 50%; width: 35px; height: 35px; display: flex; align-items: center; justify-content: center;" 
                                                                aria-label="Xóa khối">
                                                            <i class="bi bi-x-lg"></i>
                                                        </button>

                                                        <div class="row g-4 align-items-end">
                                                            <div class="col-md-6">
                                                                <label class="form-label fw-semibold text-dark mb-2">
                                                                    <i class="bi bi-tag-fill text-primary me-2"></i>Tên Tài Liệu
                                                                </label>
                                                                <input type="text" name="attachment_names" class="form-control form-control-lg rounded-3 border-2" 
                                                                       placeholder="VD: Sơ yếu lý lịch, Bảng báo giá..." 
                                                                       style="border-color: #e3f2fd; transition: all 0.3s ease;">
                                                                <div class="invalid-feedback fw-medium">Vui lòng nhập tên tài liệu.</div>
                                                            </div>

                                                            <div class="col-md-6">
                                                                <label class="form-label fw-semibold text-dark mb-2">
                                                                    <i class="bi bi-cloud-upload-fill text-success me-2"></i>Chọn File (PDF/Word, ≤ 10MB)
                                                                </label>
                                                                <input type="file" name="attachment_files" class="form-control form-control-lg rounded-3 border-2"
                                                                       accept=".pdf,.doc,.docx" aria-label="Chọn file PDF/Word (≤10MB)"
                                                                       style="border-color: #e8f5e8; transition: all 0.3s ease;">
                                                                <div class="form-text text-muted mt-2">
                                                                    <i class="bi bi-info-circle me-1"></i>
                                                                    Hỗ trợ: <span class="badge bg-primary">PDF</span> 
                                                                    <span class="badge bg-info">.doc</span> 
                                                                    <span class="badge bg-secondary">.docx</span> — Tối đa 10MB
                                                                </div>
                                                                <div class="invalid-feedback fw-medium">Chỉ chấp nhận PDF/Word và dung lượng ≤ 10MB.</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- /Khối mặc định -->
                                                </div>
                                            </div>
                                        </div>

                                        <style>
                                            /* Custom gradient backgrounds */
                                            .bg-gradient {
                                                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                            }

                                            .bg-gradient-light {
                                                background: linear-gradient(135deg, #f8f9ff 0%, #f0f7ff 100%);
                                                border: 2px solid #e3f2fd !important;
                                            }

                                            /* Enhanced hover effects for document blocks */
                                            #extraDocsContainer .extra-doc-item {
                                                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                                                position: relative;
                                                overflow: hidden;
                                            }

                                            #extraDocsContainer .extra-doc-item::before {
                                                content: '';
                                                position: absolute;
                                                top: 0;
                                                left: -100%;
                                                width: 100%;
                                                height: 100%;
                                                background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
                                                transition: left 0.5s;
                                            }

                                            #extraDocsContainer .extra-doc-item:hover {
                                                box-shadow: 0 15px 35px rgba(0,0,0,0.1);
                                                transform: translateY(-3px);
                                                border-color: #2196f3 !important;
                                            }

                                            #extraDocsContainer .extra-doc-item:hover::before {
                                                left: 100%;
                                            }

                                            /* Enhanced form controls */
                                            .form-control:focus {
                                                border-color: #2196f3;
                                                box-shadow: 0 0 0 0.2rem rgba(33, 150, 243, 0.15);
                                                transform: translateY(-1px);
                                            }

                                            /* Button enhancements */
                                            #addExtraDocBtn {
                                                background: linear-gradient(135deg, #ffc107 0%, #ff8f00 100%);
                                                border: none;
                                                transition: all 0.3s ease;
                                                border-radius: 12px !important;
                                                padding: 12px 24px;
                                            }

                                            #addExtraDocBtn:hover {
                                                background: linear-gradient(135deg, #ff8f00 0%, #f57c00 100%);
                                                transform: translateY(-2px);
                                                box-shadow: 0 8px 25px rgba(255, 193, 7, 0.4);
                                            }

                                            .remove-extra-doc {
                                                transition: all 0.3s ease;
                                                background: linear-gradient(135deg, #f44336 0%, #d32f2f 100%) !important;
                                                border: none !important;
                                                opacity: 0.8;
                                            }

                                            .remove-extra-doc:hover {
                                                opacity: 1;
                                                transform: scale(1.1);
                                                box-shadow: 0 4px 15px rgba(244, 67, 54, 0.4);
                                            }

                                            /* Enhanced badges */
                                            .badge {
                                                padding: 6px 10px;
                                                font-size: 0.75rem;
                                                margin: 0 2px;
                                                border-radius: 8px;
                                            }

                                            /* Card shadow enhancement */
                                            .card {
                                                transition: all 0.3s ease;
                                            }

                                            .card:hover {
                                                box-shadow: 0 20px 40px rgba(0,0,0,0.1) !important;
                                            }

                                            /* Form label styling */
                                            .form-label {
                                                color: #333;
                                                margin-bottom: 8px;
                                            }

                                            /* File input styling */
                                            input[type="file"] {
                                                padding: 12px;
                                            }

                                            input[type="file"]::-webkit-file-upload-button {
                                                background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
                                                color: white;
                                                border: none;
                                                padding: 8px 16px;
                                                border-radius: 8px;
                                                margin-right: 12px;
                                                cursor: pointer;
                                                transition: all 0.3s ease;
                                                font-weight: 500;
                                            }

                                            input[type="file"]::-webkit-file-upload-button:hover {
                                                background: linear-gradient(135deg, #45a049 0%, #388e3c 100%);
                                                transform: translateY(-1px);
                                            }

                                            /* Animation for new items */
                                            @keyframes slideInUp {
                                                from {
                                                    opacity: 0;
                                                    transform: translateY(30px);
                                                }
                                                to {
                                                    opacity: 1;
                                                    transform: translateY(0);
                                                }
                                            }

                                            .extra-doc-item {
                                                animation: slideInUp 0.5s ease-out;
                                            }

                                            /* Form text improvements */
                                            .form-text {
                                                font-size: 0.875rem;
                                                color: #6c757d;
                                            }

                                            /* Invalid feedback styling */
                                            .invalid-feedback {
                                                font-size: 0.875rem;
                                                color: #dc3545;
                                                margin-top: 4px;
                                            }
                                        </style>
                                    </div>

                                    <!-- Sidebar -->
                                    <div class="col-lg-4">
                                        <!-- Preview -->
                                        <div class="card border-0 shadow-sm mb-4 position-sticky" style="top: 1rem;">
                                            <div class="card-header bg-transparent border-0 p-3">
                                                <h6 class="mb-0">
                                                    <i class="bi bi-eye text-warning me-2"></i>Xem trước Proposal
                                                </h6>
                                            </div>
                                            <div class="card-body p-3">
                                                <div class="mb-3">
                                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                                        <span class="badge bg-warning">Giá đề xuất</span>
                                                        <strong id="previewPrice" class="text-warning">VND 0</strong>
                                                    </div>
                                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                                        <span class="badge bg-info">Thời gian</span>
                                                        <strong id="previewDuration">0 ngày</strong>
                                                    </div>
                                                </div>

                                                <div class="mb-3">
                                                    <h6 class="small fw-bold mb-1">Thư giới thiệu:</h6>
                                                    <p id="previewCoverLetter" class="small text-muted">Thư giới thiệu sẽ hiển thị ở đây...</p>
                                                </div>

                                                <div class="mb-3">
                                                    <h6 class="small fw-bold mb-1">Portfolio:</h6>
                                                    <p id="previewPortfolio" class="small text-muted">Chưa có portfolio...</p>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Proposal Management -->
                                        <div class="card border-0 shadow-sm mb-4">
                                            <div class="card-header bg-transparent border-0 p-3">
                                                <h6 class="mb-0">
                                                    <i class="bi bi-list-ul text-warning me-2"></i>Quản lý proposal
                                                </h6>
                                            </div>
                                            <div class="card-body p-3">
                                                <div class="d-grid">
                                                    <a href="<c:url value='/freelancer/proposals'/>" class="btn btn-outline-secondary mb-2">
                                                        <i class="bi bi-file-earmark-text me-1"></i>Proposal đã gửi
                                                    </a>
                                                    <small class="text-muted text-center">
                                                        <i class="bi bi-info-circle me-1"></i>
                                                        Xem trạng thái các proposal đã gửi
                                                    </small>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Tips -->
                                        <div class="card border-0 shadow-sm">
                                            <div class="card-header bg-transparent border-0 p-3">
                                                <h6 class="mb-0">
                                                    <i class="bi bi-lightbulb text-warning me-2"></i>Mẹo viết proposal hiệu quả
                                                </h6>
                                            </div>
                                            <div class="card-body p-3">
                                                <ul class="list-unstyled small mb-0">
                                                    <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Đọc kỹ yêu cầu dự án</li>
                                                    <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Viết thư giới thiệu chân thành</li>
                                                    <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Thể hiện kinh nghiệm liên quan</li>
                                                    <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Đặt giá hợp lý, cạnh tranh</li>
                                                    <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Kèm portfolio chất lượng</li>
                                                    <li><i class="bi bi-check-circle text-success me-2"></i>Phản hồi nhanh chóng</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Action Buttons -->
                                <div class="d-flex justify-content-between align-items-center mt-4 pt-4 border-top">
                                    <div>
                                        <a href="${pageContext.request.contextPath}/dashboard/browse-jobs/jobDetail?id=${jobEntity.id}" class="btn btn-link text-decoration-none">
                                            <i class="bi bi-arrow-left me-1"></i>Quay lại chi tiết job
                                        </a>
                                    </div>
                                    <div class="d-flex gap-3">
                                        <button type="reset" class="btn btn-outline-secondary">
                                            <i class="bi bi-x-circle me-1"></i>Làm lại
                                        </button>
                                        <button type="submit" class="btn btn-warning text-white">
                                            <i class="bi bi-send me-1"></i>Gửi proposal
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
                            const form = document.getElementById('proposalForm');

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

                            // === PRICE FORMATTING ===
                            const priceDisplay = document.getElementById("priceDisplay");
                            const priceInput = document.getElementById("priceInput");
                            const previewPrice = document.getElementById("previewPrice");

                            priceDisplay.addEventListener("input", function () {
                                let raw = this.value.replace(/\D/g, ""); // chỉ giữ số
                                if (!raw) {
                                    priceInput.value = "";
                                    previewPrice.textContent = "VND 0";
                                    return;
                                }
                                priceInput.value = raw; // giá trị thực để submit
                                let formatted = new Intl.NumberFormat("vi-VN").format(raw);
                                this.value = formatted; // hiển thị đẹp
                                previewPrice.textContent = "VND " + formatted;
                            });

                            // === CHARACTER COUNTERS ===
                            const coverLetterTextarea = document.querySelector('textarea[name="cover_letter"]');
                            const coverLetterCount = document.getElementById('coverLetterCount');
                            if (coverLetterTextarea && coverLetterCount) {
                                coverLetterTextarea.addEventListener('input', function () {
                                    coverLetterCount.textContent = this.value.length;
                                    updatePreview();
                                });
                            }

                            // === LIVE PREVIEW ===
                            function updatePreview() {
                                const coverLetter = document.querySelector('textarea[name="cover_letter"]').value || 'Thư giới thiệu sẽ hiển thị ở đây...';
                                const duration = document.querySelector('input[name="duration_days"]').value || '0';

                                document.getElementById('previewCoverLetter').textContent =
                                        coverLetter.substring(0, 150) + (coverLetter.length > 150 ? '...' : '');

                                document.getElementById('previewDuration').textContent = duration + ' ngày';
                            }

                            // === PORTFOLIO FILE UPLOAD ===
                            const fileInput = document.getElementById('portfolioFile');
                            const uploadContainer = document.getElementById('fileUploadContainer');
                            const uploadContent = document.getElementById('uploadContent');
                            const fileInfo = document.getElementById('fileInfo');
                            const previewPortfolio = document.getElementById('previewPortfolio');

                            // Only initialize file upload if elements exist
                            if (fileInput && uploadContainer && fileInfo) {
                                const fileName = document.getElementById('fileName').querySelector('span');
                                const fileSize = document.getElementById('fileSize');
                                const removeButton = document.getElementById('removeFile');

                                // File size limit (10MB)
                                const MAX_FILE_SIZE = 10 * 1024 * 1024;

                                // Allowed file types (PDF and Word only)
                                const ALLOWED_TYPES = [
                                    'application/pdf',
                                    'application/msword',
                                    'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
                                ];

                                function formatFileSize(bytes) {
                                    if (bytes === 0)
                                        return '0 Bytes';
                                    const k = 1024;
                                    const sizes = ['Bytes', 'KB', 'MB', 'GB'];
                                    const i = Math.floor(Math.log(bytes) / Math.log(k));
                                    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
                                }

                                function getFileIcon(type) {
                                    if (type === 'application/pdf')
                                        return 'bi-file-pdf';
                                    if (type.includes('word') || type === 'application/msword' ||
                                            type === 'application/vnd.openxmlformats-officedocument.wordprocessingml.document') {
                                        return 'bi-file-word';
                                    }
                                    return 'bi-file-earmark';
                                }

                                function showFile(file) {
                                    fileName.textContent = file.name;
                                    fileSize.textContent = formatFileSize(file.size);

                                    // Update icon
                                    const iconClass = getFileIcon(file.type);
                                    const iconElement = document.getElementById('fileName').querySelector('i');
                                    iconElement.className = `bi ${iconClass}`;

                                    uploadContent.style.display = 'none';
                                    fileInfo.classList.add('show');

                                    // Update preview in sidebar
                                    updatePortfolioPreview(file.name);
                                }

                                function clearFile() {
                                    fileInput.value = '';
                                    uploadContent.style.display = 'block';
                                    fileInfo.classList.remove('show');
                                    uploadContainer.classList.remove('dragover');

                                    // Update preview in sidebar
                                    updatePortfolioPreview('');
                                }

                                function updatePortfolioPreview(filename) {
                                    if (previewPortfolio) {
                                        previewPortfolio.textContent = filename ?
                                                `📁 ${filename.substring(0, 30)}${filename.length > 30 ? '...' : ''}` :
                                                'Chưa có file portfolio...';
                                    }
                                }

                                function validateFile(file) {
                                    // Check file size
                                    if (file.size > MAX_FILE_SIZE) {
                                        showNotification('❌ File quá lớn! Vui lòng chọn file nhỏ hơn 10MB.', 'danger');
                                        return false;
                                    }

                                    // Check file type
                                    if (!ALLOWED_TYPES.includes(file.type)) {
                                        showNotification('❌ Định dạng file không được hỗ trợ! Chỉ chấp nhận file PDF và Word (.doc, .docx).', 'danger');
                                        return false;
                                    }

                                    return true;
                                }

                                // File input change event
                                fileInput.addEventListener('change', function (e) {
                                    const file = e.target.files[0];
                                    if (file && validateFile(file)) {
                                        showFile(file);
                                        validatePortfolio(); // Thêm validation
                                    } else if (file) {
                                        clearFile();
                                        validatePortfolio(); // Thêm validation
                                    } else {
                                        validatePortfolio(); // Thêm validation khi không có file
                                    }
                                });

                                // Remove file button
                                removeButton.addEventListener('click', function () {
                                    clearFile();
                                    validatePortfolio(); // Thêm validation
                                });

                                // Drag and drop functionality
                                uploadContainer.addEventListener('dragover', function (e) {
                                    e.preventDefault();
                                    uploadContainer.classList.add('dragover');
                                });

                                uploadContainer.addEventListener('dragleave', function (e) {
                                    e.preventDefault();
                                    uploadContainer.classList.remove('dragover');
                                });

                                uploadContainer.addEventListener('drop', function (e) {
                                    e.preventDefault();
                                    uploadContainer.classList.remove('dragover');

                                    const files = e.dataTransfer.files;
                                    if (files.length > 0) {
                                        const file = files[0];
                                        if (validateFile(file)) {
                                            // Create a new FileList-like object
                                            const dt = new DataTransfer();
                                            dt.items.add(file);
                                            fileInput.files = dt.files;
                                            showFile(file);
                                            validatePortfolio(); // Thêm validation
                                        }
                                    }
                                });

                                // Initial portfolio preview update
                                updatePortfolioPreview('');
                            }

                            // === PORTFOLIO VALIDATION ===
                            function validatePortfolio() {
                                const fileInput = document.getElementById('portfolioFile');
                                const uploadContainer = document.getElementById('fileUploadContainer');

                                if (!fileInput.files || fileInput.files.length === 0) {
                                    // Set invalid state
                                    uploadContainer.classList.add('is-invalid');
                                    uploadContainer.classList.remove('is-valid');
                                    return false;
                                }

                                const file = fileInput.files[0];

                                // File size validation (10MB)
                                const MAX_FILE_SIZE = 10 * 1024 * 1024;
                                if (file.size > MAX_FILE_SIZE) {
                                    uploadContainer.classList.add('is-invalid');
                                    uploadContainer.classList.remove('is-valid');

                                    // Update error message
                                    const feedback = uploadContainer.querySelector('.invalid-feedback');
                                    if (feedback) {
                                        feedback.textContent = 'File quá lớn! Vui lòng chọn file nhỏ hơn 10MB.';
                                    }
                                    return false;
                                }

                                // File type validation
                                const ALLOWED_TYPES = [
                                    'application/pdf',
                                    'application/msword',
                                    'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
                                ];

                                if (!ALLOWED_TYPES.includes(file.type)) {
                                    uploadContainer.classList.add('is-invalid');
                                    uploadContainer.classList.remove('is-valid');

                                    // Update error message
                                    const feedback = uploadContainer.querySelector('.invalid-feedback');
                                    if (feedback) {
                                        feedback.textContent = 'Định dạng file không hợp lệ! Chỉ chấp nhận PDF và Word (.doc, .docx).';
                                    }
                                    return false;
                                }

                                // Set valid state
                                uploadContainer.classList.remove('is-invalid');
                                uploadContainer.classList.add('is-valid');

                                // Reset error message
                                const feedback = uploadContainer.querySelector('.invalid-feedback');
                                if (feedback) {
                                    feedback.textContent = 'Vui lòng tải lên file portfolio (PDF hoặc Word, ≤ 10MB).';
                                }

                                return true;
                            }

                            // === VALIDATION RULES (compat & stable) ===

                            // Email (kể cả dạng che "name (at) domain (dot) com")
                            const EMAIL_REGEXES = [
                                /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i,
                                /\b[A-Z0-9._%+-]+\s*(?:\(|\[)?at(?:\)|\])?\s*[A-Z0-9.-]+\s*(?:\(|\[)?dot(?:\)|\])?\s*[A-Z]{2,}\b/i
                            ];

                            // Phone: 9–12 chữ số, hỗ trợ +84, khoảng trắng/dấu .-()
                            const PHONE_REGEX = /(?:\+?\d{1,3}[-.\s()]*)?(?:\d[-.\s()]*){9,12}/i;

                            // Link/ID chat trực tiếp
                            const CHAT_LINK_REGEXES = [
                                /(?:t\.me|telegram\.me|telegram\.org|zalo\.me|wa\.me|viber\.com|line\.me|m\.me|fb\.me|facebook\.com\/(?:messages|messenger|profile\.php\?id=))\/?[A-Za-z0-9_.-]{3,}/i,
                                /(?:skype:)[A-Za-z0-9_.-]{3,}/i,
                                /(?:discord\.gg|discordapp\.com\/invite)\/[A-Za-z0-9-]{3,}/i
                            ];

                            // Tên nền tảng đứng riêng
                            const PLATFORM_WORDS = [
                                'facebook', 'messenger', 'fb', 'zalo', 'telegram', 'whatsapp', 'viber', 'line', 'skype', 'discord', 'wechat'
                            ];

                            // Profanity (có thể mở rộng)
                            const PROFANITY_TERMS = [
                                'dm', 'đm', 'dmm', 'dcm', 'đcm', 'địt', 'đéo', 'đụ', 'vãi', 'vl', 'vcl', 'cặc', 'lồn', 'buồi',
                                'khốn', 'ngu', 'đần',
                                'fuck', 'fck', 'wtf', 'shit', 'bitch', 'bastard', 'asshole', 'dick', 'cock', 'pussy', 'cunt', 'motherfucker'
                            ];

                            // Helpers
                            function escapeRegex(s) {
                                return s.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
                            }
                            // Bỏ dấu an toàn (không dùng \p{M} để tránh lỗi trên WebView cũ)
                            function stripDiacriticsCompat(s) {
                                return String(s || '')
                                        .normalize('NFD')
                                        .replace(/[\u0300-\u036f]/g, '') // remove combining marks
                                        .replace(/đ/g, 'd').replace(/Đ/g, 'D');
                            }

                            // Regex theo ranh giới từ ASCII sau khi bỏ dấu (ổn định trên mọi trình duyệt)
                            const PLATFORM_REGEX_ASCII = new RegExp('\\b(?:' + PLATFORM_WORDS.map(escapeRegex).join('|') + ')\\b', 'i');
                            const PROFANITY_REGEX_ASCII = new RegExp('\\b(?:' + PROFANITY_TERMS.map(t => escapeRegex(stripDiacriticsCompat(t))).join('|') + ')\\b', 'i');

                            // Hàm tổng hợp
                            function containsContactInfo(text) {
                                const sRaw = String(text || '');
                                const sASCII = stripDiacriticsCompat(sRaw).toLowerCase();

                                const email = EMAIL_REGEXES.some(r => r.test(sRaw));
                                const phone = PHONE_REGEX.test(sRaw);
                                const chatLink = CHAT_LINK_REGEXES.some(r => r.test(sRaw));

                                const platform = PLATFORM_REGEX_ASCII.test(sASCII);   // "facebook", "zalo", "fb", ...
                                const profanity = PROFANITY_REGEX_ASCII.test(sASCII);  // "lồn" => "lon", "đm" => "dm", ...

                                return email || phone || chatLink || platform || profanity;
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

                            function validatePrice() {
                                const priceValue = Number(priceInput.value) || 0;
                                const maxBudget = Number(document.getElementById('maxBudgetRaw').value) || 0;

                                if (maxBudget > 0 && priceValue >= maxBudget) {
                                    const formattedMaxBudget = new Intl.NumberFormat("vi-VN").format(maxBudget);
                                    setInvalid(priceDisplay, `Giá đề xuất phải nhỏ hơn ngân sách tối đa: ${formattedMaxBudget} VND.`);
                                    return false;
                                }

                                if (priceValue < 50000) {
                                    setInvalid(priceDisplay, "Giá đề xuất tối thiểu 50.000 VND.");
                                    return false;
                                }
                                setValid(priceDisplay);
                                return true;
                            }

                            function validateDuration() {
                                const el = document.querySelector('input[name="duration_days"]');
                                const value = Number(el.value) || 0;
                                const maxDaysByDeadline = Number(document.getElementById('maxDaysByDeadline').value) || 0;

                                if (value < 1) {
                                    setInvalid(el, "Thời gian tối thiểu 1 ngày.");
                                    return false;
                                }

                                if (value > 365) {
                                    setInvalid(el, "Thời gian tối đa 365 ngày.");
                                    return false;
                                }

                                if (maxDaysByDeadline > 0 && value > maxDaysByDeadline) {
                                    setInvalid(el, `Thời gian hoàn thành không được vượt quá ${maxDaysByDeadline} ngày (dựa trên deadline của dự án).`);
                                    return false;
                                }

                                setValid(el);
                                return true;
                            }

                            function validateCoverLetter() {
                                const el = document.querySelector('textarea[name="cover_letter"]');
                                const value = (el.value || "").trim();
                                if (value.length < 100) {
                                    setInvalid(el, "Thư giới thiệu tối thiểu 100 ký tự.");
                                    return false;
                                }
                                if (value.length > 3000) {
                                    setInvalid(el, "Thư giới thiệu tối đa 3000 ký tự.");
                                    return false;
                                }
                                if (containsContactInfo(value)) {
                                    setInvalid(el, "Không được chứa email/số điện thoại/ID chat hoặc từ ngữ thô tục.");
                                    return false;
                                }
                                setValid(el);
                                return true;
                            }

                            // === REAL-TIME VALIDATION ===
                            priceDisplay.addEventListener('input', validatePrice);
                            priceDisplay.addEventListener('blur', validatePrice);

                            const durationInput = document.querySelector('input[name="duration_days"]');
                            durationInput.addEventListener('input', () => {
                                validateDuration();
                                updatePreview();
                            });
                            durationInput.addEventListener('blur', validateDuration);

                            coverLetterTextarea.addEventListener('blur', validateCoverLetter);
                            coverLetterTextarea.addEventListener('input', validateCoverLetter);

                            // === EXTRA DOCS (dynamic) ===
                            const extraDocsContainer = document.getElementById('extraDocsContainer');
                            const addExtraDocBtn = document.getElementById('addExtraDocBtn');

                            const EXTRA_MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB
                            const EXTRA_ALLOWED_EXTS = ['pdf', 'doc', 'docx'];

                            function getExt(filename) {
                                const idx = filename.lastIndexOf('.');
                                return idx >= 0 ? filename.substring(idx + 1).toLowerCase() : '';
                            }

                            function setValidExtra(el) {
                                el.classList.remove('is-invalid');
                                el.classList.add('is-valid');
                            }

                            function setInvalidExtra(el, msg) {
                                el.classList.remove('is-valid');
                                el.classList.add('is-invalid');
                                const feedback = el.parentNode.querySelector('.invalid-feedback');
                                if (feedback && msg)
                                    feedback.textContent = msg;
                            }

                            function validateExtraItem(itemEl, showMsg = true) {
                                const nameInput = itemEl.querySelector('input[name="attachment_names"]');
                                const fileInput = itemEl.querySelector('input[name="attachment_files"]');

                                // Trạng thái
                                function ok(el) {
                                    setValidExtra(el);
                                }
                                function bad(el, msg) {
                                    if (showMsg)
                                        setInvalidExtra(el, msg);
                                }

                                const nameVal = (nameInput.value || '').trim();
                                const fileObj = fileInput.files && fileInput.files[0] ? fileInput.files[0] : null;

                                // Nếu cả name & file đều trống -> coi như khối "bỏ qua" (hợp lệ)
                                if (!nameVal && !fileObj) {
                                    nameInput.classList.remove('is-invalid', 'is-valid');
                                    fileInput.classList.remove('is-invalid', 'is-valid');
                                    return true;
                                }

                                // Nếu có file mà thiếu tên
                                if (fileObj && !nameVal) {
                                    bad(nameInput, 'Vui lòng nhập tên tài liệu.');
                                    ok(fileInput);
                                    return false;
                                }

                                // Nếu có tên mà thiếu file
                                if (nameVal && !fileObj) {
                                    bad(fileInput, 'Vui lòng chọn file PDF/Word (≤ 10MB).');
                                    ok(nameInput);
                                    return false;
                                }

                                // Kiểm tra file (size + đuôi)
                                const ext = getExt(fileObj.name);
                                if (!EXTRA_ALLOWED_EXTS.includes(ext)) {
                                    bad(fileInput, 'Chỉ chấp nhận PDF/Word (.pdf, .doc, .docx).');
                                    ok(nameInput);
                                    return false;
                                }
                                if (fileObj.size > EXTRA_MAX_FILE_SIZE) {
                                    bad(fileInput, 'File quá lớn! Tối đa 10MB.');
                                    ok(nameInput);
                                    return false;
                                }

                                ok(nameInput);
                                ok(fileInput);
                                return true;
                            }

                            function wireItemEvents(itemEl) {
                                const nameInput = itemEl.querySelector('input[name="attachment_names"]');
                                const fileInput = itemEl.querySelector('input[name="attachment_files"]');
                                const removeBtn = itemEl.querySelector('.remove-extra-doc');

                                if (nameInput) {
                                    nameInput.addEventListener('input', () => validateExtraItem(itemEl, false));
                                    nameInput.addEventListener('blur', () => validateExtraItem(itemEl, true));
                                }
                                if (fileInput) {
                                    fileInput.addEventListener('change', () => validateExtraItem(itemEl, true));
                                }
                                if (removeBtn) {
                                    removeBtn.addEventListener('click', () => {
                                        itemEl.style.animation = 'slideInUp 0.3s ease-out reverse';
                                        setTimeout(() => itemEl.remove(), 300);
                                    });
                                }
                            }

                            function createExtraItem() {
                                const wrapper = document.createElement('div');
                                wrapper.className = 'extra-doc-item border-0 rounded-4 p-4 position-relative shadow-sm bg-gradient-light';
                                wrapper.innerHTML = `
                      <button type="button" class="btn btn-sm btn-danger position-absolute shadow-sm remove-extra-doc" 
                              style="top: 12px; right: 12px; border-radius: 50%; width: 35px; height: 35px; display: flex; align-items: center; justify-content: center;" 
                              aria-label="Xóa khối">
                        <i class="bi bi-x-lg"></i>
                      </button>

                      <div class="row g-4 align-items-end">
                        <div class="col-md-6">
                          <label class="form-label fw-semibold text-dark mb-2">
                            <i class="bi bi-tag-fill text-primary me-2"></i>Tên Tài Liệu
                          </label>
                          <input type="text" name="attachment_names" class="form-control form-control-lg rounded-3 border-2" 
                                 placeholder="VD: Hợp đồng mẫu, Tài liệu tham khảo..."
                                 style="border-color: #e3f2fd; transition: all 0.3s ease;">
                          <div class="invalid-feedback fw-medium">Vui lòng nhập tên tài liệu.</div>
                        </div>

                        <div class="col-md-6">
                          <label class="form-label fw-semibold text-dark mb-2">
                            <i class="bi bi-cloud-upload-fill text-success me-2"></i>Chọn File (PDF/Word, ≤ 10MB)
                          </label>
                          <input type="file" name="attachment_files" class="form-control form-control-lg rounded-3 border-2" 
                                 accept=".pdf,.doc,.docx"
                                 style="border-color: #e8f5e8; transition: all 0.3s ease;">
                          <div class="form-text text-muted mt-2">
                            <i class="bi bi-info-circle me-1"></i>
                            Hỗ trợ: <span class="badge bg-primary">PDF</span> 
                            <span class="badge bg-info">.doc</span> 
                            <span class="badge bg-secondary">.docx</span> — Tối đa 10MB
                          </div>
                          <div class="invalid-feedback fw-medium">Chỉ chấp nhận PDF/Word và dung lượng ≤ 10MB.</div>
                        </div>
                      </div>
                    `;
                                wireItemEvents(wrapper);
                                return wrapper;
                            }

                            // Gắn sự kiện cho khối mặc định ban đầu
                            if (extraDocsContainer) {
                                extraDocsContainer.querySelectorAll('.extra-doc-item').forEach(wireItemEvents);
                            }

                            if (addExtraDocBtn) {
                                addExtraDocBtn.addEventListener('click', () => {
                                    const newItem = createExtraItem();
                                    extraDocsContainer.appendChild(newItem);
                                    // Scroll nhẹ tới khối mới
                                    newItem.scrollIntoView({behavior: 'smooth', block: 'center'});
                                });
                            }

                            // === FORM SUBMIT HANDLER ===
                            form.addEventListener('submit', function (e) {
                                const isValid =
                                        validatePrice() &&
                                        validateDuration() &&
                                        validateCoverLetter() &&
                                        validatePortfolio(); // Thêm validation portfolio

                                // Validate extra docs
                                let extrasValid = true;
                                extraDocsContainer.querySelectorAll('.extra-doc-item').forEach(itemEl => {
                                    if (!validateExtraItem(itemEl, true))
                                        extrasValid = false;
                                });

                                if (!isValid || !extrasValid) {
                                    e.preventDefault();
                                    e.stopPropagation();
                                    form.classList.add('was-validated');

                                    // Scroll to first invalid field
                                    const firstInvalid = form.querySelector('.is-invalid');
                                    if (firstInvalid) {
                                        firstInvalid.scrollIntoView({behavior: 'smooth', block: 'center'});
                                        firstInvalid.focus();
                                    }

                                    showNotification('❌ Vui lòng kiểm tra và sửa các lỗi trong form!', 'danger');
                                    return;
                                }

                                // Confirm submit
                                if (!confirm('✅ Bạn có chắc muốn gửi proposal này?\n\nLưu ý: Sau khi gửi, bạn sẽ không thể chỉnh sửa proposal.')) {
                                    e.preventDefault();
                                    return;
                                }

                                // Show loading
                                const submitBtn = document.querySelector('button[type="submit"]');
                                submitBtn.disabled = true;
                                submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span>Đang gửi...';
                            });

                            // Reset form: xoá hết khối, để lại một khối trống
                            form.addEventListener('reset', () => {
                                setTimeout(() => {
                                    extraDocsContainer.innerHTML = '';
                                    extraDocsContainer.appendChild(createExtraItem());
                                    clearFile(); // Reset portfolio file
                                    validatePortfolio(); // Validate portfolio after reset
                                }, 0);
                            });

                            // === HOOK FOR PREVIEW UPDATES ===
                            // Only attach to non-file inputs
                            document.querySelectorAll('input:not([type="file"]), textarea').forEach(el => {
                                el.addEventListener('input', updatePreview);
                            });

                            // Initial validation and preview update
                            updatePreview();
                            validatePortfolio(); // Validate portfolio on page load
                        });
        </script>
    </body>
</html>