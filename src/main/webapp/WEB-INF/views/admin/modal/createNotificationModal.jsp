<%@ page contentType="text/html; charset=UTF-8" %>
<!-- Create Notification Modal -->
<div class="modal fade" id="createNotificationModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-plus-circle text-primary me-2"></i>Tạo thông báo mới
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/notifications/create" method="POST"
                  id="createNotificationForm">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Người nhận</label>
                            <select class="form-select" name="userId" required>
                                <option value="">-- Chọn người dùng --</option>
                                <option value="ALL">📢 Toàn hệ thống</option> <!-- thêm option broadcast -->
                                <c:forEach var="user" items="${users}">
                                    <option value="${user.id}">${user.fullName} (@${user.username})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Loại thông báo</label>
                            <select class="form-select" name="type" required>
                                <option value="JOB">Công việc</option>
                                <option value="PROPOSAL">Đề xuất</option>
                                <option value="CONTRACT">Hợp đồng</option>
                                <option value="CHAT">Tin nhắn</option>
                                <option value="WALLET">Ví tiền</option>
                                <option value="SYSTEM">Hệ thống</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Ưu tiên</label>
                            <select class="form-select" name="priority">
                                <option value="LOW">Thấp</option>
                                <option value="NORMAL" selected>Bình thường</option>
                                <option value="HIGH">Cao</option>
                                <option value="URGENT">Khẩn cấp</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Ngày hết hạn (tùy chọn)</label>
                            <input type="datetime-local" class="form-control" name="expiresAt">
                        </div>
                        <div class="col-12">
                            <label class="form-label">Tiêu đề</label>
                            <input type="text" class="form-control" name="title" maxlength="200" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Nội dung</label>
                            <textarea class="form-control" name="content" rows="4" maxlength="1000" required></textarea>
                        </div>
                        <div class="col-12">
                            <label class="form-label">URL hành động (tùy chọn)</label>
                            <input type="url" class="form-control" name="actionUrl"
                                   placeholder="https://example.com/action">
                        </div>
                        <div class="col-12">
                            <label class="form-label">Metadata (JSON - tùy chọn)</label>
                            <textarea class="form-control" name="metadata" rows="2"
                                      placeholder='{"key": "value"}'></textarea>
                            <div class="form-text">Dữ liệu bổ sung dạng JSON</div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-send me-1"></i>Gửi thông báo
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>