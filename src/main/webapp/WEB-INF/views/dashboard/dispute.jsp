<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>

<html lang="vi">
    <%@include file="include/head.jsp" %>
    <body style="background: linear-gradient(135deg, #fff5f0 0%, #ffffff 100%);">
        <div class="container-fluid">
            <div class="row g-0">
                <!-- Sidebar -->
                <%@include file="include/sidebar.jsp" %>

                <!-- Main Content -->
                <main class="col-12 col-lg-9 col-xl-10 p-4">
                    <!-- Header -->
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h2 class="h3 mb-1 text-dark">
                                <i class="bi bi-shield-exclamation text-warning me-2"></i>Dispute Management
                            </h2>
                            <p class="text-muted mb-0">Resolve project disputes and manage escalations</p>
                        </div>
                        <button class="btn btn-warning text-white">
                            <i class="bi bi-plus-lg me-2"></i>Create New Dispute
                        </button>
                    </div>

                    <div class="row g-4">
                        <!-- Left Sidebar Navigation -->
                        <div class="col-lg-3">
                            <div class="card border-0 shadow-sm">
                                <div class="card-header bg-transparent border-0 p-3">
                                    <h5 class="mb-0 fw-bold">Dispute Center</h5>
                                </div>
                                <div class="list-group list-group-flush">
                                    <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center active">
                                        <div>
                                            <i class="bi bi-exclamation-triangle me-2 text-danger"></i>
                                            <span>Open Disputes</span>
                                        </div>
                                        <span class="badge bg-danger rounded-pill">2</span>
                                    </a>
                                    <a href="#" class="list-group-item list-group-item-action">
                                        <i class="bi bi-hourglass-split me-2 text-warning"></i>
                                        <span>In Mediation</span>
                                        <span class="badge bg-warning rounded-pill ms-auto">1</span>
                                    </a>
                                    <a href="#" class="list-group-item list-group-item-action">
                                        <i class="bi bi-check2-circle me-2 text-success"></i>
                                        <span>Resolved</span>
                                    </a>
                                    <a href="#" class="list-group-item list-group-item-action">
                                        <i class="bi bi-archive me-2 text-muted"></i>
                                        <span>Archived</span>
                                    </a>
                                </div>
                            </div>

                            <!-- Quick Stats -->
                            <div class="card border-0 shadow-sm mt-3">
                                <div class="card-body p-3">
                                    <h6 class="fw-bold mb-3">Your Stats</h6>
                                    <div class="row g-2 text-center">
                                        <div class="col-6">
                                            <div class="p-2 bg-light rounded">
                                                <div class="h6 mb-0 text-primary">3</div>
                                                <small class="text-muted">Total</small>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="p-2 bg-light rounded">
                                                <div class="h6 mb-0 text-success">92%</div>
                                                <small class="text-muted">Win Rate</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Main Dispute Content -->
                        <div class="col-lg-9">
                            <!-- Dispute Header -->
                            <div class="card border-0 shadow-sm mb-4">
                                <div class="card-body p-4">
                                    <div class="d-flex justify-content-between align-items-start mb-3">
                                        <div>
                                            <h4 class="fw-bold mb-2">Milestone Dispute #M-2025-001</h4>
                                            <span class="badge bg-danger px-3 py-2">
                                                <i class="bi bi-exclamation-triangle me-1"></i>Active Dispute
                                            </span>
                                        </div>
                                        <button class="btn btn-outline-secondary btn-sm">
                                            <i class="bi bi-three-dots"></i>
                                        </button>
                                    </div>

                                    <div class="row g-3">
                                        <div class="col-md-3">
                                            <div class="text-center p-3 bg-light rounded">
                                                <div class="h5 text-success mb-0">$1,200</div>
                                                <small class="text-muted">Milestone Value</small>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="text-center p-3 bg-warning bg-opacity-25 rounded">
                                                <div class="h5 text-warning mb-0">Frozen</div>
                                                <small class="text-muted">Escrow Status</small>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="text-center p-3 bg-danger bg-opacity-25 rounded">
                                                <div class="h5 text-danger mb-0">$120</div>
                                                <small class="text-muted">Deposit Locked</small>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="text-center p-3 bg-light rounded">
                                                <div class="h5 text-primary mb-0">3 days</div>
                                                <small class="text-muted">Time Elapsed</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Process Timeline -->
                            <div class="card border-0 shadow-sm mb-4">
                                <div class="card-header bg-transparent border-0 p-4">
                                    <h5 class="mb-0">
                                        <i class="bi bi-clock-history text-warning me-2"></i>Dispute Process
                                    </h5>
                                </div>
                                <div class="card-body p-4">
                                    <div class="row g-3">
                                        <div class="col-md-2 text-center">
                                            <div class="p-3 bg-success text-white rounded-circle d-inline-block mb-2">
                                                <i class="bi bi-check-lg"></i>
                                            </div>
                                            <div class="small fw-bold">Raised</div>
                                            <div class="text-muted small">Completed</div>
                                        </div>
                                        <div class="col-md-2 text-center">
                                            <div class="p-3 bg-warning text-white rounded-circle d-inline-block mb-2">
                                                <i class="bi bi-file-earmark"></i>
                                            </div>
                                            <div class="small fw-bold">Evidence</div>
                                            <div class="text-warning small">Current</div>
                                        </div>
                                        <div class="col-md-2 text-center">
                                            <div class="p-3 bg-light text-muted rounded-circle d-inline-block mb-2">
                                                <i class="bi bi-people"></i>
                                            </div>
                                            <div class="small fw-bold">Mediation</div>
                                            <div class="text-muted small">Pending</div>
                                        </div>
                                        <div class="col-md-2 text-center">
                                            <div class="p-3 bg-light text-muted rounded-circle d-inline-block mb-2">
                                                <i class="bi bi-person-badge"></i>
                                            </div>
                                            <div class="small fw-bold">Admin Review</div>
                                            <div class="text-muted small">Pending</div>
                                        </div>
                                        <div class="col-md-2 text-center">
                                            <div class="p-3 bg-light text-muted rounded-circle d-inline-block mb-2">
                                                <i class="bi bi-check-circle"></i>
                                            </div>
                                            <div class="small fw-bold">Resolution</div>
                                            <div class="text-muted small">Pending</div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Dispute Details -->
                            <div class="card border-0 shadow-sm mb-4">
                                <div class="card-header bg-transparent border-0 p-4">
                                    <h5 class="mb-0">
                                        <i class="bi bi-info-circle text-warning me-2"></i>Dispute Details
                                    </h5>
                                </div>
                                <div class="card-body p-4">
                                    <div class="mb-4">
                                        <h6 class="text-danger mb-2">
                                            <i class="bi bi-exclamation-triangle me-1"></i>Issue: Deliverable Quality Dispute
                                        </h6>
                                    </div>

                                    <div class="row g-4">
                                        <div class="col-md-6">
                                            <div class="border border-primary border-opacity-25 rounded p-3 bg-primary bg-opacity-10">
                                                <h6 class="text-primary mb-2">
                                                    <i class="bi bi-briefcase me-1"></i>Employer's Claim
                                                </h6>
                                                <p class="mb-0 small">"Sản phẩm không đạt yêu cầu UI/UX như đã mô tả trong scope. Layout không responsive và thiếu nhiều tính năng đã yêu cầu."</p>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="border border-success border-opacity-25 rounded p-3 bg-success bg-opacity-10">
                                                <h6 class="text-success mb-2">
                                                    <i class="bi bi-person-check me-1"></i>Freelancer's Response
                                                </h6>
                                                <p class="mb-0 small">"Đã nộp đầy đủ source code + prototype đúng deadline. Tất cả requirements đã được implement theo specs ban đầu."</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row g-4">
                                <!-- Evidence Section -->
                                <div class="col-md-6">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-header bg-transparent border-0 p-4">
                                            <h5 class="mb-0">
                                                <i class="bi bi-file-earmark-arrow-up text-warning me-2"></i>Submit Evidence
                                            </h5>
                                        </div>
                                        <div class="card-body p-4">
                                            <form>
                                                <div class="mb-3">
                                                    <label class="form-label fw-medium">Upload Supporting Files</label>
                                                    <div class="border border-2 border-dashed border-secondary rounded p-4 text-center">
                                                        <i class="bi bi-cloud-upload fs-1 text-muted mb-2"></i>
                                                        <div class="text-muted">
                                                            <input type="file" class="form-control" multiple>
                                                        </div>
                                                        <small class="text-muted">Screenshots, documents, code files</small>
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label fw-medium">Evidence Description</label>
                                                    <textarea class="form-control" rows="4" placeholder="Describe your evidence and how it supports your case..."></textarea>
                                                </div>
                                                <button type="submit" class="btn btn-warning text-white w-100">
                                                    <i class="bi bi-upload me-2"></i>Submit Evidence
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                                <!-- Communication -->
                                <div class="col-md-6">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-header bg-transparent border-0 p-4">
                                            <h5 class="mb-0">
                                                <i class="bi bi-chat-dots text-warning me-2"></i>Mediation Chat
                                            </h5>
                                        </div>
                                        <div class="card-body p-0">
                                            <div class="p-3" style="max-height: 300px; overflow-y: auto;">
                                                <!-- Message 1 -->
                                                <div class="d-flex align-items-start mb-3">
                                                    <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 32px; height: 32px; font-size: 0.8rem;">
                                                        E
                                                    </div>
                                                    <div class="flex-grow-1">
                                                        <div class="bg-light rounded p-3">
                                                            <small class="text-primary fw-bold">Employer</small>
                                                            <p class="mb-0 small">Tôi muốn hoàn tiền 50% vì sản phẩm không như mô tả trong requirements.</p>
                                                        </div>
                                                        <small class="text-muted">2 hours ago</small>
                                                    </div>
                                                </div>

                                                <!-- Message 2 -->
                                                <div class="d-flex align-items-start mb-3 flex-row-reverse">
                                                    <div class="bg-success text-white rounded-circle d-flex align-items-center justify-content-center ms-2" style="width: 32px; height: 32px; font-size: 0.8rem;">
                                                        F
                                                    </div>
                                                    <div class="flex-grow-1 text-end">
                                                        <div class="bg-success bg-opacity-25 rounded p-3">
                                                            <small class="text-success fw-bold">Freelancer</small>
                                                            <p class="mb-0 small text-start">Tôi đã giao đúng scope, có thể thương lượng giảm 20% để kết thúc tranh chấp.</p>
                                                        </div>
                                                        <small class="text-muted">1 hour ago</small>
                                                    </div>
                                                </div>

                                                <!-- Mediator Message -->
                                                <div class="text-center mb-3">
                                                    <div class="d-inline-block bg-warning bg-opacity-25 rounded p-3">
                                                        <small class="text-warning fw-bold">
                                                            <i class="bi bi-person-badge me-1"></i>Mediator
                                                        </small>
                                                        <p class="mb-0 small">Tôi đang xem xét bằng chứng từ cả hai bên. Vui lòng cung cấp thêm tài liệu.</p>
                                                    </div>
                                                    <div><small class="text-muted">30 minutes ago</small></div>
                                                </div>
                                            </div>

                                            <div class="border-top p-3">
                                                <div class="input-group">
                                                    <input type="text" class="form-control" placeholder="Type your message...">
                                                    <button class="btn btn-warning text-white">
                                                        <i class="bi bi-send"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="d-flex justify-content-between align-items-center mt-4">
                                <div class="d-flex gap-2">
                                    <button class="btn btn-outline-warning">
                                        <i class="bi bi-download me-1"></i>Download Report
                                    </button>
                                    <button class="btn btn-outline-secondary">
                                        <i class="bi bi-printer me-1"></i>Print Details
                                    </button>
                                </div>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-success">
                                        <i class="bi bi-handshake me-1"></i>Accept Settlement
                                    </button>
                                    <button class="btn btn-danger">
                                        <i class="bi bi-flag me-1"></i>Escalate to Admin
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Auto-scroll chat to bottom
            document.addEventListener('DOMContentLoaded', function () {
                const chatContainer = document.querySelector('[style*="max-height: 300px"]');
                if (chatContainer) {
                    chatContainer.scrollTop = chatContainer.scrollHeight;
                }

                // Send message functionality
                const sendBtn = document.querySelector('.input-group .btn-warning');
                const messageInput = document.querySelector('.input-group input');

                if (sendBtn && messageInput) {
                    sendBtn.addEventListener('click', function () {
                        const message = messageInput.value.trim();
                        if (message) {
                            // Add message to chat (demo)
                            const chatArea = chatContainer;
                            const messageHTML = `
                                <div class="d-flex align-items-start mb-3 flex-row-reverse">
                                    <div class="bg-info text-white rounded-circle d-flex align-items-center justify-content-center ms-2" style="width: 32px; height: 32px; font-size: 0.8rem;">
                                        Y
                                    </div>
                                    <div class="flex-grow-1 text-end">
                                        <div class="bg-info bg-opacity-25 rounded p-3">
                                            <small class="text-info fw-bold">You</small>
                                            <p class="mb-0 small text-start">${message}</p>
                                        </div>
                                        <small class="text-muted">Just now</small>
                                    </div>
                                </div>
                            `;
                            chatArea.insertAdjacentHTML('beforeend', messageHTML);
                            messageInput.value = '';
                            chatArea.scrollTop = chatArea.scrollHeight;
                        }
                    });

                    messageInput.addEventListener('keypress', function (e) {
                        if (e.key === 'Enter') {
                            sendBtn.click();
                        }
                    });
                }
            });
        </script>
    </body>
</html>