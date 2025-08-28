<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="vi">
    <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title>Xác minh mã – FJCON</title>
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
        <style>
            :root{
                --text:#1f2937;
                --muted:#6b7280;
                --card:#ffffff;
                --brand:#FF7300;
                --brand-600:#e76700;
                --ring:#f3f4f6;
                --radius:16px;
            }
            *{
                box-sizing:border-box
            }
            body{
                margin:0;
                font-family:Inter,system-ui,-apple-system,Segoe UI,Roboto,Arial,sans-serif;
                color:var(--text);
                background:linear-gradient(135deg,#f8fafc,#eef2ff);
                min-height:100svh;
                display:grid;
                place-items:center;
                padding:24px;
            }
            .wrap{
                width:min(720px,100%);
            }
            .card{
                background:var(--card);
                border-radius:var(--radius);
                box-shadow:0 20px 40px rgba(2,6,23,.08), 0 4px 10px rgba(2,6,23,.04);
                overflow:hidden;
                padding:24px 24px 20px;
            }
            .brand{
                display:flex;
                align-items:center;
                gap:12px;
                margin-bottom:4px;
            }
            .brand img{
                height:36px
            }
            .title{
                margin:0;
                font-size:20px;
                color:#111827
            }
            .subtitle{
                color:var(--muted);
                margin:6px 0 18px;
                font-weight:500
            }
            .row{
                display:grid;
                gap:14px
            }
            label{
                font-size:14px;
                color:#374151;
                display:block;
                margin:0 0 6px
            }
            input[type="text"]{
                width:100%;
                border:1px solid #e5e7eb;
                border-radius:12px;
                padding:12px 14px;
                outline:none;
                transition:box-shadow .15s,border-color .15s;
                background:#fff;
                font-size:16px;
            }
            input:focus{
                border-color:#c7d2fe;
                box-shadow:0 0 0 4px #e0e7ff
            }
            .btn{
                display:inline-flex;
                justify-content:center;
                align-items:center;
                gap:8px;
                border:none;
                border-radius:12px;
                padding:12px 16px;
                background:var(--brand);
                color:#fff;
                font-weight:600;
                cursor:pointer;
                transition:transform .05s ease, background .15s;
            }
            .btn:active{
                transform:translateY(1px)
            }
            .btn:hover{
                background:var(--brand-600)
            }
            .btn-outline{
                background:#fff;
                color:#111827;
                border:1px solid #e5e7eb;
            }
            .center{
                text-align:center
            }
            #countdown-timer{
                font-weight:600;
                color:#374151;
                margin-top:8px
            }
            .hint{
                color:#6b7280;
                font-size:13px
            }
            .actions{
                display:flex;
                gap:10px;
                flex-wrap:wrap
            }
            .actions .btn{
                flex:1
            }
        </style>

        <!-- SweetAlert for message popup -->
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    </head>
    <body>

        <div class="wrap">
            <section class="card">
                <div class="brand">
                    <img src="<c:url value='/assets/img/logo-center.png'/>" alt="Logo FJCON"/>
                    <h1 class="title">Xác minh email của bạn</h1>
                </div>
                <p class="subtitle">Chúng tôi đã gửi mã gồm 6 chữ số đến email của bạn. Vui lòng nhập mã bên dưới.</p>

                <!-- Form xác nhận mã -->
                <form action="${pageContext.request.contextPath}/signup" method="post" class="row" id="verify-form">
                    <c:if test="${not empty _csrf}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </c:if>

                    <div>
                        <label for="code">Mã xác minh</label>
                        <input id="code" name="code" type="text" inputmode="numeric" autocomplete="one-time-code"
                               placeholder="Nhập mã 6 chữ số" required maxlength="6"
                               pattern="[0-9]{6}" title="Vui lòng nhập 6 chữ số (0–9)">
                        <div class="hint">Ví dụ: 123456</div>
                    </div>

                    <!-- Hidden fields (lấy từ session do bước trước đã set) -->
                    <input type="hidden" name="coderes"        value="${sessionScope.signup_verificationCode}">
                    <input type="hidden" name="email"          value="${sessionScope.signup_email}">
                    <input type="hidden" name="password"       value="${sessionScope.signup_password}">
                    <input type="hidden" name="confirmPassword"value="${sessionScope.signup_password}">
                    <input type="hidden" name="userRole"       value="${sessionScope.signup_role}">
                    <input type="hidden" name="username"       value="${sessionScope.signup_username}">
                    <input type="hidden" name="firstName"      value="${sessionScope.signup_firstName}">
                    <input type="hidden" name="lastName"       value="${sessionScope.signup_lastName}">
                    <input type="hidden" name="fullName"       value="${sessionScope.signup_fullName}">

                    <div class="actions">
                        <button type="submit" class="btn"><i class="bi bi-check-circle-fill"></i> Xác nhận</button>
                        <button type="button" class="btn btn-outline" id="back-btn"
                                onclick="window.location.href = '${pageContext.request.contextPath}/signup'">
                            Quay lại
                        </button>
                    </div>

                    <div class="center">
                        <div id="countdown-timer">Gửi lại mã sau <span id="timer">02:00</span></div>
                    </div>
                </form>

                <!-- Form resend code -->
                <form id="resend-form" action="<c:url value='/resendcode'/>" method="post" class="row center" style="margin-top:10px">
                    <c:if test="${not empty _csrf}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </c:if>
                    <input type="hidden" name="username"        value="${sessionScope.signup_username}">
                    <input type="hidden" name="firstName"       value="${sessionScope.signup_firstName}">
                    <input type="hidden" name="lastName"        value="${sessionScope.signup_lastName}">
                    <input type="hidden" name="email"           value="${sessionScope.signup_email}">
                    <input type="hidden" name="password"        value="${sessionScope.signup_password}">
                    <input type="hidden" name="confirmPassword" value="${sessionScope.signup_password}">
                    <button type="submit" id="resend-code-btn" class="btn" style="display:none;">Gửi lại mã</button>
                    <div class="hint" style="margin-top:6px">Chưa nhận được email? Hãy kiểm tra thư mục Spam.</div>
                </form>

            </section>
        </div>

        <!-- ===== JS: giữ logic thông báo + countdown + xử lý codeError ===== -->
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                /* ---- SweetAlert message (from session) ---- */
                var msg = "${sessionScope.message}";
                var type = "${sessionScope.messageType}";
                if (msg && msg.trim() !== "") {
                    var icon = (type === "error") ? "error" : (type === "info" ? "info" : "success");
                    swal({title: icon === "error" ? "Lỗi" : "Thông báo", text: msg, icon: icon, button: "Đồng ý"});
                }
            });
        </script>
        <c:if test="${not empty sessionScope.message}">
            <c:remove var="message" scope="session"/>
            <c:remove var="messageType" scope="session"/>
        </c:if>

        <script>window.SIGNUP_FLOW_ID = '${sessionScope.signup_flow_id}';</script>

        <script>
            (function () {
                var DURATION = 120; // 2 phút
                var FLOW = (window.SIGNUP_FLOW_ID || "no-flow");    // flowId do server set vào session khi bắt đầu flow
                var KEY_PREFIX = "verifyCountdownEndAt:";           // key theo flow để không dính countdown cũ
                var KEY = KEY_PREFIX + FLOW;

                var timerEl = document.getElementById('timer');
                var blockEl = document.getElementById('countdown-timer');
                var resendBtn = document.getElementById('resend-code-btn');
                var resendForm = document.getElementById('resend-form');
                var verifyForm = document.getElementById('verify-form');
                var codeInput = document.getElementById('code');

                var intervalId = null;
                var isExpired = false;

                function fmt(sec) {
                    var m = Math.floor(sec / 60), s = sec % 60;
                    return (m < 10 ? "0" + m : m) + ":" + (s < 10 ? "0" + s : s);
                }
                function render(sec) {
                    if (timerEl)
                        timerEl.textContent = fmt(Math.max(0, sec));
                }
                function stop() {
                    if (intervalId) {
                        clearInterval(intervalId);
                        intervalId = null;
                    }
                }

                function ensureExpiredNote() {
                    var id = "code-expired-note";
                    var ex = document.getElementById(id);
                    if (ex)
                        return ex;
                    var div = document.createElement('div');
                    div.id = id;
                    div.textContent = "Mã xác minh đã hết hạn. Vui lòng nhấn \"Gửi lại mã\" để nhận mã mới.";
                    div.style.color = "#dc2626";
                    div.style.fontSize = "13px";
                    div.style.marginTop = "6px";
                    if (codeInput && codeInput.parentElement)
                        codeInput.parentElement.appendChild(div);
                    return div;
                }
                function removeExpiredNote() {
                    var ex = document.getElementById("code-expired-note");
                    if (ex && ex.parentElement)
                        ex.parentElement.removeChild(ex);
                }

                function setRunningUI() {
                    if (blockEl)
                        blockEl.style.display = 'block';
                    if (resendBtn)
                        resendBtn.style.display = 'none';
                    isExpired = false;
                    if (codeInput) {
                        codeInput.disabled = false;
                        codeInput.readOnly = false;
                        codeInput.placeholder = "Nhập mã 6 chữ số";
                        codeInput.title = "";
                    }
                    removeExpiredNote();
                }
                function setFinishedUI() {
                    if (blockEl)
                        blockEl.style.display = 'none';
                    if (resendBtn)
                        resendBtn.style.display = 'inline-flex';
                    isExpired = true;
                    if (codeInput) {
                        codeInput.value = "";
                        codeInput.disabled = true;
                        codeInput.readOnly = true;
                        codeInput.placeholder = "Mã đã hết hạn. Nhấn \"Gửi lại mã\"";
                        codeInput.title = "Mã đã hết hạn. Nhấn \"Gửi lại mã\" để lấy mã mới.";
                    }
                    ensureExpiredNote();
                }

                function runUntil(endAtMs) {
                    stop();
                    setRunningUI();
                    function tick() {
                        var remain = Math.ceil((endAtMs - Date.now()) / 1000);
                        if (remain <= 0) {
                            stop();
                            sessionStorage.removeItem(KEY);
                            render(0);
                            setFinishedUI();
                            return;
                        }
                        render(remain);
                    }
                    tick();
                    intervalId = setInterval(tick, 1000);
                }

                // --- Boot theo flow: flowId mới => key mới => countdown mới 2 phút ---
                (function boot() {
                    if (!FLOW || FLOW === "no-flow") {
                        setFinishedUI();
                        render(0);
                        return;
                    }
                    var endStr = sessionStorage.getItem(KEY);
                    if (!endStr) {
                        var endAt = Date.now() + DURATION * 1000;
                        sessionStorage.setItem(KEY, String(endAt));
                        runUntil(endAt);
                    } else {
                        var endAt = parseInt(endStr, 10);
                        if (isNaN(endAt) || endAt <= Date.now()) {
                            sessionStorage.removeItem(KEY);
                            render(0);
                            setFinishedUI();
                        } else {
                            runUntil(endAt);
                        }
                    }
                })();

                // --- Resend: reset 2 phút cho flow hiện tại (UI lạc quan), server sẽ gửi mail ---
                if (resendForm) {
                    resendForm.addEventListener('submit', function () {
                        if (!FLOW || FLOW === "no-flow")
                            return;
                        var newEnd = Date.now() + DURATION * 1000;
                        sessionStorage.setItem(KEY, String(newEnd));
                        runUntil(newEnd);
                        if (resendBtn) {
                            resendBtn.disabled = true;
                            setTimeout(function () {
                                if (resendBtn)
                                    resendBtn.disabled = false;
                            }, 3000);
                        }
                    });
                }

                // --- Chặn submit khi code hết hạn + validate 6 digits ---
                if (verifyForm) {
                    verifyForm.addEventListener('submit', function (e) {
                        if (isExpired) {
                            e.preventDefault();
                            swal({
                                title: "Mã đã hết hạn",
                                text: "Mã xác minh đã hết hạn. Vui lòng nhấn \"Gửi lại mã\" để nhận mã mới.",
                                icon: "error",
                                button: "Đồng ý"
                            });
                            return;
                        }
                        var v = (codeInput ? (codeInput.value || "").trim() : "");
                        if (!/^\d{6}$/.test(v)) {
                            e.preventDefault();
                            swal({title: "Mã không hợp lệ", text: "Vui lòng nhập chuỗi 6 chữ số.", icon: "error", button: "Đồng ý"});
                        }
                    });
                }
            })();
        </script>
    </body>
</html>
