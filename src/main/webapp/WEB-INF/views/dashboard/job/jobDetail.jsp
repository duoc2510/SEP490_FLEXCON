<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="vi">
    <%@include file="../include/head.jsp" %>
    <body style="background: linear-gradient(135deg, #fff5f0 0%, #ffffff 100%);">
        <div class="container-fluid">
            <div class="row g-0">
                <!-- Sidebar -->
                <%@include file="../include/sidebar.jsp" %>

                <!-- Main Content -->
                <main class="col-12 col-lg-9 col-xl-10 p-4">
                    <!-- Breadcrumb -->
                    <nav aria-label="breadcrumb" class="mb-4">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard/browse-jobs" class="text-decoration-none">Khám Phá Công Việc</a></li>
                            <li class="breadcrumb-item active">
                                <c:choose>
                                    <c:when test="${jobLoaded}">Chi Tiết ${breadcrumbType}</c:when>
                                    <c:otherwise>Chi Tiết Công Việc</c:otherwise>
                                </c:choose>
                            </li>
                        </ol>
                    </nav>

                    <!-- Error State -->
                    <c:if test="${jobNotFound || hasError}">
                        <div class="row justify-content-center">
                            <div class="col-md-8">
                                <div class="card border-0 shadow-sm">
                                    <div class="card-body p-5 text-center">
                                        <i class="bi bi-exclamation-triangle text-warning" style="font-size: 4rem;"></i>
                                        <h3 class="mt-3 mb-3">
                                            <c:choose>
                                                <c:when test="${jobNotFound}">Không Tìm Thấy Công Việc</c:when>
                                                <c:otherwise>Đã Xảy Ra Lỗi</c:otherwise>
                                            </c:choose>
                                        </h3>
                                        <p class="text-muted mb-4">
                                            <c:out value="${errorMessage}" default="Công việc bạn đang tìm kiếm không tồn tại hoặc đã bị xóa." />
                                        </p>
                                        <div class="d-flex gap-3 justify-content-center">
                                            <a href="${pageContext.request.contextPath}/users/explore" class="btn btn-warning text-white">
                                                <i class="bi bi-arrow-left me-2"></i>Quay Lại Danh Sách
                                            </a>
                                            <a href="${pageContext.request.contextPath}/users/dashboard" class="btn btn-outline-warning">
                                                <i class="bi bi-house me-2"></i>Về Trang Chủ
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Job Content - Only show if job loaded successfully -->
                    <c:if test="${jobLoaded && !jobNotFound && !hasError}">
                        <div class="row g-4">
                            <!-- Main Job Content -->
                            <div class="col-12 col-xl-8">
                                <!-- Job Header -->
                                <div class="card border-0 shadow-sm mb-4">
                                    <div class="card-body p-4">
                                        <!-- Job Type & Status -->
                                        <div class="d-flex justify-content-between align-items-start mb-3">
                                            <div class="d-flex gap-2 flex-wrap">
                                                <c:choose>
                                                    <c:when test="${job.type eq 'bidding'}">
                                                        <span class="badge bg-primary px-3 py-2">
                                                            <i class="bi bi-hammer me-1"></i>Dự Án Đấu Thầu
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${job.type eq 'contest'}">
                                                        <span class="badge bg-info px-3 py-2">
                                                            <i class="bi bi-trophy me-1"></i>Cuộc Thi
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${job.type eq 'microtask'}">
                                                        <span class="badge bg-warning px-3 py-2">
                                                            <i class="bi bi-list-task me-1"></i>Tác Vụ Nhỏ
                                                        </span>
                                                    </c:when>
                                                </c:choose>

                                                <c:choose>
                                                    <c:when test="${job.status eq 'OPEN'}">
                                                        <span class="badge bg-success px-3 py-2">
                                                            <i class="bi bi-circle-fill me-1" style="font-size: 8px;"></i>Đang Mở Ứng Tuyển
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${job.status eq 'CLOSED'}">
                                                        <span class="badge bg-danger px-3 py-2">
                                                            <i class="bi bi-x-circle me-1"></i>Đã Đóng
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary px-3 py-2">
                                                            <c:out value="${job.status}"/>
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>

                                                <c:if test="${job.featured}">
                                                    <span class="badge bg-warning text-dark px-3 py-2">
                                                        <i class="bi bi-star-fill me-1"></i>Nổi Bật
                                                    </span>
                                                </c:if>

                                                <c:if test="${job.urgent}">
                                                    <span class="badge bg-danger px-3 py-2">
                                                        <i class="bi bi-exclamation-triangle me-1"></i>Gấp
                                                    </span>
                                                </c:if>
                                            </div>
                                            <div class="dropdown">
                                                <button class="btn btn-outline-secondary btn-sm" data-bs-toggle="dropdown">
                                                    <i class="bi bi-three-dots"></i>
                                                </button>
                                                <ul class="dropdown-menu">
                                                    <li><a class="dropdown-item" href="#"><i class="bi bi-bookmark me-2"></i>Lưu Công Việc</a></li>
                                                    <li><a class="dropdown-item" href="#"><i class="bi bi-share me-2"></i>Chia Sẻ</a></li>
                                                    <li><a class="dropdown-item" href="#"><i class="bi bi-flag me-2"></i>Báo Cáo</a></li>
                                                </ul>
                                            </div>
                                        </div>

                                        <!-- Job Title & Description -->
                                        <h1 class="h3 mb-3"><c:out value="${job.title}"/></h1>
                                        <p class="text-muted mb-4 lead"><c:out value="${job.description}"/></p>

                                        <!-- Job Stats -->
                                        <div class="row g-3 mb-4">
                                            <c:choose>
                                                <c:when test="${job.type eq 'bidding'}">
                                                    <div class="col-6 col-md-3">
                                                        <div class="text-center p-3 bg-light rounded">
                                                            <div class="h5 text-success mb-0">
                                                                <c:out value="${job.budget}"/>₫
                                                            </div>
                                                            <small class="text-muted">Ngân Sách</small>
                                                        </div>
                                                    </div>
                                                    <div class="col-6 col-md-3">
                                                        <div class="text-center p-3 bg-light rounded">
                                                            <div class="h5 text-primary mb-0"><c:out value="${job.deadline}"/></div>
                                                            <small class="text-muted">Hạn Chót</small>
                                                        </div>
                                                    </div>
                                                    <div class="col-6 col-md-3">
                                                        <div class="text-center p-3 bg-light rounded">
                                                            <div class="h5 text-warning mb-0"><c:out value="${job.proposalCount}"/></div>
                                                            <small class="text-muted">Đề Xuất</small>
                                                        </div>
                                                    </div>
                                                    <div class="col-6 col-md-3">
                                                        <div class="text-center p-3 bg-light rounded">
                                                            <div class="h5 text-info mb-0"><c:out value="${job.viewCount}"/></div>
                                                            <small class="text-muted">Lượt Xem</small>
                                                        </div>
                                                    </div>
                                                    <!-- NEW: Lowest Bid -->
                                                    <div class="col-6 col-md-3">
                                                        <div class="text-center p-3 bg-light rounded">
                                                            <div class="h5 mb-0">
                                                                <c:out value="${job.lowestBid != null ? job.lowestBid : 0}"/>₫
                                                            </div>
                                                            <small class="text-muted">Giá Thầu Thấp Nhất</small>
                                                        </div>
                                                    </div>
                                                    <!-- NEW: Selection Mode -->
                                                    <div class="col-6 col-md-3">
                                                        <div class="text-center p-3 bg-light rounded">
                                                            <div class="h6 mb-0">
                                                                <span class="badge bg-secondary">
                                                                    <c:out value="${job.selectionMode}"/>
                                                                </span>
                                                            </div>
                                                            <small class="text-muted">Chế độ của công việc</small>
                                                        </div>
                                                    </div>      
                                                </c:when>
                                                <c:when test="${job.type eq 'contest'}">
                                                    <div class="col-6 col-md-3">
                                                        <div class="text-center p-3 bg-light rounded">
                                                            <div class="h5 text-success mb-0">
                                                                <c:out value="${job.topPrize}"/>₫
                                                            </div>
                                                            <small class="text-muted">Tổng Giải Thưởng</small>
                                                        </div>
                                                    </div>
                                                    <div class="col-6 col-md-3">
                                                        <div class="text-center p-3 bg-light rounded">
                                                            <div class="h5 text-primary mb-0"><c:out value="${job.winnerCount}"/></div>
                                                            <small class="text-muted">Số Người Thắng</small>
                                                        </div>
                                                    </div>
                                                    <div class="col-6 col-md-3">
                                                        <div class="text-center p-3 bg-light rounded">
                                                            <div class="h5 text-warning mb-0"><c:out value="${job.participantCount}"/></div>
                                                            <small class="text-muted">Người Tham Gia</small>
                                                        </div>
                                                    </div>
                                                    <div class="col-6 col-md-3">
                                                        <div class="text-center p-3 bg-light rounded">
                                                            <div class="h5 text-info mb-0"><c:out value="${job.timeLeft}"/></div>
                                                            <small class="text-muted">Thời Gian Còn Lại</small>
                                                        </div>
                                                    </div>
                                                </c:when>
                                                <c:when test="${job.type eq 'microtask'}">
                                                    <div class="col-6 col-md-3">
                                                        <div class="text-center p-3 bg-light rounded">
                                                            <div class="h5 text-success mb-0">
                                                                <c:out value="${job.unitPrice}"/>₫
                                                            </div>
                                                            <small class="text-muted">Mỗi Tác Vụ</small>
                                                        </div>
                                                    </div>
                                                    <div class="col-6 col-md-3">
                                                        <div class="text-center p-3 bg-light rounded">
                                                            <div class="h5 text-primary mb-0"><c:out value="${job.totalTasks}"/></div>
                                                            <small class="text-muted">Tổng Tác Vụ</small>
                                                        </div>
                                                    </div>
                                                    <div class="col-6 col-md-3">
                                                        <div class="text-center p-3 bg-light rounded">
                                                            <div class="h5 text-warning mb-0"><c:out value="${job.maxWorkers}"/></div>
                                                            <small class="text-muted">Số Lượng Tối Đa</small>
                                                        </div>
                                                    </div>
                                                    <div class="col-6 col-md-3">
                                                        <div class="text-center p-3 bg-light rounded">
                                                            <div class="h5 text-info mb-0"><c:out value="${job.completedTasks}"/>/<c:out value="${job.totalTasks}"/></div>
                                                            <small class="text-muted">Tiến Độ</small>
                                                        </div>
                                                    </div>
                                                </c:when>
                                            </c:choose>
                                        </div>
                                        <!-- Action Buttons (dùng biến từ Controller) -->
                                        <div class="d-flex flex-wrap gap-3">

                                            <!-- Chưa đăng nhập -->
                                            <c:if test="${!isLoggedIn}">
                                                <button class="btn btn-warning text-white btn-lg" onclick="showLoginModal()">
                                                    <i class="bi bi-lock me-2"></i>Đăng Nhập Để Ứng Tuyển
                                                </button>
                                                <button class="btn btn-outline-warning btn-lg" onclick="showRegisterModal()">
                                                    <i class="bi bi-person-plus me-2"></i>Đăng Ký Để Ứng Tuyển
                                                </button>
                                            </c:if>


                                            <c:if test="${isLoggedIn}">

                                                <c:if test="${canApply}">
                                                    <c:choose>

                                                        <c:when test="${!hasApplied}">
                                                            <form method="get" action="<c:url value='/dashboard/createproposal'/>" style="display:inline">
                                                                <input type="hidden" name="id" value="${job.id}"/>
                                                                <button class="btn btn-warning text-white btn-lg" id="applyBtn" type="submit">
                                                                    <i class="bi bi-plus-circle me-2"></i>
                                                                    <c:out value="${empty actionText ? 'Gửi Đề Xuất' : actionText}"/>
                                                                </button>
                                                            </form>

                                                        </c:when>

                                                        <c:otherwise>
                                                            <button class="btn btn-success btn-lg" disabled>
                                                                <i class="bi bi-check-circle me-2"></i>Đã Ứng Tuyển
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:if>

                                                <c:if test="${!canApply}">
                                                    <button class="btn btn-outline-secondary btn-lg" disabled>
                                                        <i class="bi bi-info-circle me-2"></i>Tài khoản hiện tại không thể ứng tuyển
                                                    </button>
                                                </c:if>


                                                <button class="btn ${isSaved ? 'btn-warning text-white' : 'btn-outline-warning'} btn-lg save-job-btn"
                                                        data-job-id="${job.id}">
                                                    <i class="bi ${isSaved ? 'bi-bookmark-check' : 'bi-bookmark'} me-2"></i>
                                                    <span class="save-text">${isSaved ? 'Đã Lưu' : 'Lưu Công Việc'}</span>
                                                </button>
                                            </c:if>

                                        </div>
                                    </div>
                                </div>

                                <!-- Job Details Tabs -->
                                <div class="card border-0 shadow-sm mb-4">
                                    <div class="card-header bg-transparent border-0 p-0">
                                        <ul class="nav nav-tabs border-0" id="jobDetailTabs" role="tablist">
                                            <li class="nav-item" role="presentation">
                                                <button class="nav-link active border-0 px-4 py-3" id="details-tab" data-bs-toggle="tab" data-bs-target="#details" type="button" role="tab">
                                                    <i class="bi bi-info-circle me-2"></i>Chi Tiết Công Việc
                                                </button>
                                            </li>
                                            <li class="nav-item" role="presentation">
                                                <button class="nav-link border-0 px-4 py-3" id="requirements-tab" data-bs-toggle="tab" data-bs-target="#requirements" type="button" role="tab">
                                                    <i class="bi bi-list-check me-2"></i>Yêu Cầu
                                                </button>
                                            </li>
                                            <c:if test="${job.type eq 'contest'}">
                                                <li class="nav-item" role="presentation">
                                                    <button class="nav-link border-0 px-4 py-3" id="criteria-tab" data-bs-toggle="tab" data-bs-target="#criteria" type="button" role="tab">
                                                        <i class="bi bi-award me-2"></i>Tiêu Chí Đánh Giá
                                                    </button>
                                                </li>
                                            </c:if>
                                            <li class="nav-item" role="presentation">
                                                <button class="nav-link border-0 px-4 py-3" id="submissions-tab" data-bs-toggle="tab" data-bs-target="#submissions" type="button" role="tab">
                                                    <i class="bi bi-people me-2"></i>Người Tham Gia (<c:out value="${job.submissionCount}"/>)
                                                </button>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="card-body p-4">
                                        <div class="tab-content" id="jobDetailTabsContent">
                                            <!-- Job Details Tab -->
                                            <div class="tab-pane fade show active" id="details" role="tabpanel">
                                                <div class="row g-4">
                                                    <div class="col-md-8">
                                                        <h5 class="mb-3">Mô Tả Dự Án</h5>
                                                        <div class="mb-4">
                                                            <c:out value="${job.detailedDescription}" escapeXml="false"/>
                                                        </div>

                                                        <h5 class="mb-3">Chúng tôi đang tìm kiếm:</h5>
                                                        <ul class="list-unstyled">
                                                            <c:forEach var="requirement" items="${job.requirements}">
                                                                <li class="mb-2">
                                                                    <i class="bi bi-check-circle text-success me-2"></i>
                                                                    <c:out value="${requirement}"/>
                                                                </li>
                                                            </c:forEach>
                                                        </ul>

                                                        <h5 class="mb-3">Kỹ Năng Cần Thiết</h5>
                                                        <div class="d-flex flex-wrap gap-2 mb-4">
                                                            <c:forEach var="skill" items="${job.skills}">
                                                                <span class="badge bg-light text-dark border px-3 py-2">
                                                                    <c:out value="${skill}"/>
                                                                </span>
                                                            </c:forEach>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="bg-light rounded p-3">
                                                            <h6 class="mb-3">Thời Gian Dự Án</h6>
                                                            <div class="mb-3">
                                                                <small class="text-muted">Ngày đăng:</small>
                                                                <div class="fw-bold"><c:out value="${job.postedDate}"/></div>
                                                            </div>
                                                            <div class="mb-3">
                                                                <small class="text-muted">Hạn chót:</small>
                                                                <div class="fw-bold text-danger"><c:out value="${job.deadline}"/></div>
                                                            </div>
                                                            <div class="mb-3">
                                                                <small class="text-muted">Thời gian dự kiến:</small>
                                                                <div class="fw-bold"><c:out value="${job.duration}"/></div>
                                                            </div>
                                                            <div class="mb-3">
                                                                <small class="text-muted">Trình độ kinh nghiệm:</small>
                                                                <div class="fw-bold">
                                                                    <c:choose>
                                                                        <c:when test="${job.experienceLevel eq 'entry'}">
                                                                            <span class="badge bg-success">Mới Bắt Đầu</span>
                                                                        </c:when>
                                                                        <c:when test="${job.experienceLevel eq 'intermediate'}">
                                                                            <span class="badge bg-warning">Trung Cấp</span>
                                                                        </c:when>
                                                                        <c:when test="${job.experienceLevel eq 'expert'}">
                                                                            <span class="badge bg-danger">Chuyên Gia</span>
                                                                        </c:when>
                                                                    </c:choose>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Requirements Tab -->
                                            <div class="tab-pane fade" id="requirements" role="tabpanel">
                                                <div class="row g-4">
                                                    <div class="col-md-6">
                                                        <h5 class="mb-3">Yêu Cầu Kỹ Thuật</h5>
                                                        <ul class="list-group list-group-flush">
                                                            <c:forEach var="tech" items="${job.technicalRequirements}">
                                                                <li class="list-group-item border-0 px-0">
                                                                    <i class="bi bi-gear text-primary me-2"></i>
                                                                    <c:out value="${tech}"/>
                                                                </li>
                                                            </c:forEach>
                                                        </ul>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <h5 class="mb-3">Sản Phẩm Bàn Giao</h5>
                                                        <ul class="list-group list-group-flush">
                                                            <c:forEach var="deliverable" items="${job.deliverables}">
                                                                <li class="list-group-item border-0 px-0">
                                                                    <i class="bi bi-box-seam text-success me-2"></i>
                                                                    <c:out value="${deliverable}"/>
                                                                </li>
                                                            </c:forEach>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Contest Criteria Tab -->
                                            <c:if test="${job.type eq 'contest'}">
                                                <div class="tab-pane fade" id="criteria" role="tabpanel">
                                                    <h5 class="mb-3">Tiêu Chí Đánh Giá</h5>
                                                    <div class="row g-3">
                                                        <c:forEach var="criteria" items="${criteriaMap[job.id]}">
                                                            <div class="col-md-6">
                                                                <div class="card border">
                                                                    <div class="card-body p-3">
                                                                        <h6 class="mb-2">
                                                                            <i class="bi bi-award text-warning me-2"></i>
                                                                            <c:out value="${criteria.name}"/>
                                                                        </h6>
                                                                        <p class="text-muted small mb-2">
                                                                            <c:out value="${criteria.description}"/>
                                                                        </p>
                                                                        <div class="d-flex justify-content-between">
                                                                            <span class="text-muted small">Trọng số:</span>
                                                                            <span class="fw-bold"><c:out value="${criteria.weight}"/>%</span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </c:if>

                                            <!-- Submissions Tab -->
                                            <div class="tab-pane fade" id="submissions" role="tabpanel">
                                                <div class="d-flex justify-content-between align-items-center mb-3">
                                                    <h5 class="mb-0">Người Tham Gia Gần Đây</h5>
                                                    <select class="form-select" style="width: auto;">
                                                        <option>Mới Nhất</option>
                                                        <option>Đánh Giá Cao Nhất</option>
                                                        <option>Giá Thấp Nhất</option>
                                                    </select>
                                                </div>

                                                <div class="row g-3">
                                                    <c:forEach var="submission" items="${recentSubmissions}" varStatus="status">
                                                        <c:if test="${status.index < 6}">
                                                            <div class="col-md-6">
                                                                <div class="card border">
                                                                    <div class="card-body p-3">
                                                                        <div class="d-flex align-items-center mb-2">
                                                                            <img src="https://i.pravatar.cc/32?img=${status.index + 10}" class="rounded-circle me-2" width="32" height="32">
                                                                            <div>
                                                                                <h6 class="mb-0"><c:out value="${submission.freelancerName}"/></h6>
                                                                                <div class="text-warning small">
                                                                                    <c:forEach begin="1" end="${submission.rating}">
                                                                                        <i class="bi bi-star-fill"></i>
                                                                                    </c:forEach>
                                                                                    <span class="text-muted ms-1">(<c:out value="${submission.reviewCount}"/>)</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <c:if test="${job.type eq 'bidding'}">
                                                                            <div class="d-flex justify-content-between">
                                                                                <span class="text-muted">Giá đề xuất:</span>
                                                                                <span class="fw-bold text-success">
                                                                                    <c:out value="${submission.bidAmount}"/>₫
                                                                                </span>
                                                                            </div>
                                                                        </c:if>
                                                                        <small class="text-muted">
                                                                            <c:out value="${submission.timeAgo}"/>
                                                                        </small>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:if>
                                                    </c:forEach>
                                                </div>

                                                <div class="text-center mt-4">
                                                    <button class="btn btn-outline-warning">
                                                        <i class="bi bi-eye me-1"></i>Xem Tất Cả
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- FAQ Section -->
                                <div class="card border-0 shadow-sm">
                                    <div class="card-header bg-transparent border-0 p-4">
                                        <h5 class="mb-0">
                                            <i class="bi bi-question-circle text-warning me-2"></i>Câu Hỏi Thường Gặp
                                        </h5>
                                    </div>
                                    <div class="card-body p-4">
                                        <div class="accordion" id="faqAccordion">
                                            <div class="accordion-item border-0 border-bottom">
                                                <h2 class="accordion-header">
                                                    <button class="accordion-button collapsed bg-transparent border-0" type="button" data-bs-toggle="collapse" data-bs-target="#faq1">
                                                        Làm thế nào để gửi đề xuất?
                                                    </button>
                                                </h2>
                                                <div id="faq1" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                                    <div class="accordion-body text-muted">
                                                        Nhấp vào nút "Gửi Đề Xuất" ở trên và điền vào biểu mẫu với phương pháp tiếp cận, thời gian và giá cả của bạn.
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="accordion-item border-0 border-bottom">
                                                <h2 class="accordion-header">
                                                    <button class="accordion-button collapsed bg-transparent border-0" type="button" data-bs-toggle="collapse" data-bs-target="#faq2">
                                                        Phương thức thanh toán là gì?
                                                    </button>
                                                </h2>
                                                <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                                    <div class="accordion-body text-muted">
                                                        Thanh toán được xử lý thông qua hệ thống ký quỹ an toàn của chúng tôi. Tiền sẽ được giải ngân khi hoàn thành từng mốc.
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="accordion-item border-0">
                                                <h2 class="accordion-header">
                                                    <button class="accordion-button collapsed bg-transparent border-0" type="button" data-bs-toggle="collapse" data-bs-target="#faq3">
                                                        Tôi có thể đặt câu hỏi trước khi ứng tuyển không?
                                                    </button>
                                                </h2>
                                                <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                                    <div class="accordion-body text-muted">
                                                        Có, bạn có thể sử dụng tính năng "Đặt Câu Hỏi" bên dưới để làm rõ bất kỳ yêu cầu nào với khách hàng.
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Right Sidebar -->
                            <div class="col-12 col-xl-4">
                                <!-- Employer Information -->
                                <div class="card border-0 shadow-sm mb-4">
                                    <div class="card-header bg-transparent border-0 p-3">
                                        <h6 class="mb-0">
                                            <i class="bi bi-person-circle text-warning me-2"></i>Về Khách Hàng
                                        </h6>
                                    </div>
                                    <div class="card-body p-3">
                                        <div class="text-center mb-3">
                                            <img src="https://i.pravatar.cc/80?img=5" class="rounded-circle mb-2" width="80" height="80">
                                            <h6 class="mb-1"><c:out value="${job.employerName}"/></h6>
                                            <div class="text-warning small mb-2">
                                                <c:forEach begin="1" end="${job.employerRating}">
                                                    <i class="bi bi-star-fill"></i>
                                                </c:forEach>
                                                <span class="text-muted ms-1">(<c:out value="${job.employerReviews}"/> đánh giá)</span>
                                            </div>
                                            <span class="badge bg-success">Khách Hàng Đã Xác Minh</span>
                                        </div>

                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <small class="text-muted">Thành viên từ</small>
                                                <div class="fw-bold"><c:out value="${job.employerMemberSince}"/></div>
                                            </div>
                                            <div class="col-6">
                                                <small class="text-muted">Công việc đã đăng</small>
                                                <div class="fw-bold"><c:out value="${job.employerJobsPosted}"/></div>
                                            </div>
                                            <div class="col-6">
                                                <small class="text-muted">Tổng chi tiêu</small>
                                                <div class="fw-bold">
                                                    <c:out value="${job.employerTotalSpent}"/>₫
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <small class="text-muted">Địa điểm</small>
                                                <div class="fw-bold"><c:out value="${job.employerLocation}"/></div>
                                            </div>
                                        </div>

                                        <div class="d-grid gap-2">
                                            <button class="btn btn-outline-warning btn-sm">
                                                <i class="bi bi-envelope me-1"></i>Liên Hệ Khách Hàng
                                            </button>
                                            <button class="btn btn-outline-secondary btn-sm">
                                                <i class="bi bi-eye me-1"></i>Xem Hồ Sơ
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Quick Stats -->
                                <div class="card border-0 shadow-sm mb-4">
                                    <div class="card-header bg-transparent border-0 p-3">
                                        <h6 class="mb-0">
                                            <i class="bi bi-graph-up text-warning me-2"></i>Thống Kê Công Việc
                                        </h6>
                                    </div>
                                    <div class="card-body p-3">
                                        <div class="row g-2">
                                            <div class="col-6">
                                                <div class="text-center p-2 bg-light rounded">
                                                    <div class="h6 text-primary mb-0"><c:out value="${job.proposalCount}"/></div>
                                                    <small class="text-muted">Đề Xuất</small>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-center p-2 bg-light rounded">
                                                    <div class="h6 text-success mb-0">
                                                        <c:out value="${job.avgBid}"/>₫
                                                    </div>
                                                    <small class="text-muted">Giá TB</small>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-center p-2 bg-light rounded">
                                                    <div class="h6 text-warning mb-0"><c:out value="${job.viewCount}"/></div>
                                                    <small class="text-muted">Lượt Xem</small>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-center p-2 bg-light rounded">
                                                    <div class="h6 text-info mb-0"><c:out value="${job.watchingCount}"/></div>
                                                    <small class="text-muted">Theo Dõi</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Similar Jobs -->
                                <div class="card border-0 shadow-sm mb-4">
                                    <div class="card-header bg-transparent border-0 p-3">
                                        <h6 class="mb-0">
                                            <i class="bi bi-lightbulb text-warning me-2"></i>Công Việc Tương Tự
                                        </h6>
                                    </div>
                                    <div class="card-body p-3">
                                        <c:forEach var="similarJob" items="${similarJobs}" varStatus="status">
                                            <c:if test="${status.index < 3}">
                                                <div class="border-bottom pb-3 mb-3">
                                                    <h6 class="mb-1">
                                                        <a href="${pageContext.request.contextPath}/users/explore/detail?id=${similarJob.id}" class="text-decoration-none">
                                                            <c:out value="${similarJob.title}"/>
                                                        </a>
                                                    </h6>
                                                    <p class="text-muted small mb-2">
                                                        <c:out value="${similarJob.shortDescription}"/>
                                                    </p>
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <c:if test="${similarJob.budget != null}">
                                                            <span class="text-success fw-bold">
                                                                <c:out value="${similarJob.budget}"/>₫
                                                            </span>
                                                        </c:if>
                                                        <small class="text-muted"><c:out value="${similarJob.timeAgo}"/></small>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                        <button class="btn btn-outline-warning btn-sm w-100">
                                            <i class="bi bi-search me-1"></i>Xem Thêm Công Việc
                                        </button>
                                    </div>
                                </div>

                                <!-- Application Tips -->
                                <div class="card border-0 shadow-sm">
                                    <div class="card-header bg-transparent border-0 p-3">
                                        <h6 class="mb-0">
                                            <i class="bi bi-lightbulb text-warning me-2"></i>Mẹo Ứng Tuyển
                                        </h6>
                                    </div>
                                    <div class="card-body p-3">
                                        <ul class="list-unstyled mb-0">
                                            <li class="mb-2">
                                                <i class="bi bi-check-circle text-success me-2"></i>
                                                <small>Đọc kỹ mô tả công việc</small>
                                            </li>
                                            <li class="mb-2">
                                                <i class="bi bi-check-circle text-success me-2"></i>
                                                <small>Nội bật kinh nghiệm liên quan</small>
                                            </li>
                                            <li class="mb-2">
                                                <i class="bi bi-check-circle text-success me-2"></i>
                                                <small>Đính kèm mẫu portfolio</small>
                                            </li>
                                            <li class="mb-2">
                                                <i class="bi bi-check-circle text-success me-2"></i>
                                                <small>Đưa ra giá thực tế</small>
                                            </li>
                                            <li>
                                                <i class="bi bi-check-circle text-success me-2"></i>
                                                <small>Đặt câu hỏi làm rõ</small>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </main>
            </div>
        </div>

        <!-- Login Modal for Guests -->
        <div class="modal fade" id="loginModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Yêu Cầu Đăng Nhập</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body text-center">
                        <i class="bi bi-lock fs-1 text-warning mb-3"></i>
                        <h6 class="mb-3">Vui lòng đăng nhập để ứng tuyển công việc này</h6>
                        <p class="text-muted mb-4">Tham gia cùng hàng nghìn freelancer kiếm tiền trên nền tảng của chúng tôi</p>
                        <div class="d-grid gap-2">
                            <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-warning text-white">
                                <i class="bi bi-box-arrow-in-right me-2"></i>Đăng Nhập
                            </a>
                            <a href="${pageContext.request.contextPath}/signup" class="btn btn-outline-warning">
                                <i class="bi bi-person-plus me-2"></i>Tạo Tài Khoản
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                    function showLoginModal() {
                                                        const loginModal = new bootstrap.Modal(document.getElementById('loginModal'));
                                                        loginModal.show();
                                                    }

                                                    function showRegisterModal() {
                                                        window.location.href = '${pageContext.request.contextPath}/signup';
                                                    }

                                                    document.addEventListener('DOMContentLoaded', function () {
                                                        // Save job functionality
                                                        document.querySelectorAll('.save-job-btn').forEach(btn => {
                                                            btn.addEventListener('click', function () {
                                                                const saveText = this.querySelector('.save-text');
                                                                const icon = this.querySelector('i');

                                                                if (saveText.textContent.includes('Lưu')) {
                                                                    saveText.textContent = 'Đã Lưu';
                                                                    icon.className = 'bi bi-bookmark-check me-2';
                                                                    this.classList.remove('btn-outline-warning');
                                                                    this.classList.add('btn-warning', 'text-white');
                                                                } else {
                                                                    saveText.textContent = 'Lưu Công Việc';
                                                                    icon.className = 'bi bi-bookmark me-2';
                                                                    this.classList.remove('btn-warning', 'text-white');
                                                                    this.classList.add('btn-outline-warning');
                                                                }
                                                            });
                                                        });

                                                        // Tab switching
                                                        const tabs = document.querySelectorAll('#jobDetailTabs button[data-bs-toggle="tab"]');
                                                        tabs.forEach(tab => {
                                                            tab.addEventListener('shown.bs.tab', function (event) {
                                                                console.log('Switched to tab:', event.target.id);
                                                            });
                                                        });
                                                    });
        </script>
    </body>
</html>