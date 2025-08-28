<!doctype html>
<%@ page contentType="text/html; charset=UTF-8" %>

<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FLEXCON – Premium Freelance Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<!-- Navigation -->
<%@include file="include/nav.jsp" %>

<!-- Hero Section -->
<section class="bg-dark text-white py-5"
         style="min-height: 100vh; background: linear-gradient(135deg, #212529, #495057);">
    <div class="container py-5">
        <div class="row align-items-center min-vh-100">
            <div class="col-lg-6">
                <h1 class="display-4 fw-bold mb-4">
                    Freelance với
                    <span class="text-warning">FLEXCON</span>
                    <br>Thành công vượt mọi kỳ vọng
                </h1>
                <p class="lead text-white-75 mb-4">
                    Nền tảng freelance thế hệ mới với công nghệ AI, ví điện tử an toàn,
                    và hệ thống escrow minh bạch. Ba mô hình làm việc: Bidding, Contest, Microtask.
                </p>
                <div class="d-flex flex-wrap gap-3">
                    <a href="#jobs" class="btn btn-warning btn-lg text-white rounded-pill px-4">
                        🔍 Tìm việc ngay
                    </a>
                    <a href="#flow" class="btn btn-outline-light btn-lg rounded-pill px-4">
                        ➕ Đăng dự án
                    </a>
                </div>
            </div>
            <div class="col-lg-6 mt-5 mt-lg-0">
                <div class="bg-white bg-opacity-10 rounded-4 p-4 backdrop-blur">
                    <h5 class="text-white mb-3">🔍 Tìm kiếm việc làm</h5>
                    <form>
                        <div class="mb-3">
                            <input type="text" class="form-control form-control-lg rounded-3"
                                   placeholder="Nhập từ khóa: design, development, writing...">
                        </div>
                        <div class="row g-2 mb-3">
                            <div class="col-md-4">
                                <select class="form-select rounded-3">
                                    <option>Loại job</option>
                                    <option>Bidding</option>
                                    <option>Contest</option>
                                    <option>Microtask</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <select class="form-select rounded-3">
                                    <option>Ngân sách</option>
                                    <option>≤ $100</option>
                                    <option>$100 - $500</option>
                                    <option>≥ $500</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <select class="form-select rounded-3">
                                    <option>Thời gian</option>
                                    <option>1-3 ngày</option>
                                    <option>1-2 tuần</option>
                                    <option>1+ tháng</option>
                                </select>
                            </div>
                        </div>
                        <button type="button" class="btn btn-warning btn-lg text-white w-100 rounded-3">
                            🔍 Tìm kiếm ngay
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Trusted By -->
<section class="py-4 bg-light">
    <div class="container text-center">
        <p class="text-muted mb-3">Được tin dùng bởi 36,000+ tổ chức hàng đầu</p>
        <div class="row align-items-center text-muted">
            <div class="col-6 col-md-2 fw-bold">Google</div>
            <div class="col-6 col-md-2 fw-bold">Microsoft</div>
            <div class="col-6 col-md-2 fw-bold">Amazon</div>
            <div class="col-6 col-md-2 fw-bold">Netflix</div>
            <div class="col-6 col-md-2 fw-bold">Spotify</div>
            <div class="col-6 col-md-2 fw-bold">Uber</div>
        </div>
    </div>
</section>

<!-- Jobs Section -->
<section class="py-5" id="jobs">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-5">
            <div>
                <h2 class="fw-bold mb-3">Việc làm hot hôm nay</h2>
                <div class="d-flex gap-2">
                    <span class="badge bg-primary rounded-pill">Bidding</span>
                    <span class="badge bg-warning rounded-pill">Contest</span>
                    <span class="badge bg-info rounded-pill">Microtask</span>
                </div>
            </div>
            <a href="#" class="btn btn-outline-warning rounded-pill">Xem tất cả</a>
        </div>

        <div class="row g-4">
            <div class="col-lg-3 col-md-6">
                <div class="card border-0 shadow-sm h-100 rounded-4">
                    <div class="card-body">
                        <span class="badge bg-primary rounded-pill mb-3">Bidding</span>
                        <h6 class="fw-bold mb-2">Website Landing Page cho Startup</h6>
                        <p class="text-muted small mb-3">Thiết kế hiện đại, responsive, tối ưu SEO và tốc độ
                            loading.</p>
                        <div class="d-flex justify-content-between mb-3">
                            <span class="small text-muted">Budget</span>
                            <span class="fw-bold text-success">$300 - $500</span>
                        </div>
                    </div>
                    <div class="card-footer bg-transparent border-0 d-flex justify-content-between">
                        <span class="small text-muted">8 proposals</span>
                        <a href="#" class="text-decoration-none fw-semibold text-warning">Chi tiết →</a>
                    </div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="card border-0 shadow-sm h-100 rounded-4">
                    <div class="card-body">
                        <span class="badge bg-warning rounded-pill mb-3">Contest</span>
                        <h6 class="fw-bold mb-2">Logo Design cho "TechFlow"</h6>
                        <p class="text-muted small mb-3">Sáng tạo, hiện đại, phù hợp với công ty technology.</p>
                        <div class="d-flex justify-content-between mb-3">
                            <span class="small text-muted">Giải thưởng</span>
                            <span class="fw-bold text-warning">$400</span>
                        </div>
                    </div>
                    <div class="card-footer bg-transparent border-0 d-flex justify-content-between">
                        <span class="small text-muted">Còn 2 ngày</span>
                        <a href="#" class="text-decoration-none fw-semibold text-warning">Tham gia →</a>
                    </div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="card border-0 shadow-sm h-100 rounded-4">
                    <div class="card-body">
                        <span class="badge bg-info rounded-pill mb-3">Microtask</span>
                        <h6 class="fw-bold mb-2">Data Entry 1000 records</h6>
                        <p class="text-muted small mb-3">Nhập liệu từ PDF sang Excel, yêu cầu chính xác 99%.</p>
                        <div class="d-flex justify-content-between mb-3">
                            <span class="small text-muted">Đơn giá</span>
                            <span class="fw-bold text-info">$0.08/record</span>
                        </div>
                    </div>
                    <div class="card-footer bg-transparent border-0 d-flex justify-content-between">
                        <span class="small text-muted">Cần 20 workers</span>
                        <a href="#" class="text-decoration-none fw-semibold text-warning">Nhận việc →</a>
                    </div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="card border-0 shadow-sm h-100 rounded-4">
                    <div class="card-body">
                        <span class="badge bg-primary rounded-pill mb-3">Bidding</span>
                        <h6 class="fw-bold mb-2">Mobile App Development</h6>
                        <p class="text-muted small mb-3">React Native app với Firebase backend, payment gateway.</p>
                        <div class="d-flex justify-content-between mb-3">
                            <span class="small text-muted">Budget</span>
                            <span class="fw-bold text-success">$1200 - $2000</span>
                        </div>
                    </div>
                    <div class="card-footer bg-transparent border-0 d-flex justify-content-between">
                        <span class="small text-muted">3 milestones</span>
                        <a href="#" class="text-decoration-none fw-semibold text-warning">Chi tiết →</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="py-5 bg-light" id="features">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold mb-3">Tại sao chọn <span class="text-warning">FLEXCON</span>?</h2>
            <p class="text-muted">Công nghệ tiên tiến bảo vệ quyền lợi và tối ưu hiệu quả làm việc</p>
        </div>

        <div class="row g-4">
            <div class="col-lg-4 col-md-6">
                <div class="card border-0 shadow-sm h-100 rounded-4 text-center p-4">
                    <div class="bg-warning text-white rounded-circle d-inline-flex align-items-center justify-content-center mx-auto mb-3"
                         style="width: 60px; height: 60px;">
                        <span class="fs-4">🛡️</span>
                    </div>
                    <h5 class="fw-bold mb-3">Escrow Thông minh</h5>
                    <p class="text-muted">Hệ thống ký quỹ tự động theo milestone, bảo vệ 100% quyền lợi cả hai bên với
                        công nghệ blockchain.</p>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="card border-0 shadow-sm h-100 rounded-4 text-center p-4">
                    <div class="bg-warning text-white rounded-circle d-inline-flex align-items-center justify-content-center mx-auto mb-3"
                         style="width: 60px; height: 60px;">
                        <span class="fs-4">💳</span>
                    </div>
                    <h5 class="fw-bold mb-3">Ví điện tử tích hợp</h5>
                    <p class="text-muted">Nạp/rút tiền linh hoạt qua PayOS, theo dõi giao dịch realtime, phí thấp nhất
                        thị trường.</p>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="card border-0 shadow-sm h-100 rounded-4 text-center p-4">
                    <div class="bg-warning text-white rounded-circle d-inline-flex align-items-center justify-content-center mx-auto mb-3"
                         style="width: 60px; height: 60px;">
                        <span class="fs-4">🤖</span>
                    </div>
                    <h5 class="fw-bold mb-3">AI Moderation</h5>
                    <p class="text-muted">Lọc spam, phát hiện đạo văn, kiểm duyệt nội dung tự động với độ chính xác
                        99.7%.</p>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="card border-0 shadow-sm h-100 rounded-4 text-center p-4">
                    <div class="bg-warning text-white rounded-circle d-inline-flex align-items-center justify-content-center mx-auto mb-3"
                         style="width: 60px; height: 60px;">
                        <span class="fs-4">💬</span>
                    </div>
                    <h5 class="fw-bold mb-3">Chat Realtime</h5>
                    <p class="text-muted">Giao tiếp trực tiếp, chia sẻ file an toàn, videocall HD tích hợp sẵn.</p>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="card border-0 shadow-sm h-100 rounded-4 text-center p-4">
                    <div class="bg-warning text-white rounded-circle d-inline-flex align-items-center justify-content-center mx-auto mb-3"
                         style="width: 60px; height: 60px;">
                        <span class="fs-4">⭐</span>
                    </div>
                    <h5 class="fw-bold mb-3">Review hai chiều</h5>
                    <p class="text-muted">Hệ thống đánh giá ẩn danh, công bằng, chống manipulation và fake review.</p>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="card border-0 shadow-sm h-100 rounded-4 text-center p-4">
                    <div class="bg-warning text-white rounded-circle d-inline-flex align-items-center justify-content-center mx-auto mb-3"
                         style="width: 60px; height: 60px;">
                        <span class="fs-4">⚖️</span>
                    </div>
                    <h5 class="fw-bold mb-3">Giải quyết tranh chấp</h5>
                    <p class="text-muted">Trọng tài chuyên nghiệp, quy trình minh bạch, giải quyết nhanh chóng trong
                        24-48h.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- How it works -->
<section class="py-5" id="flow">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold mb-3">Quy trình làm việc</h2>
            <p class="text-muted">Chọn vai trò để xem hướng dẫn chi tiết</p>
        </div>

        <ul class="nav nav-pills justify-content-center mb-5" role="tablist">
            <li class="nav-item me-3">
                <button class="nav-link active bg-warning border-0 text-white rounded-pill px-4" data-bs-toggle="pill"
                        data-bs-target="#employer" type="button">
                    💼 Employer
                </button>
            </li>
            <li class="nav-item">
                <button class="nav-link text-warning border-warning rounded-pill px-4" data-bs-toggle="pill"
                        data-bs-target="#freelancer" type="button">
                    👨‍💼 Freelancer
                </button>
            </li>
        </ul>

        <div class="tab-content">
            <div class="tab-pane fade show active" id="employer">
                <div class="row g-4">
                    <div class="col-lg-3 col-md-6">
                        <div class="card border-0 shadow-sm h-100 rounded-4 text-center p-4">
                            <div class="bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center mx-auto mb-3"
                                 style="width: 60px; height: 60px;">
                                <span class="fw-bold fs-4">1</span>
                            </div>
                            <h6 class="fw-bold mb-3">Đăng dự án</h6>
                            <p class="text-muted small">Mô tả chi tiết, chọn loại job, thiết lập budget và milestone rõ
                                ràng.</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="card border-0 shadow-sm h-100 rounded-4 text-center p-4">
                            <div class="bg-warning text-white rounded-circle d-inline-flex align-items-center justify-content-center mx-auto mb-3"
                                 style="width: 60px; height: 60px;">
                                <span class="fw-bold fs-4">2</span>
                            </div>
                            <h6 class="fw-bold mb-3">Ký quỹ an toàn</h6>
                            <p class="text-muted small">Nạp tiền vào ví và khóa vào escrow để đảm bảo cam kết.</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="card border-0 shadow-sm h-100 rounded-4 text-center p-4">
                            <div class="bg-info text-white rounded-circle d-inline-flex align-items-center justify-content-center mx-auto mb-3"
                                 style="width: 60px; height: 60px;">
                                <span class="fw-bold fs-4">3</span>
                            </div>
                            <h6 class="fw-bold mb-3">Quản lý dự án</h6>
                            <p class="text-muted small">Chat realtime, theo dõi tiến độ, duyệt deliverable từng
                                milestone.</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="card border-0 shadow-sm h-100 rounded-4 text-center p-4">
                            <div class="bg-success text-white rounded-circle d-inline-flex align-items-center justify-content-center mx-auto mb-3"
                                 style="width: 60px; height: 60px;">
                                <span class="fw-bold fs-4">4</span>
                            </div>
                            <h6 class="fw-bold mb-3">Thanh toán</h6>
                            <p class="text-muted small">Giải ngân tự động khi hoàn thành hoặc mở tranh chấp nếu cần.</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="tab-pane fade" id="freelancer">
                <div class="row g-4">
                    <div class="col-lg-3 col-md-6">
                        <div class="card border-0 shadow-sm h-100 rounded-4 text-center p-4">
                            <div class="bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center mx-auto mb-3"
                                 style="width: 60px; height: 60px;">
                                <span class="fw-bold fs-4">1</span>
                            </div>
                            <h6 class="fw-bold mb-3">Tạo hồ sơ</h6>
                            <p class="text-muted small">Portfolio ấn tượng, skill verification, badge chuyên môn.</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="card border-0 shadow-sm h-100 rounded-4 text-center p-4">
                            <div class="bg-warning text-white rounded-circle d-inline-flex align-items-center justify-content-center mx-auto mb-3"
                                 style="width: 60px; height: 60px;">
                                <span class="fw-bold fs-4">2</span>
                            </div>
                            <h6 class="fw-bold mb-3">Ứng tuyển</h6>
                            <p class="text-muted small">Gửi proposal chuyên nghiệp, tham gia contest, nhận
                                microtask.</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="card border-0 shadow-sm h-100 rounded-4 text-center p-4">
                            <div class="bg-info text-white rounded-circle d-inline-flex align-items-center justify-content-center mx-auto mb-3"
                                 style="width: 60px; height: 60px;">
                                <span class="fw-bold fs-4">3</span>
                            </div>
                            <h6 class="fw-bold mb-3">Thực hiện</h6>
                            <p class="text-muted small">Làm việc theo milestone, cập nhật tiến độ, bàn giao chất
                                lượng.</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="card border-0 shadow-sm h-100 rounded-4 text-center p-4">
                            <div class="bg-success text-white rounded-circle d-inline-flex align-items-center justify-content-center mx-auto mb-3"
                                 style="width: 60px; height: 60px;">
                                <span class="fw-bold fs-4">4</span>
                            </div>
                            <h6 class="fw-bold mb-3">Nhận tiền</h6>
                            <p class="text-muted small">Tiền về ví ngay khi approve, rút tiền linh hoạt 24/7.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Stats & Testimonials -->
<section class="py-5 bg-light">
    <div class="container">
        <div class="row align-items-center g-5">
            <div class="col-lg-6">
                <h2 class="fw-bold mb-4">Thống kê ấn tượng</h2>
                <div class="row g-3">
                    <div class="col-6">
                        <div class="card border-0 shadow-sm text-center p-4 rounded-4 bg-warning bg-opacity-10">
                            <div class="display-6 fw-bold text-warning">36K+</div>
                            <div class="text-muted small">Tổ chức tin dùng</div>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="card border-0 shadow-sm text-center p-4 rounded-4 bg-warning bg-opacity-10">
                            <div class="display-6 fw-bold text-warning">99.7%</div>
                            <div class="text-muted small">Giao dịch thành công</div>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="card border-0 shadow-sm text-center p-4 rounded-4 bg-warning bg-opacity-10">
                            <div class="display-6 fw-bold text-warning">&lt; 2h</div>
                            <div class="text-muted small">Thời gian giải ngân TB</div>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="card border-0 shadow-sm text-center p-4 rounded-4 bg-warning bg-opacity-10">
                            <div class="display-6 fw-bold text-warning">4.9/5</div>
                            <div class="text-muted small">Đánh giá người dùng</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div id="testimonialCarousel" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <div class="card border-0 shadow-sm rounded-4 p-4">
                                <div class="position-relative">
                                    <span class="position-absolute top-0 start-0 text-warning display-4"
                                          style="line-height: 1; margin-top: -10px;">"</span>
                                    <p class="mb-3 ps-4">FLEXCON thay đổi hoàn toàn cách team tôi làm việc với
                                        freelancer. Escrow minh bạch, AI lọc proposal chất lượng cao.</p>
                                </div>
                                <div class="d-flex align-items-center">
                                    <div class="bg-warning text-white rounded-circle d-flex align-items-center justify-content-center me-3"
                                         style="width: 50px; height: 50px;">
                                        <span class="fw-bold">LA</span>
                                    </div>
                                    <div>
                                        <h6 class="mb-0 fw-bold">Nguyễn Lan Anh</h6>
                                        <small class="text-muted">Product Manager, TechCorp</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <div class="card border-0 shadow-sm rounded-4 p-4">
                                <div class="position-relative">
                                    <span class="position-absolute top-0 start-0 text-warning display-4"
                                          style="line-height: 1; margin-top: -10px;">"</span>
                                    <p class="mb-3 ps-4">Là freelancer, tôi yên tâm 100% về việc thanh toán. Microtask
                                        trả tiền ngay, không delay như platform khác.</p>
                                </div>
                                <div class="d-flex align-items-center">
                                    <div class="bg-warning text-white rounded-circle d-flex align-items-center justify-content-center me-3"
                                         style="width: 50px; height: 50px;">
                                        <span class="fw-bold">MH</span>
                                    </div>
                                    <div>
                                        <h6 class="mb-0 fw-bold">Trần Minh Hoàng</h6>
                                        <small class="text-muted">Full-stack Developer</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <div class="card border-0 shadow-sm rounded-4 p-4">
                                <div class="position-relative">
                                    <span class="position-absolute top-0 start-0 text-warning display-4"
                                          style="line-height: 1; margin-top: -10px;">"</span>
                                    <p class="mb-3 ps-4">Contest design trên FLEXCON rất công bằng. AI chống đạo văn
                                        hiệu quả, admin support nhiệt tình 24/7.</p>
                                </div>
                                <div class="d-flex align-items-center">
                                    <div class="bg-warning text-white rounded-circle d-flex align-items-center justify-content-center me-3"
                                         style="width: 50px; height: 50px;">
                                        <span class="fw-bold">TM</span>
                                    </div>
                                    <div>
                                        <h6 class="mb-0 fw-bold">Lê Thu Minh</h6>
                                        <small class="text-muted">UI/UX Designer</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#testimonialCarousel"
                            data-bs-slide="prev">
                        <span class="carousel-control-prev-icon"></span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#testimonialCarousel"
                            data-bs-slide="next">
                        <span class="carousel-control-next-icon"></span>
                    </button>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Pricing -->
<section class="py-5" id="pricing">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold mb-3">Bảng phí minh bạch</h2>
            <p class="text-muted">Không phí ẩn, không ràng buộc dài hạn</p>
        </div>

        <div class="row justify-content-center g-4">
            <div class="col-lg-5">
                <div class="card border-0 shadow-sm h-100 rounded-4 p-4">
                    <div class="text-center mb-4">
                        <div class="bg-warning text-white rounded-circle d-inline-flex align-items-center justify-content-center mx-auto mb-3"
                             style="width: 80px; height: 80px;">
                            <span class="fs-3">%</span>
                        </div>
                        <h4 class="fw-bold">Phí nền tảng 8%</h4>
                        <p class="text-muted">Chỉ thu khi giải ngân thành công</p>
                    </div>
                    <ul class="list-unstyled">
                        <li class="d-flex align-items-center mb-3">
                            <span class="text-success me-3 fs-5">✓</span>
                            <span>Không phí tạo tài khoản</span>
                        </li>
                        <li class="d-flex align-items-center mb-3">
                            <span class="text-success me-3 fs-5">✓</span>
                            <span>Không phí đăng job cơ bản</span>
                        </li>
                        <li class="d-flex align-items-center mb-3">
                            <span class="text-success me-3 fs-5">✓</span>
                            <span>Không phí rút tiền</span>
                        </li>
                        <li class="d-flex align-items-center mb-3">
                            <span class="text-success me-3 fs-5">✓</span>
                            <span>Phí tranh chấp chỉ khi sử dụng</span>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="col-lg-5">
                <div class="card border-0 shadow-sm h-100 rounded-4 p-4">
                    <div class="text-center mb-4">
                        <div class="bg-warning text-white rounded-circle d-inline-flex align-items-center justify-content-center mx-auto mb-3"
                             style="width: 80px; height: 80px;">
                            <span class="fs-3">🛡️</span>
                        </div>
                        <h4 class="fw-bold">Bảo vệ toàn diện</h4>
                        <p class="text-muted">An toàn 100% cho mọi giao dịch</p>
                    </div>
                    <ul class="list-unstyled">
                        <li class="d-flex align-items-center mb-3">
                            <span class="text-success me-3 fs-5">✓</span>
                            <span>Escrow tự động theo milestone</span>
                        </li>
                        <li class="d-flex align-items-center mb-3">
                            <span class="text-success me-3 fs-5">✓</span>
                            <span>Bảo hiểm giao dịch 24/7</span>
                        </li>
                        <li class="d-flex align-items-center mb-3">
                            <span class="text-success me-3 fs-5">✓</span>
                            <span>Hỗ trợ tranh chấp miễn phí</span>
                        </li>
                        <li class="d-flex align-items-center mb-3">
                            <span class="text-success me-3 fs-5">✓</span>
                            <span>Hoàn tiền nếu không hài lòng</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Skills Categories -->
<section class="py-5 bg-light">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold mb-3">Danh mục kỹ năng hot</h2>
            <p class="text-muted">Khám phá cơ hội việc làm trong các lĩnh vực hàng đầu</p>
        </div>

        <div class="row g-4">
            <div class="col-lg-3 col-md-6">
                <div class="card border-0 shadow-sm rounded-4 p-4 text-center h-100">
                    <div class="bg-primary bg-opacity-10 rounded-circle d-inline-flex align-items-center justify-content-center mx-auto mb-3"
                         style="width: 80px; height: 80px;">
                        <span class="fs-2">💻</span>
                    </div>
                    <h5 class="fw-bold mb-3">Web Development</h5>
                    <p class="text-muted small mb-3">React, Vue, Angular, Node.js, PHP, Laravel</p>
                    <div class="badge bg-primary bg-opacity-10 text-primary rounded-pill">1,234 jobs</div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="card border-0 shadow-sm rounded-4 p-4 text-center h-100">
                    <div class="bg-warning bg-opacity-10 rounded-circle d-inline-flex align-items-center justify-content-center mx-auto mb-3"
                         style="width: 80px; height: 80px;">
                        <span class="fs-2">🎨</span>
                    </div>
                    <h5 class="fw-bold mb-3">Design & Creative</h5>
                    <p class="text-muted small mb-3">UI/UX, Logo, Brand Identity, Illustration</p>
                    <div class="badge bg-warning bg-opacity-10 text-warning rounded-pill">987 jobs</div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="card border-0 shadow-sm rounded-4 p-4 text-center h-100">
                    <div class="bg-info bg-opacity-10 rounded-circle d-inline-flex align-items-center justify-content-center mx-auto mb-3"
                         style="width: 80px; height: 80px;">
                        <span class="fs-2">📱</span>
                    </div>
                    <h5 class="fw-bold mb-3">Mobile Development</h5>
                    <p class="text-muted small mb-3">iOS, Android, React Native, Flutter</p>
                    <div class="badge bg-info bg-opacity-10 text-info rounded-pill">567 jobs</div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="card border-0 shadow-sm rounded-4 p-4 text-center h-100">
                    <div class="bg-success bg-opacity-10 rounded-circle d-inline-flex align-items-center justify-content-center mx-auto mb-3"
                         style="width: 80px; height: 80px;">
                        <span class="fs-2">📊</span>
                    </div>
                    <h5 class="fw-bold mb-3">Data & Analytics</h5>
                    <p class="text-muted small mb-3">Machine Learning, Python, R, Tableau</p>
                    <div class="badge bg-success bg-opacity-10 text-success rounded-pill">432 jobs</div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- FAQ -->
<section class="py-5" id="faq">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold mb-3">Câu hỏi thường gặp</h2>
            <p class="text-muted">Tìm hiểu thêm về FLEXCON</p>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="accordion" id="faqAccordion">
                    <div class="accordion-item border-0 shadow-sm rounded-4 mb-3">
                        <h2 class="accordion-header">
                            <button class="accordion-button fw-semibold rounded-4" type="button"
                                    data-bs-toggle="collapse" data-bs-target="#faq1">
                                Escrow hoạt động như thế nào?
                            </button>
                        </h2>
                        <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted">
                                Hệ thống escrow tự động khóa tiền theo từng milestone. Chỉ khi employer xác nhận hoàn
                                thành
                                hoặc trọng tài quyết định, tiền mới được giải ngân cho freelancer. Hoàn toàn minh bạch
                                và an toàn.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item border-0 shadow-sm rounded-4 mb-3">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed fw-semibold rounded-4" type="button"
                                    data-bs-toggle="collapse" data-bs-target="#faq2">
                                Thời gian rút tiền mất bao lâu?
                            </button>
                        </h2>
                        <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted">
                                Yêu cầu rút tiền được xử lý tự động trong giờ hành chính. Thời gian trung bình từ 30
                                phút đến 2 giờ
                                cho các giao dịch trong nước qua PayOS.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item border-0 shadow-sm rounded-4 mb-3">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed fw-semibold rounded-4" type="button"
                                    data-bs-toggle="collapse" data-bs-target="#faq3">
                                Double-blind review nghĩa là gì?
                            </button>
                        </h2>
                        <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted">
                                Cả employer và freelancer nộp đánh giá độc lập. Hệ thống chỉ hiển thị khi cả hai đã hoàn
                                tất
                                hoặc hết thời hạn review, tránh tình trạng "trả đũa" và đảm bảo đánh giá công bằng.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item border-0 shadow-sm rounded-4 mb-3">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed fw-semibold rounded-4" type="button"
                                    data-bs-toggle="collapse" data-bs-target="#faq4">
                                AI có thể tự động khóa tài khoản không?
                            </button>
                        </h2>
                        <div id="faq4" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted">
                                AI chỉ có nhiệm vụ phát hiện và gắn cờ các hoạt động bất thường. Mọi quyết định khóa/mở
                                tài khoản
                                đều do đội ngũ admin con người xem xét kỹ lưỡng để đảm bảo công bằng.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item border-0 shadow-sm rounded-4">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed fw-semibold rounded-4" type="button"
                                    data-bs-toggle="collapse" data-bs-target="#faq5">
                                Làm sao để tăng cơ hội được chọn?
                            </button>
                        </h2>
                        <div id="faq5" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted">
                                Tạo hồ sơ chuyên nghiệp với portfolio ấn tượng, hoàn thành skill verification,
                                duy trì rating cao và viết proposal chi tiết, phù hợp với yêu cầu của từng dự án cụ thể.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- CTA -->
<section class="py-5" id="cta">
    <div class="container">
        <div class="rounded-4 p-5 text-center text-white position-relative overflow-hidden"
             style="background: linear-gradient(135deg, #ff6b35, #ff8c42, #ff9f1c);">
            <div class="position-relative z-3">
                <h2 class="display-5 fw-bold mb-3">Sẵn sàng thành công với FLEXCON?</h2>
                <p class="lead mb-4">Tham gia cộng đồng 36,000+ chuyên gia đang kiếm thu nhập ổn định từ freelance</p>
                <div class="d-flex flex-wrap justify-content-center gap-3">
                    <a href="#" class="btn btn-light btn-lg px-5 rounded-pill">
                        💼 Đăng dự án ngay
                    </a>
                    <a href="#" class="btn btn-outline-light btn-lg px-5 rounded-pill">
                        👨‍💼 Trở thành Freelancer
                    </a>
                </div>
                <div class="mt-4">
                    <small class="text-white-75">✓ Miễn phí đăng ký ✓ Không ràng buộc dài hạn ✓ Hỗ trợ 24/7</small>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<%@include file="include/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
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

    // Navbar scroll effect
    window.addEventListener('scroll', function () {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            navbar.classList.add('shadow');
        } else {
            navbar.classList.remove('shadow');
        }
    });
</script>
</body>
</html>