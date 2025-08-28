<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>

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
                                <i class="bi bi-person-workspace text-primary me-2"></i>Project Management
                            </h2>
                            <p class="text-muted mb-0">Track your active projects, submissions, and earnings</p>
                        </div>
                        <div class="d-flex gap-2">
                            <button class="btn btn-outline-primary">
                                <i class="bi bi-clock-history me-1"></i>Time Tracker
                            </button>
                            <button class="btn btn-primary">
                                <i class="bi bi-search me-1"></i>Find More Jobs
                            </button>
                        </div>
                    </div>

                    <div class="row g-4">
                        <!-- Main Project Management -->
                        <div class="col-12 col-xl-8">
                            <!-- Project Header Card -->
                            <div class="card border-0 shadow-sm mb-4">
                                <div class="card-body p-4">
                                    <div class="d-flex justify-content-between align-items-start mb-3">
                                        <div class="d-flex gap-2">
                                            <span class="badge bg-primary px-3 py-2">
                                                <i class="bi bi-briefcase me-1"></i>Active Project
                                            </span>
                                            <span class="badge bg-success px-3 py-2">
                                                <i class="bi bi-circle-fill me-1" style="font-size: 8px;"></i>In Progress
                                            </span>
                                        </div>
                                        <div class="dropdown">
                                            <button class="btn btn-outline-secondary btn-sm" data-bs-toggle="dropdown">
                                                <i class="bi bi-three-dots"></i>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li><a class="dropdown-item" href="#"><i class="bi bi-eye me-2"></i>View Contract</a></li>
                                                <li><a class="dropdown-item" href="#"><i class="bi bi-download me-2"></i>Download Files</a></li>
                                                <li><hr class="dropdown-divider"></li>
                                                <li><a class="dropdown-item text-warning" href="#"><i class="bi bi-flag me-2"></i>Report Issue</a></li>
                                            </ul>
                                        </div>
                                    </div>

                                    <h3 class="h4 mb-2">E-commerce Website Development</h3>
                                    <p class="text-muted mb-3">Build a modern e-commerce platform with React and Node.js. Need payment integration and admin dashboard with comprehensive analytics and mobile responsive design.</p>

                                    <!-- Project Stats -->
                                    <div class="row g-3 mb-4">
                                        <div class="col-6 col-sm-3">
                                            <div class="text-center p-3 bg-light rounded">
                                                <div class="h5 text-success mb-0">$2,200</div>
                                                <small class="text-muted">Contract Value</small>
                                            </div>
                                        </div>
                                        <div class="col-6 col-sm-3">
                                            <div class="text-center p-3 bg-light rounded">
                                                <div class="h5 text-warning mb-0">35 days</div>
                                                <small class="text-muted">Remaining</small>
                                            </div>
                                        </div>
                                        <div class="col-6 col-sm-3">
                                            <div class="text-center p-3 bg-light rounded">
                                                <div class="h5 text-primary mb-0">40%</div>
                                                <small class="text-muted">Completed</small>
                                            </div>
                                        </div>
                                        <div class="col-6 col-sm-3">
                                            <div class="text-center p-3 bg-light rounded">
                                                <div class="h5 text-info mb-0">45.5h</div>
                                                <small class="text-muted">Hours Logged</small>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Quick Actions -->
                                    <div class="d-flex flex-wrap gap-2">
                                        <button class="btn btn-primary">
                                            <i class="bi bi-chat-dots me-1"></i>Message Client
                                        </button>
                                        <button class="btn btn-outline-success">
                                            <i class="bi bi-upload me-1"></i>Submit Work
                                        </button>
                                        <button class="btn btn-outline-info">
                                            <i class="bi bi-clock me-1"></i>Log Time
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <!-- My Proposal & Contract -->
                            <div class="card border-0 shadow-sm mb-4">
                                <div class="card-header bg-transparent border-0 p-4">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h5 class="mb-0">
                                            <i class="bi bi-file-text text-primary me-2"></i>My Proposal & Contract
                                        </h5>
                                        <button class="btn btn-outline-primary btn-sm">
                                            <i class="bi bi-pencil"></i> Edit Terms
                                        </button>
                                    </div>
                                </div>
                                <div class="card-body p-4">
                                    <div class="row g-4">
                                        <!-- Original Proposal -->
                                        <div class="col-md-6">
                                            <div class="border rounded p-3 bg-light bg-opacity-50">
                                                <h6 class="mb-3">Original Proposal</h6>
                                                <div class="d-flex justify-content-between mb-2">
                                                    <span class="text-muted">Bid Amount:</span>
                                                    <span class="fw-bold text-success">$2,200</span>
                                                </div>
                                                <div class="d-flex justify-content-between mb-2">
                                                    <span class="text-muted">Timeline:</span>
                                                    <span class="fw-bold">5 weeks</span>
                                                </div>
                                                <div class="d-flex justify-content-between mb-3">
                                                    <span class="text-muted">Submitted:</span>
                                                    <span class="fw-bold">Aug 15, 2025</span>
                                                </div>
                                                <p class="small text-muted mb-0">I can deliver a scalable e-commerce platform with React and Node.js, optimized for performance and user experience...</p>
                                            </div>
                                        </div>

                                        <!-- Contract Status -->
                                        <div class="col-md-6">
                                            <div class="border rounded p-3">
                                                <h6 class="mb-3">Contract Status</h6>
                                                <div class="d-flex justify-content-between mb-2">
                                                    <span class="text-muted">Status:</span>
                                                    <span class="badge bg-success">Active</span>
                                                </div>
                                                <div class="d-flex justify-content-between mb-2">
                                                    <span class="text-muted">Start Date:</span>
                                                    <span class="fw-bold">Aug 18, 2025</span>
                                                </div>
                                                <div class="d-flex justify-content-between mb-3">
                                                    <span class="text-muted">End Date:</span>
                                                    <span class="fw-bold">Sep 29, 2025</span>
                                                </div>
                                                <div class="d-flex gap-2">
                                                    <button class="btn btn-sm btn-outline-primary flex-fill">
                                                        <i class="bi bi-eye me-1"></i>View Contract
                                                    </button>
                                                    <button class="btn btn-sm btn-outline-info flex-fill">
                                                        <i class="bi bi-download me-1"></i>Download
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Milestones & Progress -->
                            <div class="card border-0 shadow-sm mb-4">
                                <div class="card-header bg-transparent border-0 p-4">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h5 class="mb-0">
                                            <i class="bi bi-flag text-primary me-2"></i>Project Milestones
                                        </h5>
                                        <div class="d-flex gap-2">
                                            <span class="badge bg-primary">2 of 4 completed</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body p-4">
                                    <!-- Overall Progress -->
                                    <div class="mb-4">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <span class="fw-medium">Project Progress</span>
                                            <span class="text-primary fw-bold">40%</span>
                                        </div>
                                        <div class="progress mb-2" style="height: 12px;">
                                            <div class="progress-bar bg-primary" style="width: 40%"></div>
                                        </div>
                                        <small class="text-muted">
                                            <i class="bi bi-clock me-1"></i>Last update: Milestone 2 submitted for review
                                        </small>
                                    </div>

                                    <!-- Milestone List -->
                                    <div class="row g-3">
                                        <!-- Milestone 1 - Completed -->
                                        <div class="col-md-6">
                                            <div class="card border border-success border-opacity-25 bg-success bg-opacity-10">
                                                <div class="card-body p-3">
                                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                                        <h6 class="mb-0">Milestone 1: UI Design</h6>
                                                        <span class="badge bg-success">Approved & Paid</span>
                                                    </div>
                                                    <p class="small text-muted mb-2">Wireframes, mockups, and design system completed</p>
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <span class="h6 text-success mb-0">$800</span>
                                                        <div class="d-flex gap-1">
                                                            <button class="btn btn-sm btn-outline-success" disabled>
                                                                <i class="bi bi-check-circle me-1"></i>Completed
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Milestone 2 - Under Review -->
                                        <div class="col-md-6">
                                            <div class="card border border-warning border-opacity-25 bg-warning bg-opacity-10">
                                                <div class="card-body p-3">
                                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                                        <h6 class="mb-0">Milestone 2: Frontend Dev</h6>
                                                        <span class="badge bg-warning text-dark">Under Review</span>
                                                    </div>
                                                    <p class="small text-muted mb-2">React components and responsive layouts</p>
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <span class="h6 text-warning mb-0">$600</span>
                                                        <div class="d-flex gap-1">
                                                            <button class="btn btn-sm btn-outline-primary">
                                                                <i class="bi bi-pencil me-1"></i>Revise
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Milestone 3 - Active -->
                                        <div class="col-md-6">
                                            <div class="card border border-primary border-opacity-25 bg-primary bg-opacity-10">
                                                <div class="card-body p-3">
                                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                                        <h6 class="mb-0">Milestone 3: Backend API</h6>
                                                        <span class="badge bg-primary">In Progress</span>
                                                    </div>
                                                    <p class="small text-muted mb-2">API development and database setup</p>
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <span class="h6 text-primary mb-0">$800</span>
                                                        <div class="d-flex gap-1">
                                                            <button class="btn btn-sm btn-success">
                                                                <i class="bi bi-upload me-1"></i>Submit
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Milestone 4 - Pending -->
                                        <div class="col-md-6">
                                            <div class="card border border-secondary border-opacity-25">
                                                <div class="card-body p-3">
                                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                                        <h6 class="mb-0">Milestone 4: Integration</h6>
                                                        <span class="badge bg-secondary">Pending</span>
                                                    </div>
                                                    <p class="small text-muted mb-2">Payment integration and final testing</p>
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <span class="h6 text-muted mb-0">$500</span>
                                                        <div class="d-flex gap-1">
                                                            <button class="btn btn-sm btn-outline-secondary" disabled>
                                                                <i class="bi bi-clock me-1"></i>Waiting
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Communication & Support -->
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-header bg-transparent border-0 p-3">
                                            <h6 class="mb-0">
                                                <i class="bi bi-chat-dots text-primary me-2"></i>Recent Messages
                                            </h6>
                                        </div>
                                        <div class="card-body p-3">
                                            <div class="d-flex align-items-start gap-2 mb-3">
                                                <img src="https://i.pravatar.cc/32?img=3" class="rounded-circle" width="32" height="32">
                                                <div class="flex-grow-1">
                                                    <div class="bg-light rounded p-2">
                                                        <small class="fw-bold text-primary">Alice Smith</small>
                                                        <p class="mb-0 small">Great work on Milestone 1! Please proceed with the frontend development...</p>
                                                    </div>
                                                    <small class="text-muted">2 hours ago</small>
                                                </div>
                                            </div>
                                            <div class="d-flex gap-2">
                                                <button class="btn btn-primary btn-sm flex-fill">
                                                    <i class="bi bi-reply me-1"></i>Reply
                                                </button>
                                                <button class="btn btn-outline-success btn-sm flex-fill">
                                                    <i class="bi bi-telephone me-1"></i>Call
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-header bg-transparent border-0 p-3">
                                            <h6 class="mb-0">
                                                <i class="bi bi-life-preserver text-primary me-2"></i>Support & Help
                                            </h6>
                                        </div>
                                        <div class="card-body p-3">
                                            <div class="text-center py-3">
                                                <i class="bi bi-headset text-info fs-2 mb-2"></i>
                                                <p class="text-muted small mb-3">Need help with your project?</p>
                                                <div class="d-grid gap-2">
                                                    <button class="btn btn-outline-info btn-sm">
                                                        <i class="bi bi-chat-square-dots me-1"></i>Contact Support
                                                    </button>
                                                    <button class="btn btn-outline-warning btn-sm">
                                                        <i class="bi bi-exclamation-triangle me-1"></i>Report Issue
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Right Sidebar -->
                        <div class="col-12 col-xl-4">
                            <!-- Client Information -->
                            <div class="card border-0 shadow-sm mb-4">
                                <div class="card-header bg-transparent border-0 p-3">
                                    <h6 class="mb-0">
                                        <i class="bi bi-person-circle text-primary me-2"></i>Client Information
                                    </h6>
                                </div>
                                <div class="card-body p-3">
                                    <div class="d-flex align-items-center mb-3">
                                        <img src="https://i.pravatar.cc/50?img=3" class="rounded-circle me-3" width="50" height="50" alt="Client">
                                        <div class="flex-grow-1">
                                            <div class="fw-bold">Alice Smith</div>
                                            <div class="text-muted small">Tech Startup CEO</div>
                                            <div class="d-flex align-items-center small">
                                                <span class="text-warning me-1">★★★★★</span>
                                                <span class="text-muted">4.9 (23 reviews)</span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row g-2 text-center small mb-3">
                                        <div class="col-4">
                                            <div class="fw-bold text-primary">15</div>
                                            <div class="text-muted">Jobs Posted</div>
                                        </div>
                                        <div class="col-4">
                                            <div class="fw-bold text-success">$45K</div>
                                            <div class="text-muted">Total Spent</div>
                                        </div>
                                        <div class="col-4">
                                            <div class="fw-bold text-info">92%</div>
                                            <div class="text-muted">Hire Rate</div>
                                        </div>
                                    </div>

                                    <button class="btn btn-sm btn-outline-primary w-100">
                                        <i class="bi bi-person-lines-fill me-1"></i>View Full Profile
                                    </button>
                                </div>
                            </div>

                            <!-- Earnings Summary -->
                            <div class="card border-0 shadow-sm mb-4">
                                <div class="card-header bg-transparent border-0 p-3">
                                    <h6 class="mb-0">
                                        <i class="bi bi-wallet2 text-primary me-2"></i>Earnings Summary
                                    </h6>
                                </div>
                                <div class="card-body p-3">
                                    <div class="bg-light rounded p-3">
                                        <div class="d-flex justify-content-between mb-2">
                                            <small class="text-muted">Earned & Released:</small>
                                            <span class="fw-bold text-success">$800</span>
                                        </div>
                                        <div class="d-flex justify-content-between mb-2">
                                            <small class="text-muted">Awaiting Review:</small>
                                            <span class="fw-bold text-warning">$600</span>
                                        </div>
                                        <div class="d-flex justify-content-between mb-2">
                                            <small class="text-muted">Remaining Work:</small>
                                            <span class="fw-bold text-primary">$800</span>
                                        </div>
                                        <hr class="my-2">
                                        <div class="d-flex justify-content-between">
                                            <small class="fw-bold">Total Contract:</small>
                                            <span class="fw-bold h6 mb-0 text-dark">$2,200</span>
                                        </div>
                                    </div>

                                    <div class="row g-2 mt-3 text-center">
                                        <div class="col-6">
                                            <div class="text-center">
                                                <div class="fw-bold text-info">45.5</div>
                                                <small class="text-muted">Hours Logged</small>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="text-center">
                                                <div class="fw-bold text-success">$17.8</div>
                                                <small class="text-muted">Hourly Rate</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Activity Timeline -->
                            <div class="card border-0 shadow-sm mb-4">
                                <div class="card-header bg-transparent border-0 p-3">
                                    <h6 class="mb-0">
                                        <i class="bi bi-clock-history text-primary me-2"></i>Recent Activity
                                    </h6>
                                </div>
                                <div class="card-body p-3">
                                    <div class="timeline">
                                        <div class="d-flex gap-3 mb-3">
                                            <div class="bg-success text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 24px; height: 24px; font-size: 0.7rem;">
                                                <i class="bi bi-check"></i>
                                            </div>
                                            <div>
                                                <small class="fw-bold">Milestone 1 Approved</small>
                                                <div class="text-muted small">2 hours ago</div>
                                            </div>
                                        </div>
                                        <div class="d-flex gap-3 mb-3">
                                            <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 24px; height: 24px; font-size: 0.7rem;">
                                                <i class="bi bi-upload"></i>
                                            </div>
                                            <div>
                                                <small class="fw-bold">Work Submitted</small>
                                                <div class="text-muted small">Yesterday</div>
                                            </div>
                                        </div>
                                        <div class="d-flex gap-3 mb-3">
                                            <div class="bg-warning text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 24px; height: 24px; font-size: 0.7rem;">
                                                <i class="bi bi-clock"></i>
                                            </div>
                                            <div>
                                                <small class="fw-bold">Time Logged (8h)</small>
                                                <div class="text-muted small">Yesterday</div>
                                            </div>
                                        </div>
                                        <div class="d-flex gap-3">
                                            <div class="bg-info text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 24px; height: 24px; font-size: 0.7rem;">
                                                <i class="bi bi-handshake"></i>
                                            </div>
                                            <div>
                                                <small class="fw-bold">Contract Started</small>
                                                <div class="text-muted small">3 days ago</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Quick Actions -->
                            <div class="card border-0 shadow-sm">
                                <div class="card-header bg-transparent border-0 p-3">
                                    <h6 class="mb-0">
                                        <i class="bi bi-lightning text-primary me-2"></i>Quick Actions
                                    </h6>
                                </div>
                                <div class="card-body p-3">
                                    <div class="d-grid gap-2">
                                        <button class="btn btn-success btn-sm">
                                            <i class="bi bi-upload me-1"></i>Submit Current Work
                                        </button>
                                        <button class="btn btn-outline-primary btn-sm">
                                            <i class="bi bi-clock me-1"></i>Log Time Entry
                                        </button>
                                        <button class="btn btn-outline-info btn-sm">
                                            <i class="bi bi-file-earmark-arrow-down me-1"></i>Download Resources
                                        </button>
                                        <button class="btn btn-outline-secondary btn-sm">
                                            <i class="bi bi-list-task me-1"></i>View All Projects
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <!-- Submit Work Modal -->
        <div class="modal fade" id="submitWorkModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Submit Work for Milestone 3</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="mb-3">
                                <label for="workTitle" class="form-label">Work Title</label>
                                <input type="text" class="form-control" id="workTitle" value="Backend API Development" placeholder="Brief title for your submission">
                            </div>
                            <div class="mb-3">
                                <label for="workDescription" class="form-label">Work Description</label>
                                <textarea class="form-control" id="workDescription" rows="4" placeholder="Describe what you've completed and any important notes...">- Developed REST API endpoints for product management
- Implemented user authentication with JWT
- Set up MongoDB database with proper indexing
- Added input validation and error handling
- Created API documentation with Swagger</textarea>
                            </div>
                            <div class="mb-3">
                                <label for="fileUpload" class="form-label">Attach Files</label>
                                <input class="form-control" type="file" id="fileUpload" multiple>
                                <div class="form-text">Upload source code, documentation, or any relevant files (max 10MB each)</div>
                            </div>
                            <div class="mb-3">
                                <label for="testingNotes" class="form-label">Testing & Demo Information</label>
                                <textarea class="form-control" id="testingNotes" rows="3" placeholder="Provide testing instructions, demo credentials, or any setup notes...">API endpoints are live at: https://api.example.com
Test credentials: admin@test.com / password123
Postman collection included in attached files</textarea>
                            </div>
                            <div class="mb-3">
                                <label for="timeSpent" class="form-label">Time Spent (hours)</label>
                                <input type="number" class="form-control" id="timeSpent" value="28" step="0.5" min="0">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Save as Draft</button>
                        <button type="button" class="btn btn-primary">Submit for Review</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Time Logging Modal -->
        <div class="modal fade" id="timeLogModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Log Time Entry</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="mb-3">
                                <label for="logDate" class="form-label">Date</label>
                                <input type="date" class="form-control" id="logDate" value="2025-08-18">
                            </div>
                            <div class="mb-3">
                                <label for="logHours" class="form-label">Hours</label>
                                <input type="number" class="form-control" id="logHours" step="0.5" min="0" max="24" placeholder="8">
                            </div>
                            <div class="mb-3">
                                <label for="logDescription" class="form-label">Work Description</label>
                                <textarea class="form-control" id="logDescription" rows="3" placeholder="What did you work on?"></textarea>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary">Log Time</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Submit work functionality
                document.querySelectorAll('button').forEach(btn => {
                    if (btn.textContent.includes('Submit') && !btn.textContent.includes('Submit for Review')) {
                        btn.addEventListener('click', function (e) {
                            e.preventDefault();
                            const modal = new bootstrap.Modal(document.getElementById('submitWorkModal'));
                            modal.show();
                        });
                    }
                });

                // Time logging functionality
                document.querySelectorAll('button').forEach(btn => {
                    if (btn.textContent.includes('Log Time')) {
                        btn.addEventListener('click', function (e) {
                            e.preventDefault();
                            const modal = new bootstrap.Modal(document.getElementById('timeLogModal'));
                            modal.show();
                        });
                    }
                });

                // File upload preview
                document.getElementById('fileUpload').addEventListener('change', function (e) {
                    const files = e.target.files;
                    if (files.length > 0) {
                        console.log(`${files.length} file(s) selected for upload`);
                        // Add file preview logic here
                    }
                });

                // Auto-save drafts
                let saveTimeout;
                document.querySelectorAll('textarea').forEach(textarea => {
                    textarea.addEventListener('input', function () {
                        clearTimeout(saveTimeout);
                        saveTimeout = setTimeout(() => {
                            console.log('Auto-saving draft...', this.value.substring(0, 50) + '...');
                            showNotification('Draft saved automatically', 'info');
                        }, 3000);
                    });
                });

                // Submit work for review
                document.querySelector('#submitWorkModal .btn-primary').addEventListener('click', function () {
                    // Simulate submission
                    const modal = bootstrap.Modal.getInstance(document.getElementById('submitWorkModal'));
                    modal.hide();
                    showNotification('Work submitted successfully! Client will review within 48 hours.', 'success');
                });

                // Time logging submission
                document.querySelector('#timeLogModal .btn-primary').addEventListener('click', function () {
                    const hours = document.getElementById('logHours').value;
                    if (hours) {
                        const modal = bootstrap.Modal.getInstance(document.getElementById('timeLogModal'));
                        modal.hide();
                        showNotification(`${hours} hours logged successfully!`, 'success');

                        // Update total hours display
                        const totalHoursElement = document.querySelector('.h5.text-info');
                        if (totalHoursElement) {
                            const currentHours = parseFloat(totalHoursElement.textContent);
                            const newTotal = currentHours + parseFloat(hours);
                            totalHoursElement.textContent = newTotal.toFixed(1) + 'h';
                        }
                    }
                });

                // Notification system
                function showNotification(message, type = 'info') {
                    const alertDiv = document.createElement('div');
                    alertDiv.className = `alert alert-${type} alert-dismissible fade show position-fixed`;
                    alertDiv.style.cssText = 'top: 20px; right: 20px; z-index: 1050; min-width: 300px;';
                    alertDiv.innerHTML = `
            ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    `;
                    document.body.appendChild(alertDiv);

                    setTimeout(() => {
                        if (alertDiv.parentNode) {
                            alertDiv.remove();
                        }
                    }, 5000);
                }

                // Keyboard shortcuts
                document.addEventListener('keydown', function (e) {
                    // Ctrl + S to submit work
                    if (e.ctrlKey && e.key === 's') {
                        e.preventDefault();
                        const submitBtn = document.querySelector('.btn-success');
                        if (submitBtn && submitBtn.textContent.includes('Submit')) {
                            submitBtn.click();
                        }
                    }
                    // Ctrl + T to log time
                    if (e.ctrlKey && e.key === 't') {
                        e.preventDefault();
                        const timeBtn = document.querySelector('button[data-bs-target="#timeLogModal"]');
                        if (timeBtn)
                            timeBtn.click();
                    }
                });

                // Progress simulation
                function simulateProgress() {
                    const progressBar = document.querySelector('.progress-bar');
                    const progressText = document.querySelector('.text-primary.fw-bold');

                    if (progressBar && progressText) {
                        const currentProgress = parseInt(progressBar.style.width);
                        if (currentProgress < 100) {
                            // Simulate small progress increments
                            const increment = Math.random() * 2;
                            const newProgress = Math.min(100, currentProgress + increment);
                            progressBar.style.width = newProgress + '%';
                            progressText.textContent = Math.round(newProgress) + '%';
                        }
                    }
                }

                // Update progress occasionally
                setInterval(simulateProgress, 30000);

                // Initialize tooltips
                const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
                tooltipTriggerList.map(function (tooltipTriggerEl) {
                    return new bootstrap.Tooltip(tooltipTriggerEl);
                });
            });
        </script>
    </body>
</html>