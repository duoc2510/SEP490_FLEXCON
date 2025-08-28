<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Đăng nhập - FLEXCON</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

        <!-- SweetAlert for message popup -->
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                /* ---- SweetAlert message (from session) ---- */
                var msg = "${sessionScope.message}";
                var type = "${sessionScope.messageType}";
                if (msg && msg.trim() !== "") {
                    var icon = (type === "error") ? "error" : (type === "info" ? "info" : "success");
                    swal({
                        title: icon === "error" ? "Lỗi" : "Thông báo",
                        text: msg,
                        icon: icon,
                        button: "Đồng ý"
                    });
                }
            });
        </script>
        <c:if test="${not empty sessionScope.message}">
            <c:remove var="message" scope="session"/>
            <c:remove var="messageType" scope="session"/>
        </c:if>
    </head>
    <body style="background-color:#fd7e14">
        <div class="container-fluid">
            <div class="row justify-content-center align-items-center min-vh-100">
                <div class="col-11 col-sm-8 col-md-6 col-lg-5 col-xl-4">

                    <div class="card border-0 shadow-lg">
                        <div class="card-body p-5">
                            <div class="text-center mb-4">
                                <div class="d-inline-flex align-items-center justify-content-center bg-warning text-white rounded-circle mb-3" style="width:60px;height:60px;">
                                    <i class="bi bi-hexagon-fill fs-3"></i>
                                </div>
                                <h2 class="h3 mb-1">Chào mừng đến với FLEXCON</h2>
                                <p class="text-muted mb-0">Đăng nhập vào tài khoản của bạn</p>
                            </div>

                            <!-- Login Form -->
                            <form id="loginForm" action="<c:url value='/auth/login'/>" method="POST" novalidate>
                                <c:if test="${not empty _csrf}">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                </c:if>

                                <!-- Email -->
                                <div class="mb-3">
                                    <label for="email" class="form-label fw-medium">Địa chỉ email</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0">
                                            <i class="bi bi-envelope text-muted"></i>
                                        </span>
                                        <input type="email" class="form-control border-start-0 ps-0" id="email" name="email"
                                               placeholder="Nhập email của bạn" required>
                                    </div>
                                    <div class="invalid-feedback">Vui lòng nhập địa chỉ email hợp lệ.</div>
                                </div>

                                <!-- Password -->
                                <div class="mb-3">
                                    <label for="password" class="form-label fw-medium">Mật khẩu</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0">
                                            <i class="bi bi-lock text-muted"></i>
                                        </span>
                                        <input type="password" class="form-control border-start-0 border-end-0 ps-0" id="password" name="password"
                                               placeholder="Nhập mật khẩu của bạn" required>
                                        <button class="btn btn-outline-secondary border-start-0" type="button" id="togglePassword" aria-label="Hiện/ẩn mật khẩu">
                                            <i class="bi bi-eye" id="toggleIcon"></i>
                                        </button>
                                    </div>
                                    <div class="invalid-feedback">Vui lòng nhập mật khẩu.</div>
                                </div>

                                <!-- Remember & Forgot -->
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="rememberMe" name="remember">
                                        <label class="form-check-label small" for="rememberMe">Ghi nhớ đăng nhập</label>
                                    </div>
                                    <a href="#" class="text-decoration-none small text-warning" data-bs-toggle="modal" data-bs-target="#forgotPasswordModal">
                                        Quên mật khẩu?
                                    </a>
                                </div>

                                <!-- Submit -->
                                <button type="submit" class="btn btn-warning text-white w-100 py-3 fw-medium mb-3" id="loginBtn">
                                    <span class="btn-text"><i class="bi bi-box-arrow-in-right me-2"></i>Đăng nhập</span>
                                    <span class="spinner-border spinner-border-sm d-none me-2" role="status">
                                        <span class="visually-hidden">Đang xử lý...</span>
                                    </span>
                                </button>

                                <!-- Server error -->
                                <c:if test="${not empty param.error || (not empty message && messageType eq 'error')}">
                                    <div class="alert alert-danger" role="alert">
                                        <i class="bi bi-exclamation-triangle me-2"></i>
                                        <span>
                                            <c:choose>
                                                <c:when test="${not empty message}">${message}</c:when>
                                                <c:otherwise>Email hoặc mật khẩu không đúng.</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    <c:remove var="message" scope="session"/>
                                    <c:remove var="messageType" scope="session"/>
                                </c:if>
                            </form>

                            <!-- Divider -->
                            <div class="text-center my-4">
                                <span class="text-muted small">hoặc tiếp tục bằng</span>
                            </div>

                            <!-- Social buttons -->
                            <div class="d-grid gap-2 mb-4">
                                <a class="btn btn-outline-secondary py-2" href="<c:url value='/oauth2/authorization/google'/>">
                                    <i class="bi bi-google text-danger me-2"></i>Đăng nhập với Google
                                </a>
                                <a class="btn btn-outline-secondary py-2" href="#">
                                    <i class="bi bi-facebook text-primary me-2"></i>Đăng nhập với Facebook
                                </a>
                            </div>

                            <div class="text-center">
                                <p class="mb-0 small text-muted">
                                    Chưa có tài khoản?
                                    <a href="<c:url value='/signup'/>" class="text-warning text-decoration-none fw-medium">Đăng ký tại đây</a>
                                </p>
                            </div>
                        </div>

                        <div class="card-footer bg-light border-0 text-center py-3">
                            <small class="text-muted">
                                Bằng việc đăng nhập, bạn đồng ý với
                                <a href="#" class="text-warning text-decoration-none">Điều khoản dịch vụ</a> và
                                <a href="#" class="text-warning text-decoration-none">Chính sách bảo mật</a>
                                của chúng tôi.
                            </small>
                        </div>
                    </div>

                    <!-- Quick Stats -->
                    <div class="row text-center text-white mt-4">
                        <div class="col-4"><div class="h5 mb-0">10K+</div><small class="opacity-75">Người dùng hoạt động</small></div>
                        <div class="col-4"><div class="h5 mb-0">5K+</div><small class="opacity-75">Dự án</small></div>
                        <div class="col-4"><div class="h5 mb-0">99%</div><small class="opacity-75">Tỷ lệ thành công</small></div>
                    </div>

                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Toggle show/hide password
                const togglePassword = document.getElementById('togglePassword');
                const passwordInput = document.getElementById('password');
                const toggleIcon = document.getElementById('toggleIcon');
                togglePassword.addEventListener('click', function () {
                    const type = passwordInput.type === 'password' ? 'text' : 'password';
                    passwordInput.type = type;
                    toggleIcon.classList.toggle('bi-eye');
                    toggleIcon.classList.toggle('bi-eye-slash');
                });

                // Submit: chỉ kiểm tra HTML5; KHÔNG chặn submit -> POST tới controller
                const loginForm = document.getElementById('loginForm');
                const loginBtn = document.getElementById('loginBtn');
                const btnText = loginBtn.querySelector('.btn-text');
                const spinner = loginBtn.querySelector('.spinner-border');

                loginForm.addEventListener('submit', function (e) {
                    if (!loginForm.checkValidity()) {
                        e.preventDefault();
                        e.stopPropagation();
                        loginForm.classList.add('was-validated');
                        return;
                    }
                    // không preventDefault -> để browser gửi form
                    btnText.classList.add('d-none');
                    spinner.classList.remove('d-none');
                    loginBtn.disabled = true;
                });
            });
        </script>
    </body>
</html>
