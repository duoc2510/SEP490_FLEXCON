<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>

<html lang="vi">
    <%@include file="../include/head.jsp" %>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        .btn-shortlisted {
            background-color: #f8f9fa !important;
            border: 1px solid #ffc107 !important;
            color: #856404 !important;
        }

        .btn-shortlisted:hover {
            background-color: #ffc107 !important;
            color: white !important;
        }

        .btn-shortlisted:hover .shortlist-text {
            display: none;
        }

        .btn-shortlisted:hover .unshortlist-text {
            display: inline;
        }

        .unshortlist-text {
            display: none;
        }
    </style>
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
                                <i class="bi bi-briefcase text-warning me-2"></i>Job Management
                            </h2>
                            <p class="text-muted mb-0">Manage your posted jobs, proposals, and project progress</p>
                        </div>
                        <div class="d-flex gap-2">
                            <button class="btn btn-outline-warning">
                                <i class="bi bi-download me-1"></i>Export Report
                            </button>
                            <button class="btn btn-warning text-white">
                                <i class="bi bi-plus-lg me-1"></i>Post New Job
                            </button>
                        </div>
                    </div>

                    <div class="row g-4">
                        <!-- Main Job Management -->
                        <div class="col-12 col-xl-8">
                            <!-- Job Header Card -->
                            <div class="card border-0 shadow-sm mb-4">
                                <div class="card-body p-4">
                                    <div class="d-flex justify-content-between align-items-start mb-3">
                                        <div class="d-flex gap-2">
                                            <span class="badge bg-primary px-3 py-2">
                                                <i class="bi bi-hammer me-1"></i>${jobBidding.job.type}
                                            </span>
                                            <span class="badge bg-success px-3 py-2">
                                                <i class="bi bi-circle-fill me-1" style="font-size: 8px;"></i>${jobBidding.job.status}
                                            </span>
                                        </div>
                                        <div class="dropdown">
                                            <button class="btn btn-outline-secondary btn-sm" data-bs-toggle="dropdown">
                                                <i class="bi bi-three-dots"></i>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li><a class="dropdown-item" href="#"><i class="bi bi-pencil me-2"></i>Edit Job</a></li>
                                                <li><a class="dropdown-item" href="#"><i class="bi bi-copy me-2"></i>Clone Job</a></li>
                                                <li><hr class="dropdown-divider"></li>
                                                <li><a class="dropdown-item text-danger" href="#"><i class="bi bi-trash me-2"></i>Delete Job</a></li>
                                            </ul>
                                        </div>
                                    </div>

                                    <h3 class="h4 mb-2">${jobBidding.job.title}</h3>
                                    <p class="text-muted mb-3">${jobBidding.job.description}</p>

                                    <!-- Job Stats -->
                                    <div class="row g-3 mb-4">
                                        <div class="col-6 col-sm-3">
                                            <div class="text-center p-3 bg-light rounded">
                                                <div class="h5 text-success mb-0">${jobBidding.lowestBidPriceFormatted}-${jobBidding.lowestBudgetFormatted} ${jobBidding.job.currency}</div>
                                                <small class="text-muted">Budget Range</small>
                                            </div>
                                        </div>
                                        <div class="col-6 col-sm-3">
                                            <div class="text-center p-3 bg-light rounded">
                                                <div class="h5 text-primary mb-0">${jobBidding.job.deadlineFormatted}</div>
                                                <small class="text-muted">Application Deadline </small>
                                            </div>
                                        </div>
                                        <div class="col-6 col-sm-3">
                                            <div class="text-center p-3 bg-light rounded">
                                                <div class="h5 text-warning mb-0">${numProposal}</div>
                                                <small class="text-muted">Proposals</small>
                                            </div>
                                        </div>
                                        <div class="col-6 col-sm-3">
                                            <div class="text-center p-3 bg-light rounded">
                                                <div class="h5 text-info mb-0">${jobBidding.job.views}</div>
                                                <small class="text-muted">Views</small>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Quick Actions -->
                                    <div class="d-flex flex-wrap gap-2">
                                        <button class="btn btn-warning text-white">
                                            <i class="bi bi-chat-dots me-1"></i>Message Freelancer
                                        </button>
                                        <button class="btn btn-outline-secondary">
                                            <i class="bi bi-pencil-square me-1"></i>Edit Job
                                        </button>
                                        <button class="btn btn-outline-danger">
                                            <i class="bi bi-pause-circle me-1"></i>Pause Job
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <!-- Proposals Management -->
                            <div class="card border-0 shadow-sm mb-4">
                                <div class="card-header bg-transparent border-0 p-4">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h5 class="mb-0">
                                            <i class="bi bi-people text-warning me-2"></i>Proposals (${numProposal})
                                        </h5>
                                        <div class="d-flex gap-2">
                                            <select class="form-select form-select-sm" style="width: auto;">
                                                <option>All Proposals</option>
                                                <option>Pending Review</option>
                                                <option>Shortlisted</option>
                                                <option>Rejected</option>
                                            </select>
                                            <button class="btn btn-outline-warning btn-sm">
                                                <i class="bi bi-funnel"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body p-0">
                                    <div class="list-group list-group-flush">
                                        <!-- Proposal 1 -->


                                        <c:forEach var="item" items="${listAll}">
                                            <div class="list-group-item border-0 p-4">
                                                <div class="d-flex align-items-start gap-3">
                                                    <img src="https://i.pravatar.cc/50?img=12" class="rounded-circle" width="50" height="50">
                                                    <div class="flex-grow-1">
                                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                                            <div>
                                                                <h6 class="mb-1">${item.jobseeker.fullName}</h6>
                                                                <div class="text-warning small">
                                                                    <i class="bi bi-star-fill"></i>
                                                                    <i class="bi bi-star-fill"></i>
                                                                    <i class="bi bi-star-fill"></i>
                                                                    <i class="bi bi-star-fill"></i>
                                                                    <i class="bi bi-star-fill"></i>
                                                                    <span class="text-muted ms-1">5.0 (47 reviews)</span>
                                                                </div>
                                                            </div>
                                                            <div class="text-end">
                                                                <div class="h6 text-success mb-0">${item.lowestBudgetFormatted} ${item.currency}</div>
                                                                <small class="text-muted">in ${item.durationDays} days</small>
                                                            </div>
                                                        </div>
                                                        <p class="small text-muted mb-3">${item.coverLetter}</p>
                                                        <div class="d-flex justify-content-between align-items-center">
                                                            <div class="d-flex gap-1">

                                                                <span class="badge bg-light text-dark">React</span>
                                                                <span class="badge bg-light text-dark">Node.js</span>
                                                                <span class="badge bg-light text-dark">MongoDB</span>
                                                            </div>
                                                            <div class="d-flex gap-2">
                                                                <button class="btn btn-sm btn-outline-secondary">View Profile</button>
                                                                <c:choose>
                                                                    <c:when test="${item.status == 'SHORTLISTED'}">
                                                                        <button class="btn btn-sm btn-shortlisted" 
                                                                                data-bs-toggle="modal" 
                                                                                data-bs-target="#unshortlistModal"
                                                                                data-proposal-id="${item.id}"
                                                                                data-job-id="${item.job.id}">
                                                                            <span class="shortlist-text">SHORTLISTED</span>
                                                                            <span class="unshortlist-text">Remove from Shortlist</span>
                                                                        </button>

                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <button class="btn btn-sm btn-outline-warning" 
                                                                                data-bs-toggle="modal" 
                                                                                data-bs-target="#shortlistModal" 
                                                                                data-proposal-id="${item.id}"
                                                                                onclick="setShortlistProposal(${item.id}, ${item.job.id})">
                                                                            Add to Shortlist
                                                                        </button>
                                                                    </c:otherwise>
                                                                </c:choose>

                                                                <button class="btn btn-sm btn-success" 
                                                                        data-bs-toggle="modal" 
                                                                        data-bs-target="#confirmModal" 
                                                                        onclick="setProposalId(${item.id}, ${item.job.id})">
                                                                    <i class="bi bi-check2 me-1"></i>Accept
                                                                </button>
                                                                <button class="btn btn-sm btn-outline-danger"

                                                                        data-bs-toggle="modal" 
                                                                        data-bs-target="#rejectModal" 
                                                                        onclick="setProposalId(${item.id}, ${item.job.id})">


                                                                    <i class="bi bi-x me-1"></i>Decline
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>

                                        <div class="modal fade" id="confirmModal" tabindex="-1">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Confirm Accept</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        Are you sure you want to accept this proposal?
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                        <button type="button" class="btn btn-success" onclick="acceptProposal()">Accept</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="modal fade" id="shortlistModal" tabindex="-1">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Add to Shortlist</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        Are you sure you want to add this proposal to shortlist?
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                        <button type="button" class="btn btn-warning" onclick="shortlistProposal()">Add to Shortlist</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal fade" id="unshortlistModal" tabindex="-1">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Remove from Shortlist</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        Are you sure you want to remove this proposal from shortlist?
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                        <button type="button" class="btn btn-warning" onclick="confirmUnshortlist()">Remove from Shortlist</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>



                                        <div class="modal fade" id="rejectModal" tabindex="-1">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Confirm Reject</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        Are you sure you want to reject this proposal?
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                        <button type="button" class="btn btn-outline-danger" onclick="rejectProposal()">Reject</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>










                                        <!-- Proposal 2 -->

                                    </div>

                                    <div class="p-4 border-top">
                                        <button class="btn btn-outline-warning w-100">
                                            <i class="bi bi-plus-circle me-1"></i>View All Proposals (10 more)
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <!-- Milestones & Progress -->
                            <div class="card border-0 shadow-sm mb-4">
                                <div class="card-header bg-transparent border-0 p-4">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h5 class="mb-0">
                                            <i class="bi bi-flag text-warning me-2"></i>Project Milestones
                                        </h5>
                                        <button class="btn btn-outline-warning btn-sm">
                                            <i class="bi bi-plus-circle me-1"></i>Add Milestone
                                        </button>
                                    </div>
                                </div>
                                <div class="card-body p-4">
                                    <!-- Overall Progress -->
                                    <div class="mb-4">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <span class="fw-medium">Overall Progress</span>
                                            <span class="text-warning fw-bold">40%</span>
                                        </div>
                                        <div class="progress mb-2" style="height: 12px;">
                                            <div class="progress-bar bg-warning" style="width: 40%"></div>
                                        </div>
                                        <small class="text-muted">
                                            <i class="bi bi-clock me-1"></i>Last update: Freelancer submitted Milestone 1 deliverables
                                        </small>
                                    </div>

                                    <!-- Milestone List -->
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <div class="card border border-success border-opacity-25 bg-success bg-opacity-10">
                                                <div class="card-body p-3">
                                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                                        <h6 class="mb-0">Milestone 1: UI Design</h6>
                                                        <span class="badge bg-success">Completed</span>
                                                    </div>
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <span class="h6 text-success mb-0">$800</span>
                                                        <button class="btn btn-sm btn-success">
                                                            <i class="bi bi-check-circle me-1"></i>Released
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="card border border-warning border-opacity-25 bg-warning bg-opacity-10">
                                                <div class="card-body p-3">
                                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                                        <h6 class="mb-0">Milestone 2: Backend API</h6>
                                                        <span class="badge bg-warning text-dark">In Progress</span>
                                                    </div>
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <span class="h6 text-warning mb-0">$1,200</span>
                                                        <div class="d-flex gap-1">
                                                            <button class="btn btn-sm btn-warning text-white">Fund</button>
                                                            <button class="btn btn-sm btn-outline-secondary" disabled>Release</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="card border border-secondary border-opacity-25">
                                                <div class="card-body p-3">
                                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                                        <h6 class="mb-0">Milestone 3: Integration</h6>
                                                        <span class="badge bg-secondary">Pending</span>
                                                    </div>
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <span class="h6 text-muted mb-0">$1,000</span>
                                                        <div class="d-flex gap-1">
                                                            <button class="btn btn-sm btn-outline-secondary" disabled>Fund</button>
                                                            <button class="btn btn-sm btn-outline-secondary" disabled>Release</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Communication & Disputes -->
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-header bg-transparent border-0 p-3">
                                            <h6 class="mb-0">
                                                <i class="bi bi-chat-dots text-warning me-2"></i>Communication
                                            </h6>
                                        </div>
                                        <div class="card-body p-3">
                                            <div class="d-flex align-items-center gap-2 mb-3">
                                                <img src="https://i.pravatar.cc/32?img=20" class="rounded-circle" width="32" height="32">
                                                <div class="flex-grow-1">
                                                    <div class="bg-light rounded p-2">
                                                        <small class="fw-bold text-success">Sarah Frontend</small>
                                                        <p class="mb-0 small">Milestone 1 completed. Please review...</p>
                                                    </div>
                                                    <small class="text-muted">2 hours ago</small>
                                                </div>
                                            </div>
                                            <button class="btn btn-warning text-white btn-sm w-100">
                                                <i class="bi bi-reply me-1"></i>Reply to Message
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-header bg-transparent border-0 p-3">
                                            <h6 class="mb-0">
                                                <i class="bi bi-shield-exclamation text-warning me-2"></i>Dispute Management
                                            </h6>
                                        </div>
                                        <div class="card-body p-3">
                                            <div class="text-center py-3">
                                                <i class="bi bi-check-circle text-success fs-2 mb-2"></i>
                                                <p class="text-muted small mb-3">No active disputes for this job</p>
                                                <button class="btn btn-outline-danger btn-sm">
                                                    <i class="bi bi-exclamation-triangle me-1"></i>Report Issue
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Right Sidebar -->
                        <div class="col-12 col-xl-4">
                            <!-- Job Summary -->
                            <div class="card border-0 shadow-sm mb-4">
                                <div class="card-header bg-transparent border-0 p-3">
                                    <h6 class="mb-0">
                                        <i class="bi bi-info-circle text-warning me-2"></i>Job Summary
                                    </h6>
                                </div>
                                <div class="card-body p-3">
                                    <div class="row g-2 mb-3">
                                        <div class="col-6">
                                            <small class="text-muted">Job ID</small>
                                            <div class="fw-bold">#${jobBidding.job.id}</div>
                                        </div>
                                        <div class="col-6">
                                            <small class="text-muted">Mode Select</small>
                                            <div class="fw-bold">${jobBidding.selectionMode}</div>
                                        </div>
                                        <div class="col-6">
                                            <small class="text-muted">Deviation</small>
                                            <div class="fw-bold">${jobBidding.bidDeviationPct}%</div>
                                        </div>
                                        <div class="col-6">
                                            <small class="text-muted">Posted</small>
                                            <div class="fw-bold">${jobBidding.job.createdAtFormatted}</div>
                                        </div>
                                    </div>


                                    <div class="bg-light rounded p-3">
                                        <div class="d-flex justify-content-between mb-1">
                                            <small class="text-muted">Escrow Balance:</small>
                                            <span class="fw-bold text-success">$800</span>
                                        </div>
                                        <div class="d-flex justify-content-between mb-1">
                                            <small class="text-muted">Pending Release:</small>
                                            <span class="fw-bold text-warning">$1,200</span>
                                        </div>
                                        <div class="d-flex justify-content-between">
                                            <small class="text-muted">Total Budget:</small>
                                            <span class="fw-bold">$3,000</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Activity Timeline -->
                            <div class="card border-0 shadow-sm mb-4">
                                <div class="card-header bg-transparent border-0 p-3">
                                    <h6 class="mb-0">
                                        <i class="bi bi-clock-history text-warning me-2"></i>Recent Activity
                                    </h6>
                                </div>
                                <div class="card-body p-3">
                                    <div class="timeline">
                                        <div class="d-flex gap-3 mb-3">
                                            <div class="bg-success text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 24px; height: 24px; font-size: 0.7rem;">
                                                <i class="bi bi-check"></i>
                                            </div>
                                            <div>
                                                <small class="fw-bold">Milestone 1 Completed</small>
                                                <div class="text-muted small">2 hours ago</div>
                                            </div>
                                        </div>
                                        <div class="d-flex gap-3 mb-3">
                                            <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 24px; height: 24px; font-size: 0.7rem;">
                                                <i class="bi bi-person"></i>
                                            </div>
                                            <div>
                                                <small class="fw-bold">Freelancer Hired</small>
                                                <div class="text-muted small">3 days ago</div>
                                            </div>
                                        </div>
                                        <div class="d-flex gap-3 mb-3">
                                            <div class="bg-warning text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 24px; height: 24px; font-size: 0.7rem;">
                                                <i class="bi bi-cash"></i>
                                            </div>
                                            <div>
                                                <small class="fw-bold">Milestone 1 Funded</small>
                                                <div class="text-muted small">4 days ago</div>
                                            </div>
                                        </div>
                                        <div class="d-flex gap-3">
                                            <div class="bg-info text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 24px; height: 24px; font-size: 0.7rem;">
                                                <i class="bi bi-plus"></i>
                                            </div>
                                            <div>
                                                <small class="fw-bold">Job Posted</small>
                                                <div class="text-muted small">5 days ago</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Quick Actions -->
                            <div class="card border-0 shadow-sm">
                                <div class="card-header bg-transparent border-0 p-3">
                                    <h6 class="mb-0">
                                        <i class="bi bi-lightning text-warning me-2"></i>Quick Actions
                                    </h6>
                                </div>
                                <div class="card-body p-3">
                                    <div class="d-grid gap-2">
                                        <button class="btn btn-warning text-white btn-sm">
                                            <i class="bi bi-plus-circle me-1"></i>Create Similar Job
                                        </button>
                                        <button class="btn btn-outline-secondary btn-sm">
                                            <i class="bi bi-list-task me-1"></i>View All My Jobs
                                        </button>
                                        <button class="btn btn-outline-info btn-sm">
                                            <i class="bi bi-graph-up me-1"></i>Job Analytics
                                        </button>
                                        <button class="btn btn-outline-success btn-sm">
                                            <i class="bi bi-wallet2 me-1"></i>Manage Escrow
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        <script>
                                                            // === TOASTR CONFIGURATION ===
                                                            toastr.options = {
                                                                "closeButton": true,
                                                                "progressBar": true,
                                                                "positionClass": "toast-top-right",
                                                                "timeOut": "4000",
                                                                "extendedTimeOut": "1000",
                                                                "showEasing": "swing",
                                                                "hideEasing": "linear",
                                                                "showMethod": "fadeIn",
                                                                "hideMethod": "fadeOut"
                                                            };

                                                            // === HANDLE FLASH MESSAGES FROM REDIRECT ===
                                                            $(document).ready(function () {
            <c:if test="${not empty success}">
                                                                toastr.success('${success}');
            </c:if>

            <c:if test="${not empty error}">
                                                                toastr.error('${error}');
            </c:if>

            <c:if test="${not empty warning}">
                                                                toastr.warning('${warning}');
            </c:if>

            <c:if test="${not empty info}">
                                                                toastr.info('${info}');
            </c:if>
                                                            });

                                                            // === EXISTING JAVASCRIPT FUNCTIONS ===
                                                            let selectedProposalId;
                                                            let selectedJobId;
                                                            function setProposalId(id, jobID) {
                                                                selectedProposalId = id;
                                                                selectedJobId = jobID;
                                                                console.log('Set ID:', id);
                                                                console.log('Job ID:', jobID);
                                                            }

                                                            function acceptProposal() {
                                                                console.log('Accept clicked, ID:', selectedProposalId);
                                                                // Direct redirect without modal hide
                                                                if (selectedProposalId) {
                                                                    window.location.href = "/employer/job/accept?id=" + selectedProposalId + "&idJob=" + selectedJobId;
                                                                } else {
                                                                    alert('No proposal selected');
                                                                }
                                                            }

                                                            function rejectProposal() {
                                                                if (!selectedProposalId) {
                                                                    alert('No proposal selected');
                                                                    return;
                                                                }

                                                                const rejectButton = document.querySelector('#rejectModal .btn-outline-danger');
                                                                const originalText = rejectButton.innerHTML;
                                                                rejectButton.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span>Rejecting...';
                                                                rejectButton.disabled = true;

                                                                fetch('/employer/job/reject', {
                                                                    method: 'POST',
                                                                    headers: {
                                                                        'Content-Type': 'application/x-www-form-urlencoded',
                                                                    },
                                                                    body: 'id=' + selectedProposalId + '&idJob=' + selectedJobId
                                                                })
                                                                        .then(response => {
                                                                            // Close modal
                                                                            $('#rejectModal').modal('hide');
                                                                            setTimeout(() => {
                                                                                $('.modal-backdrop').remove();
                                                                                $('body').removeClass('modal-open').removeAttr('style');
                                                                            }, 150);

                                                                            if (response.ok) {
                                                                                updateProposalAsRejected(selectedProposalId);
                                                                                toastr.success('Proposal rejected successfully!');
                                                                            } else {
                                                                                console.log('❌ Error status:', response.status);
                                                                                toastr.error('Error rejecting proposal');
                                                                            }
                                                                        })
                                                                        .catch(error => {
                                                                            console.error('💥 Error:', error);
                                                                            $('#rejectModal').modal('hide');
                                                                            setTimeout(() => {
                                                                                $('.modal-backdrop').remove();
                                                                                $('body').removeClass('modal-open').removeAttr('style');
                                                                            }, 150);
                                                                            toastr.error('Error occurred while rejecting proposal');
                                                                        })
                                                                        .finally(() => {
                                                                            rejectButton.innerHTML = originalText;
                                                                            rejectButton.disabled = false;
                                                                        });
                                                            }

                                                            function updateProposalAsRejected(proposalId) {
                                                                console.log('Trying to hide proposal:', proposalId);

                                                                // Debug: Kiểm tra tất cả buttons
                                                                document.querySelectorAll('[data-proposal-id]').forEach(btn => {
                                                                    console.log('Found button ID:', btn.getAttribute('data-proposal-id'));
                                                                    if (btn.getAttribute('data-proposal-id') == proposalId) {
                                                                        const container = btn.closest('.list-group-item');
                                                                        console.log('Found container:', container);
                                                                        if (container) {
                                                                            container.remove(); // Remove luôn khỏi DOM
                                                                            console.log('✅ Removed proposal');
                                                                        }
                                                                    }
                                                                });
                                                            }

                                                            let shortlistProposalId;
                                                            let shortlistJobId;
                                                            function setShortlistProposal(id, jobId) {
                                                                shortlistProposalId = id;
                                                                shortlistJobId = jobId;
                                                            }

                                                            function shortlistProposal() {
                                                                if (shortlistProposalId) {
                                                                    fetch('/employer/job/shortlist', {
                                                                        method: 'POST',
                                                                        headers: {
                                                                            'Content-Type': 'application/x-www-form-urlencoded',
                                                                        },
                                                                        body: 'id=' + shortlistProposalId + '&idJob=' + shortlistJobId
                                                                    })
                                                                            .then(response => response.json())
                                                                            .then(data => {
                                                                                // ✅ Properly close modal
                                                                                $('#shortlistModal').modal('hide');
                                                                                setTimeout(() => {
                                                                                    $('.modal-backdrop').remove();
                                                                                    $('body').removeClass('modal-open').removeAttr('style');
                                                                                }, 150);
                                                                                if (data.success) {
                                                                                    toastr.success('Đã proposal vào danh sách rút gọn thành công!');
                                                                                    updateButtonToShortlisted(shortlistProposalId);
                                                                                } else {
                                                                                    toastr.error('Error: ' + data.message);
                                                                                }
                                                                            })
                                                                            .catch(error => {
                                                                                $('#shortlistModal').modal('hide');
                                                                                setTimeout(() => {
                                                                                    $('.modal-backdrop').remove();
                                                                                    $('body').removeClass('modal-open').removeAttr('style');
                                                                                }, 150);
                                                                                toastr.error('Error occurred while adding to shortlist');
                                                                            });
                                                                }
                                                            }

                                                            let unshortlistProposalId;
                                                            let unshortlistJobId;

                                                            // ✅ Function để set unshortlist proposal (gọi khi click button)
                                                            function setUnshortlistProposal(id, jobId) {
                                                                unshortlistProposalId = id;
                                                                unshortlistJobId = jobId;
                                                                console.log('Set Unshortlist ID:', id);
                                                                console.log('Unshortlist Job ID:', jobId);
                                                            }

                                                            function confirmUnshortlist() {
                                                                if (unshortlistProposalId) {
                                                                    // Close modal first
                                                                    $('#unshortlistModal').modal('hide');
                                                                    setTimeout(() => {
                                                                        $('.modal-backdrop').remove();
                                                                        $('body').removeClass('modal-open').removeAttr('style');
                                                                    }, 150);

                                                                    // Call actual unshortlist function
                                                                    unshortlistProposal(unshortlistProposalId, unshortlistJobId);
                                                                }
                                                            }

                                                            // ✅ Function để unshortlist
                                                            function unshortlistProposal(proposalId, jobId) {
                                                                fetch('/employer/job/unshortlist', {
                                                                    method: 'POST',
                                                                    headers: {
                                                                        'Content-Type': 'application/x-www-form-urlencoded',
                                                                    },
                                                                    body: 'id=' + proposalId + '&idJob=' + jobId
                                                                })
                                                                        .then(response => response.json())
                                                                        .then(data => {
                                                                            if (data.success) {
                                                                                toastr.info('Proposal bị xóa khỏi danh sách rút gọn');
                                                                                updateButtonToNormal(proposalId);
                                                                            } else {
                                                                                toastr.error('Error: ' + data.message);
                                                                            }
                                                                        })
                                                                        .catch(error => {
                                                                            toastr.error('Error occurred while removing from shortlist');
                                                                        });
                                                            }

                                                            // ✅ Update button to SHORTLISTED state
                                                            function updateButtonToShortlisted(proposalId) {
                                                                let button = $('button[data-proposal-id="' + proposalId + '"]');
                                                                button.removeClass('btn-outline-warning')
                                                                        .addClass('btn-shortlisted')
                                                                        .attr('onclick', 'unshortlistProposal(' + proposalId + ', ' + shortlistJobId + ')')
                                                                        .removeAttr('data-bs-toggle data-bs-target')
                                                                        .html('<span class="shortlist-text">SHORTLISTED</span><span class="unshortlist-text">UnShortlist</span>');
                                                            }

                                                            // ✅ Update button to normal state
                                                            function updateButtonToNormal(proposalId) {
                                                                let button = $('button[data-proposal-id="' + proposalId + '"]');
                                                                button.removeClass('btn-shortlisted')
                                                                        .addClass('btn-outline-warning')
                                                                        .attr('data-bs-toggle', 'modal')
                                                                        .attr('data-bs-target', '#shortlistModal')
                                                                        .attr('onclick', 'setShortlistProposal(' + proposalId + ', ' + shortlistJobId + ')')
                                                                        .text('Add to Shortlist');
                                                            }

                                                            $('#unshortlistModal').on('show.bs.modal', function (event) {
                                                                const button = event.relatedTarget;
                                                                unshortlistProposalId = button.getAttribute('data-proposal-id');
                                                                unshortlistJobId = button.getAttribute('data-job-id');
                                                                console.log('Modal will show for:', unshortlistProposalId, unshortlistJobId);
                                                            });

        </script>
    </body>
</html>