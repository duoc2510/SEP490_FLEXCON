<%-- withdraw.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="modal fade" id="withdrawModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title"><i class="bi bi-cash-coin me-2"></i>Rút tiền từ ví</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form:form modelAttribute="withdrawForm"
                       action="${pageContext.request.contextPath}/dashboard/wallet/withdraw"
                       method="post" enctype="multipart/form-data" id="withdrawForm">

                <div class="modal-body">
                    <!-- Thông tin số dư -->
                    <div class="card bg-primary text-white mb-3">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <h6 class="card-subtitle mb-1">Số dư hiện tại</h6>
                                    <h4 class="card-title mb-0" id="currentBalance">
                                        <fmt:formatNumber value="${wallet.balanceAvailable}" type="number"
                                                          groupingUsed="true"/> ₫
                                    </h4>
                                </div>
                                <div class="col-md-6 text-md-end">
                                    <h6 class="card-subtitle mb-1">Số dư sau khi rút</h6>
                                    <h4 class="card-title mb-0" id="newBalance">
                                        <fmt:formatNumber value="${wallet.balanceAvailable}" type="number"
                                                          groupingUsed="true"/> ₫
                                    </h4>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Số tiền rút -->
                    <div class="row mb-3">
                        <div class="col-md-8">
                            <label class="form-label">Số tiền rút <span class="text-danger">*</span></label>
                            <form:input path="amount" id="withdrawAmountRaw" type="hidden"/>
                            <input type="text" id="withdrawAmountDisplay" class="form-control"
                                   placeholder="Nhập số tiền muốn rút (tối thiểu 100.000 ₫)" required>
                            <div class="invalid-feedback" id="amountError"></div>
                            <small class="text-muted">Tối thiểu: 100.000 ₫</small>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Chọn nhanh</label>
                            <div class="d-grid gap-1">
                                <button type="button" class="btn btn-outline-primary btn-sm"
                                        onclick="setAmount(500000)">500.000 ₫
                                </button>
                                <button type="button" class="btn btn-outline-primary btn-sm"
                                        onclick="setAmount(1000000)">1.000.000 ₫
                                </button>
                                <button type="button" class="btn btn-outline-success btn-sm" onclick="setMaxAmount()">
                                    <i class="bi bi-wallet2 me-1"></i>Rút tất cả
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Phương thức rút tiền -->
                    <div class="mb-3">
                        <label class="form-label">Phương thức rút tiền <span class="text-danger">*</span></label>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-check">
                                    <form:radiobutton path="method" id="bankMethod" value="BANK" checked="true"
                                                      onchange="toggleMethod()" cssClass="form-check-input"/>
                                    <label class="form-check-label" for="bankMethod">
                                        <i class="bi bi-bank me-2"></i>Thông tin ngân hàng
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-check">
                                    <form:radiobutton path="method" id="qrMethod" value="QR" onchange="toggleMethod()"
                                                      cssClass="form-check-input"/>
                                    <label class="form-check-label" for="qrMethod">
                                        <i class="bi bi-qr-code me-2"></i>Upload QR Code
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Form thông tin ngân hàng -->
                    <div id="bankInfo" class="border rounded p-3 mb-3">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="bankName" class="form-label">Ngân hàng <span
                                        class="text-danger">*</span></label>
                                <form:select path="bankName" cssClass="form-select" id="bankName">
                                    <form:option value="" label="Chọn ngân hàng"/>
                                    <form:option value="vietcombank" label="Vietcombank"/>
                                    <form:option value="techcombank" label="Techcombank"/>
                                    <form:option value="bidv" label="BIDV"/>
                                    <form:option value="vietinbank" label="VietinBank"/>
                                    <form:option value="acb" label="ACB"/>
                                    <form:option value="mb" label="MB Bank"/>
                                    <form:option value="other" label="Khác"/>
                                </form:select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="accountNumber" class="form-label">Số tài khoản <span
                                        class="text-danger">*</span></label>
                                <form:input path="accountNumber" cssClass="form-control" id="accountNumber"
                                            placeholder="Nhập số tài khoản"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="accountName" class="form-label">Tên chủ tài khoản <span class="text-danger">*</span></label>
                                <form:input path="accountName" cssClass="form-control" id="accountName"
                                            placeholder="Nhập tên chủ tài khoản"/>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="branchName" class="form-label">Chi nhánh</label>
                                <form:input path="branchName" cssClass="form-control" id="branchName"
                                            placeholder="Nhập tên chi nhánh (tùy chọn)"/>
                            </div>
                        </div>
                    </div>

                    <!-- Form upload QR -->
                    <div id="qrInfo" class="border rounded p-3 mb-3" style="display: none;">
                        <label for="qrFile" class="form-label">Upload QR Code <span class="text-danger">*</span></label>
                        <form:input path="qrFile" type="file" cssClass="form-control" id="qrFile" accept="image/*"
                                    onchange="previewQR(event)"/>
                        <small class="text-muted">Hỗ trợ: JPG, PNG, GIF (tối đa 5MB)</small>

                        <div id="qrPreview" class="mt-3 text-center" style="display: none;">
                            <img id="qrImage" class="img-thumbnail" style="max-width: 200px; max-height: 200px;"
                                 alt="QR Preview">
                            <div class="mt-2">
                                <button type="button" class="btn btn-sm btn-outline-danger" onclick="removeQR()">
                                    <i class="bi bi-trash me-1"></i>Xóa ảnh
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Ghi chú -->
                    <div class="mb-3">
                        <label for="note" class="form-label">Ghi chú</label>
                        <form:textarea path="note" cssClass="form-control" id="note" rows="2"
                                       placeholder="Nhập ghi chú cho giao dịch này (tùy chọn)"/>
                    </div>

                    <div class="alert alert-info">
                        <i class="bi bi-info-circle me-2"></i>
                        <strong>Lưu ý:</strong> Giao dịch rút tiền sẽ được xử lý trong 1-3 ngày làm việc.
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary" id="submitBtn">
                        <i class="bi bi-check-circle me-2"></i>Xác nhận rút tiền
                    </button>
                </div>
            </form:form>

        </div>
    </div>
</div>

<!-- Script xử lý -->
<script>
    const withdrawDisplay = document.getElementById("withdrawAmountDisplay");
    const withdrawRaw = document.getElementById("withdrawAmountRaw");
    const currentBalanceAmount = ${wallet.balanceAvailable}; // từ backend
    const submitBtn = document.getElementById("submitBtn");

    withdrawDisplay.addEventListener("input", function (e) {
        let value = e.target.value.replace(/\D/g, "");
        withdrawRaw.value = value;
        if (value) {
            withdrawDisplay.value = new Intl.NumberFormat('vi-VN').format(value);
            updateNewBalance();
            validateAmount();
        } else {
            withdrawDisplay.value = "";
            updateNewBalance();
            validateAmount();
        }
    });

    function updateNewBalance() {
        const withdrawAmount = parseInt(withdrawRaw.value) || 0;
        const newBalance = currentBalanceAmount - withdrawAmount;
        document.getElementById('newBalance').textContent =
            new Intl.NumberFormat('vi-VN').format(Math.max(0, newBalance));
    }

    function validateAmount() {
        const amount = parseInt(withdrawRaw.value) || 0;
        const errorDiv = document.getElementById('amountError');
        withdrawDisplay.classList.remove('is-invalid', 'is-valid');

        if (currentBalanceAmount < 100000) {
            withdrawDisplay.classList.add('is-invalid');
            errorDiv.textContent = 'Số dư hiện tại phải tối thiểu 100.000 ₫ mới rút được.';
            submitBtn.disabled = true;
            return false;
        }
        if (amount < 100000) {
            withdrawDisplay.classList.add('is-invalid');
            errorDiv.textContent = 'Số tiền rút tối thiểu là 100.000 ₫';
            submitBtn.disabled = true;
            return false;
        } else if (amount > currentBalanceAmount) {
            withdrawDisplay.classList.add('is-invalid');
            errorDiv.textContent = 'Số tiền rút không được vượt quá số dư hiện tại';
            submitBtn.disabled = true;
            return false;
        } else {
            withdrawDisplay.classList.add('is-valid');
            errorDiv.textContent = '';
            submitBtn.disabled = false;
            return true;
        }
    }

    function setAmount(amount) {
        withdrawRaw.value = amount;
        withdrawDisplay.value = new Intl.NumberFormat('vi-VN').format(amount);
        updateNewBalance();
        validateAmount();
    }

    function setMaxAmount() {
        setAmount(currentBalanceAmount);
    }

    function toggleMethod() {
        const bankMethod = document.getElementById('bankMethod').checked;
        const bankInfo = document.getElementById('bankInfo');
        const qrInfo = document.getElementById('qrInfo');

        if (bankMethod) {
            bankInfo.style.display = 'block';
            qrInfo.style.display = 'none';
            // bắt buộc bank
            document.getElementById('bankName').required = true;
            document.getElementById('accountNumber').required = true;
            document.getElementById('accountName').required = true;
            // bỏ required file + clear file input
            const qrFile = document.getElementById('qrFile');
            if (qrFile) {
                qrFile.required = false;
                qrFile.value = '';
            }
        } else {
            bankInfo.style.display = 'none';
            qrInfo.style.display = 'block';
            // bỏ required bank
            document.getElementById('bankName').required = false;
            document.getElementById('accountNumber').required = false;
            document.getElementById('accountName').required = false;
            // bắt buộc file
            document.getElementById('qrFile').required = true;
        }
    }


    function previewQR(event) {
        const file = event.target.files[0];
        if (file) {
            if (file.size > 5 * 1024 * 1024) {
                alert('File quá lớn. Vui lòng chọn file nhỏ hơn 5MB.');
                event.target.value = '';
                return;
            }
            const reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById('qrImage').src = e.target.result;
                document.getElementById('qrPreview').style.display = 'block';
            };
            reader.readAsDataURL(file);
        }
    }

    function removeQR() {
        document.getElementById('qrFile').value = '';
        document.getElementById('qrPreview').style.display = 'none';
    }

    document.getElementById('withdrawForm').addEventListener('submit', function (e) {
        if (!validateAmount()) {
            e.preventDefault();
            return false;
        }
    });

    // Initialize
    updateNewBalance();
    validateAmount();
</script>
