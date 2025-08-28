<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- Modal Chi tiết số dư bị đóng băng -->
<div class="modal fade" id="frozenDetailsModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">

            <!-- Header -->
            <div class="modal-header border-0 text-white" style="background: linear-gradient(90deg,#f59e0b,#f97316);">
                <div class="d-flex align-items-center">
                    <div class="bg-white bg-opacity-20 p-3 rounded-circle me-3">
                        <i class="bi bi-lock text-white fs-3"></i>
                    </div>
                    <div>
                        <h4 class="modal-title fw-bold mb-1">Chi tiết số dư bị đóng băng</h4>
                        <p class="mb-0 opacity-75 small">Xem lý do và thời gian ước tính giải tỏa</p>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>

            <!-- Body -->
            <div class="modal-body p-0">
                <!-- Summary -->
                <div class="bg-light p-4 border-bottom">
                    <div class="row g-3">
                        <div class="col-lg-4 col-md-6">
                            <div class="card border-0 bg-white shadow-sm h-100">
                                <div class="card-body text-center p-4">
                                    <i class="bi bi-lock text-warning fs-2 mb-2"></i>
                                    <div id="frozen-balance" class="h3 text-warning fw-bold mb-1">— ₫</div>
                                    <small class="text-muted fw-semibold">Tổng số dư bị đóng băng</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="card border-0 bg-white shadow-sm h-100">
                                <div class="card-body text-center p-4">
                                    <i class="bi bi-hourglass-split text-info fs-2 mb-2"></i>
                                    <div id="frozen-count" class="h3 text-info fw-bold mb-1">0</div>
                                    <small class="text-muted fw-semibold">Yêu cầu đang xử lý</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-12">
                            <div class="card border-0 bg-white shadow-sm h-100">
                                <div class="card-body text-center p-4">
                                    <i class="bi bi-clock text-success fs-2 mb-2"></i>
                                    <div class="h3 text-success fw-bold mb-1">3-5</div>
                                    <small class="text-muted fw-semibold">Ngày làm việc (ước tính)</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="p-4">
                    <div class="d-flex align-items-center mb-4">
                        <div class="bg-primary bg-opacity-10 p-2 rounded-circle me-3">
                            <i class="bi bi-list-check text-primary fs-5"></i>
                        </div>
                        <div>
                            <h5 class="mb-0 fw-bold">Danh sách yêu cầu đang xử lý</h5>
                            <small class="text-muted">Chi tiết các giao dịch rút tiền đang chờ xử lý</small>
                        </div>
                    </div>

                    <!-- Table (desktop) -->
                    <div class="d-none d-lg-block">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                <tr>
                                    <th>Mã yêu cầu</th>
                                    <th>Ngày tạo</th>
                                    <th class="text-end">Số tiền</th>
                                    <th>Phương thức</th>
                                    <th>Trạng thái</th>
                                    <th>Ngân hàng</th>
                                    <th>Thời gian ước tính</th>
                                </tr>
                                </thead>
                                <tbody id="frozen-table-body">
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-4">Đang tải...</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Mobile (cards) -->
                    <div id="frozen-mobile-list" class="d-lg-none"></div>
                    <div class="mt-5">
                        <div class="alert border-0 shadow-sm"
                             style="background: linear-gradient(45deg, #e3f2fd, #f3e5f5);">
                            <div class="d-flex align-items-start">
                                <div class="bg-info bg-opacity-20 p-2 rounded-circle me-3 flex-shrink-0">
                                    <i class="bi bi-info-circle text-info fs-5"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <h6 class="fw-bold mb-3 text-info">Thông tin quan trọng</h6>
                                    <div class="row g-2">
                                        <div class="col-md-6">
                                            <div class="d-flex align-items-start mb-2">
                                                <i class="bi bi-dot text-info me-1 mt-1"></i>
                                                <span class="small">Số dư bị đóng băng khi có yêu cầu rút tiền đang chờ xử lý</span>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="d-flex align-items-start mb-2">
                                                <i class="bi bi-dot text-info me-1 mt-1"></i>
                                                <span class="small">Thời gian xử lý: 1-5 ngày làm việc tùy theo phương thức</span>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="d-flex align-items-start mb-2">
                                                <i class="bi bi-dot text-info me-1 mt-1"></i>
                                                <span class="small">Bạn có thể hủy yêu cầu rút tiền để giải tỏa số dư</span>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="d-flex align-items-start mb-2">
                                                <i class="bi bi-dot text-info me-1 mt-1"></i>
                                                <span class="small">Liên hệ hỗ trợ: <a href="mailto:support@example.com"
                                                                                       class="text-decoration-none">support@example.com</a></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Process Timeline -->
                    <div class="mt-5">
                        <div class="d-flex align-items-center mb-4">
                            <div class="bg-primary bg-opacity-10 p-2 rounded-circle me-3">
                                <i class="bi bi-arrow-right-circle text-primary fs-5"></i>
                            </div>
                            <div>
                                <h5 class="mb-0 fw-bold">Quy trình xử lý yêu cầu rút tiền</h5>
                                <small class="text-muted">Theo dõi tiến trình xử lý từ tạo yêu cầu đến hoàn
                                    thành</small>
                            </div>
                        </div>

                        <div class="row g-3">
                            <div class="col-lg-3 col-md-6">
                                <div class="card border-0 bg-light h-100">
                                    <div class="card-body p-4 text-center">
                                        <div class="bg-warning bg-opacity-20 rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                                             style="width: 50px; height: 50px;">
                                            <i class="bi bi-clock text-warning fs-5"></i>
                                        </div>
                                        <h6 class="fw-bold mb-1">Bước 1</h6>
                                        <div class="text-muted small">Chờ duyệt</div>
                                        <div class="text-muted small mt-1">1-2 ngày</div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6">
                                <div class="card border-0 bg-light h-100">
                                    <div class="card-body p-4 text-center">
                                        <div class="bg-info bg-opacity-20 rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                                             style="width: 50px; height: 50px;">
                                            <i class="bi bi-check-circle text-info fs-5"></i>
                                        </div>
                                        <h6 class="fw-bold mb-1">Bước 2</h6>
                                        <div class="text-muted small">Đã duyệt</div>
                                        <div class="text-muted small mt-1">Tự động</div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6">
                                <div class="card border-0 bg-light h-100">
                                    <div class="card-body p-4 text-center">
                                        <div class="bg-primary bg-opacity-20 rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                                             style="width: 50px; height: 50px;">
                                            <i class="bi bi-arrow-repeat text-primary fs-5"></i>
                                        </div>
                                        <h6 class="fw-bold mb-1">Bước 3</h6>
                                        <div class="text-muted small">Đang chuyển</div>
                                        <div class="text-muted small mt-1">1-2 ngày</div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6">
                                <div class="card border-0 bg-light h-100">
                                    <div class="card-body p-4 text-center">
                                        <div class="bg-success bg-opacity-20 rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                                             style="width: 50px; height: 50px;">
                                            <i class="bi bi-check-circle-fill text-success fs-5"></i>
                                        </div>
                                        <h6 class="fw-bold mb-1">Bước 4</h6>
                                        <div class="text-muted small">Hoàn thành</div>
                                        <div class="text-muted small mt-1">Thông báo</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer bg-light border-0">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div class="text-muted small">
                        <i class="bi bi-info-circle me-1"></i>
                        Cập nhật lần cuối: hôm nay
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-secondary" onclick="window.print()">
                            <i class="bi bi-printer me-1"></i>In báo cáo
                        </button>
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">
                            <i class="bi bi-check-lg me-1"></i>Hoàn tất
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        var frozenModal = document.getElementById("frozenDetailsModal");
        frozenModal.addEventListener("show.bs.modal", async function () {
            try {
                const url = '${pageContext.request.contextPath}/dashboard/wallet/withdraws/pending-approved?page=0&size=20';
                const res = await fetch(url, {headers: {"Accept": "application/json"}});
                const pageData = await res.json();
                const list = pageData.content || [];

                // Update count & balance
                setText("frozen-count", list.length);
                const total = list.reduce((sum, w) => sum + (w.amount || 0), 0);
                setText("frozen-balance", formatCurrency(total) + "₫");

                const tbody = document.getElementById("frozen-table-body");
                const mobileList = document.getElementById("frozen-mobile-list");
                tbody.innerHTML = "";
                mobileList.innerHTML = "";

                if (list.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="7" class="text-center text-muted py-4">Không có yêu cầu rút tiền</td></tr>';
                    return;
                }

                list.forEach(w => {
                    const created = formatDateTime(w.createdAt);

                    // table row
                    const row =
                        '<tr>' +
                        '<td><span class="badge bg-warning bg-opacity-15 fw-bold px-3 py-2">#WD' + w.id + '</span></td>' +
                        '<td><div class="d-flex flex-column">' +
                        '<span class="fw-semibold">' + created.date + '</span>' +
                        '<span class="text-muted small">' + created.time + '</span>' +
                        '</div></td>' +
                        '<td class="text-end"><span class="fw-bold text-warning">' + formatCurrency(w.amount) + '₫</span></td>' +
                        '<td>' + (w.method || "") + '</td>' +
                        '<td>' +
                        (w.status === "PENDING"
                            ? '<span class="badge bg-warning"><i class="bi bi-clock me-1"></i>Chờ duyệt</span>'
                            : '<span class="badge bg-info"><i class="bi bi-check-circle me-1"></i>Đã duyệt</span>') +
                        '</td>' +
                        '<td>' +
                        '<div class="fw-semibold">' + (w.bankName || "") + '</div>' +
                        '<div class="text-muted small">' + (w.accountName || "") + '</div>' +
                        '<div class="text-muted small font-monospace">***' + ((w.accountNumber || "").slice(-4)) + '</div>' +
                        '</td>' +
                        '<td>' +
                        (w.status === "PENDING"
                            ? '<span class="text-warning fw-semibold"><i class="bi bi-clock me-1"></i>2-3 ngày</span>'
                            : '<span class="text-info fw-semibold"><i class="bi bi-hourglass me-1"></i>1-2 ngày</span>') +
                        '</td>' +
                        '</tr>';
                    tbody.innerHTML += row;

                    // mobile card
                    const card =
                        '<div class="card shadow-sm border-0 mb-3">' +
                        '<div class="card-body p-3">' +
                        '<div class="d-flex justify-content-between align-items-start mb-3">' +
                        '<span class="badge bg-warning bg-opacity-15 text-warning fw-bold px-3 py-2">#WD' + w.id + '</span>' +
                        (w.status === "PENDING"
                            ? '<span class="badge bg-warning px-3 py-2"><i class="bi bi-clock me-1"></i>Chờ duyệt</span>'
                            : '<span class="badge bg-info px-3 py-2"><i class="bi bi-check-circle me-1"></i>Đã duyệt</span>') +
                        '</div>' +
                        '<div class="row g-3">' +
                        '<div class="col-6"><div class="small text-muted">Số tiền</div><div class="fw-bold text-warning">' + formatCurrency(w.amount) + '₫</div></div>' +
                        '<div class="col-6"><div class="small text-muted">Ngày tạo</div><div class="fw-semibold">' + created.date + '</div><div class="text-muted small">' + created.time + '</div></div>' +
                        '<div class="col-6"><div class="small text-muted">Phương thức</div>' + (w.method || "") + '</div>' +
                        '<div class="col-6"><div class="small text-muted">Thời gian ước tính</div>' +
                        (w.status === "PENDING"
                            ? '<span class="text-warning fw-semibold small"><i class="bi bi-clock me-1"></i>2-3 ngày</span>'
                            : '<span class="text-info fw-semibold small"><i class="bi bi-hourglass me-1"></i>1-2 ngày</span>') +
                        '</div>' +
                        '<div class="col-12"><div class="small text-muted">Ngân hàng</div><div class="fw-semibold">' + (w.bankName || "") + '</div><div class="text-muted small">' + (w.accountName || "") + '</div><div class="text-muted small font-monospace">***' + ((w.accountNumber || "").slice(-4)) + '</div></div>' +
                        '</div></div></div>';
                    mobileList.innerHTML += card;
                });
            } catch (e) {
                console.error("❌ Lỗi load frozen withdraws:", e);
            }
        });
    });

    // ==== Helpers ====
    function setText(id, text) {
        document.getElementById(id).innerText = text || "—";
    }

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
</script>
