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
                    <div class="row align-items-center mb-4">
                        <div class="col">
                            <h2 class="h3 mb-1 text-dark">Dashboard Overview</h2>
                            <p class="text-muted mb-0">Welcome back, Ava! Here's what's happening with your account.</p>
                        </div>
                        <div class="col-auto">
                            <div class="d-flex gap-2">
                                <button class="btn btn-outline-warning">
                                    <i class="bi bi-download me-2"></i>Export
                                </button>
                                <button class="btn btn-warning text-white">
                                    <i class="bi bi-plus-lg me-2"></i>New Project
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Stats Cards -->
                    <div class="row g-4 mb-4">
                        <div class="col-12 col-sm-6 col-xl-3">
                            <div class="card border-0 shadow-sm h-100" style="background: linear-gradient(135deg, #ffffff 0%, #fff8f0 100%);">
                                <div class="card-body p-4">
                                    <div class="d-flex align-items-start justify-content-between mb-3">
                                        <div class="p-3 rounded-3" style="background: linear-gradient(135deg, #ff8c42 0%, #ffa726 100%);">
                                            <i class="bi bi-currency-dollar text-white fs-4"></i>
                                        </div>
                                        <span class="badge bg-success bg-opacity-25 text-success">+12%</span>
                                    </div>
                                    <h3 class="h4 mb-1 text-warning fw-bold">$1,080</h3>
                                    <p class="text-muted mb-3 small">Total Income</p>
                                    <button class="btn btn-outline-warning btn-sm">
                                        <i class="bi bi-arrow-clockwise me-1"></i>Refresh
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="col-12 col-sm-6 col-xl-3">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-body p-4">
                                    <div class="d-flex align-items-start justify-content-between mb-3">
                                        <div class="p-3 bg-info bg-opacity-25 rounded-3">
                                            <i class="bi bi-arrow-up-circle text-info fs-4"></i>
                                        </div>
                                        <span class="badge bg-secondary bg-opacity-25 text-secondary">0%</span>
                                    </div>
                                    <h3 class="h4 mb-1 fw-bold">$0</h3>
                                    <p class="text-muted mb-3 small">Withdraw Requested</p>
                                    <button class="btn btn-outline-secondary btn-sm">
                                        <i class="bi bi-list-ul me-1"></i>View All
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="col-12 col-sm-6 col-xl-3">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-body p-4">
                                    <div class="d-flex align-items-start justify-content-between mb-3">
                                        <div class="p-3 bg-warning bg-opacity-25 rounded-3">
                                            <i class="bi bi-hourglass-split text-warning fs-4"></i>
                                        </div>
                                        <span class="badge bg-secondary bg-opacity-25 text-secondary">0%</span>
                                    </div>
                                    <h3 class="h4 mb-1 fw-bold">$0</h3>
                                    <p class="text-muted mb-3 small">Pending Income</p>
                                    <button class="btn btn-outline-secondary btn-sm">
                                        <i class="bi bi-arrow-clockwise me-1"></i>Refresh
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="col-12 col-sm-6 col-xl-3">
                            <div class="card border-0 shadow-sm h-100" style="background: linear-gradient(135deg, #ffffff 0%, #fff8f0 100%);">
                                <div class="card-body p-4">
                                    <div class="d-flex align-items-start justify-content-between mb-3">
                                        <div class="p-3 rounded-3" style="background: linear-gradient(135deg, #ff8c42 0%, #ffa726 100%);">
                                            <i class="bi bi-wallet2 text-white fs-4"></i>
                                        </div>
                                        <span class="badge bg-success bg-opacity-25 text-success">Ready</span>
                                    </div>
                                    <h3 class="h4 mb-1 text-warning fw-bold">$1,080</h3>
                                    <p class="text-muted mb-3 small">Available Balance</p>
                                    <button class="btn btn-warning btn-sm text-white">
                                        <i class="bi bi-download me-1"></i>Withdraw
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Projects & Payouts -->
                    <div class="row g-4 mb-4">
                        <!-- Projects Overview -->
                        <div class="col-12 col-xl-8">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-header bg-transparent border-0 p-4">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <h5 class="mb-1">Projects & Tasks Overview</h5>
                                            <p class="text-muted mb-0 small">Track your project progress and task completion</p>
                                        </div>
                                        <button class="btn btn-outline-warning btn-sm">View All</button>
                                    </div>
                                </div>
                                <div class="card-body p-4 pt-0">
                                    <div class="row g-3">
                                        <div class="col-6 col-lg-4">
                                            <div class="text-center p-3 rounded-3 border border-success border-opacity-25 bg-success bg-opacity-10">
                                                <div class="h2 mb-1 text-success fw-bold">1</div>
                                                <small class="text-success fw-medium">Completed Projects</small>
                                            </div>
                                        </div>
                                        <div class="col-6 col-lg-4">
                                            <div class="text-center p-3 rounded-3 border border-primary border-opacity-25 bg-primary bg-opacity-10">
                                                <div class="h2 mb-1 text-primary fw-bold">1</div>
                                                <small class="text-primary fw-medium">Ongoing Projects</small>
                                            </div>
                                        </div>
                                        <div class="col-6 col-lg-4">
                                            <div class="text-center p-3 rounded-3 border border-danger border-opacity-25 bg-danger bg-opacity-10">
                                                <div class="h2 mb-1 text-danger fw-bold">0</div>
                                                <small class="text-danger fw-medium">Cancelled Projects</small>
                                            </div>
                                        </div>
                                        <div class="col-6 col-lg-4">
                                            <div class="text-center p-3 rounded-3 border border-warning border-opacity-25 bg-warning bg-opacity-10">
                                                <div class="h2 mb-1 text-warning fw-bold">2</div>
                                                <small class="text-warning fw-medium">Tasks Sold</small>
                                            </div>
                                        </div>
                                        <div class="col-6 col-lg-4">
                                            <div class="text-center p-3 rounded-3 border border-info border-opacity-25 bg-info bg-opacity-10">
                                                <div class="h2 mb-1 text-info fw-bold">0</div>
                                                <small class="text-info fw-medium">Ongoing Tasks</small>
                                            </div>
                                        </div>
                                        <div class="col-6 col-lg-4">
                                            <div class="text-center p-3 rounded-3 border border-secondary border-opacity-25 bg-secondary bg-opacity-10">
                                                <div class="h2 mb-1 text-secondary fw-bold">1</div>
                                                <small class="text-secondary fw-medium">Cancelled Tasks</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Payout Methods -->
                        <div class="col-12 col-xl-4">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-header bg-transparent border-0 p-4">
                                    <h5 class="mb-1">
                                        <i class="bi bi-credit-card-2-back text-warning me-2"></i>Payment Methods
                                    </h5>
                                    <p class="text-muted mb-0 small">Configure your payout preferences</p>
                                </div>
                                <div class="card-body p-4 pt-0">
                                    <div class="d-flex flex-column gap-3">
                                        <div class="card border border-warning border-opacity-25 bg-warning bg-opacity-10">
                                            <div class="card-body p-3">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-flex align-items-center gap-3">
                                                        <i class="bi bi-paypal text-primary fs-4"></i>
                                                        <div>
                                                            <div class="fw-medium">PayPal</div>
                                                            <small class="text-muted">Not configured</small>
                                                        </div>
                                                    </div>
                                                    <div class="form-check form-switch">
                                                        <input class="form-check-input" type="checkbox" role="switch">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card border">
                                            <div class="card-body p-3">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-flex align-items-center gap-3">
                                                        <i class="bi bi-credit-card text-info fs-4"></i>
                                                        <div>
                                                            <div class="fw-medium">Payoneer</div>
                                                            <small class="text-muted">Not configured</small>
                                                        </div>
                                                    </div>
                                                    <div class="form-check form-switch">
                                                        <input class="form-check-input" type="checkbox" role="switch">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card border">
                                            <div class="card-body p-3">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-flex align-items-center gap-3">
                                                        <i class="bi bi-bank text-success fs-4"></i>
                                                        <div>
                                                            <div class="fw-medium">Bank Account</div>
                                                            <small class="text-muted">Not configured</small>
                                                        </div>
                                                    </div>
                                                    <div class="form-check form-switch">
                                                        <input class="form-check-input" type="checkbox" role="switch">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="alert alert-warning bg-warning bg-opacity-25 border-warning border-opacity-25 mt-3" role="alert">
                                        <div class="d-flex">
                                            <i class="bi bi-info-circle me-2 mt-1"></i>
                                            <small>
                                                Configure at least one payment method to receive your earnings. 
                                                <a href="#" class="alert-link fw-medium">Learn more</a>
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Earning History -->
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-transparent border-0 p-4">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-1">
                                        <i class="bi bi-graph-up-arrow text-warning me-2"></i>Earning History
                                    </h5>
                                    <p class="text-muted mb-0 small">Track your recent earnings and transactions</p>
                                </div>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-outline-secondary btn-sm">
                                        <i class="bi bi-funnel me-1"></i>Filter
                                    </button>
                                    <button class="btn btn-outline-warning btn-sm">
                                        <i class="bi bi-download me-1"></i>Export
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th scope="col" class="ps-4 py-3 border-0">#</th>
                                            <th scope="col" class="py-3 border-0">
                                                <i class="bi bi-calendar3 me-2 text-muted"></i>Date
                                            </th>
                                            <th scope="col" class="py-3 border-0">
                                                <i class="bi bi-file-text me-2 text-muted"></i>Description
                                            </th>
                                            <th scope="col" class="py-3 border-0">
                                                <i class="bi bi-currency-dollar me-2 text-muted"></i>Amount
                                            </th>
                                            <th scope="col" class="py-3 border-0">Status</th>
                                            <th scope="col" class="pe-4 py-3 border-0 text-end">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr class="border-bottom border-opacity-25">
                                            <th scope="row" class="ps-4 py-4">
                                                <div class="d-flex align-items-center justify-content-center bg-warning bg-opacity-25 rounded-circle" style="width: 32px; height: 32px;">
                                                    <span class="fw-bold text-warning small">1</span>
                                                </div>
                                            </th>
                                            <td class="py-4">
                                                <div class="fw-medium">Aug 10, 2025</div>
                                                <small class="text-muted">3 days ago</small>
                                            </td>
                                            <td class="py-4">
                                                <div class="fw-medium">Website redesign</div>
                                                <small class="text-muted">Project completion</small>
                                            </td>
                                            <td class="py-4">
                                                <span class="h6 mb-0 text-warning fw-bold">$320.00</span>
                                            </td>
                                            <td class="py-4">
                                                <span class="badge bg-success bg-opacity-25 text-success px-3 py-2">Paid</span>
                                            </td>
                                            <td class="pe-4 py-4 text-end">
                                                <button class="btn btn-outline-warning btn-sm">
                                                    <i class="bi bi-receipt me-1"></i>Invoice
                                                </button>
                                            </td>
                                        </tr>
                                        <tr class="border-bottom border-opacity-25">
                                            <th scope="row" class="ps-4 py-4">
                                                <div class="d-flex align-items-center justify-content-center bg-warning bg-opacity-25 rounded-circle" style="width: 32px; height: 32px;">
                                                    <span class="fw-bold text-warning small">2</span>
                                                </div>
                                            </th>
                                            <td class="py-4">
                                                <div class="fw-medium">Aug 03, 2025</div>
                                                <small class="text-muted">10 days ago</small>
                                            </td>
                                            <td class="py-4">
                                                <div class="fw-medium">Logo contest win</div>
                                                <small class="text-muted">Contest prize</small>
                                            </td>
                                            <td class="py-4">
                                                <span class="h6 mb-0 text-warning fw-bold">$160.00</span>
                                            </td>
                                            <td class="py-4">
                                                <span class="badge bg-success bg-opacity-25 text-success px-3 py-2">Paid</span>
                                            </td>
                                            <td class="pe-4 py-4 text-end">
                                                <button class="btn btn-outline-warning btn-sm">
                                                    <i class="bi bi-receipt me-1"></i>Invoice
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row" class="ps-4 py-4">
                                                <div class="d-flex align-items-center justify-content-center bg-warning bg-opacity-25 rounded-circle" style="width: 32px; height: 32px;">
                                                    <span class="fw-bold text-warning small">3</span>
                                                </div>
                                            </th>
                                            <td class="py-4">
                                                <div class="fw-medium">Jul 29, 2025</div>
                                                <small class="text-muted">20 days ago</small>
                                            </td>
                                            <td class="py-4">
                                                <div class="fw-medium">Microtask batch</div>
                                                <small class="text-muted">Task completion</small>
                                            </td>
                                            <td class="py-4">
                                                <span class="h6 mb-0 text-warning fw-bold">$600.00</span>
                                            </td>
                                            <td class="py-4">
                                                <span class="badge bg-success bg-opacity-25 text-success px-3 py-2">Paid</span>
                                            </td>
                                            <td class="pe-4 py-4 text-end">
                                                <button class="btn btn-outline-warning btn-sm">
                                                    <i class="bi bi-receipt me-1"></i>Invoice
                                                </button>
                                            </td>                                          
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>