<!-- Withdraw Detail Modal (chỉ duy nhất 1 cái, đặt cuối trang) -->
<%@ page contentType="text/html; charset=UTF-8" %>

<div class="modal fade" id="withdrawDetailModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">

            <!-- Header -->
            <div class="modal-header border-0 text-white" style="background: linear-gradient(90deg, #f59e0b, #f97316);">
                <div class="d-flex align-items-center">
                    <div>
                        <h4 class="modal-title fw-bold mb-1">Chi tiết yêu cầu rút tiền</h4>
                        <p class="mb-0 opacity-75 small">Mã yêu cầu: #WD<span id="wd-id"></span></p>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body p-0">
                <!-- Status và Amount Section -->
                <div class="p-4 bg-light border-bottom">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <div class="d-flex align-items-center">
                                <i id="wd-status-icon" class="bi bi-question-circle text-secondary fs-2 me-3"></i>
                                <div>
                                    <h5 id="wd-status-text" class="mb-1 text-secondary">Đang tải...</h5>
                                    <small class="text-muted" id="wd-status-sub">Vui lòng chờ</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 text-md-end mt-3 mt-md-0">
                            <div class="small text-muted mb-1">Số tiền yêu cầu</div>
                            <h2 class="fw-bold text-primary mb-0"><span id="wd-amount"></span>₫</h2>
                        </div>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="row g-0">
                    <div class="col-lg-8">
                        <div class="p-4">
                            <!-- Thông tin thời gian -->
                            <div class="row g-3 mb-4">
                                <div class="col-sm-6">
                                    <div class="card border-0 bg-light h-100">
                                        <div class="card-body p-3">
                                            <div class="small text-muted mb-1">Ngày tạo</div>
                                            <div class="fw-semibold" id="wd-created-date"></div>
                                            <small class="text-muted" id="wd-created-time"></small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="card border-0 bg-light h-100">
                                        <div class="card-body p-3">
                                            <div class="small text-muted mb-1">Cập nhật lần cuối</div>
                                            <div class="fw-semibold" id="wd-updated-date"></div>
                                            <small class="text-muted" id="wd-updated-time"></small>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Thông tin thanh toán -->
                            <div class="mb-4">
                                <h6 class="text-uppercase small fw-bold text-muted mb-3 d-flex align-items-center">
                                    <i class="bi bi-credit-card me-2"></i>Thông tin thanh toán
                                </h6>
                                <div class="card shadow-sm border-0">
                                    <div class="card-body p-4">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                <span id="wd-method"
                      class="badge bg-primary-subtle text-primary px-3 py-2 fs-6"></span>
                                        </div>

                                        <!-- BANK INFO WRAPPER -->
                                        <div id="wd-bank-wrapper">
                                            <div class="row g-3">
                                                <div class="col-md-6">
                                                    <label class="small text-muted fw-semibold">Ngân hàng</label>
                                                    <div class="fw-bold fs-6" id="wd-bankName">—</div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="small text-muted fw-semibold">Chủ tài khoản</label>
                                                    <div class="fw-bold fs-6" id="wd-accountName">—</div>
                                                </div>
                                                <div class="col-12">
                                                    <label class="small text-muted fw-semibold">Số tài khoản</label>
                                                    <div class="font-monospace fw-bold text-primary fs-5 p-2 bg-light rounded"
                                                         id="wd-accountNumber">—
                                                    </div>
                                                </div>
                                                <div class="col-12" id="wd-branch-wrapper" style="display:none;">
                                                    <label class="small text-muted fw-semibold">Chi nhánh</label>
                                                    <div class="fw-bold fs-6" id="wd-branchName">—</div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- QR WRAPPER -->
                                        <div class="text-center mt-4" id="wd-qr-wrapper" style="display:none;">
                                            <div class="p-3 bg-light rounded d-inline-block">
                                                <img id="wd-qr" class="img-fluid rounded shadow-sm"
                                                     style="max-width:100%;">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <!-- Ghi chú -->
                            <div id="wd-notes">
                                <h6 class="text-uppercase small fw-bold text-muted mb-3 d-flex align-items-center">
                                    <i class="bi bi-chat-text me-2"></i>Ghi chú
                                </h6>
                            </div>
                        </div>
                    </div>

                    <!-- Timeline Sidebar -->
                    <div class="col-lg-4 border-start bg-light">
                        <div class="p-4">
                            <h6 class="text-uppercase small fw-bold text-muted mb-4 d-flex align-items-center">
                                <i class="bi bi-clock-history me-2"></i>Lịch sử xử lý
                            </h6>
                            <div class="position-relative">
                                <ul class="list-unstyled position-relative" id="wd-timeline"></ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <div class="modal-footer bg-light border-top">
                <button id="wd-cancel-btn" class="btn btn-outline-danger d-none">
                    <i class="bi bi-x-lg me-1"></i>Hủy yêu cầu
                </button>
                <div class="ms-auto">
                    <div class="btn-group" role="group">
                        <button class="btn btn-outline-secondary" onclick="window.print()">
                            <i class="bi bi-printer me-1"></i>In
                        </button>
                        <button class="btn btn-outline-primary">
                            <i class="bi bi-download me-1"></i>PDF
                        </button>
                        <button class="btn btn-primary" data-bs-dismiss="modal">
                            <i class="bi bi-check-lg me-1"></i>Hoàn tất
                        </button>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        document.querySelectorAll(".view-detail-btn").forEach(btn => {
            btn.addEventListener("click", async () => {
                try {
                    const id = btn.dataset.id;
                    const url = '${pageContext.request.contextPath}/dashboard/wallet/withdraws/' + id;
                    console.log("fetch url:", url);
                    const res = await fetch(url, {headers: {"Accept": "application/json"}});
                    const data = await res.json();

                    // ==== Basic Info ====
                    setText("wd-id", data.id);
                    setText("wd-amount", formatCurrency(data.amount));

                    // ==== Status ====
                    const statusMap = {
                        PENDING: {
                            icon: "bi-clock text-warning",
                            text: "Chờ duyệt",
                            sub: "Yêu cầu đang được xem xét",
                            showCancel: true
                        },
                        APPROVED: {
                            icon: "bi-check-circle text-info",
                            text: "Đã duyệt",
                            sub: "Đang xử lý"
                        },
                        DONE: {
                            icon: "bi-check-circle-fill text-success",
                            text: "Hoàn thành",
                            sub: "Tiền đã chuyển thành công"
                        },
                        REJECTED: {
                            icon: "bi-x-circle text-danger",
                            text: "Từ chối",
                            sub: "Yêu cầu bị từ chối"
                        }
                    };
                    const s = statusMap[data.status] || {
                        icon: "bi-question-circle text-secondary",
                        text: "Không xác định",
                        sub: ""
                    };
                    setClass("wd-status-icon", "bi fs-2 me-3 " + s.icon);
                    setText("wd-status-text", s.text);
                    setText("wd-status-sub", s.sub);
                    toggle("wd-cancel-btn", !!s.showCancel);

                    // ==== Dates ====
                    const created = formatDateTime(data.createdAt);
                    setText("wd-created-date", created.date);
                    setText("wd-created-time", created.time);

                    const updated = formatDateTime(data.updatedAt);
                    setText("wd-updated-date", updated.date);
                    setText("wd-updated-time", updated.time);

                    // ==== Payment && QR info ====
                    if (data.method === "BANK") {
                        setText("wd-bankName", data.bankName);
                        setText("wd-accountName", data.accountName);
                        setText("wd-accountNumber", formatBankAccount(data.accountNumber));
                        toggle("wd-branch-wrapper", !!data.branchName);
                        setText("wd-branchName", data.branchName);
                        setText("wd-method", "Bank Transfer");

                        toggle("wd-bank-wrapper", true);
                        toggle("wd-qr-wrapper", false);
                    } else if (data.method === "QR") {
                        if (data.qrCodePath) {
                            document.getElementById("wd-qr").src = data.qrCodePath;
                            toggle("wd-qr-wrapper", true);
                        }
                        setText("wd-method", "QR Code");

                        toggle("wd-bank-wrapper", false);
                    } else {
                        toggle("wd-bank-wrapper", false);
                        toggle("wd-qr-wrapper", false);
                        setText("wd-method", data.method || "—");
                    }

                    // ==== Notes ====
                    console.log("API note:", data.note);
                    console.log("API adminNote:", data.adminNote);

                    let notesHtml = "";
                    if (data.note && data.note.trim() !== "") {
                        notesHtml +=
                            '<div class="alert alert-primary border-0 shadow-sm mb-3">' +
                            '<div class="d-flex align-items-start">' +
                            '<i class="bi bi-person-circle text-primary me-2 fs-5"></i>' +
                            '<div>' +
                            '<div class="small fw-semibold text-primary mb-1">Ghi chú của bạn</div>' +
                            '<div>' + data.note + '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>';
                    }
                    if (data.adminNote && data.adminNote.trim() !== "") {
                        notesHtml +=
                            '<div class="alert alert-warning border-0 shadow-sm mb-3">' +
                            '<div class="d-flex align-items-start">' +
                            '<i class="bi bi-shield-check text-warning me-2 fs-5"></i>' +
                            '<div>' +
                            '<div class="small fw-semibold text-warning mb-1">Ghi chú từ quản trị viên</div>' +
                            '<div>' + data.adminNote + '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>';
                    }

                    const notesSection = document.getElementById("wd-notes");
                    if (notesHtml) {
                        notesSection.innerHTML =
                            '<h6 class="text-uppercase small fw-bold text-muted mb-3 d-flex align-items-center">' +
                            '<i class="bi bi-chat-text me-2"></i>Ghi chú' +
                            '</h6>' +
                            notesHtml;
                    } else {
                        notesSection.innerHTML =
                            '<h6 class="text-uppercase small fw-bold text-muted mb-3 d-flex align-items-center">' +
                            '<i class="bi bi-chat-text me-2"></i>Ghi chú' +
                            '</h6>' +
                            '<div class="text-muted fst-italic">Không có ghi chú</div>';
                    }


                    // ==== Timeline ====
                    let timeline = "";

                    timeline +=
                        '<li class="mb-4 position-relative">' +
                        '<div class="d-flex align-items-start">' +
                        '<div class="bg-primary rounded-circle p-2 me-3 flex-shrink-0">' +
                        '<i class="bi bi-plus-lg text-white small"></i>' +
                        '</div>' +
                        '<div>' +
                        '<div class="fw-semibold">Tạo yêu cầu</div>' +
                        '<div class="small text-muted">' + created.date + ' • ' + created.time + '</div>' +
                        '</div>' +
                        '</div>' +
                        '</li>';

                    if (data.reviewedAt) {
                        const reviewIcon = data.status === "REJECTED" ? "x-lg" : "check-lg";
                        const reviewColor = data.status === "REJECTED" ? "danger" : "success";
                        const reviewed = formatDateTime(data.reviewedAt);

                        timeline +=
                            '<li class="mb-4 position-relative">' +
                            '<div class="d-flex align-items-start">' +
                            '<div class="bg-' + reviewColor + ' rounded-circle p-2 me-3 flex-shrink-0">' +
                            '<i class="bi bi-' + reviewIcon + ' text-white small"></i>' +
                            '</div>' +
                            '<div>' +
                            '<div class="fw-semibold">Xử lý bởi ' + (data.reviewedByName || "Hệ thống") + '</div>' +
                            '<div class="small text-muted">' + reviewed.date + ' • ' + reviewed.time + '</div>' +
                            '</div>' +
                            '</div>' +
                            '</li>';
                    }

                    if (data.status === "COMPLETED" && data.updatedAt) {
                        timeline +=
                            '<li class="position-relative">' +
                            '<div class="d-flex align-items-start">' +
                            '<div class="bg-success rounded-circle p-2 me-3 flex-shrink-0">' +
                            '<i class="bi bi-check-all text-white small"></i>' +
                            '</div>' +
                            '<div>' +
                            '<div class="fw-semibold">Hoàn thành</div>' +
                            '<div class="small text-muted">' + updated.date + ' • ' + updated.time + '</div>' +
                            '</div>' +
                            '</div>' +
                            '</li>';
                    }

                    document.getElementById("wd-timeline").innerHTML = timeline;

                } catch (err) {
                    console.error("❌ Lỗi fetch withdraw detail:", err);
                }
            });
        });
    });

    // ==== Helpers ====
    function setText(id, text) {
        document.getElementById(id).innerText = text || "—";
    }

    function setClass(id, className) {
        document.getElementById(id).className = className;
    }

    function toggle(id, show) {
        document.getElementById(id).style.display = show ? "block" : "none";
    }

    // ==== Formatters ====
    function formatCurrency(amount) {
        if (amount == null) return "—";
        return new Intl.NumberFormat("vi-VN").format(amount);
    }

    function formatDateTime(isoString) {
        if (!isoString) return {date: "—", time: ""};
        const d = new Date(isoString);
        return {
            date: d.toLocaleDateString("vi-VN"),
            time: d.toLocaleTimeString("vi-VN", {hour: "2-digit", minute: "2-digit"})
        };
    }

    function formatBankAccount(number) {
        if (!number) return "—";
        return number.replace(/(\d{4})(?=\d)/g, "$1 ");
    }
</script>