<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="vi">
    <%@include file="include/head.jsp" %>
    <body style="background: linear-gradient(135deg, #fff5f0 0%, #ffffff 100%);">
        <div class="container-fluid">
            <div class="row g-0">
                <%@include file="include/sidebar.jsp" %>

                <main class="col-12 col-lg-9 col-xl-10 p-4">
                    <!-- Header -->
                    <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4 gap-3">
                        <div>
                            <h2 class="h3 mb-1 text-dark">
                                <i class="bi bi-person-circle text-warning me-2"></i>Hồ Sơ Người Dùng
                            </h2>
                            <p class="text-muted mb-0">Quản lý thông tin cá nhân và cài đặt tài khoản</p>
                        </div>

                        <div class="d-flex flex-column flex-md-row align-items-stretch align-items-md-center gap-2">
                            <div class="d-flex gap-2">
                                <button class="btn btn-outline-warning btn-sm" data-bs-toggle="modal"
                                        data-bs-target="#editProfileModal">
                                    <i class="bi bi-pencil me-1"></i>Chỉnh sửa
                                </button>
                                <button class="btn btn-warning text-white btn-sm" onclick="exportData()">
                                    <i class="bi bi-download me-1"></i>Xuất dữ liệu
                                </button>
                            </div>
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb mb-0">
                                    <li class="breadcrumb-item">
                                        <a href="${pageContext.request.contextPath}/users/dashboard/"
                                           class="text-warning text-decoration-none">Dashboard</a>
                                    </li>
                                    <li class="breadcrumb-item active">Hồ sơ</li>
                                </ol>
                            </nav>
                        </div>
                    </div>

                    <!-- Thông báo -->
                    <div id="notificationArea" class="mb-3"></div>

                    <div class="row justify-content-center">
                        <div class="col-12">
                            <!-- Main Profile Card -->
                            <div class="card border-0 shadow-sm mb-4"
                                 style="background: linear-gradient(135deg, #ffffff 0%, #fff8f0 100%);">
                                <div class="card-header bg-transparent border-0 p-4">
                                    <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                                        <h5 class="mb-0">
                                            <i class="bi bi-person-fill text-warning me-2"></i>Thông tin cá nhân
                                        </h5>
                                        <div class="d-flex gap-2 flex-wrap">
                                            <span class="badge bg-${currentUser.status == 'ACTIVE' ? 'success' : currentUser.status == 'INACTIVE' ? 'warning' : 'danger'} px-3 py-2">
                                                ${currentUser.status}
                                            </span>
                                            <span class="badge bg-${currentUser.activeStatus == 'ONLINE' ? 'success' : currentUser.activeStatus == 'OFFLINE' ? 'secondary' : 'warning'} bg-opacity-25 px-3 py-2">
                                                <i class="bi bi-circle-fill me-1" style="font-size: 0.6rem;"></i>
                                                ${currentUser.activeStatus}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body p-4 pt-0">
                                    <div class="row g-4">
                                        <!-- Avatar & Basic Info -->
                                        <div class="col-12 col-lg-3">
                                            <div class="text-center">
                                                <div class="position-relative d-inline-block mb-3">
                                                    <c:choose>
                                                        <c:when test="${not empty profile.avatarUrl}">
                                                            <img src="${profile.avatarUrl}" alt="Avatar"
                                                                 class="rounded-circle border"
                                                                 style="width: 120px; height: 120px; object-fit: cover;">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="rounded-circle bg-warning bg-opacity-25 d-flex align-items-center justify-content-center"
                                                                 style="width: 120px; height: 120px;">
                                                                <i class="bi bi-person-fill text-warning"
                                                                   style="font-size: 3rem;"></i>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <button class="btn btn-warning btn-sm rounded-circle position-absolute bottom-0 end-0"
                                                            style="width: 32px; height: 32px;" data-bs-toggle="modal"
                                                            data-bs-target="#uploadAvatarModal">
                                                        <i class="bi bi-camera"></i>
                                                    </button>
                                                </div>

                                                <h5 class="mb-1 fw-bold">${currentUser.fullName}</h5>
                                                <p class="text-muted mb-2">@${currentUser.username}</p>
                                                <p class="mb-3">
                                                    <span class="badge bg-success">${currentUser.role}</span>
                                                </p>

                                                <c:if test="${profile.ratingCount > 0}">
                                                    <div class="d-flex justify-content-center align-items-center gap-1 mb-3">
                                                        <div class="text-warning">
                                                            <c:forEach begin="1" end="5" var="star">
                                                                <i class="bi bi-star${star <= profile.ratingAvg ? '-fill' : star - 0.5 <= profile.ratingAvg ? '-half' : ''}"></i>
                                                            </c:forEach>
                                                        </div>
                                                        <span class="fw-medium text-dark">
                                                            <fmt:formatNumber value="${profile.ratingAvg}"
                                                                              minFractionDigits="1"
                                                                              maxFractionDigits="1"/>
                                                        </span>
                                                        <span class="text-muted">(${profile.ratingCount} đánh giá)</span>
                                                    </div>
                                                </c:if>

                                                <small class="text-muted">
                                                    <i class="bi bi-calendar-check me-1"></i>
                                                    Tham gia từ ${currentUser.createdAt}
                                                    <%--                                            <fmt:formatDate value="${currentUser.createdAt}" pattern="MM/yyyy"/>--%>
                                                </small>
                                            </div>
                                        </div>

                                        <!-- Contact & Bio Info -->
                                        <div class="col-12 col-lg-6">
                                            <div class="row g-3">
                                                <!-- Giới thiệu -->
                                                <div class="col-12">
                                                    <label class="form-label text-muted small fw-medium">Giới thiệu</label>
                                                    <p class="mb-0">
                                                        <c:choose>
                                                            <c:when test="${not empty profile.bio}">
                                                                ${profile.bio}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <em class="text-muted">Chưa có thông tin giới thiệu</em>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                </div>

                                                <!-- Tên đăng nhập -->
                                                <div class="col-12">
                                                    <label class="form-label text-muted small fw-medium">Tên đăng nhập</label>
                                                    <div class="d-flex align-items-center gap-2">
                                                        <i class="bi bi-at text-warning"></i>
                                                        <span>${currentUser.username}</span>
                                                    </div>
                                                </div>

                                                <!-- Email -->
                                                <div class="col-12">
                                                    <label class="form-label text-muted small fw-medium">Email</label>
                                                    <div class="d-flex align-items-center gap-2">
                                                        <i class="bi bi-envelope text-warning"></i>
                                                        <span class="text-break">${currentUser.email}</span>
                                                    </div>
                                                </div>

                                                <!-- Ngày tạo -->
                                                <div class="col-12">
                                                    <label class="form-label text-muted small fw-medium">Ngày tạo</label>
                                                    <div class="d-flex align-items-center gap-2">
                                                        <i class="bi bi-calendar-plus text-warning"></i>
                                                        <span>
                                                            ${currentUser.createdAt}
                                                            <%-- <fmt:formatDate value="${userCreatedAtDate}" pattern="dd/MM/yyyy HH:mm"/> --%>
                                                        </span>
                                                    </div>
                                                </div>

                                                <!-- Cập nhật lần cuối -->
                                                <c:if test="${userUpdatedAtDate != null}">
                                                    <div class="col-12">
                                                        <label class="form-label text-muted small fw-medium">Cập nhật lần cuối</label>
                                                        <div class="d-flex align-items-center gap-2">
                                                            <i class="bi bi-clock-history text-warning"></i>
                                                            <span>
                                                                <fmt:formatDate value="${userUpdatedAtDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>


                                        <!-- Stats & Portfolio -->
                                        <div class="col-12 col-lg-3">
                                            <!-- Quick Stats -->
                                            <div class="row g-2 mb-4">
                                                <div class="col-6 col-lg-12">
                                                    <div class="text-center p-3 rounded bg-light">
                                                        <div class="h5 mb-1 text-warning fw-bold">
                                                            <c:choose>
                                                                <c:when test="${profile.ratingAvg != null and profile.ratingAvg > 0}">
                                                                    <fmt:formatNumber value="${profile.ratingAvg}"
                                                                                      minFractionDigits="1"
                                                                                      maxFractionDigits="1"/>
                                                                </c:when>
                                                                <c:otherwise>N/A</c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <small class="text-muted">Điểm đánh giá</small>
                                                    </div>
                                                </div>
                                                <div class="col-6 col-lg-12">
                                                    <div class="text-center p-3 rounded bg-light">
                                                        <%--                                                <div class="h5 mb-1 text-success fw-bold">${profile.totalJobsCompleted != null ? profile.totalJobsCompleted : 0}</div>--%>
                                                        <small class="text-muted">Job hoàn thành</small>
                                                    </div>
                                                </div>
                                                <div class="col-6 col-lg-12">
                                                    <div class="text-center p-3 rounded bg-light">
                                                        <div class="h6 mb-1 text-info fw-bold">
                                                            <%--                                                    <c:choose>--%>
                                                            <%--                                                        <c:when test="${profile.totalEarnings != null and profile.totalEarnings > 0}">--%>
                                                            <%--                                                            ₫<fmt:formatNumber value="${profile.totalEarnings}"--%>
                                                            <%--                                                                               type="number" groupingUsed="true"/>--%>
                                                            <%--                                                        </c:when>--%>
                                                            <%--                                                        <c:otherwise>₫0</c:otherwise>--%>
                                                            <%--                                                    </c:choose>--%>
                                                        </div>
                                                        <small class="text-muted">Tổng thu nhập</small>
                                                    </div>
                                                </div>
                                                <div class="col-6 col-lg-12">
                                                    <div class="text-center p-3 rounded bg-light">
                                                        <div class="h6 mb-1 text-primary fw-bold">
                                                            <%--                                                    <c:choose>--%>
                                                            <%--                                                        <c:when test="${profile.hourlyRate != null and profile.hourlyRate > 0}">--%>
                                                            <%--                                                            ₫<fmt:formatNumber value="${profile.hourlyRate}"--%>
                                                            <%--                                                                               type="number" groupingUsed="true"/>--%>
                                                            <%--                                                        </c:when>--%>
                                                            <%--                                                        <c:otherwise>Chưa đặt</c:otherwise>--%>
                                                            <%--                                                    </c:choose>--%>
                                                        </div>
                                                        <small class="text-muted">Giá theo giờ</small>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Portfolio Links -->
                                            <div>
                                                <label class="form-label text-muted small fw-medium">Liên kết Portfolio</label>
                                                <c:choose>
                                                    <c:when test="${not empty portfolioLinksList}">
                                                        <div class="d-flex flex-column gap-2">
                                                            <c:forEach items="${portfolioLinksList}" var="link"
                                                                       varStatus="status">
                                                                <a href="${link}" target="_blank"
                                                                   class="text-decoration-none d-flex align-items-center gap-2 p-2 rounded bg-light hover-shadow-sm">
                                                                    <i class="bi bi-link-45deg text-warning"></i>
                                                                    <span class="text-truncate small">Portfolio ${status.index + 1}</span>
                                                                    <i class="bi bi-box-arrow-up-right small text-muted ms-auto"></i>
                                                                </a>
                                                            </c:forEach>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <p class="text-muted small">Chưa có liên kết portfolio</p>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row g-4 mb-4">
                                <!-- Bảo mật tài khoản -->
                                <div class="col-12 col-xl-6">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-header bg-transparent border-0 p-4">
                                            <h5 class="mb-1">
                                                <i class="bi bi-shield-check text-warning me-2"></i>Bảo mật tài khoản
                                            </h5>
                                            <p class="text-muted mb-0 small">Quản lý cài đặt bảo mật cho tài khoản</p>
                                        </div>
                                        <div class="card-body p-4 pt-0">
                                            <div class="list-group list-group-flush">
                                                <div class="list-group-item border-0 px-0 d-flex justify-content-between align-items-center py-3">
                                                    <div>
                                                        <h6 class="mb-1">Mật khẩu</h6>
                                                        <small class="text-muted">
                                                            <c:choose>
                                                                <c:when test="${userUpdatedAtDate != null}">
                                                                    Đổi lần cuối <fmt:formatDate value="${userUpdatedAtDate}"
                                                                                    pattern="dd/MM/yyyy"/>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    Chưa từng thay đổi
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </small>
                                                    </div>
                                                    <button class="btn btn-outline-warning btn-sm" data-bs-toggle="modal"
                                                            data-bs-target="#changePasswordModal">
                                                        Đổi mật khẩu
                                                    </button>
                                                </div>

                                                <div class="list-group-item border-0 px-0 d-flex justify-content-between align-items-center py-3">
                                                    <div>
                                                        <h6 class="mb-1">Xác thực 2 bước</h6>
                                                        <small class="text-muted">Tăng cường bảo mật</small>
                                                    </div>
                                                    <button class="btn btn-secondary btn-sm" disabled>Đang phát triển</button>
                                                </div>

                                                <div class="list-group-item border-0 px-0 d-flex justify-content-between align-items-center py-3">
                                                    <div>
                                                        <h6 class="mb-1">Email xác minh</h6>
                                                        <small class="text-muted">
                                                            <%--                                                    <c:choose>--%>
                                                            <%--                                                        <c:when test="${currentUser.emailVerified}">--%>
                                                            <%--                                                            <span class="text-success">Đã xác minh</span>--%>
                                                            <%--                                                        </c:when>--%>
                                                            <%--                                                        <c:otherwise>--%>
                                                            <%--                                                            Chưa xác minh--%>
                                                            <%--                                                        </c:otherwise>--%>
                                                            <%--                                                    </c:choose>--%>
                                                        </small>
                                                    </div>
                                                    <%--                                            <c:choose>--%>
                                                    <%--                                                <c:when test="${currentUser.emailVerified}">--%>
                                                    <%--                                                    <span class="badge bg-success">Đã xác minh</span>--%>
                                                    <%--                                                </c:when>--%>
                                                    <%--                                                <c:otherwise>--%>
                                                    <%--                                                    <button class="btn btn-outline-warning btn-sm">Xác minh ngay--%>
                                                    <%--                                                    </button>--%>
                                                    <%--                                                </c:otherwise>--%>
                                                    <%--                                            </c:choose>--%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Hoạt động gần đây -->
                                <div class="col-12 col-xl-6">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-header bg-transparent border-0 p-4">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <h5 class="mb-1">
                                                        <i class="bi bi-clock-history text-warning me-2"></i>Hoạt động gần đây
                                                    </h5>
                                                    <p class="text-muted mb-0 small">Các hoạt động mới nhất của tài khoản</p>
                                                </div>
                                                <button class="btn btn-outline-warning btn-sm" onclick="refreshActivities()">
                                                    <i class="bi bi-arrow-clockwise me-1"></i>Làm mới
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body p-0">
                                            <div class="list-group list-group-flush">
                                                <div class="list-group-item border-0 px-4 py-3 d-flex align-items-center gap-3">
                                                    <div class="bg-success bg-opacity-25 rounded-circle p-2 flex-shrink-0">
                                                        <i class="bi bi-check-circle text-success"></i>
                                                    </div>
                                                    <div class="flex-grow-1 min-w-0">
                                                        <h6 class="mb-1">Cập nhật hồ sơ thành công</h6>
                                                        <small class="text-muted">Bạn đã chỉnh sửa thông tin cá nhân</small>
                                                    </div>
                                                    <small class="text-muted text-nowrap">19/08 10:30</small>
                                                </div>

                                                <div class="list-group-item border-0 px-4 py-3 d-flex align-items-center gap-3">
                                                    <div class="bg-info bg-opacity-25 rounded-circle p-2 flex-shrink-0">
                                                        <i class="bi bi-person-check text-info"></i>
                                                    </div>
                                                    <div class="flex-grow-1 min-w-0">
                                                        <h6 class="mb-1">Đăng nhập thành công</h6>
                                                        <small class="text-muted">Thiết bị Chrome • Windows</small>
                                                    </div>
                                                    <small class="text-muted text-nowrap">18/08 08:02</small>
                                                </div>

                                                <div class="list-group-item border-0 px-4 py-3 d-flex align-items-center gap-3">
                                                    <div class="bg-warning bg-opacity-25 rounded-circle p-2 flex-shrink-0">
                                                        <i class="bi bi-exclamation-triangle text-warning"></i>
                                                    </div>
                                                    <div class="flex-grow-1 min-w-0">
                                                        <h6 class="mb-1">Nhắc đổi mật khẩu định kỳ</h6>
                                                        <small class="text-muted">Để tăng bảo mật tài khoản</small>
                                                    </div>
                                                    <small class="text-muted text-nowrap">17/08 21:15</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <!-- Edit Profile Modal -->
        <div class="modal fade" id="editProfileModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <i class="bi bi-pencil text-warning me-2"></i>Chỉnh sửa hồ sơ
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="<c:url value='/profile/update'/>" method="POST" id="editProfileForm">
                        <div class="modal-body">
                            <input type="hidden" name="userId" value="${currentUser.id}"/>

                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Họ tên đầy đủ</label>
                                    <input type="text" class="form-control" name="fullName" value="${currentUser.fullName}"
                                           required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" name="email" value="${currentUser.email}" required>
                                </div>
                                <%--                        <div class="col-md-6">--%>
                                <%--                            <label class="form-label">Số điện thoại</label>--%>
                                <%--                            <input type="tel" class="form-control" name="phoneNumber" value="${profile.phoneNumber}"--%>
                                <%--                                   placeholder="0123456789">--%>
                                <%--                        </div>--%>
                                <%--                        <div class="col-md-6">--%>
                                <%--                            <label class="form-label">Kinh nghiệm (năm)</label>--%>
                                <%--                            <input type="number" class="form-control" name="experienceYears"--%>
                                <%--                                   value="${profile.experienceYears}" min="0" max="50">--%>
                                <%--                        </div>--%>
                                <%--                        <div class="col-md-6">--%>
                                <%--                            <label class="form-label">Giá theo giờ (VNĐ)</label>--%>
                                <%--                            <input type="number" class="form-control" name="hourlyRate" value="${profile.hourlyRate}"--%>
                                <%--                                   min="0" step="1000">--%>
                                <%--                        </div>--%>
                                <%--                        <div class="col-md-6">--%>
                                <%--                            <label class="form-label">Tình trạng</label>--%>
                                <%--                            <select class="form-select" name="isAvailable">--%>
                                <%--                                <option value="true" ${profile.isAvailable ? 'selected' : ''}>Sẵn sàng nhận việc--%>
                                <%--                                </option>--%>
                                <%--                                <option value="false" ${!profile.isAvailable ? 'selected' : ''}>Tạm không nhận việc--%>
                                <%--                                </option>--%>
                                <%--                            </select>--%>
                                <%--                        </div>--%>
                                <%--                        <div class="col-12">--%>
                                <%--                            <label class="form-label">Địa chỉ</label>--%>
                                <%--                            <textarea class="form-control" name="address" rows="2"--%>
                                <%--                                      placeholder="Nhập địa chỉ của bạn">${profile.address}</textarea>--%>
                                <%--                        </div>--%>
                                <div class="col-12">
                                    <label class="form-label">Giới thiệu bản thân</label>
                                    <textarea class="form-control" name="bio" rows="4" maxlength="2000"
                                              placeholder="Mô tả ngắn về bản thân, kinh nghiệm, kỹ năng...">${profile.bio}</textarea>
                                    <div class="form-text">Tối đa 2000 ký tự</div>
                                </div>
                                <%--                        <div class="col-12">--%>
                                <%--                            <label class="form-label">Kỹ năng</label>--%>
                                <%--                            <textarea class="form-control" name="skills" rows="2"--%>
                                <%--                                      placeholder="Các kỹ năng chuyên môn, phân cách bằng dấu phẩy">${profile.skills}</textarea>--%>
                                <%--                            <div class="form-text">Ví dụ: Java, Spring Boot, React, JavaScript, MySQL</div>--%>
                                <%--                        </div>--%>
                                <div class="col-12">
                                    <label class="form-label">Liên kết Portfolio</label>
                                    <textarea class="form-control" name="portfolioLinks" rows="3"
                                              placeholder="Nhập các link portfolio, mỗi link một dòng">${profile.portfolioLinks}</textarea>
                                    <div class="form-text">Mỗi link một dòng (website, Behance, Dribbble, GitHub, v.v.)</div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-warning text-white">
                                <i class="bi bi-save me-1"></i>Lưu thay đổi
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Upload Avatar Modal -->
        <div class="modal fade" id="uploadAvatarModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <i class="bi bi-camera text-warning me-2"></i>Cập nhật ảnh đại diện
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="<c:url value='/profile/upload-avatar'/>" method="POST" enctype="multipart/form-data"
                          id="uploadAvatarForm">
                        <div class="modal-body text-center">
                            <input type="hidden" name="userId" value="${currentUser.id}"/>

                            <div class="mb-3">
                                <div class="position-relative d-inline-block mb-3">
                                    <c:choose>
                                        <c:when test="${not empty profile.avatarUrl}">
                                            <img id="avatarPreview" src="${profile.avatarUrl}" alt="Avatar Preview"
                                                 class="rounded-circle border"
                                                 style="width: 150px; height: 150px; object-fit: cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <div id="avatarPreview"
                                                 class="rounded-circle bg-warning bg-opacity-25 d-flex align-items-center justify-content-center border"
                                                 style="width: 150px; height: 150px;">
                                                <i class="bi bi-person-fill text-warning" style="font-size: 4rem;"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <div class="mb-3">
                                <input type="file" class="form-control" name="avatarFile" id="avatarFile" accept="image/*"
                                       required>
                                <div class="form-text">Chỉ chấp nhận file ảnh (JPG, PNG, GIF). Kích thước tối đa 5MB.</div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-warning text-white">
                                <i class="bi bi-upload me-1"></i>Cập nhật ảnh
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Change Password Modal -->
        <div class="modal fade" id="changePasswordModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <i class="bi bi-key text-warning me-2"></i>Đổi mật khẩu
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="<c:url value='/profile/change-password' />" method="POST" id="changePasswordForm">
                        <div class="modal-body">
                            <input type="hidden" name="userId" value="${currentUser.id}"/>
                            <div class="mb-3">
                                <label class="form-label">Mật khẩu hiện tại</label>
                                <input type="password" class="form-control" name="currentPassword" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Mật khẩu mới</label>
                                <input type="password" class="form-control" name="newPassword" minlength="8" required>
                                <div class="form-text">Tối thiểu 8 ký tự, gồm chữ thường, CHỮ HOA, số và ký tự đặc biệt.</div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Xác nhận mật khẩu mới</label>
                                <input type="password" class="form-control" name="confirmPassword" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-warning text-white">
                                <i class="bi bi-check me-1"></i>Đổi mật khẩu
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                    // =================== PREVIEW AVATAR ===================
                                                    const avatarFile = document.getElementById('avatarFile');
                                                    const avatarPreview = document.getElementById('avatarPreview');

                                                    if (avatarFile && avatarPreview) {
                                                        avatarFile.addEventListener('change', function (e) {
                                                            const file = e.target.files[0];
                                                            if (file) {
                                                                const reader = new FileReader();
                                                                reader.onload = function (e) {
                                                                    if (avatarPreview.tagName === 'IMG') {
                                                                        avatarPreview.src = e.target.result;
                                                                    } else {
                                                                        // Replace div with img
                                                                        const newImg = document.createElement('img');
                                                                        newImg.id = 'avatarPreview';
                                                                        newImg.src = e.target.result;
                                                                        newImg.alt = 'Avatar Preview';
                                                                        newImg.className = 'rounded-circle border';
                                                                        newImg.style = 'width: 150px; height: 150px; object-fit: cover;';
                                                                        avatarPreview.parentNode.replaceChild(newImg, avatarPreview);
                                                                    }
                                                                };
                                                                reader.readAsDataURL(file);
                                                            }
                                                        });
                                                    }

                                                    // =================== UPLOAD AVATAR AJAX ===================
                                                    const uploadAvatarForm = document.getElementById('uploadAvatarForm');
                                                    if (uploadAvatarForm) {
                                                        uploadAvatarForm.addEventListener('submit', function (e) {
                                                            e.preventDefault();
                                                            const formData = new FormData(this);

                                                            // Show loading
                                                            const submitBtn = this.querySelector('button[type="submit"]');
                                                            const originalText = submitBtn.innerHTML;
                                                            submitBtn.innerHTML = '<i class="bi bi-hourglass-split me-1"></i>Đang tải...';
                                                            submitBtn.disabled = true;

                                                            fetch(this.action, {method: 'POST', body: formData})
                                                                    .then(async (r) => {
                                                                        const data = await r.json().catch(() => ({}));
                                                                        if (r.ok && data.status === 'success') {
                                                                            showNotification('🖼️ Cập nhật ảnh đại diện thành công!', 'success');
                                                                            const m = bootstrap.Modal.getInstance(document.getElementById('uploadAvatarModal'));
                                                                            if (m)
                                                                                m.hide();

                                                                            // Reload page to show new avatar
                                                                            setTimeout(() => {
                                                                                window.location.reload();
                                                                            }, 500);
                                                                        } else {
                                                                            showNotification('❌ ' + (data.message || 'Có lỗi xảy ra khi tải ảnh'), 'danger');
                                                                        }
                                                                    })
                                                                    .catch(() => showNotification('❌ Lỗi kết nối. Vui lòng thử lại!', 'danger'))
                                                                    .finally(() => {
                                                                        submitBtn.innerHTML = originalText;
                                                                        submitBtn.disabled = false;
                                                                    });
                                                        });
                                                    }

                                                    // =================== EDIT PROFILE AJAX ===================
                                                    const editProfileForm = document.getElementById('editProfileForm');
                                                    if (editProfileForm) {
                                                        editProfileForm.addEventListener('submit', function (e) {
                                                            e.preventDefault();
                                                            const formData = new FormData(this);
                                                            fetch(this.action, {method: 'POST', body: formData})
                                                                    .then(async (r) => {
                                                                        const data = await r.json().catch(() => ({}));
                                                                        if (r.ok && data.status === 'success') {
                                                                            showNotification(data.message || '🎉 Cập nhật hồ sơ thành công!', 'success');
                                                                            const m = bootstrap.Modal.getInstance(document.getElementById('editProfileModal'));
                                                                            if (m)
                                                                                m.hide();

                                                                            const url = new URL(window.location.href);
                                                                            url.pathname = '${pageContext.request.contextPath}/dashboard/profile';
                                                                            url.searchParams.set('success', 'true');
                                                                            url.searchParams.set('action', 'updated');
                                                                            setTimeout(() => {
                                                                                window.location.href = url.toString();
                                                                            }, 300);
                                                                        } else {
                                                                            showNotification('❌ ' + (data.message || 'Có lỗi xảy ra'), 'danger');
                                                                        }
                                                                    })
                                                                    .catch(() => showNotification('❌ Lỗi kết nối. Vui lòng thử lại!', 'danger'));
                                                        });
                                                    }

                                                    // =================== CHANGE PASSWORD AJAX ===================
                                                    const changePasswordForm = document.getElementById('changePasswordForm');
                                                    if (changePasswordForm) {
                                                        changePasswordForm.addEventListener('submit', function (e) {
                                                            e.preventDefault();
                                                            const newPassword = this.newPassword.value;
                                                            const confirmPassword = this.confirmPassword.value;
                                                            if (newPassword !== confirmPassword) {
                                                                showNotification('❌ Mật khẩu xác nhận không khớp!', 'danger');
                                                                return;
                                                            }
                                                            const formData = new FormData(this);
                                                            fetch(this.action, {method: 'POST', body: formData})
                                                                    .then(async (r) => {
                                                                        const data = await r.json().catch(() => ({}));
                                                                        if (r.ok && data.status === 'success') {
                                                                            showNotification(data.message || '🔒 Đổi mật khẩu thành công!', 'success');
                                                                            const m = bootstrap.Modal.getInstance(document.getElementById('changePasswordModal'));
                                                                            if (m)
                                                                                m.hide();
                                                                            this.reset();

                                                                            const url = new URL(window.location.href);
                                                                            url.pathname = '${pageContext.request.contextPath}/dashboard/profile';
                                                                            url.searchParams.set('success', 'true');
                                                                            url.searchParams.set('action', 'password-changed');
                                                                            setTimeout(() => {
                                                                                window.location.href = url.toString();
                                                                            }, 300);
                                                                        } else {
                                                                            showNotification('❌ ' + (data.message || 'Có lỗi xảy ra'), 'danger');
                                                                        }
                                                                    })
                                                                    .catch(() => showNotification('❌ Lỗi kết nối. Vui lòng thử lại!', 'danger'));
                                                        });
                                                    }

                                                    // =================== Query param toast ===================
                                                    (function () {
                                                        const urlParams = new URLSearchParams(window.location.search);
                                                        if (urlParams.get('success') === 'true') {
                                                            const action = urlParams.get('action');
                                                            if (action === 'updated') {
                                                                showNotification('🎉 Cập nhật hồ sơ thành công!', 'success');
                                                            } else if (action === 'password-changed') {
                                                                showNotification('🔒 Đổi mật khẩu thành công!', 'success');
                                                            }
                                                            window.history.replaceState({}, '', window.location.pathname);
                                                        }
                                                    })();

                                                    // =================== FUNCTIONS ===================
                                                    function exportData() {
                                                        if (confirm('🗂️ Bạn muốn xuất toàn bộ dữ liệu cá nhân?')) {
                                                            window.location.href = '<c:url value="/export"/>';
                                                        }
                                                    }

                                                    function refreshActivities() {
                                                        window.location.reload();
                                                    }

                                                    function showNotification(message, type) {
                                                        const area = document.getElementById('notificationArea');
                                                        if (!area) {
                                                            alert(message);
                                                            return;
                                                        }
                                                        const div = document.createElement('div');
                                                        div.className = `alert alert-${type} alert-dismissible fade show`;
                                                        div.role = 'alert';

                                                        const span = document.createElement('span');
                                                        span.textContent = message || 'Có thông báo nhưng trống nội dung';
                                                        div.appendChild(span);

                                                        const btn = document.createElement('button');
                                                        btn.type = 'button';
                                                        btn.className = 'btn-close';
                                                        btn.setAttribute('data-bs-dismiss', 'alert');
                                                        div.appendChild(btn);

                                                        area.prepend(div);

                                                        setTimeout(() => {
                                                            const alert = bootstrap.Alert.getOrCreateInstance(div);
                                                            alert.close();
                                                        }, 4000);
                                                    }
        </script>
    </body>
</html>