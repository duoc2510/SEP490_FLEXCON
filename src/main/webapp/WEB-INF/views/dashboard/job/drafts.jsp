<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <%@include file="../include/head.jsp" %>
    <body style="background: linear-gradient(135deg, #fdfbfb 0%, #ebedee 100%);">
        <div class="container-fluid">
            <div class="row g-0">
                <!-- Sidebar -->
                <%@include file="../include/sidebar.jsp" %>

                <!-- Main Content -->
                <main class="col-12 col-lg-9 col-xl-10 p-4">
                    <!-- Header -->
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h2 class="h3 mb-1 text-dark">
                                <i class="bi bi-file-earmark-text text-warning me-2"></i>Danh sách Job Nháp
                            </h2>
                            <p class="text-muted mb-0">Quản lý và đăng các job đã lưu nháp</p>
                        </div>
                        <div>
                            <a href="<c:url value='/employer/job/create'/>" class="btn btn-warning text-white shadow-sm">
                                <i class="bi bi-plus-circle me-1"></i>Tạo Job Mới
                            </a>
                        </div>
                    </div>

                    <!-- Thông báo -->
                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                            <i class="bi bi-check-circle-fill me-2"></i>${success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Stats Cards -->
                    <div class="row g-3 mb-4">
                        <div class="col-md-3">
                            <div class="card border-0 shadow-sm">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-warning bg-opacity-10 rounded-circle p-3 me-3">
                                            <i class="bi bi-file-earmark text-warning fs-4"></i>
                                        </div>
                                        <div>
                                            <h6 class="text-muted mb-1">Tổng số nháp</h6>
                                            <h4 class="mb-0">${drafts.size()}</h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card border-0 shadow-sm">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-info bg-opacity-10 rounded-circle p-3 me-3">
                                            <i class="bi bi-clock-history text-info fs-4"></i>
                                        </div>
                                        <div>
                                            <h6 class="text-muted mb-1">Cần hoàn thiện</h6>
                                            <h4 class="mb-0">
                                                <c:set var="incomplete" value="0"/>
                                                <c:forEach items="${drafts}" var="draft">
                                                    <c:if test="${empty draft.description or draft.description.length() < 30}">
                                                        <c:set var="incomplete" value="${incomplete + 1}"/>
                                                    </c:if>
                                                </c:forEach>
                                                ${incomplete}
                                            </h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card border-0 shadow-sm">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-success bg-opacity-10 rounded-circle p-3 me-3">
                                            <i class="bi bi-check2-circle text-success fs-4"></i>
                                        </div>
                                        <div>
                                            <h6 class="text-muted mb-1">Sẵn sàng đăng</h6>
                                            <h4 class="mb-0">
                                                <c:set var="ready" value="0"/>
                                                <c:forEach items="${drafts}" var="draft">
                                                    <c:if test="${not empty draft.description and draft.description.length() >= 30}">
                                                        <c:set var="ready" value="${ready + 1}"/>
                                                    </c:if>
                                                </c:forEach>
                                                ${ready}
                                            </h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card border-0 shadow-sm">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-danger bg-opacity-10 rounded-circle p-3 me-3">
                                            <i class="bi bi-calendar-x text-danger fs-4"></i>
                                        </div>
                                        <div>
                                            <h6 class="text-muted mb-1">Quá hạn</h6>
                                            <h4 class="mb-0">
                                                <c:set var="expired" value="0"/>
                                                <jsp:useBean id="now" class="java.util.Date"/>
                                                <c:forEach items="${drafts}" var="draft">
                                                    <c:if test="${draft.deadlineAt != null and draft.deadlineAt.toEpochMilli() < now.time}">
                                                        <c:set var="expired" value="${expired + 1}"/>
                                                    </c:if>
                                                </c:forEach>
                                                ${expired}
                                            </h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Search and Filter -->
                    <div class="card border-0 shadow-sm mb-3">
                        <div class="card-body py-3">
                            <div class="row align-items-center">
                                <div class="col-md-6">
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-search"></i>
                                        </span>
                                        <input type="text" class="form-control" 
                                               placeholder="Tìm kiếm theo tiêu đề..." id="searchInput">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-flex justify-content-end gap-2">
                                        <div class="btn-group btn-group-sm">
                                            <button type="button" class="btn btn-outline-secondary active" data-filter="all">
                                                Tất cả (${drafts.size()})
                                            </button>
                                            <button type="button" class="btn btn-outline-success" data-filter="ready">
                                                Sẵn sàng (${ready})
                                            </button>
                                            <button type="button" class="btn btn-outline-warning" data-filter="incomplete">
                                                Chưa hoàn thiện (${incomplete})
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Jobs Table -->
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-light">
                            <h5 class="mb-0"><i class="bi bi-list-ul text-warning me-2"></i>Danh sách nháp (${drafts.size()} jobs)</h5>
                        </div>
                        <div class="card-body p-0">
                            <c:choose>
                                <c:when test="${empty drafts}">
                                    <div class="text-center py-5">
                                        <i class="bi bi-inbox text-muted" style="font-size: 3rem;"></i>
                                        <h5 class="text-muted mt-3">Chưa có job nháp nào</h5>
                                        <a href="<c:url value='/employer/job/create'/>" class="btn btn-warning shadow-sm mt-3">
                                            <i class="bi bi-plus-circle me-1"></i>Tạo Job Đầu Tiên
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="table-responsive">
                                        <table class="table table-hover align-middle mb-0">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>Tiêu đề</th>
                                                    <th>Loại</th>
                                                    <th style="width: 250px;">Mô tả</th>
                                                    <th>Ngân sách</th>
                                                    <th>Hạn chót</th>
                                                    <th>Trạng thái</th>
                                                    <th class="text-center">Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${drafts}" var="draft">
                                                    <tr>
                                                        <td class="fw-semibold">
                                                            ${draft.title}
                                                            <br><small class="text-muted">ID: #${draft.id}</small>
                                                        </td>
                                                        <td>${draft.type}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty draft.description}">
                                                                    <span class="text-truncate d-inline-block" style="max-width:230px;" title="${draft.description}">
                                                                        ${draft.description}
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">Chưa có mô tả</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${draft.jobBidding != null and draft.jobBidding.budget != null}">
                                                                    <span class="text-success fw-semibold">
                                                                        <fmt:formatNumber value="${draft.jobBidding.budget}" pattern="#,###"/> VNĐ
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise><span class="text-muted">Chưa đặt</span></c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty draft.deadlineFormatted}">
                                                                    ${draft.deadlineFormatted}
                                                                </c:when>
                                                                <c:otherwise><span class="text-muted">Chưa đặt</span></c:otherwise>
                                                            </c:choose>
                                                        </td>

                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${draft.status eq 'DRAFT'}">
                                                                    <span class="badge bg-warning text-dark">Nháp</span>
                                                                </c:when>
                                                                <c:when test="${draft.status eq 'PENDING_REVIEW'}">
                                                                    <span class="badge bg-success">Sẵn sàng</span>
                                                                </c:when>
                                                                <c:when test="${draft.status eq 'OPEN'}">
                                                                    <span class="badge bg-primary">Đang tuyển</span>
                                                                </c:when>
                                                                <c:when test="${draft.status eq 'CLOSED'}">
                                                                    <span class="badge bg-danger">Đã đóng</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-secondary">Không xác định</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>

                                                        <td class="text-center">
                                                            <!-- Publish -->
                                                            <form action="<c:url value='/employer/draft/publish/${draft.id}'/>"
                                                                  method="post" class="d-inline"
                                                                  onsubmit="return confirmPublish()">
                                                                <button type="submit" class="btn btn-sm btn-success" title="Đăng job">
                                                                    <i class="bi bi-send"></i>
                                                                </button>
                                                            </form>
                                                            <!-- Preview -->
                                                            <button type="button" class="btn btn-sm btn-outline-info"
                                                                    title="Xem trước"
                                                                    onclick="previewJob(
                                                                                    '${fn:escapeXml(draft.title)}',
                                                                                    '${fn:escapeXml(draft.description)}',
                                                                                    '${draft.jobBidding != null ? draft.jobBidding.budget : ''}',
                                                                                    '${draft.deadlineAt != null ? draft.deadlineAt : ''}',
                                                                                    '${draft.status eq "DRAFT" ? "Nháp" : 
                                                                       (draft.status eq "PENDING_REVIEW" ? "Sẵn sàng" : 
                                                                       (draft.status eq "OPEN" ? "Đang tuyển" : 
                                                                       (draft.status eq "CLOSED" ? "Đã đóng" : "Khác")))}'
                                                                                    )">
                                                                <i class="bi bi-eye"></i>
                                                            </button>
                                                            <!-- Update -->
                                                            <button type="button" class="btn btn-sm btn-outline-primary"
                                                                    title="Chỉnh sửa"
                                                                    onclick="openEdit(
                                                                                    '${draft.id}',
                                                                                    '${fn:escapeXml(draft.title)}',
                                                                                    '${fn:escapeXml(draft.description)}',
                                                                                    '${draft.jobBidding != null ? draft.jobBidding.budget : ''}',
                                                                                    '${draft.deadlineAt != null ? draft.deadlineAt : ''}'
                                                                                    )">
                                                                <i class="bi bi-pencil"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <!-- Help Section -->
                    <div class="card border-0 shadow-sm mt-4">
                        <div class="card-body">
                            <h6 class="text-warning mb-3">
                                <i class="bi bi-lightbulb me-2"></i>Hướng dẫn sử dụng
                            </h6>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="d-flex">
                                        <i class="bi bi-1-circle text-primary me-3 fs-5"></i>
                                        <div>
                                            <h6 class="mb-1">Hoàn thiện nháp</h6>
                                            <small class="text-muted">Nhấn nút chỉnh sửa để bổ sung thông tin</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="d-flex">
                                        <i class="bi bi-2-circle text-success me-3 fs-5"></i>
                                        <div>
                                            <h6 class="mb-1">Kiểm tra kỹ</h6>
                                            <small class="text-muted">Xem lại thông tin trước khi đăng</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="d-flex">
                                        <i class="bi bi-3-circle text-warning me-3 fs-5"></i>
                                        <div>
                                            <h6 class="mb-1">Đăng job</h6>
                                            <small class="text-muted">Nhấn nút gửi để công khai</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <!-- Preview Modal -->
        <div class="modal fade" id="previewModal" tabindex="-1">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content shadow-lg border-0 rounded-3">
                    <div class="modal-header bg-info text-white">
                        <h5 class="modal-title"><i class="bi bi-eye me-2"></i> Xem trước Job Nháp</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body p-4">
                        <h4 class="fw-bold text-primary" id="previewTitle"></h4>
                        <p class="text-muted" id="previewDescription"></p>
                        <div class="row g-3 mt-3">
                            <div class="col-md-6">
                                <div class="card border-0 shadow-sm h-100">
                                    <div class="card-body">
                                        <h6 class="text-muted"><i class="bi bi-cash-coin me-2 text-success"></i>Ngân sách</h6>
                                        <p class="fs-5 fw-semibold" id="previewBudget">-</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card border-0 shadow-sm h-100">
                                    <div class="card-body">
                                        <h6 class="text-muted"><i class="bi bi-calendar-event me-2 text-warning"></i>Hạn chót</h6>
                                        <p class="fs-5 fw-semibold" id="previewDeadline">-</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="mt-4">
                            <span class="badge fs-6 px-3 py-2" id="previewStatus"></span>
                        </div>
                    </div>
                    <div class="modal-footer bg-light">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="bi bi-x-circle me-1"></i>Đóng
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Modal -->
        <div class="modal fade" id="editModal" tabindex="-1">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content shadow-lg border-0 rounded-3">
                    <form method="post" action="<c:url value='/employer/draft/update'/>">
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title"><i class="bi bi-pencil-square me-2"></i> Chỉnh sửa Job Nháp</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body p-4">
                            <input type="hidden" name="id" id="editId"/>
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Tiêu đề</label>
                                <input type="text" class="form-control" name="title" id="editTitle"/>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Mô tả</label>
                                <textarea class="form-control" rows="5" name="description" id="editDescription"></textarea>
                            </div>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Ngân sách</label>
                                    <input type="number" class="form-control" name="budget" id="editBudget"/>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Hạn chót</label>
                                    <input type="datetime-local" class="form-control" name="deadline" id="editDeadline"/>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer bg-light">
                            <button type="submit" class="btn btn-success">
                                <i class="bi bi-check-circle me-1"></i> Lưu thay đổi
                            </button>
                            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                <i class="bi bi-x-circle me-1"></i> Hủy
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <style>
            .table th {
                background-color: #f8f9fa;
                border-top: none;
                padding: 12px;
                font-size: 0.9rem;
            }

            .table td {
                padding: 12px;
                vertical-align: middle;
            }

            .table tbody tr:hover {
                background-color: #f8f9fa;
            }

            .badge {
                font-size: 0.75rem;
            }

            .btn-sm {
                padding: 0.25rem 0.5rem;
            }

            @media (max-width: 768px) {
                .table th, .table td {
                    padding: 8px;
                    font-size: 0.85rem;
                }
            }
        </style>
        <script>
                                                                        function confirmPublish() {
                                                                            return confirm('Bạn có chắc muốn đăng job này?');
                                                                        }

                                                                        function previewJob(title, description, budget, deadline, status) {
                                                                            document.getElementById('previewTitle').innerText = title;
                                                                            document.getElementById('previewDescription').innerText = description || 'Chưa có mô tả';
                                                                            document.getElementById('previewBudget').innerText = budget || 'Chưa đặt';
                                                                            document.getElementById('previewDeadline').innerText = deadline || 'Chưa đặt';

                                                                            let statusEl = document.getElementById('previewStatus');
                                                                            if (status === "Sẵn sàng") {
                                                                                statusEl.className = "badge bg-success fs-6 px-3 py-2";
                                                                                statusEl.innerText = "Sẵn sàng";
                                                                            } else {
                                                                                statusEl.className = "badge bg-warning text-dark fs-6 px-3 py-2";
                                                                                statusEl.innerText = "Chưa hoàn thiện";
                                                                            }

                                                                            new bootstrap.Modal(document.getElementById('previewModal')).show();
                                                                        }

                                                                        function openEdit(id, title, description, budget, deadline) {
                                                                            document.getElementById('editId').value = id;
                                                                            document.getElementById('editTitle').value = title;
                                                                            document.getElementById('editDescription').value = description;
                                                                            document.getElementById('editBudget').value = budget;
                                                                            document.getElementById('editDeadline').value = deadline;
                                                                            new bootstrap.Modal(document.getElementById('editModal')).show();
                                                                        }

                                                                        // Auto dismiss alerts
                                                                        setTimeout(() => {
                                                                            document.querySelectorAll('.alert').forEach(alert => {
                                                                                const bsAlert = new bootstrap.Alert(alert);
                                                                                if (bsAlert)
                                                                                    bsAlert.close();
                                                                            });
                                                                        }, 5000);
        </script>
    </body>
</html>
