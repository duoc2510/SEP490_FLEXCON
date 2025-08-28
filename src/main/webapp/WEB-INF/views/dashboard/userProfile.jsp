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
                    <div class="d-flex justify-content-between align-items-center mb-4">                      
                        <div>
                            <h2 class="h3 mb-1 text-dark">
                                <i class="bi bi-person-circle text-warning me-2"></i>Hồ Sơ Người Dùng
                            </h2>
                            <p class="text-muted mb-0">Quản lý thông tin cá nhân và cài đặt tài khoản</p>
                        </div>


                        <div class="d-flex align-items-center gap-3">
                            <button class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                                <i class="bi bi-pencil me-1"></i>Chỉnh sửa
                            </button>
                            <button class="btn btn-warning text-white" onclick="exportData()">
                                <i class="bi bi-download me-1"></i>Xuất dữ liệu
                            </button>
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb mb-0">
                                    <li class="breadcrumb-item">
                                        <a href="${pageContext.request.contextPath}/users/dashboard/" class="text-warning text-decoration-none">Dashboard</a>
                                    </li>
                                    <li class="breadcrumb-item active">Hồ sơ</li>
                                </ol>
                            </nav>
                        </div>
                    </div>

                    <!-- Thông báo -->
                    <div id="notificationArea"></div>

                    <div class="row justify-content-center">
                        <div class="col-12">
                            <!-- Thông tin cá nhân -->
                            <div class="card border-0 shadow-sm mb-4" style="background: linear-gradient(135deg, #ffffff 0%, #fff8f0 100%);">
                                <div class="card-header bg-transparent border-0 p-4">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h5 class="mb-0">
                                            <i class="bi bi-person-fill text-warning me-2"></i>Thông tin cá nhân
                                        </h5>
                                        <div class="d-flex gap-2">
                                            <span class="badge bg-${user.status == 'ACTIVE' ? 'success' : user.status == 'INACTIVE' ? 'warning' : 'danger'} px-3 py-2">
                                                ${user.status}
                                            </span>
                                            <span class="badge bg-${user.activeStatus == 'ONLINE' ? 'success' : user.activeStatus == 'OFFLINE' ? 'secondary' : 'warning'} bg-opacity-25 px-3 py-2">
                                                <i class="bi bi-circle-fill me-1" style="font-size: 0.6rem;"></i>
                                                ${user.activeStatus}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body p-4 pt-0">
                                    <div class="row g-4">
                                        <!-- Avatar & Basic Info -->
                                        <div class="col-12 col-md-4 col-lg-3">
                                            <div class="text-center">
                                                <div class="position-relative d-inline-block mb-3">
                                                    <div class="rounded-circle bg-warning bg-opacity-25 d-flex align-items-center justify-content-center" style="width: 120px; height: 120px;">
                                                        <i class="bi bi-person-fill text-warning" style="font-size: 3rem;"></i>
                                                    </div>
                                                    <button class="btn btn-warning btn-sm rounded-circle position-absolute bottom-0 end-0" style="width: 32px; height: 32px;" data-bs-toggle="modal" data-bs-target="#uploadAvatarModal">
                                                        <i class="bi bi-camera"></i>
                                                    </button>
                                                </div>
                                                <h5 class="mb-1 fw-bold">${user.fullName}</h5>
                                                <p class="text-muted mb-2">@${user.username}</p>
                                                <p class="text-muted mb-3">${user.role}</p>

                                                <c:if test="${profile.ratingCount > 0}">
                                                    <div class="d-flex justify-content-center align-items-center gap-1 mb-3">
                                                        <div class="text-warning">
                                                            <c:forEach begin="1" end="5" var="star">
                                                                <i class="bi bi-star${star <= profile.ratingAvg ? '-fill' : star - 0.5 <= profile.ratingAvg ? '-half' : ''}"></i>
                                                            </c:forEach>
                                                        </div>
                                                        <span class="fw-medium text-dark">
                                                            <fmt:formatNumber value="${profile.ratingAvg}" minFractionDigits="1" maxFractionDigits="1"/>
                                                        </span>
                                                        <span class="text-muted">(${profile.ratingCount} đánh giá)</span>
                                                    </div>
                                                </c:if>

                                                <small class="text-muted">
                                                    <i class="bi bi-calendar-check me-1"></i>
                                                    Tham gia từ <fmt:formatDate value="${userCreatedAtDate}" pattern="MM/yyyy"/>
                                                </small>
                                            </div>
                                        </div>

                                        <!-- Profile Details -->
                                        <div class="col-12 col-md-8 col-lg-6">
                                            <div class="row g-3">
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

                                                <div class="col-12 col-sm-6">
                                                    <label class="form-label text-muted small fw-medium">Email</label>
                                                    <div class="d-flex align-items-center gap-2">
                                                        <i class="bi bi-envelope text-warning"></i>
                                                        <span>${user.email}</span>
                                                    </div>
                                                </div>

                                                <div class="col-12 col-sm-6">
                                                    <label class="form-label text-muted small fw-medium">Tên đăng nhập</label>
                                                    <div class="d-flex align-items-center gap-2">
                                                        <i class="bi bi-at text-warning"></i>
                                                        <span>${user.username}</span>
                                                    </div>
                                                </div>

                                                <div class="col-12 col-sm-6">
                                                    <label class="form-label text-muted small fw-medium">Vai trò</label>
                                                    <div class="d-flex align-items-center gap-2">
                                                        <i class="bi bi-person-badge text-warning"></i>
                                                        <span class="badge bg-primary px-3 py-2">${user.role}</span>
                                                    </div>
                                                </div>

                                                <div class="col-12 col-sm-6">
                                                    <label class="form-label text-muted small fw-medium">Ngày tạo</label>
                                                    <div class="d-flex align-items-center gap-2">
                                                        <i class="bi bi-calendar-plus text-warning"></i>
                                                        <span><fmt:formatDate value="${userCreatedAtDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                                                    </div>
                                                </div>

                                                <c:if test="${userUpdatedAtDate != null}">
                                                    <div class="col-12 col-sm-6">
                                                        <label class="form-label text-muted small fw-medium">Cập nhật lần cuối</label>
                                                        <div class="d-flex align-items-center gap-2">
                                                            <i class="bi bi-clock-history text-warning"></i>
                                                            <span><fmt:formatDate value="${userUpdatedAtDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>

                                        <!-- Portfolio Links -->
                                        <div class="col-12 col-lg-3">
                                            <div class="row g-3">
                                                <div class="col-12">
                                                    <label class="form-label text-muted small fw-medium">Liên kết Portfolio</label>
                                                    <c:choose>
                                                        <c:when test="${not empty portfolioLinksList}">
                                                            <div class="d-flex flex-column gap-2">
                                                                <c:forEach items="${portfolioLinksList}" var="link" varStatus="status">
                                                                    <a href="${link}" target="_blank" class="text-decoration-none d-flex align-items-center gap-2">
                                                                        <i class="bi bi-link-45deg text-warning"></i>
                                                                        <span class="text-truncate">Portfolio ${status.index + 1}</span>
                                                                        <i class="bi bi-box-arrow-up-right small text-muted"></i>
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
                                                <div class="list-group-item border-0 px-0 d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <h6 class="mb-1">Mật khẩu</h6>
                                                        <small class="text-muted">
                                                            <c:choose>
                                                                <c:when test="${userUpdatedAtDate != null}">
                                                                    Đổi lần cuối <fmt:formatDate value="${userUpdatedAtDate}" pattern="dd/MM/yyyy"/>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    Chưa từng thay đổi
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </small>
                                                    </div>
                                                    <button class="btn btn-outline-warning btn-sm" data-bs-toggle="modal" data-bs-target="#changePasswordModal">
                                                        Đổi mật khẩu
                                                    </button>
                                                </div>

                                                <div class="list-group-item border-0 px-0 d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <h6 class="mb-1">Xác thực 2 bước</h6>
                                                        <small class="text-muted">Chưa hỗ trợ</small>
                                                    </div>
                                                    <button class="btn btn-secondary btn-sm" disabled>Đang phát triển</button>
                                                </div>

                                                <div class="list-group-item border-0 px-0 d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <h6 class="mb-1">Email xác minh</h6>
                                                        <small class="text-muted">Chưa hỗ trợ</small>
                                                    </div>
                                                    <button class="btn btn-secondary btn-sm" disabled>Đang phát triển</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Thống kê hoạt động (TĨNH) -->
                                <div class="col-12 col-xl-6">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-header bg-transparent border-0 p-4">
                                            <h5 class="mb-1">
                                                <i class="bi bi-graph-up text-warning me-2"></i>Thống kê hoạt động
                                            </h5>
                                            <p class="text-muted mb-0 small">Tổng quan các chỉ số của tài khoản</p>
                                        </div>
                                        <div class="card-body p-4 pt-0">
                                            <div class="row g-3">
                                                <div class="col-6">
                                                    <div class="text-center p-3 rounded bg-light">
                                                        <div class="h4 mb-1 text-warning fw-bold">4.8</div>
                                                        <small class="text-muted">Điểm đánh giá</small>
                                                    </div>
                                                </div>
                                                <div class="col-6">
                                                    <div class="text-center p-3 rounded bg-light">
                                                        <div class="h4 mb-1 text-primary fw-bold">125</div>
                                                        <small class="text-muted">Lượt đánh giá</small>
                                                    </div>
                                                </div>
                                                <div class="col-6">
                                                    <div class="text-center p-3 rounded bg-light">
                                                        <div class="h4 mb-1 text-success fw-bold">12</div>
                                                        <small class="text-muted">Job hoàn thành</small>
                                                    </div>
                                                </div>
                                                <div class="col-6">
                                                    <div class="text-center p-3 rounded bg-light">
                                                        <div class="h4 mb-1 text-info fw-bold">₫24,500,000</div>
                                                        <small class="text-muted">Tổng thu nhập</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Hoạt động gần đây (TĨNH) -->
                            <div class="card border-0 shadow-sm">
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
                                            <div class="bg-success bg-opacity-25 rounded-circle p-2">
                                                <i class="bi bi-check-circle text-success"></i>
                                            </div>
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1">Cập nhật hồ sơ thành công</h6>
                                                <small class="text-muted">Bạn đã chỉnh sửa thông tin cá nhân</small>
                                            </div>
                                            <small class="text-muted">19/08 10:30</small>
                                        </div>

                                        <div class="list-group-item border-0 px-4 py-3 d-flex align-items-center gap-3">
                                            <div class="bg-warning bg-opacity-25 rounded-circle p-2">
                                                <i class="bi bi-exclamation-triangle text-warning"></i>
                                            </div>
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1">Nhắc đổi mật khẩu định kỳ</h6>
                                                <small class="text-muted">Để tăng bảo mật tài khoản</small>
                                            </div>
                                            <small class="text-muted">18/08 21:15</small>
                                        </div>

                                        <div class="list-group-item border-0 px-4 py-3 d-flex align-items-center gap-3">
                                            <div class="bg-info bg-opacity-25 rounded-circle p-2">
                                                <i class="bi bi-info-circle text-info"></i>
                                            </div>
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1">Đăng nhập thành công</h6>
                                                <small class="text-muted">Thiết bị Chrome • Windows</small>
                                            </div>
                                            <small class="text-muted">18/08 08:02</small>
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
                    <form id="editProfileForm">
                        <div class="modal-body">
                            <input type="hidden" name="userId" value="${user.id}"/>

                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Họ tên đầy đủ</label>
                                    <input type="text" class="form-control" name="fullName" value="${user.fullName}" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" name="email" value="${user.email}" required>
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Giới thiệu bản thân</label>
                                    <textarea class="form-control" name="bio" rows="4" maxlength="2000" placeholder="Mô tả ngắn về bản thân, kinh nghiệm, kỹ năng...">${profile.bio}</textarea>
                                    <div class="form-text">Tối đa 2000 ký tự</div>
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Liên kết Portfolio</label>
                                    <textarea class="form-control" name="portfolioLinks" rows="3" placeholder="Nhập các link portfolio, mỗi link một dòng">${profile.portfolioLinks}</textarea>
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

        <!-- Change Password Modal -->
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
                    <form action="<c:url value='/profile/change-password' />"
                          method="POST"
                          id="changePasswordForm">
                        <div class="modal-body">
                            <input type="hidden" name="userId" value="${user.id}"/>

                            <div class="mb-3">
                                <label class="form-label">Mật khẩu hiện tại</label>
                                <input type="password" class="form-control" name="currentPassword" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Mật khẩu mới</label>
                                <input type="password"
                                       class="form-control"
                                       name="newPassword"
                                       minlength="8"
                                       maxlength="64"
                                       pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^A-Za-z0-9])\\S+$"
                                       title="Mật khẩu phải có chữ hoa, chữ thường, số và ký tự đặc biệt."
                                       required>
                                <div class="form-text">
                                    Tối thiểu 8 ký tự, gồm chữ thường, CHỮ HOA, số và ký tự đặc biệt.
                                </div>
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
// === // === EDIT PROFILE ===
                                            const editProfileForm = document.getElementById('editProfileForm');
                                            if (editProfileForm) {
                                                editProfileForm.addEventListener('submit', async function (e) {
                                                    e.preventDefault();
                                                    const formData = new FormData(this);

                                                    try {
                                                        const res = await fetch('<c:url value="/dashboard/profile"/>', {
                                                            method: 'POST',
                                                            body: formData
                                                        });
                                                        const data = await res.json();

                                                        if (data.status === 'success') {
                                                            showNotification(data.message || '🎉 Cập nhật hồ sơ thành công!', 'success');
                                                            bootstrap.Modal.getInstance(document.getElementById('editProfileModal')).hide();
                                                            setTimeout(() => window.location.reload(), 800);
                                                        } else {
                                                            showNotification(data.message || '❌ Có lỗi xảy ra', 'danger');
                                                        }
                                                    } catch (err) {
                                                        showNotification('❌ Lỗi kết nối. Vui lòng thử lại!', 'danger');
                                                    }
                                                });
                                            }

// === CHANGE PASSWORD ===
                                            const changePasswordForm = document.getElementById('changePasswordForm');
                                            if (changePasswordForm) {
                                                changePasswordForm.addEventListener('submit', async function (e) {
                                                    e.preventDefault();

                                                    const newPassword = this.newPassword.value;
                                                    const confirmPassword = this.confirmPassword.value;

                                                    const strongPw = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9])\S{8,64}$/;
                                                    if (newPassword !== confirmPassword) {
                                                        showNotification('❌ Mật khẩu xác nhận không khớp!', 'danger');
                                                        return;
                                                    }
                                                    if (!strongPw.test(newPassword)) {
                                                        showNotification('❌ Mật khẩu mới chưa đủ mạnh (8–64 ký tự, gồm chữ thường, CHỮ HOA, số, ký tự đặc biệt)', 'danger');
                                                        return;
                                                    }

                                                    const formData = new FormData(this);

                                                    try {
                                                        const res = await fetch('<c:url value="/dashboard/profile/change-password"/>', {
                                                            method: 'POST',
                                                            body: formData
                                                        });

                                                        const data = await res.json();

                                                        if (data.status === 'success') {
                                                            showNotification(data.message || '🔒 Đổi mật khẩu thành công!', 'success');
                                                            bootstrap.Modal.getInstance(document.getElementById('changePasswordModal')).hide();
                                                            this.reset();
                                                        } else {
                                                            showNotification(data.message || '❌ Có lỗi xảy ra', 'danger');
                                                        }
                                                    } catch (err) {
                                                        showNotification('❌ Lỗi kết nối. Vui lòng thử lại!', 'danger');
                                                    }
                                                });
                                            }

        </script>

    </body>
</html>
