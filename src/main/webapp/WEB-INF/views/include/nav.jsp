<%@ page contentType="text/html; charset=UTF-8" %>
<nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold text-warning fs-3" href="#">⚡ FLEXCON</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item"><a class="nav-link fw-semibold" href="#features">Tính năng</a></li>
                <li class="nav-item"><a class="nav-link fw-semibold" href="#jobs">Việc làm</a></li>
                <li class="nav-item"><a class="nav-link fw-semibold" href="#flow">Quy trình</a></li>
                <li class="nav-item"><a class="nav-link fw-semibold" href="#pricing">Phí dịch vụ</a></li>
                <li class="nav-item"><a class="nav-link fw-semibold" href="#faq">FAQ</a></li>
            </ul>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-outline-warning rounded-pill">Đăng
                    nhập</a>
                <a href="${pageContext.request.contextPath}/signup"
                   class="btn btn-warning text-white rounded-pill fw-semibold">Đăng ký ngay</a>
                <a href="${pageContext.request.contextPath}/dashboard"
                   class="btn btn-primary text-white rounded-pill fw-semibold">Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/dashboard"
                   class="btn btn-primary text-white rounded-pill fw-semibold">Admin Dashboard</a>
            </div>
        </div>
    </div>
</nav>