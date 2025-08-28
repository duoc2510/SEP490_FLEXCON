<%-- 
    Document   : signup
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Đăng ký – FJCON (Lite)</title>

        <!-- Bootstrap Icons chỉ để hiển thị biểu tượng Google -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet"/>
        <style>
            :root{
                --bg:#0A0F26;
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
                background-color:#fd7e14;
                min-height:100svh;
                display:grid;
                place-items:center;
                padding:24px;
            }
            .wrap{
                width:min(1100px,100%);
                display:grid;
                gap:28px;
                grid-template-columns: 1.1fr 0.9fr;
            }
            .card{
                background:var(--card);
                border-radius:var(--radius);
                box-shadow:0 20px 40px rgba(2,6,23,.08), 0 4px 10px rgba(2,6,23,.04);
                overflow:hidden;
                display:flex;
                flex-direction:column;
                padding:28px;
            }
            .brand{
                display:flex;
                align-items:center;
                gap:12px;
                margin-bottom:12px;
            }
            .brand img{
                height:40px
            }
            .subtitle{
                color:var(--muted);
                margin:0 0 20px;
                font-weight:500
            }
            form{
                display:grid;
                grid-template-columns:1fr 1fr;
                gap:16px
            }
            .full{
                grid-column:1/-1
            }
            label{
                font-size:14px;
                color:#374151;
                display:block;
                margin:0 0 6px
            }
            input[type="text"],input[type="email"],input[type="password"]{
                width:100%;
                border:1px solid #e5e7eb;
                border-radius:12px;
                padding:12px 14px;
                outline:none;
                transition:box-shadow .15s,border-color .15s;
                background:#fff;
            }
            input:focus{
                border-color:#c7d2fe;
                box-shadow:0 0 0 4px #e0e7ff
            }
            .password-wrap{
                position:relative
            }
            .toggle{
                position:absolute;
                right:10px;
                top:50%;
                transform:translateY(-50%);
                border:none;
                background:#f3f4f6;
                border-radius:8px;
                padding:6px 8px;
                cursor:pointer;
                font-size:12px;
                color:#374151;
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
            .foot{
                margin-top:10px;
                font-size:14px;
                color:#4b5563;
            }
            .foot a{
                color:var(--brand);
                text-decoration:none
            }

            /* ---------- TV FRAME (nền trắng) ---------- */
            .panel{
                border-radius:var(--radius);
            }
            .panel.panel--tv{
                background:transparent;
                padding:0 8px;                 /* khoảng cách với bo góc cột phải */
                display:flex;
                flex-direction:column;
                align-items:center;
                justify-content:center;
            }
            .panel.panel--tv .tv{
                width:100%;
                max-width:720px;
                margin:0 auto;
            }
            .tv-frame{
                position:relative;
                aspect-ratio:16/9;
                background:#fff;
                border-radius:22px;
                overflow:hidden;
                box-shadow:
                    0 18px 40px rgba(2,6,23,.12), /* bóng ngoài mềm */
                    inset 0 0 0 8px #fff,          /* viền trắng (bezel sáng) */
                    inset 0 0 0 1px #e5e7eb;       /* đường viền mỏng xám nhạt */
            }
            .tv-frame::after{
                content:"";
                position:absolute;
                inset:0;
                border-radius:inherit;
                box-shadow: inset 0 0 0 2px rgba(17,24,39,.04);
                pointer-events:none;
            }
            .panel--tv .tv-frame img{
                width:100%;
                height:100%;
                display:block;
                object-fit:contain;            /* không cắt chữ */
                object-position:center;        /* canh giữa */
                background:#fff;               /* tránh viền khác màu khi letterbox */
            }
            .tv-neck{
                width: 90px;
                height: 10px;
                background:#e5e7eb;
                border-radius:6px;
                margin:10px auto 0;
                box-shadow:0 2px 6px rgba(0,0,0,.12);
            }
            .tv-base{
                width:260px;
                height:16px;
                margin:8px auto 0;
                border-radius:16px;
                background:linear-gradient(180deg,#f3f4f6,#cbd5e1);
                box-shadow:0 10px 28px rgba(0,0,0,.15);
            }
            .tv-shadow{
                width:52%;
                height:12px;
                margin:6px auto 0;
                border-radius:999px;
                background:radial-gradient(ellipse at center, rgba(0,0,0,.12), rgba(0,0,0,0));
            }
            .panel.panel--tv .badge{
                position:absolute;
                left:16px;
                bottom:16px;
                background:rgba(255,255,255,.92);
                color:#111827;
                padding:10px 14px;
                border-radius:999px;
                font-size:14px;
                font-weight:600;
                box-shadow:0 6px 16px rgba(0,0,0,.15);
            }

            /* === Slideshow trong TV === */
            .tv-slides{
                position:absolute;
                inset:0;
            }
            .tv-slides img{
                position:absolute;
                inset:0;
                width:100%;
                height:100%;
                object-fit:contain;            /* không cắt chữ; muốn fill khung: đổi sang cover */
                object-position:center;
                background:#fff;               /* đồng nền với TV */
                opacity:0;
                transition:opacity .6s ease;
                display:block;
            }
            .tv-slides img.active{
                opacity:1;
            }

            /* ---- Validation styles ---- */
            /* Chỉ đỏ khi JS đã gắn .invalid hoặc sau khi form bị submit lỗi */
            input.invalid,
            form.was-validated input:invalid{
                border-color:#fca5a5;
                box-shadow:0 0 0 4px #fee2e2;
            }
            input.valid{
                border-color:#86efac;
                box-shadow:0 0 0 4px #dcfce7;
            }

            .small-hint{
                color:#6b7280;
                font-size:12px;
                margin-top:6px
            }
            .err-msg{
                color:#dc2626;
                font-size:12px;
                margin-top:6px;
                display:none
            }
            .err-msg.show{
                display:block
            }

            @media (max-width:900px){
                .wrap{
                    grid-template-columns:1fr
                }
                .panel.panel--tv .tv{
                    max-width:100%;
                }
            }
        </style>

        <!-- SweetAlert for message popup -->
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                /* ---- SweetAlert message (from session) ---- */
                var msg = "${sessionScope.message}";
                var type = "${sessionScope.messageType}";
                if (msg && msg.trim() !== "") {
                    var icon = (type === "error") ? "error" : (type === "info" ? "info" : "success");
                    swal({
                        title: icon === "error" ? "Lỗi" : "Thông báo",
                        text: msg,
                        icon: icon,
                        button: "Đồng ý"
                    });
                }
            });
        </script>
        <c:if test="${not empty sessionScope.message}">
            <c:remove var="message" scope="session"/>
            <c:remove var="messageType" scope="session"/>
        </c:if>
    </head>
    <body>
        <main class="wrap">
            <!-- Trái: Form -->
            <section class="card">
                <div class="brand">
                    <img src="<c:url value='/assets/img/logo-center.png'/>" alt="Logo FJCON" />
                    <h1 style="font-size:20px;margin:0;color:#111827">Tạo tài khoản của bạn</h1>
                </div>
                <p class="subtitle">Rất vui được chào mừng bạn đến với cộng đồng của chúng tôi.</p>

                <!-- Form Đăng ký cho thực thể User -->
                <form id="userregistration-form"
                      action="<c:url value='/verifycodesignup'/>"
                      method="post"
                      autocomplete="on"
                      novalidate>

                    <%-- Spring Security CSRF (nếu có) --%>
                    <c:if test="${not empty _csrf}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </c:if>

                    <!-- Username -->
                    <div class="full">
                        <label for="username">Tên người dùng *</label>
                        <input id="username"
                               name="username"
                               type="text"
                               required
                               minlength="3"
                               maxlength="100"
                               placeholder="Chọn tên người dùng">
                    </div>

                    <!-- Họ & Tên -->
                    <div>
                        <label for="firstname">Tên *</label>
                        <input id="firstname"
                               name="firstName"
                               type="text"
                               required
                               placeholder="Nhập tên">
                    </div>
                    <div>
                        <label for="lastname">Họ *</label>
                        <input id="lastname"
                               name="lastName"
                               type="text"
                               required
                               placeholder="Nhập họ">
                    </div>

                    <!-- Email -->
                    <div class="full">
                        <label for="user_email">Email *</label>
                        <input id="user_email"
                               name="email"
                               type="email"
                               required
                               maxlength="150"
                               placeholder="Địa chỉ email của bạn">
                    </div>

                    <!-- Mật khẩu -->
                    <div class="full password-wrap">
                        <label for="user_password">Mật khẩu *</label>
                        <input id="user_password"
                               name="password"
                               type="password"
                               required
                               minlength="8"
                               placeholder="Nhập mật khẩu">
                        <button class="toggle" type="button"
                                aria-controls="user_password"
                                aria-label="Bật/tắt hiển thị mật khẩu">Hiện</button>
                    </div>

                    <!-- Xác nhận mật khẩu -->
                    <div class="full password-wrap">
                        <label for="user_password_confirm">Xác nhận mật khẩu *</label>
                        <input id="user_password_confirm"
                               name="confirmPassword"
                               type="password"
                               required
                               placeholder="Nhập lại mật khẩu">
                        <button class="toggle" type="button"
                                aria-controls="user_password_confirm"
                                aria-label="Bật/tắt hiển thị mật khẩu">Hiện</button>
                    </div>

                    <!-- Submit -->
                    <div class="full">
                        <button class="btn" type="submit">
                            <i class="bi bi-person-plus"></i> Tạo tài khoản
                        </button>
                    </div>

                    <!-- Divider -->
                    <div class="full" style="display:flex;align-items:center;gap:12px;margin-top:8px;">
                        <div style="height:1px;background:#e5e7eb;flex:1;"></div>
                        <span style="color:#6b7280;font-size:12px;">hoặc</span>
                        <div style="height:1px;background:#e5e7eb;flex:1;"></div>
                    </div>

                    <!-- Tiếp tục với Google -->
                    <div class="full">
                        <a class="btn" href="<c:url value='/oauth2/authorization/google'/>" style="background:#111827">
                            <i class="bi bi-google" style="margin-right:8px;"></i> Đăng ký với Google
                        </a>
                    </div>

                    <!-- Link đăng nhập -->
                    <div class="full foot">
                        Đã có tài khoản?
                        <a href="<c:url value='/auth/login'/>">Đăng nhập</a>
                    </div>

                </form>
            </section>

            <!-- Phải: Khung TV hiển thị ảnh/slideshow -->
            <aside class="panel panel--tv" aria-hidden="true">
                <div class="tv">
                    <div class="tv-frame" aria-live="polite">
                        <!-- Slideshow container -->
                        <div class="tv-slides">
                            <!-- Ảnh đầu tiên tạm thời; JS sẽ render lại khi bạn thêm danh sách ảnh -->
                            <img src="<c:url value='/assets/img/register-hero.jpg'/>" alt="Trình chiếu 1" class="active"/>
                        </div>
                        <div class="badge">Tìm ứng viên · Thuê nhanh · Phát triển</div>
                    </div>
                    <div class="tv-neck"></div>
                    <div class="tv-base"></div>
                    <div class="tv-shadow"></div>
                </div>
            </aside>

        </main>

        <script>
            (function () {
                /* ===== Hiện/ẩn mật khẩu (nhiều ô) ===== */
                document.querySelectorAll('.toggle[aria-controls]').forEach(function (btn) {
                    var targetId = btn.getAttribute('aria-controls');
                    var input = document.getElementById(targetId);
                    if (!input)
                        return;

                    btn.addEventListener('click', function () {
                        var isText = input.type === 'text';
                        input.type = isText ? 'password' : 'text';
                        btn.textContent = isText ? 'Hiện' : 'Ẩn';
                    });
                });

                /* ====== DOM refs ====== */
                var formEl = document.getElementById('userregistration-form');
                if (!formEl)
                    return;

                var userEl = document.getElementById('username');
                var firstEl = document.getElementById('firstname');
                var lastEl = document.getElementById('lastname');
                var mailEl = document.getElementById('user_email');
                var passEl = document.getElementById('user_password');
                var confirmEl = document.getElementById('user_password_confirm'); // nếu có
                var termsEl = document.getElementById('user_agree_terms');      // nếu có

                /* ====== Quy tắc ======
                 - Username: 3–30, bắt đầu bằng chữ, chỉ chữ/số/._, không 2 ký tự ./_ liền nhau, không kết thúc bằng ./_.
                 - Tên/Họ: cho phép chữ cái (kể cả có dấu), khoảng trắng, ', - ; 1–50.
                 - Email: dùng type="email" + check cơ bản.
                 - Mật khẩu: 8–64, ≥1 thường, ≥1 HOA, ≥1 số, ≥1 ký tự đặc biệt, KHÔNG khoảng trắng.
                 */
                var reUsername = /^(?!.*[_.]{2})[A-Za-z][A-Za-z0-9._]{1,28}[A-Za-z0-9]$/;
                var reName = /^[A-Za-zÀ-ỹĂăÂâÊêÔôƠơƯưĐđ' \-]{1,50}$/;
                var rePassword = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9])\S{8,64}$/;

                /* ===== Helpers ===== */
                function setValidState(el, ok, msg) {
                    if (!el)
                        return;
                    el.setCustomValidity(ok ? '' : (msg || 'Không hợp lệ'));
                    el.classList.toggle('invalid', !ok);
                    el.classList.toggle('valid', ok);

                    var err = el.parentElement && el.parentElement.querySelector('.err-msg');
                    if (err) {
                        err.textContent = ok ? '' : msg;
                        err.classList.toggle('show', !ok);
                    }
                }

                function ensureErrorNode(el) {
                    if (!el || !el.parentElement)
                        return;
                    if (!el.parentElement.querySelector('.err-msg')) {
                        var s = document.createElement('div');
                        s.className = 'err-msg';
                        el.parentElement.appendChild(s);
                    }
                }
                [userEl, firstEl, lastEl, mailEl, passEl, confirmEl].forEach(ensureErrorNode);

                /* ===== Field validators ===== */
                function validateUsername() {
                    if (!userEl)
                        return true;
                    var v = (userEl.value || '').trim();
                    if (!v)
                        return setValidState(userEl, false, 'Tên người dùng là bắt buộc'), false;
                    if (!reUsername.test(v))
                        return setValidState(userEl, false, '3–30 ký tự, bắt đầu bằng chữ; chỉ chữ/số/._; không 2 ký tự ./_ liền nhau; không kết thúc bằng ./_'), false;
                    return setValidState(userEl, true), true;
                }

                function validateFirst() {
                    if (!firstEl)
                        return true;
                    var v = (firstEl.value || '').trim();
                    if (!v)
                        return setValidState(firstEl, false, 'Tên là bắt buộc'), false;
                    if (!reName.test(v))
                        return setValidState(firstEl, false, 'Chỉ chữ cái, khoảng trắng, \' hoặc - (tối đa 50)'), false;
                    return setValidState(firstEl, true), true;
                }

                function validateLast() {
                    if (!lastEl)
                        return true;
                    var v = (lastEl.value || '').trim();
                    if (!v)
                        return setValidState(lastEl, false, 'Họ là bắt buộc'), false;
                    if (!reName.test(v))
                        return setValidState(lastEl, false, 'Chỉ chữ cái, khoảng trắng, \' hoặc - (tối đa 50)'), false;
                    return setValidState(lastEl, true), true;
                }

                function validateEmail() {
                    if (!mailEl)
                        return true;
                    var v = (mailEl.value || '').trim();
                    if (!v)
                        return setValidState(mailEl, false, 'Email là bắt buộc'), false;
                    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v))
                        return setValidState(mailEl, false, 'Email không hợp lệ'), false;
                    if (v.length > 150)
                        return setValidState(mailEl, false, 'Email tối đa 150 ký tự'), false;
                    return setValidState(mailEl, true), true;
                }

                function validatePassword() {
                    if (!passEl)
                        return true;
                    var v = passEl.value || '';
                    if (!v)
                        return setValidState(passEl, false, 'Mật khẩu là bắt buộc'), false;
                    if (!rePassword.test(v))
                        return setValidState(passEl, false, '8–64 ký tự, gồm: chữ thường, CHỮ HOA, số, ký tự đặc biệt; không có khoảng trắng'), false;
                    setValidState(passEl, true);
                    if (confirmEl)
                        validateConfirm();
                    return true;
                }

                function validateConfirm() {
                    if (!confirmEl)
                        return true;
                    var v1 = passEl ? passEl.value : '';
                    var v2 = confirmEl.value || '';
                    if (!v2)
                        return setValidState(confirmEl, false, 'Vui lòng nhập lại mật khẩu'), false;
                    if (v1 !== v2)
                        return setValidState(confirmEl, false, 'Mật khẩu nhập lại không khớp'), false;
                    return setValidState(confirmEl, true), true;
                }

                function validateTerms() {
                    if (!termsEl)
                        return true;
                    var ok = !!termsEl.checked;
                    if (!ok) {
                        termsEl.setCustomValidity('Bạn cần đồng ý với điều khoản');
                    } else {
                        termsEl.setCustomValidity('');
                    }
                    return ok;
                }

                /* ===== Lắng nghe nhập liệu ===== */
                if (userEl)
                    userEl.addEventListener('input', validateUsername);
                if (firstEl)
                    firstEl.addEventListener('input', validateFirst);
                if (lastEl)
                    lastEl.addEventListener('input', validateLast);
                if (mailEl)
                    mailEl.addEventListener('input', validateEmail);
                if (passEl)
                    passEl.addEventListener('input', validatePassword);
                if (confirmEl)
                    confirmEl.addEventListener('input', validateConfirm);
                if (termsEl)
                    termsEl.addEventListener('change', validateTerms);

                /* ===== Submit ===== */
                formEl.addEventListener('submit', function (e) {
                    var ok = true;
                    ok = validateUsername() && ok;
                    ok = validateFirst() && ok;
                    ok = validateLast() && ok;
                    ok = validateEmail() && ok;
                    ok = validatePassword() && ok;
                    ok = validateConfirm() && ok;
                    ok = validateTerms() && ok;

                    if (!ok) {
                        e.preventDefault();
                        formEl.classList.add('was-validated');
                        var firstInvalid = formEl.querySelector('input.invalid, input:invalid');
                        if (firstInvalid)
                            firstInvalid.focus();
                    }
                });

                /* ===== TV slideshow ===== */
                var slidesWrap = document.querySelector('.tv-slides');
                var tvFrame = document.querySelector('.tv-frame');
                if (slidesWrap && tvFrame) {
                    var ctx = '${pageContext.request.contextPath}' || '';
                    var sources = [
                        ctx + '/assets/img/register-hero.jpg',
                        ctx + '/assets/img/slide-2.jpg',
                        ctx + '/assets/img/slide-3.jpg',
                        ctx + '/assets/img/slide-4.jpg'
                    ];

                    function preload(src) {
                        return new Promise(function (resolve) {
                            var im = new Image();
                            im.onload = function () {
                                resolve({ok: true, src: src});
                            };
                            im.onerror = function () {
                                resolve({ok: false, src: src});
                            };
                            im.src = src;
                        });
                    }

                    Promise.all(sources.map(preload)).then(function (res) {
                        var images = res.filter(function (r) {
                            return r.ok;
                        }).map(function (r) {
                            return r.src;
                        });
                        if (images.length === 0)
                            return;

                        slidesWrap.innerHTML = '';
                        images.forEach(function (src, i) {
                            var img = new Image();
                            img.src = src;
                            img.alt = 'Trình chiếu ' + (i + 1);
                            img.decoding = 'async';
                            img.className = i === 0 ? 'active' : '';
                            slidesWrap.appendChild(img);
                        });

                        if (images.length === 1)
                            return;

                        var idx = 0, timer = null, interval = 3000;
                        function step() {
                            var slides = slidesWrap.querySelectorAll('img');
                            slides[idx].classList.remove('active');
                            idx = (idx + 1) % slides.length;
                            slides[idx].classList.add('active');
                        }
                        function start() {
                            if (!timer)
                                timer = setInterval(step, interval);
                        }
                        function stop() {
                            if (timer) {
                                clearInterval(timer);
                                timer = null;
                            }
                        }

                        tvFrame.addEventListener('mouseenter', stop);
                        tvFrame.addEventListener('mouseleave', start);
                        document.addEventListener('visibilitychange', function () {
                            if (document.hidden)
                                stop();
                            else
                                start();
                        });

                        start();
                    });
                }
            })();
        </script>
    </body>
</html>
