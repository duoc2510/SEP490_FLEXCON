<%-- 
    Document   : createcontract.jsp
    Created on : Aug 22, 2025, 3:15:24 PM
    Author     : ASUS-PRO
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <%@include file="../include/head.jsp" %>
    
    <body style="background: linear-gradient(135deg, #fff5f0 0%, #ffffff 100%);">

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
                                <i class="bi bi-file-earmark-text text-warning me-2"></i>Tạo Hợp Đồng Mới
                            </h2>
                            <p class="text-muted mb-0">Tạo hợp đồng làm việc với freelancer đã chọn</p>
                        </div>
                        <div class="d-flex align-items-center gap-3">
                            <a href="${pageContext.request.contextPath}/employer/contracts" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-1"></i>Quay lại
                            </a>
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb mb-0">
                                    <li class="breadcrumb-item">
                                        <a href="#" class="text-warning text-decoration-none">Hợp đồng</a>
                                    </li>
                                    <li class="breadcrumb-item active">Tạo mới</li>
                                </ol>
                            </nav>
                        </div>
                    </div>

                    <div class="row justify-content-center">
                        <div class="col-12 col-xl-10">
                            <!-- Progress Steps -->
                            <div class="card border-0 shadow-sm mb-4">
                                <div class="card-body p-4">
                                    <div class="row text-center">
                                        <div class="col-4">
                                            <div class="position-relative">
                                                <div id="step1" class="bg-warning text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-2" style="width: 40px; height: 40px;">
                                                    <i class="bi bi-1-circle"></i>
                                                </div>
                                                <div id="step1Text" class="small fw-bold text-warning">Thông tin cơ bản</div>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div class="position-relative">
                                                <div id="step2" class="bg-light text-muted rounded-circle d-inline-flex align-items-center justify-content-center mb-2" style="width: 40px; height: 40px;">
                                                    <i class="bi bi-2-circle"></i>
                                                </div>
                                                <div id="step2Text" class="small text-muted">Điều khoản & Phí</div>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div class="position-relative">
                                                <div id="step3" class="bg-light text-muted rounded-circle d-inline-flex align-items-center justify-content-center mb-2" style="width: 40px; height: 40px;">
                                                    <i class="bi bi-3-circle"></i>
                                                </div>
                                                <div id="step3Text" class="small text-muted">Xác nhận & Tạo</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <form id="contractForm" action="<c:url value='/employer/contract/create'/>" method="POST" novalidate>
                                <div class="row g-4">
                                    <!-- Main Form -->
                                    <div class="col-lg-8">
                                        <!-- Basic Information -->
                                        <div class="card border-0 shadow-sm mb-4">
                                            <div class="card-header bg-transparent border-0 p-4">
                                                <h5 class="mb-0">
                                                    <i class="bi bi-info-circle text-warning me-2"></i>Thông tin hợp đồng
                                                </h5>
                                            </div>
                                            <div class="card-body p-4">
                                                <!-- Hidden fields mapping to ContractsDto -->
                                                <input type="hidden" name="employerId" value="${sessionScope.currentUser.id}"/>
                                                <input type="hidden" name="status" value="PENDING"/>
                                                <input type="hidden" name="jobId" value="${jobBidding.job.id}"/>
                                                <input type="hidden" name="proposalId" value="${proposalsByJobseeker.id}"/>
                                                <input type="hidden" name="jobseekerId" value="${jobseekerInfo.id}"/>
                                                <input type="hidden" name="commonFund" id="commonFundInput"/>

                                                <!-- Job Information (readonly) -->
                                                <div class="mb-4">
                                                    <label class="form-label fw-medium">Dự án</label>
                                                    <div class="card bg-light border-0">
                                                        <div class="card-body p-3">
                                                            <div class="d-flex justify-content-between align-items-start">
                                                                <div class="flex-grow-1">
                                                                    <h6 class="mb-1">${jobBidding.job.title}</h6>
                                                                    <p class="text-muted small mb-2">${jobBidding.job.description}</p>
                                                                    <div class="d-flex gap-2">
                                                                        <span class="badge bg-primary">${jobBidding.job.type}</span>
                                                                        <span class="badge bg-success">${jobBidding.job.status}</span>
                                                                    </div>
                                                                </div>
                                                                <div class="text-end">
                                                                    <div class="fw-bold text-success">Job #${jobBidding.job.id}</div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Proposal Information (readonly) -->
                                                <div class="mb-4">
                                                    <label class="form-label fw-medium">Proposal đã chọn</label>
                                                    <div class="card bg-light border-0">
                                                        <div class="card-body p-3">
                                                            <div class="d-flex justify-content-between align-items-start">
                                                                <div class="flex-grow-1">
                                                                    <h6 class="mb-1">${jobseekerInfo.fullName}</h6>
                                                                    <p class="text-muted small mb-2">${proposalsByJobseeker.coverLetter}</p>
                                                                    <div class="d-flex gap-2">
                                                                        <span class="badge bg-warning text-dark">Thời gian hoàn thành: ${proposalsByJobseeker.durationDays} ngày</span>
                                                                    </div>
                                                                </div>
                                                                <div class="text-end">
                                                                    <div class="h6 text-success mb-0">${proposalsByJobseeker.lowestBudgetFormatted}₫</div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Contract Reason - mapping to ContractsDto.reason -->
                                                <div class="mb-4">
                                                    <label class="form-label fw-medium" for="reason">Lý do tạo hợp đồng <span class="text-danger">*</span></label>
                                                    <select class="form-select" name="reason" id="reason" required>
                                                        <option value="">-- Chọn lý do --</option>
                                                        <option value="Proposal tốt nhất">Proposal tốt nhất</option>
                                                        <option value="Giá cả phù hợp">Giá cả phù hợp</option>
                                                        <option value="Kinh nghiệm phù hợp">Kinh nghiệm phù hợp</option>
                                                        <option value="Portfolio ấn tượng">Portfolio ấn tượng</option>
                                                        <option value="Giao tiếp tốt">Giao tiếp tốt</option>
                                                        <option value="Được giới thiệu">Được giới thiệu</option>
                                                        <option value="Lý do khác">Lý do khác</option>
                                                    </select>
                                                    <div class="form-text">
                                                        <i class="bi bi-info-circle me-1"></i>Chọn lý do chính tại sao bạn quyết định làm việc với freelancer này.
                                                    </div>
                                                    <div class="invalid-feedback">Vui lòng chọn lý do tạo hợp đồng.</div>
                                                </div>

                                                <!-- Common Fund -->
                                                <div class="mb-4">
                                                    <label class="form-label fw-medium" for="commonFund">Quỹ chung ₫ <span class="text-danger">*</span></label>
                                                    <div class="input-group">
                                                        <span class="input-group-text" id="currencySymbol">
                                                            <c:choose>
                                                                <c:when test="${proposalsByJobseeker.currency == 'USD'}">$</c:when>
                                                                <c:otherwise>₫</c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                        <input type="text" class="form-control" id="commonFundDisplay" 
                                                               placeholder="<c:choose><c:when test='${proposalsByJobseeker.currency == "USD"}'>VD: 200</c:when><c:otherwise>VD: 200.000</c:otherwise></c:choose>" inputmode="numeric" readonly  value="${proposalsByJobseeker.lowestBudgetFormatted}"  >
                                                    </div>
                                                    <div class="form-text">
                                                        <i class="bi bi-shield-check me-1"></i>Số tiền này sẽ được giữ trong escrow để đảm bảo an toàn cho cả hai bên.
                                                    </div>
                                                    <div class="invalid-feedback" id="commonFundError">Vui lòng nhập số tiền quỹ chung hợp lệ.</div>
                                                </div>

                                                <!-- Additional Notes - mapping to ContractsDto.note -->
                                                <div class="mb-2">
                                                    <label class="form-label fw-medium" for="notes">Ghi chú bổ sung</label>
                                                    <textarea class="form-control" name="note" id="notes" rows="3"
                                                              placeholder="Thêm ghi chú về điều khoản đặc biệt, yêu cầu bổ sung, hoặc thỏa thuận khác..."
                                                              maxlength="500"></textarea>
                                                    <div class="d-flex justify-content-between">
                                                        <div class="form-text">
                                                            <i class="bi bi-info-circle me-1"></i>Tùy chọn. Ghi chú này sẽ được bao gồm trong hợp đồng.
                                                        </div>
                                                        <small class="text-muted"><span id="notesCharCount">0</span>/500</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Terms & Conditions -->
                                        <div class="card border-0 shadow-sm">
                                            <div class="card-header bg-transparent border-0 p-4">
                                                <h5 class="mb-0">
                                                    <i class="bi bi-file-text text-warning me-2"></i>Điều khoản & Điều kiện
                                                </h5>
                                            </div>
                                            <div class="card-body p-4">
                                                <div class="row g-3">
                                                    <div class="col-12">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="checkbox" name="agree_terms" id="agreeTerms" required>
                                                            <label class="form-check-label fw-medium" for="agreeTerms">
                                                                Tôi đồng ý với <a href="#" class="text-warning text-decoration-none">Điều khoản dịch vụ</a> 
                                                                và <a href="#" class="text-warning text-decoration-none">Chính sách thanh toán</a> 
                                                                <span class="text-danger">*</span>
                                                            </label>
                                                            <div class="invalid-feedback">Bạn phải đồng ý với điều khoản để tiếp tục.</div>
                                                        </div>
                                                    </div>
                                                    <div class="col-12">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="checkbox" name="escrow_agreement" id="escrowAgreement" required>
                                                            <label class="form-check-label fw-medium" for="escrowAgreement">
                                                                Tôi hiểu rằng số tiền quỹ chung sẽ được giữ trong hệ thống escrow <span class="text-danger">*</span>
                                                            </label>
                                                            <div class="form-text">Tiền sẽ chỉ được giải ngân khi dự án hoàn thành và được chấp nhận.</div>
                                                            <div class="invalid-feedback">Bạn phải đồng ý với điều khoản escrow.</div>
                                                        </div>
                                                    </div>
                                                    <div class="col-12">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="checkbox" name="dispute_resolution" id="agree3" required>
                                                            <label class="form-check-label fw-medium" for="agree3">
                                                                Tôi đồng ý sử dụng hệ thống giải quyết tranh chấp của platform
                                                            </label>
                                                            <div class="form-text">Trong trường hợp có tranh chấp, cả hai bên sẽ sử dụng hệ thống trọng tài của nền tảng.</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Sidebar -->
                                    <div class="col-lg-4">
                                        <!-- Preview -->
                                        <div class="card border-0 shadow-sm mb-4 position-sticky" style="top: 1rem;">
                                            <div class="card-header bg-transparent border-0 p-3">
                                                <h6 class="mb-0">
                                                    <i class="bi bi-eye text-warning me-2"></i>Xem trước Hợp đồng
                                                </h6>
                                            </div>
                                            <div class="card-body p-3">
                                                <div class="mb-3">
                                                    <span class="badge bg-warning text-dark mb-2">PENDING</span>
                                                    <h6 class="text-dark" id="idContract"></h6>
                                                </div>

                                                <div class="mb-3">
                                                    <small class="text-muted d-block">Dự án:</small>
                                                    <div class="fw-medium" id="previewJobTitle">${jobBidding.job.title}</div>
                                                </div>

                                                <div class="mb-3">
                                                    <small class="text-muted d-block">Freelancer:</small>
                                                    <div class="fw-medium" id="previewFreelancer">${jobseekerInfo.fullName}</div>
                                                </div>

                                                <div class="mb-3">
                                                    <small class="text-muted d-block">Giá trị:</small>
                                                    <div class="fw-medium text-success" id="previewAmount">${proposalsByJobseeker.lowestBudgetFormatted} ₫</div>
                                                </div>

                                                <div class="mb-3">
                                                    <small class="text-muted d-block">Quỹ chung:</small>
                                                    <div class="fw-medium text-warning" id="previewCommonFund">${proposalsByJobseeker.lowestBudgetFormatted} ₫</div>
                                                </div>

                                                <div class="mb-3">
                                                    <small class="text-muted d-block">Lý do:</small>
                                                    <div class="fw-medium" id="previewReason">Chưa chọn</div>
                                                </div>

                                                <hr>
                                                <div class="small text-muted">
                                                    <i class="bi bi-calendar me-1"></i>Ngày tạo: <span id="previewDate">${currentDate}</span>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Tips -->
                                    <div class="card border-0 shadow-sm position-sticky" style="top: 420px; z-index: 1;">
    <div class="card-header bg-transparent border-0 p-3">
        <h6 class="mb-0">
            <i class="bi bi-lightbulb text-warning me-2"></i>Lưu ý quan trọng
        </h6>
    </div>
    <div class="card-body p-3">
        <ul class="list-unstyled small mb-0">
            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Kiểm tra kỹ thông tin freelancer</li>
            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Đặt quỹ chung phù hợp</li>
            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Đọc kỹ điều khoản hợp đồng</li>
            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Thiết lập milestone rõ ràng</li>
            <li><i class="bi bi-check-circle text-success me-2"></i>Giao tiếp thường xuyên</li>
        </ul>
    </div>
</div>
                                    </div>
                                </div>

                                <!-- Action Buttons -->
                                <div class="d-flex justify-content-between align-items-center mt-4 pt-4 border-top">
                                    <div>
                                        <a href="${pageContext.request.contextPath}/employer/job/empJob?id=${jobBidding.job.id}" class="btn btn-link text-decoration-none">
                                            <i class="bi bi-arrow-left me-1"></i>Quay lại quản lý job
                                        </a>
                                    </div>
                                    <div class="d-flex gap-3">
                                        <button type="reset" class="btn btn-outline-secondary">
                                            <i class="bi bi-x-circle me-1"></i>Làm lại
                                        </button>
                                        <button type="button" class="btn btn-outline-warning" id="previewBtn">
                                            <i class="bi bi-eye me-1"></i>Xem trước
                                        </button>
                                        <button type="submit" class="btn btn-warning text-white" id="createBtn">
                                            <i class="bi bi-file-earmark-plus me-1"></i>Tạo hợp đồng
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <!-- PDF Preview Modal -->
        <div class="modal fade" id="pdfPreviewModal" tabindex="-1" aria-labelledby="pdfPreviewModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="pdfPreviewModalLabel">
                            <i class="bi bi-file-earmark-pdf text-danger me-2"></i>Xem trước Hợp đồng
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-0">
                        <div id="pdfContent" class="bg-white" style="min-height: 600px; font-family: 'Times New Roman', serif;">
                            <!-- PDF Content will be generated here -->
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="bi bi-x-circle me-1"></i>Đóng
                        </button>
                        <button type="button" class="btn btn-primary" onclick="printPDF()">
                            <i class="bi bi-printer me-1"></i>In PDF
                        </button>
                        <button type="button" class="btn btn-warning text-white" onclick="downloadPDF()">
                            <i class="bi bi-download me-1"></i>Tải xuống
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
        
        <!-- Toastr CSS & JS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var form = document.getElementById('contractForm');
                var commonFundDisplay = document.getElementById('commonFundDisplay');
                var commonFundInput = document.getElementById('commonFundInput');
                var reasonSelect = document.getElementById('reason');
                var notesTextarea = document.getElementById('notes');
                var charCount = document.getElementById('notesCharCount');
                var idContract = document.getElementById('idContract');
                let contractId = "NEW-" + Date.now() + "-" + Math.floor(Math.random() * 10000);
                
                // === CURRENCY SETTINGS ===
                var currency = "${proposalsByJobseeker.currency}";
                var isUSD = currency === 'USD';
                var minAmount = isUSD ? 5 : 100000; // $5 for USD, 100k for VND
                var currencySymbol = isUSD ? '$' : '₫';
                var currencyName = isUSD ? 'USD' : '₫';
                
               idContract.innerHTML = contractId + '';
                
                // === TOASTR CONFIGURATION ===
                toastr.options = {
                    "closeButton": true,
                    "debug": false,
                    "newestOnTop": true,
                    "progressBar": true,
                    "positionClass": "toast-top-right",
                    "preventDuplicates": false,
                    "onclick": null,
                    "showDuration": "300",
                    "hideDuration": "1000",
                    "timeOut": "4000",
                    "extendedTimeOut": "1000",
                    "showEasing": "swing",
                    "hideEasing": "linear",
                    "showMethod": "fadeIn",
                    "hideMethod": "fadeOut"
                };
                
                // === TOAST SYSTEM ===
                function showToast(message, type) {
                    switch(type) {
                        case 'success':
                            toastr.success(message);
                            break;
                        case 'error':
                        case 'danger':
                            toastr.error(message);
                            break;
                        case 'info':
                            toastr.info(message);
                            break;
                        case 'warning':
                            toastr.warning(message);
                            break;
                        default:
                            toastr.info(message);
                    }
                }
                
                // === Handle Backend Flash Messages ===
                <c:if test="${not empty success}">
                    $(document).ready(function() {
                        showToast('${success}', 'success');
                    });
                </c:if>
                
                <c:if test="${not empty error}">
                    $(document).ready(function() {
                        showToast('${error}', 'error');
                    });
                </c:if>
                
                // === PROGRESS STEP MANAGEMENT ===
                var currentStep = 1;
                
                function updateProgressStep(step) {
                    // Reset all steps
                    for (var i = 1; i <= 3; i++) {
                        var stepEl = document.getElementById('step' + i);
                        var stepText = document.getElementById('step' + i + 'Text');
                        if (i <= step) {
                            // Active or completed step
                            stepEl.className = 'bg-warning text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-2';
                            stepText.className = 'small fw-bold text-warning';
                        } else {
                            // Inactive step
                            stepEl.className = 'bg-light text-muted rounded-circle d-inline-flex align-items-center justify-content-center mb-2';
                            stepText.className = 'small text-muted';
                        }
                    }
                    currentStep = step;
                }

                function checkStepProgress() {
                    // Step 1: Basic info (reason selected)
                    if (reasonSelect.value) {
                        updateProgressStep(1);
                        // Step 2: Terms & Fee (common fund entered)
                        if (commonFundInput.value && parseInt(commonFundInput.value) >= minAmount) {
                            updateProgressStep(2);
                            // Step 3: Confirmation (all checkboxes checked)
                            var agreeTerms = document.getElementById('agreeTerms');
                            var escrowAgreement = document.getElementById('escrowAgreement');
                            var agree3 = document.getElementById('agree3');
                            if (agreeTerms.checked && escrowAgreement.checked && agree3.checked) {
                                updateProgressStep(3);
                            }
                        }
                    }
                }
                
                // === INITIAL SETUP FOR COMMON FUND ===
                var proposalAmountRaw = "${proposalsByJobseeker.lowestBudgetFormatted}".replace(/[,.]/g, '');
                commonFundInput.value = proposalAmountRaw;
                
                // === REASON SELECT UPDATE ===
                reasonSelect.addEventListener('change', function () {
                    var reasonText = this.options[this.selectedIndex].text;
                    document.getElementById('previewReason').textContent =
                        this.value ? reasonText : 'Chưa chọn';
                    checkStepProgress();
                });
                
                // === CHECKBOX LISTENERS ===
                document.getElementById('agreeTerms').addEventListener('change', checkStepProgress);
                document.getElementById('escrowAgreement').addEventListener('change', checkStepProgress);
                document.getElementById('agree3').addEventListener('change', checkStepProgress);
                
                // === NOTES CHARACTER COUNT ===
                notesTextarea.addEventListener('input', function () {
                    charCount.textContent = this.value.length;
                });
                
                // === PDF PREVIEW GENERATION ===
                function generatePDFContent() {
                    var jobTitle = "${jobBidding.job.title}";
                    var jobDescription = "${jobBidding.job.description}";
                    var freelancerName = "${jobseekerInfo.fullName}";
                    var proposalAmount = "${proposalsByJobseeker.lowestBudgetFormatted}";
                    var commonFund = document.getElementById('previewCommonFund').textContent;
                    var reason = document.getElementById('previewReason').textContent;
                    var notes = notesTextarea.value || 'Không có ghi chú bổ sung';
                    var currentDate = new Date().toLocaleDateString('vi-VN');
                    var currentUser = "${sessionScope.currentUser.fullName}";
                    if (!currentUser) currentUser = "${sessionScope.currentUser.username}";
                    var userEmail = "${sessionScope.currentUser.email}";
                    var userId = "${sessionScope.currentUser.id}";
                    var proposalId = "${proposalsByJobseeker.id}";
                    var durationDays = "${proposalsByJobseeker.durationDays}";
                      
                    // Calculate platform fee (8%)
                    var amountNumber = parseFloat("${proposalsByJobseeker.lowestBudgetFormatted}".replace(/,/g, ''));
                    var platformFee;
                    if (isUSD) {
                        platformFee = (amountNumber * 0.08).toFixed(2);
                    } else {
                        platformFee = (amountNumber * 0.08).toLocaleString('vi-VN');
                    } 
                    
                    return '<div class="p-5" style="max-width: 800px; margin: 0 auto;">' +
                        '<!-- Header -->' +
                        '<div class="text-center mb-5">' +
                        '<h1 class="h2 mb-2" style="color: #ff8c42; font-weight: bold;">HỢP ĐỒNG LÀM VIỆC</h1>' +
                        '<h2 class="h4 text-muted">FREELANCE PROJECT CONTRACT</h2>' +
                        '<hr style="border: 2px solid #ff8c42; width: 100px; margin: 20px auto;">' +
                        '</div>' +
                        '<!-- Contract Info -->' +
                        '<div class="row mb-4">' +
                        '<div class="col-6">' +
                        '<strong>Số hợp đồng:</strong> #' + contractId +
                        '</div>' +
                        '<div class="col-6 text-end">' +
                        '<strong>Ngày tạo:</strong> ' + currentDate +
                        '</div>' +
                        '</div>' +
                        '<!-- Parties -->' +
                        '<div class="mb-5">' +
                        '<h3 class="h5 mb-3" style="color: #ff8c42; border-bottom: 2px solid #ff8c42; padding-bottom: 5px;">' +
                        'CÁC BÊN THAM GIA' +
                        '</h3>' +
                        '<div class="row">' +
                        '<div class="col-6">' +
                        '<h6><strong>BÊN THUÊ (CLIENT)</strong></h6>' +
                        '<p class="mb-1">Tên: <strong>' + currentUser + '</strong></p>' +
                        '<p class="mb-1">Email: ' + userEmail + '</p>' +
                        '</div>' +
                        '<div class="col-6">' +
                        '<h6><strong>BÊN NHẬN VIỆC (FREELANCER)</strong></h6>' +
                        '<p class="mb-1">Tên: <strong>' + freelancerName + '</strong></p>' +
                        '<p class="mb-1">Thời gian thực hiện: ' + durationDays + ' ngày</p>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +

                        '<!-- Project Details -->' +
                        '<div class="mb-5">' +
                        '<h3 class="h5 mb-3" style="color: #ff8c42; border-bottom: 2px solid #ff8c42; padding-bottom: 5px;">' +
                        'CHI TIẾT DỰ ÁN' +
                        '</h3>' +
                        '<div class="mb-3">' +
                        '<strong>Tên dự án:</strong>' +
                        '<p class="mt-1">' + jobTitle + '</p>' +
                        '</div>' +
                        '<div class="mb-3">' +
                        '<strong>Mô tả dự án:</strong>' +
                        '<p class="mt-1" style="text-align: justify;">' + jobDescription + '</p>' +
                        '</div>' +
                        '<div class="mb-3">' +
                        '<strong>Lý do chọn freelancer:</strong>' +
                        '<p class="mt-1">' + reason + '</p>' +
                        '</div>' +
                        '</div>' +

                        '<!-- Financial Terms -->' +
                        '<div class="mb-5">' +
                        '<h3 class="h5 mb-3" style="color: #ff8c42; border-bottom: 2px solid #ff8c42; padding-bottom: 5px;">' +
                        'ĐIỀU KHOẢN TÀI CHÍNH' +
                        '</h3>' +
                        '<div class="table-responsive">' +
                        '<table class="table table-bordered">' +
                        '<tr>' +
                        '<td><strong>Giá trị hợp đồng</strong></td>' +
                        '<td class="text-end"><strong>' + proposalAmount + ' ' + currencyName + '</strong></td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td><strong>Quỹ chung (Escrow)</strong></td>' +
                        '<td class="text-end"><strong>' + commonFund + '</strong></td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td><strong>Thời gian thực hiện</strong></td>' +
                        '<td class="text-end">' + durationDays + ' ngày</td>' +
                        '</tr>' +
                        '<tr style="background-color: #fff5f0;">' +
                        '<td><strong>Phí nền tảng (8%)</strong></td>' +
                        '<td class="text-end">' + platformFee + ' ' + currencyName + '</td>' +
                        '</tr>' +
                        '</table>' +
                        '</div>' +
                        '</div>' +

                        '<!-- Terms and Conditions -->' +
                        '<div class="mb-5">' +
                        '<h3 class="h5 mb-3" style="color: #ff8c42; border-bottom: 2px solid #ff8c42; padding-bottom: 5px;">' +
                        'ĐIỀU KHOẢN & ĐIỀU KIỆN' +
                        '</h3>' +
                        '<ol style="line-height: 1.8;">' +
                        '<li><strong>Thanh toán:</strong> Số tiền được giữ trong hệ thống Escrow và sẽ được giải ngân khi dự án hoàn thành và được chấp nhận.</li>' +
                        '<li><strong>Thời hạn:</strong> Freelancer cam kết hoàn thành dự án trong ' + durationDays + ' ngày kể từ ngày hợp đồng có hiệu lực.</li>' +
                        '<li><strong>Chất lượng:</strong> Sản phẩm phải đáp ứng đầy đủ yêu cầu được nêu trong mô tả dự án.</li>' +
                        '<li><strong>Bảo mật:</strong> Cả hai bên cam kết bảo mật thông tin liên quan đến dự án.</li>' +
                        '<li><strong>Tranh chấp:</strong> Mọi tranh chấp sẽ được giải quyết thông qua hệ thống trọng tài của nền tảng.</li>' +
                        '<li><strong>Hủy bỏ:</strong> Hợp đồng có thể được hủy bỏ bởi một trong hai bên với lý do chính đáng.</li>' +
                        '</ol>' +
                        '</div>' +

                        '<!-- Additional Notes -->' +
                        '<div class="mb-5">' +
                        '<h3 class="h5 mb-3" style="color: #ff8c42; border-bottom: 2px solid #ff8c42; padding-bottom: 5px;">' +
                        'GHI CHÚ BỔ SUNG' +
                        '</h3>' +
                        '<p style="text-align: justify; background-color: #f8f9fa; padding: 15px; border-left: 4px solid #ff8c42;">' +
                        notes +
                        '</p>' +
                        '</div>' +

                        '<!-- Signatures -->' +
                        '<div class="mt-5">' +
                        '<div class="row">' +
                        '<div class="col-6 text-center">' +
                        '<div style="border-top: 2px solid #000; padding-top: 10px; margin-top: 60px;">' +
                        '<strong>CHỮ KÝ CLIENT</strong><br>' +
                        '<small>' + currentUser + '</small>' +
                        '</div>' +
                        '</div>' +
                        '<div class="col-6 text-center">' +
                        '<div style="border-top: 2px solid #000; padding-top: 10px; margin-top: 60px;">' +
                        '<strong>CHỮ KÝ FREELANCER</strong><br>' +
                        '<small>' + freelancerName + '</small>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +

                        '<!-- Footer -->' +
                        '<div class="text-center mt-5 pt-4" style="border-top: 1px solid #ddd;">' +
                        '<small class="text-muted">' +
                        'Hợp đồng này được tạo tự động bởi hệ thống FreelanceHub<br>' +
                        'Ngày tạo: ' + currentDate + ' | Contract ID: #' + contractId +
                        '</small>' +
                        '</div>' +
                        '</div>';
                }

                // === VALIDATION FUNCTIONS ===
                function validateReason() {
                    if (!reasonSelect.value) {
                        setInvalid(reasonSelect, 'Vui lòng chọn lý do tạo hợp đồng.');
                        return false;
                    }
                    setValid(reasonSelect);
                    return true;
                }

                function validateCheckboxes() {
                    var agreeTerms = document.getElementById('agreeTerms');
                    var escrowAgreement = document.getElementById('escrowAgreement');
                    var agree3 = document.getElementById('agree3');
                    
                    var valid = true;
                    
                    if (!agreeTerms.checked) {
                        setInvalid(agreeTerms, 'Bạn phải đồng ý với điều khoản.');
                        valid = false;
                    } else {
                        setValid(agreeTerms);
                    }
                    
                    if (!escrowAgreement.checked) {
                        setInvalid(escrowAgreement, 'Bạn phải đồng ý với điều khoản escrow.');
                        valid = false;
                    } else {
                        setValid(escrowAgreement);
                    }
                    
                     if (!agree3.checked) {
                        setInvalid(agree3, 'Bạn phải đồng ý với điều khoản xử lý tranh chấp.');
                        valid = false;
                    } else {
                        setValid(agree3);
                    }
                    
                    return valid;
                }

                function setInvalid(el, msg) {
                    el.classList.add('is-invalid');
                    el.classList.remove('is-valid');
                    var fb = el.parentElement.querySelector('.invalid-feedback');
                    if (!fb) {
                        fb = document.createElement('div');
                        fb.className = 'invalid-feedback';
                        el.parentElement.appendChild(fb);
                    }
                    fb.textContent = msg;
                }

                function setValid(el) {
                    el.classList.remove('is-invalid');
                    el.classList.add('is-valid');
                }

                // === FORM SUBMIT HANDLER ===
                form.addEventListener('submit', function (e) {
                    var isValid = 
                        validateReason() &&
                        validateCheckboxes();

                    if (!isValid) {
                        e.preventDefault();
                        e.stopPropagation();
                        form.classList.add('was-validated');

                        // Scroll to first invalid field
                        var firstInvalid = form.querySelector('.is-invalid');
                        if (firstInvalid) {
                            firstInvalid.scrollIntoView({behavior: 'smooth', block: 'center'});
                            firstInvalid.focus();
                        }

                        showToast('Vui lòng kiểm tra và sửa các lỗi trong form!', 'error');
                        return;
                    }

                    // Show loading
                    var submitBtn = document.getElementById('createBtn');
                    submitBtn.disabled = true;
                    submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span>Đang tạo hợp đồng...';

                    // Show confirmation
                    if (!confirm('🤝 Bạn có chắc muốn tạo hợp đồng này?\n\n⚠️ Lưu ý: Sau khi tạo, hợp đồng sẽ được gửi tới freelancer để xác nhận.')) {
                        e.preventDefault();
                        submitBtn.disabled = false;
                        submitBtn.innerHTML = '<i class="bi bi-file-earmark-plus me-1"></i>Tạo hợp đồng';
                        return;
                    }
                });

                // === PREVIEW BUTTON ===
                document.getElementById('previewBtn').addEventListener('click', function () {
                    // Validate first
                    if (!validateReason()) {
                        showToast('Vui lòng hoàn thiện thông tin trước khi xem trước.', 'error');
                        return;
                    }

                    // Generate PDF content
                    var pdfContent = generatePDFContent();
                    document.getElementById('pdfContent').innerHTML = pdfContent;
                    
                    // Show modal
                    var modal = new bootstrap.Modal(document.getElementById('pdfPreviewModal'));
                    modal.show();
                });

                // === PDF FUNCTIONS ===
                window.printPDF = function() {
                    var printContent = document.getElementById('pdfContent').innerHTML;
                    var printWindow = window.open('', '_blank');
                    printWindow.document.write(
                        '<html>' +
                            '<head>' +
                                '<title>Hợp đồng Freelance</title>' +
                                '<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">' +
                                '<style>' +
                                    'body { font-family: "Times New Roman", serif; }' +
                                    '@media print { ' +
                                        '.no-print { display: none; }' +
                                        'body { margin: 0; }' +
                                    '}' +
                                '</style>' +
                            '</head>' +
                            '<body>' +
                                printContent +
                            '</body>' +
                        '</html>'
                    );
                    printWindow.document.close();
                    printWindow.focus();
                    setTimeout(function() {
                        printWindow.print();
                        printWindow.close();
                    }, 250);
                };

                window.downloadPDF = function() {
                    // Show loading toast
                    showToast('Đang tạo PDF, vui lòng đợi...', 'info');
                    
                    // Simple download using html2canvas + jsPDF
                    var element = document.getElementById('pdfContent');
                    
                    html2canvas(element, {
                        scale: 2,
                        useCORS: true,
                        allowTaint: true
                    }).then(function(canvas) {
                        var imgData = canvas.toDataURL('image/png');
                        var jsPDF = window.jspdf.jsPDF;
                        var pdf = new jsPDF('p', 'mm', 'a4');
                        
                        var imgWidth = 210;
                        var pageHeight = 295;
                        var imgHeight = (canvas.height * imgWidth) / canvas.width;
                        var heightLeft = imgHeight;
                        var position = 0;
                        
                        pdf.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
                        heightLeft -= pageHeight;
                        
                        while (heightLeft >= 0) {
                            position = heightLeft - imgHeight;
                            pdf.addPage();
                            pdf.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
                            heightLeft -= pageHeight;
                        }
                        
                        var fileName = 'Contract_' + Date.now() + '.pdf';
                        pdf.save(fileName);
                        
                        showToast('Tải PDF thành công!', 'success');
                    }).catch(function(error) {
                        console.error('Error generating PDF:', error);
                        showToast('Lỗi tạo PDF. Vui lòng thử lại.', 'error');
                    });
                };

                // === INITIAL SETUP ===
                // Set current date
                var today = new Date().toLocaleDateString('vi-VN');
                document.getElementById('previewDate').textContent = today;
                
                // Set initial common fund value in preview
                document.getElementById('previewCommonFund').textContent = "${proposalsByJobseeker.lowestBudgetFormatted}" + ' ₫';
                
                // Initial validation and step check
                checkStepProgress();
                
                // Make showToast available globally
                window.showToast = showToast;
            });
            
            
            // ===== NGĂN CHẶN THAY ĐỔI INPUT =====
(function() {
    const ORIGINAL_VALUE = "${proposalsByJobseeker.lowestBudgetFormatted}";
    const ORIGINAL_RAW = "${proposalsByJobseeker.lowestBudgetFormatted}".replace(/[,.]/g, '');
    
    function protectInput() {
        const display = document.getElementById('commonFundDisplay');
        const hidden = document.getElementById('commonFundInput');
        
        if (display && display.value !== ORIGINAL_VALUE) {
            display.value = ORIGINAL_VALUE;
            showToast('⚠️ Không thể thay đổi giá trị!', 'warning');
        }
        
        if (hidden && hidden.value !== ORIGINAL_RAW) {
            hidden.value = ORIGINAL_RAW;
        }
    }
    
    // Check mỗi giây
    setInterval(protectInput, 1000);
    
    // Check trước khi submit form
    document.getElementById('contractForm').addEventListener('submit', function(e) {
        const display = document.getElementById('commonFundDisplay');
        if (display.value !== ORIGINAL_VALUE) {
            e.preventDefault();
            protectInput();
            showToast('🚨 Phát hiện thay đổi bất thường!', 'error');
            return false;
        }
    });
})();
        </script>
    </body>
</html>