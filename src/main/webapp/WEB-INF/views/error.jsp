<!doctype html>
<%@ page contentType="text/html; charset=UTF-8" %>

<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FLEXCON – Có lỗi xảy ra</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .error-animation {
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-20px);
            }
        }

        .glitch {
            position: relative;
            animation: glitch 2s infinite;
        }

        @keyframes glitch {
            0%, 100% {
                transform: translate(0);
            }
            10% {
                transform: translate(-2px, -2px);
            }
            20% {
                transform: translate(2px, 2px);
            }
            30% {
                transform: translate(-2px, 2px);
            }
            40% {
                transform: translate(2px, -2px);
            }
            50% {
                transform: translate(-2px, -2px);
            }
            60% {
                transform: translate(2px, 2px);
            }
            70% {
                transform: translate(-2px, 2px);
            }
            80% {
                transform: translate(2px, -2px);
            }
            90% {
                transform: translate(-2px, -2px);
            }
        }

        .bounce-in {
            animation: bounceIn 1s ease-out;
        }

        @keyframes bounceIn {
            0% {
                transform: scale(0.3);
                opacity: 0;
            }
            50% {
                transform: scale(1.05);
                opacity: 0.8;
            }
            70% {
                transform: scale(0.9);
                opacity: 0.9;
            }
            100% {
                transform: scale(1);
                opacity: 1;
            }
        }
    </style>
</head>
<body class="bg-light">

<!-- Navigation -->
<%@include file="include/nav.jsp" %>
<!-- Error Section -->
<section class="min-vh-100 d-flex align-items-center" style="background: linear-gradient(135deg, #212529, #495057);">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8 text-center">
                <!-- Error Type Selection -->
                <div class="mb-5">
                    <div class="btn-group" role="group">
                        <button type="button" class="btn btn-warning" onclick="showError('404')">404</button>
                        <button type="button" class="btn btn-outline-warning text-white" onclick="showError('500')">
                            500
                        </button>
                        <button type="button" class="btn btn-outline-warning text-white" onclick="showError('403')">
                            403
                        </button>
                        <button type="button" class="btn btn-outline-warning text-white" onclick="showError('503')">
                            503
                        </button>
                    </div>
                </div>

                <!-- 404 Error -->
                <div id="error-404" class="error-content">
                    <div class="error-animation mb-4">
                        <div class="display-1 fw-bold text-warning glitch">404</div>
                    </div>
                    <h1 class="text-white fw-bold mb-3 bounce-in">Oops! Trang không tồn tại</h1>
                    <p class="text-white-75 lead mb-4">
                        Có vẻ như trang bạn đang tìm kiếm đã bị di chuyển, xóa hoặc không tồn tại.
                        Đừng lo lắng, chúng tôi sẽ giúp bạn tìm đường về!
                    </p>

                    <div class="d-flex flex-wrap justify-content-center gap-3 mb-5">
                        <a href="/" class="btn btn-warning btn-lg px-4 rounded-pill">
                            🏠 Về trang chủ
                        </a>
                        <a href="/#jobs" class="btn btn-outline-warning btn-lg px-4 rounded-pill text-white">
                            🔍 Tìm việc làm
                        </a>
                    </div>
                </div>

                <!-- 500 Error -->
                <div id="error-500" class="error-content d-none">
                    <div class="error-animation mb-4">
                        <div class="display-1 fw-bold text-danger glitch">500</div>
                    </div>
                    <h1 class="text-white fw-bold mb-3 bounce-in">Lỗi máy chủ nội bộ</h1>
                    <p class="text-white-75 lead mb-4">
                        Hệ thống đang gặp sự cố tạm thời. Đội ngũ kỹ thuật đang khắc phục.
                        Vui lòng thử lại sau ít phút hoặc liên hệ hỗ trợ nếu vấn đề vẫn tiếp tục.
                    </p>

                    <div class="d-flex flex-wrap justify-content-center gap-3 mb-5">
                        <a href="/" class="btn btn-warning btn-lg px-4 rounded-pill">
                            🔄 Thử lại
                        </a>
                        <a href="mailto:support@flexcon.dev"
                           class="btn btn-outline-warning btn-lg px-4 rounded-pill text-white">
                            📧 Liên hệ hỗ trợ
                        </a>
                    </div>
                </div>

                <!-- 403 Error -->
                <div id="error-403" class="error-content d-none">
                    <div class="error-animation mb-4">
                        <div class="display-1 fw-bold text-warning glitch">403</div>
                    </div>
                    <h1 class="text-white fw-bold mb-3 bounce-in">Truy cập bị từ chối</h1>
                    <p class="text-white-75 lead mb-4">
                        Bạn không có quyền truy cập vào trang này.
                        Vui lòng đăng nhập với tài khoản có quyền phù hợp hoặc liên hệ quản trị viên.
                    </p>

                    <div class="d-flex flex-wrap justify-content-center gap-3 mb-5">
                        <a href="${pageContext.request.contextPath}/auth/login"
                           class="btn btn-warning btn-lg px-4 rounded-pill">
                            🔐 Đăng nhập
                        </a>
                        <a href="/" class="btn btn-outline-warning btn-lg px-4 rounded-pill text-white">
                            🏠 Về trang chủ
                        </a>
                    </div>
                </div>

                <!-- 503 Error -->
                <div id="error-503" class="error-content d-none">
                    <div class="error-animation mb-4">
                        <div class="display-1 fw-bold text-info glitch">503</div>
                    </div>
                    <h1 class="text-white fw-bold mb-3 bounce-in">Dịch vụ tạm thời không khả dụng</h1>
                    <p class="text-white-75 lead mb-4">
                        Hệ thống đang được bảo trì để mang đến trải nghiệm tốt hơn.
                        Chúng tôi sẽ sớm trở lại. Cảm ơn sự kiên nhẫn của bạn!
                    </p>

                    <div class="d-flex flex-wrap justify-content-center gap-3 mb-5">
                        <a href="/" class="btn btn-warning btn-lg px-4 rounded-pill">
                            🔄 Thử lại
                        </a>
                        <a href="https://status.flexcon.dev"
                           class="btn btn-outline-warning btn-lg px-4 rounded-pill text-white" target="_blank">
                            📊 Trạng thái hệ thống
                        </a>
                    </div>
                </div>

                <!-- Additional Info Card -->
            </div>
        </div>
    </div>
</section>

<!-- Quick Stats -->
<section class="py-4 bg-dark">
    <div class="container">
        <div class="row text-center text-white-75">
            <div class="col-md-3 col-6 mb-3 mb-md-0">
                <div class="display-6 fw-bold text-warning">99.9%</div>
                <small>Uptime hệ thống</small>
            </div>
            <div class="col-md-3 col-6 mb-3 mb-md-0">
                <div class="display-6 fw-bold text-warning">&lt; 30s</div>
                <small>Thời gian khôi phục TB</small>
            </div>
            <div class="col-md-3 col-6">
                <div class="display-6 fw-bold text-warning">24/7</div>
                <small>Hỗ trợ kỹ thuật</small>
            </div>
            <div class="col-md-3 col-6">
                <div class="display-6 fw-bold text-warning">🛡️</div>
                <small>Bảo mật SSL</small>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<%@include file="include/footer.jsp" %>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function showError(errorType) {
        // Hide all error contents
        document.querySelectorAll('.error-content').forEach(content => {
            content.classList.add('d-none');
        });

        // Show selected error
        document.getElementById(`error-${errorType}`).classList.remove('d-none');

        // Update button states
        document.querySelectorAll('.btn-group .btn').forEach(btn => {
            btn.classList.remove('btn-warning');
            btn.classList.add('btn-outline-warning', 'text-white');
        });

        event.target.classList.remove('btn-outline-warning', 'text-white');
        event.target.classList.add('btn-warning');

        // Add bounce animation to new content
        const errorContent = document.getElementById(`error-${errorType}`);
        errorContent.style.animation = 'none';
        setTimeout(() => {
            errorContent.style.animation = 'bounceIn 0.8s ease-out';
        }, 10);
    }

    // Auto-detect error type from URL or set default
    window.addEventListener('load', function () {
        const urlParams = new URLSearchParams(window.location.search);
        const errorType = urlParams.get('error') || '404';

        // Set initial state
        document.querySelector(`[onclick="showError('${errorType}')"]`).click();
    });

    // Add hover effects
    document.addEventListener('DOMContentLoaded', function () {
        // Add hover effect for quick links
        document.querySelectorAll('.hover-text-warning').forEach(element => {
            element.addEventListener('mouseenter', function () {
                this.style.color = '#ffc107';
                this.style.transition = 'color 0.3s ease';
            });

            element.addEventListener('mouseleave', function () {
                this.style.color = '';
            });
        });
    });

    // Smooth scrolling for navigation links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
</script>
</body>
</html>