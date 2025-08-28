<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="vi">
    <%@include file="include/head.jsp" %>
    <style>
        .pagination .page-link {
            color: #ffc107;
            border-color: #dee2e6;
        }

        .pagination .page-item.active .page-link {
            background-color: #ffc107;
            border-color: #ffc107;
            color: #000;
        }

        .pagination .page-link:hover {
            color: #000;
            background-color: #fff3cd;
            border-color: #ffc107;
        }

        .pagination .page-item.disabled .page-link {
            color: #6c757d;
            background-color: #fff;
            border-color: #dee2e6;
        }
    </style>
    <body style="background: linear-gradient(135deg, #fff5f0 0%, #ffffff 100%);">
        
        <!-- Flash toast container (success + error) -->
        <div class="toast-container position-fixed top-0 end-0 p-3" style="z-index:1080;">
            <c:if test="${not empty success}">
                <div id="flashSuccessToast" class="toast text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="d-flex">
                        <div class="toast-body">
                            <i class="bi bi-check-circle-fill me-2"></i>
                            <c:out value="${success}"/>
                        </div>
                        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div id="flashErrorToast" class="toast text-bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="d-flex">
                        <div class="toast-body">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            <c:out value="${error}"/>
                        </div>
                        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                </div>
            </c:if>
        </div>

        <!-- Auto show toasts when flash attributes exist -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
            <%-- hiện success nếu có --%>
            <c:if test="${not empty success}">
                new bootstrap.Toast(document.getElementById('flashSuccessToast'), {delay: 4000, autohide: true}).show();
            </c:if>
            <%-- hiện error nếu có (để autohide=false cho người dùng đọc kỹ) --%>
            <c:if test="${not empty error}">
                new bootstrap.Toast(document.getElementById('flashErrorToast'), {delay: 7000, autohide: false}).show();
            </c:if>
            });
        </script>

        <div class="container-fluid">
            <div class="row g-0">
                <!-- Sidebar -->
                <%@include file="include/sidebar.jsp" %>

                <!-- Main Content -->
                <main class="col-12 col-lg-9 col-xl-10 p-4">
                    <!-- Header Section -->
                    <div class="row align-items-center mb-4">
                        <div class="col">
                            <h2 class="h3 mb-1 text-dark">
                                <i class="bi bi-briefcase text-warning me-2"></i>Khám Phá Công Việc
                            </h2>
                            <p class="text-muted mb-0">Tìm kiếm cơ hội trong các danh mục Đấu Thầu, Cuộc Thi và Tác Vụ Nhỏ</p>
                        </div>
                        <div class="col-auto">
                            <button class="btn btn-warning text-white">
                                <i class="bi bi-plus-lg me-2"></i>Đăng Tin Tuyển
                            </button>
                        </div>
                    </div>

                    <!-- Filter Section -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <div class="row align-items-center">
                                <div class="col-md-6">
                                    <h6 class="mb-3 mb-md-0">Lọc theo loại công việc:</h6>
                                </div>
                                <div class="col-md-6">
                                    <div class="btn-group w-100" role="group" id="jobTypeFilter">
                                        <!-- data-filter khớp tham số ?type= -->
                                        <button type="button" class="btn btn-outline-secondary filter-btn" data-filter="all">
                                            <i class="bi bi-grid-3x3-gap me-1"></i>Tất Cả
                                        </button>
                                        <button type="button" class="btn btn-outline-primary filter-btn" data-filter="bidding">
                                            <i class="bi bi-hammer me-1"></i>Đấu Thầu
                                        </button>
                                        <button type="button" class="btn btn-outline-info filter-btn" data-filter="contest">
                                            <i class="bi bi-trophy me-1"></i>Cuộc Thi
                                        </button>
                                        <button type="button" class="btn btn-outline-warning filter-btn" data-filter="microtask">
                                            <i class="bi bi-list-task me-1"></i>Tác Vụ Nhỏ
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Jobs Count + Sort -->

                    <!-- ✅ FIXED: Sort Form - Only include non-empty parameters -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <span class="text-muted">Hiển thị <span id="jobCount"><c:out value="${jobCount != null ? jobCount : 6}"/></span> công việc</span>
                        <div class="d-flex align-items-center gap-2">
                            <small class="text-muted">Sắp xếp theo:</small>
                            <form id="sortForm" method="get" class="d-inline">
                                <%-- ✅ Chỉ include parameters có giá trị --%>
                                <c:if test="${not empty type and type != 'all'}">
                                    <input type="hidden" name="type" value="${type}"/>
                                </c:if>

                                <c:if test="${not empty minBudget}">
                                    <input type="hidden" name="minBudget" value="${minBudget}"/>
                                </c:if>

                                <c:if test="${not empty maxBudget}">
                                    <input type="hidden" name="maxBudget" value="${maxBudget}"/>
                                </c:if>

                                <c:if test="${not empty deadline}">
                                    <input type="hidden" name="deadline" value="${deadline}"/>
                                </c:if>

                                <%-- ✅ Luôn include size và reset page về 0 --%>
                                <input type="hidden" name="size" value="${page.size}"/>
                                <input type="hidden" name="page" value="0"/>

                                <select class="form-select form-select-sm" name="sort" style="width: auto;" 
                                        onchange="console.log('🔄 Sort changed'); document.getElementById('sortForm').submit()">
                                    <option ${sort == 'Newest First' ? 'selected' : ''}>Mới Nhất</option>
                                    <option ${sort == 'Highest Budget' ? 'selected' : ''}>Ngân Sách Cao Nhất</option>
                                    <option ${sort == 'Lowest Budget' ? 'selected' : ''}>Ngân Sách Thấp Nhất</option>
                                    <option ${sort == 'Deadline' ? 'selected' : ''}>Hạn Chót</option>
                                </select>
                            </form>
                        </div>
                    </div>

                    <!-- Jobs Grid -->
                    <div class="row g-4" id="jobsContainer">


                        <c:if test="${not empty cards}">
                            <c:forEach var="card" items="${cards}">
                                <div class="col-12 col-md-6 col-xl-4 job-item" data-type="${card.type}">
                                    <div class="card job-card border-0 shadow-sm h-100">
                                        <div class="card-body p-4 d-flex flex-column">


                                            <div class="d-flex justify-content-between align-items-start mb-3">
                                                <c:choose>
                                                    <c:when test="${card.type eq 'BIDDING'}">
                                                        <span class="badge bg-primary badge-custom"><i class="bi bi-hammer me-1"></i>Đấu Thầu</span>
                                                    </c:when>
                                                    <c:when test="${card.type eq 'CONTEST'}">
                                                        <span class="badge bg-info text-white"><i class="bi bi-trophy me-1"></i>Cuộc Thi</span>
                                                    </c:when>
                                                    <c:when test="${card.type eq 'MICROTASK'}">
                                                        <span class="badge bg-warning text-white"><i class="bi bi-list-task me-1"></i>Tác Vụ Nhỏ</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Khác</span>
                                                    </c:otherwise>
                                                </c:choose>
                                                <button class="btn btn-sm btn-outline-secondary rounded-circle"><i class="bi bi-heart"></i></button>
                                            </div>

                                            <h5 class="card-title mb-2"><c:out value="${card.title}"/></h5>
                                            <p class="text-muted small mb-3 job-desc"><c:out value="${card.description}"/></p>

                                            <div class="d-flex align-items-center mb-3">
                                                <img src="https://i.pravatar.cc/40" class="rounded-circle me-2" width="32" height="32" alt="Employer">
                                                <div><small class="text-muted">${card.type eq 'contest' ? 'Tổ chức bởi' : 'Đăng bởi'}</small>
                                                    <div class="fw-medium"><c:out value="${card.employerName}"/></div>
                                                </div>
                                            </div>


                                            <c:choose>

                                                <c:when test="${card.type eq 'bidding'}">
                                                    <div class="row g-2 mb-3 meta-block">
                                                        <div class="col-6"><small>Ngân sách:</small><div><c:out value="${card.budget}"/>₫</div></div>
                                                        <div class="col-6"><small>Hạn chót:</small><div><c:out value="${card.deadlineAt}"/></div></div>
                                                    </div>
                                                    <div class="row g-2 mb-3 meta-block">
                                                        <div class="col-6"><small>Giá thấp nhất:</small>
                                                            <div class="fw-bold text-success"><c:out value="${card.lowestBidPrice}"/>₫</div>
                                                        </div>
                                                        <div class="col-6"><small>Giá trung bình:</small><div class="fw-bold text-success">—</div></div>
                                                    </div>
                                                </c:when>

                                                <c:when test="${card.type eq 'contest'}">
                                                    <div class="row g-2 mb-3 meta-block">
                                                        <div class="col-6"><small>Giải thưởng:</small><div><c:out value="${card.topPrize}"/>₫</div></div>
                                                        <div class="col-6"><small>Hạn chót:</small><div><c:out value="${card.deadlineAt}"/></div></div>
                                                    </div>
                                                    <div class="row g-2 mb-3 meta-block">
                                                        <div class="col-6"><small>Số người thắng:</small><div>Top <c:out value="${card.winnerCount}"/></div></div>
                                                        <div class="col-6"><small>Trạng thái:</small><div class="text-success fw-medium">Đang mở</div></div>
                                                    </div>

                                                    <div class="mb-3 meta-block">
                                                        <small>Tiêu chí đánh giá:</small>
                                                        <ul class="small mb-0">
                                                            <c:forEach var="cr" items="${criteriaMap[card.id]}">
                                                                <li><c:out value="${cr.name}"/></li>
                                                                </c:forEach>
                                                                <c:if test="${empty criteriaMap[card.id]}">
                                                                <li>—</li>
                                                                </c:if>
                                                        </ul>
                                                    </div>
                                                </c:when>

                                                <c:when test="${card.type eq 'microtask'}">
                                                    <div class="row g-2 mb-3 meta-block">
                                                        <div class="col-6"><small>Giá mỗi đơn vị:</small><div><c:out value="${card.unitPrice}"/>₫/đơn vị</div></div>
                                                        <div class="col-6"><small>Số lượng tối đa:</small><div><c:out value="${card.maxWorkers}"/></div></div>
                                                    </div>

                                                    <div class="mb-3 meta-block">
                                                        <small>Tiến độ:</small>
                                                        <div class="d-flex justify-content-between small"><span>—</span><span>—</span></div>
                                                        <div class="progress mt-1" style="height:6px;"><div class="progress-bar bg-warning" style="width:0%"></div></div>
                                                    </div>

                                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                                        <span><i class="bi bi-people me-1"></i>—</span>
                                                        <span class="text-muted">—</span>
                                                    </div>
                                                </c:when>
                                            </c:choose>


                                            <div class="mt-auto d-flex gap-2">
                                                <button class="btn btn-warning text-white w-100"
                                                        onclick="window.location.href = '${pageContext.request.contextPath}/dashboard/browse-jobs/jobDetail?id=${card.id}'">
                                                    <i class="bi bi-eye me-1"></i>Xem Chi Tiết
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>


                        <c:if test="${empty cards}">
                            <div class="card border-0 shadow-sm">
                                <div class="card-body text-center py-5">
                                    <div class="display-6 mb-2">😕</div>
                                    <h5 class="mb-2">Không tìm thấy công việc phù hợp</h5>
                                    <p class="text-muted">Hãy thử điều chỉnh bộ lọc hoặc tìm kiếm với từ khóa khác</p>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <c:if test="${page.totalPages > 1}">
                        <c:url var="baseUrl" value="${pageContext.request.contextPath}/dashboard/browse-jobs">
                            <c:param name="size" value="${page.size}" />
                            <c:if test="${not empty type and type != 'all'}">
                                <c:param name="type" value="${type}" />
                            </c:if>
                            <c:if test="${not empty minBudget}">
                                <c:param name="minBudget" value="${minBudget}" />
                            </c:if>
                            <c:if test="${not empty maxBudget}">
                                <c:param name="maxBudget" value="${maxBudget}" />
                            </c:if>
                            <c:if test="${not empty deadline}">
                                <c:param name="deadline" value="${deadline}" />
                            </c:if>
                            <c:if test="${not empty sort}">
                                <c:param name="sort" value="${sort}" />
                            </c:if>
                        </c:url>

                        <c:set var="startPage" value="${page.number - 2 < 0 ? 0 : page.number - 2}" />
                        <c:set var="endPage" value="${startPage + 4 >= page.totalPages ? page.totalPages - 1 : startPage + 4}" />

                        <nav aria-label="Phân trang công việc" class="mt-5">
                            <ul class="pagination justify-content-center">
                                <li class="page-item ${page.first ? 'disabled' : ''}">
                                    <c:choose>
                                        <c:when test="${!page.first}">
                                            <c:url var="prevUrl" value="${baseUrl}">
                                                <c:param name="page" value="${page.number - 1}" />
                                            </c:url>
                                            <a class="page-link" href="${prevUrl}" aria-label="Trang trước">
                                                <span aria-hidden="true"><i class="bi bi-chevron-left"></i></span>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="page-link" aria-label="Trang trước">
                                                <span aria-hidden="true"><i class="bi bi-chevron-left"></i></span>
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </li>

                                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                    <li class="page-item ${i == page.number ? 'active' : ''}">
                                        <c:choose>
                                            <c:when test="${i == page.number}">
                                                <span class="page-link">${i + 1}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <c:url var="numUrl" value="${baseUrl}">
                                                    <c:param name="page" value="${i}" />
                                                </c:url>
                                                <a class="page-link" href="${numUrl}">${i + 1}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                </c:forEach>

                                <li class="page-item ${page.last ? 'disabled' : ''}">
                                    <c:choose>
                                        <c:when test="${!page.last}">
                                            <c:url var="nextUrl" value="${baseUrl}">
                                                <c:param name="page" value="${page.number + 1}" />
                                            </c:url>
                                            <a class="page-link" href="${nextUrl}" aria-label="Trang sau">
                                                <span aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="page-link" aria-label="Trang sau">
                                                <span aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                            </ul>
                        </nav>

                        <div class="text-center text-muted mt-3">
                            <small>
                                Trang ${page.number + 1} trong ${page.totalPages}
                                (tổng cộng ${page.totalElements} công việc)
                            </small>
                        </div>
                    </c:if>


                </main>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                            // Active nút filter theo ${type}
                                                            (function () {
                                                                var currentType = "${type}";
                                                                if (!currentType || currentType === "null")
                                                                    currentType = "all";

                                                                document.querySelectorAll('#jobTypeFilter .filter-btn').forEach(function (btn) {
                                                                    btn.classList.remove('active');
                                                                    if (btn.dataset.filter === currentType) {
                                                                        btn.classList.add('active');
                                                                    }

                                                                    btn.addEventListener('click', function () {
                                                                        console.log("🎯 Filter clicked:", btn.dataset.filter);
                                                                        updateQuery({type: btn.dataset.filter, page: 0});
                                                                    });
                                                                });
                                                            })();


                                                            function updateQuery(overrides) {
                                                                var params = new URLSearchParams(window.location.search);


                                                                var currentParams = {
                                                                    type: params.get('type'),
                                                                    minBudget: params.get('minBudget'),
                                                                    maxBudget: params.get('maxBudget'),
                                                                    deadline: params.get('deadline'),
                                                                    sort: params.get('sort'),
                                                                    size: params.get('size'),
                                                                    page: params.get('page')
                                                                };

                                                                for (var k in overrides) {
                                                                    currentParams[k] = overrides[k];
                                                                }

                                                                var newParams = new URLSearchParams();
                                                                for (var k in currentParams) {
                                                                    if (currentParams[k] !== null && currentParams[k] !== undefined && currentParams[k] !== '') {
                                                                        newParams.set(k, currentParams[k]);
                                                                    }
                                                                }

                                                                console.log("🔄 Redirecting to:", window.location.pathname + '?' + newParams.toString());
                                                                window.location.search = newParams.toString();
                                                            }

                                                            function getParam(k) {
                                                                return new URLSearchParams(window.location.search).get(k);
                                                            }
        </script>

    </body>

</html>