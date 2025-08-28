<%--
  Created by IntelliJ IDEA.
  User: Thanh Duoc
  Date: 8/20/2025
  Time: 3:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="modal fade" id="depositModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title"><i class="bi bi-wallet2 me-2"></i>Nạp tiền vào ví</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>

            <form action="${pageContext.request.contextPath}/payment/deposit" method="post">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Số tiền</label>

                        <!-- Hidden field để submit giá trị số thô -->
                        <input type="hidden" name="amount" id="amountRaw">

                        <!-- Input hiển thị để người dùng gõ -->
                        <input type="text" id="amountDisplay" class="form-control"
                               placeholder="Nhập số tiền muốn nạp" required>
                        <small class="text-muted">Ví dụ: 100.000 ₫</small>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-success">Xác nhận nạp</button>
                </div>
            </form>

        </div>
    </div>
</div>

<!-- JS format VNĐ -->
<script>
    const display = document.getElementById("amountDisplay");
    const raw = document.getElementById("amountRaw");

    display.addEventListener("input", function (e) {
        let value = e.target.value.replace(/\D/g, ""); // bỏ ký tự không phải số
        raw.value = value; // gán giá trị thô vào hidden input
        if (value) {
            display.value = new Intl.NumberFormat('vi-VN').format(value) + " ₫";
        } else {
            display.value = "";
        }
    });
</script>
