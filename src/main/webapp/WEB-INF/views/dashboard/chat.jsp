<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url value="/ws" var="wsUrl"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat Test</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
    <style>
        .job-item {
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .job-item:hover {
            background-color: #f8f9fa !important;
            transform: translateX(2px);
        }

        .job-item.active {
            background-color: #e3f2fd !important;
            border-left: 4px solid #2196f3;
        }

        .online-indicator {
            position: absolute;
            bottom: 2px;
            right: 2px;
            width: 12px;
            height: 12px;
            background-color: #6c757d;
            border: 2px solid white;
            border-radius: 50%;
        }

        .online-indicator.online {
            background-color: #28a745;
        }

        .cursor-pointer {
            cursor: pointer;
        }

        .min-width-0 {
            min-width: 0;
        }

        .job-list::-webkit-scrollbar {
            width: 4px;
        }

        .job-list::-webkit-scrollbar-track {
            background: #f1f1f1;
        }

        .job-list::-webkit-scrollbar-thumb {
            background: #c1c1c1;
            border-radius: 2px;
        }

        .job-list::-webkit-scrollbar-thumb:hover {
            background: #a8a8a8;
        }

        #chatBox::-webkit-scrollbar {
            width: 6px;
        }

        #chatBox::-webkit-scrollbar-track {
            background: #f1f1f1;
        }

        #chatBox::-webkit-scrollbar-thumb {
            background: #c1c1c1;
            border-radius: 3px;
        }

        #chatBox::-webkit-scrollbar-thumb:hover {
            background: #a8a8a8;
        }

        @media (max-width: 991.98px) {
            .job-list {
                height: 300px;
            }
        }

        .empty-state {
            transition: all 0.4s ease;
        }

        .empty-state:hover {
            transform: translateY(-2px);
        }

        .chat-header-card {
            background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
            border-bottom: 1px solid #e3f2fd !important;
        }

        .sidebar-gradient {
            background: linear-gradient(180deg, #ffffff 0%, #f8f9fa 100%);
        }

        .project-avatar {
            background: linear-gradient(135deg, #2196f3 0%, #1976d2 100%);
            box-shadow: 0 2px 8px rgba(33, 150, 243, 0.3);
        }

        .loading-spinner {
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body style="background: linear-gradient(135deg, #fff5f0 0%, #ffffff 100%); min-height: 100vh;">
    <div class="container-fluid">
        <div class="row g-0 min-vh-100">
            <!-- Left Sidebar - Job List -->
            <div class="col-12 col-lg-3 border-end sidebar-gradient">
                <!-- Header -->
                <div class="p-4 border-bottom">
                    <h5 class="mb-1 d-flex align-items-center">
                        <i class="bi bi-chat-dots text-primary me-2"></i>
                        Project Chats
                    </h5>
                    <small class="text-muted">Select a project to start chatting</small>
                </div>

                <!-- Search Bar -->
                <div class="p-3 border-bottom">
                    <div class="input-group input-group-sm">
                        <span class="input-group-text bg-light border-0">
                            <i class="bi bi-search text-muted"></i>
                        </span>
                        <input type="text" class="form-control border-0 bg-light" placeholder="Search projects..." id="searchJobs">
                    </div>
                </div>

                <!-- Job List -->
                <div id="jobList" class="job-list" style="height: calc(100vh - 160px); overflow-y: auto;">
                    <!-- Loading state - will be replaced by actual data -->
                    <div class="p-4 text-center empty-state">
                        <div class="loading-spinner text-primary mb-3">
                            <i class="bi bi-arrow-clockwise fs-3"></i>
                        </div>
                        <p class="text-muted mb-0">Loading projects...</p>
                    </div>
                </div>
            </div>

            <!-- Main Content - Chat Interface -->
            <div class="col-12 col-lg-6 d-flex flex-column">
                <!-- Chat Header -->
                <div class="p-4 border-bottom chat-header-card">
                    <!-- No Job Selected State -->
                    <div id="noJobSelected" class="text-center py-4 empty-state">
                        <div class="bg-light text-muted rounded-circle d-flex align-items-center justify-content-center mx-auto mb-3" style="width: 60px; height: 60px;">
                            <i class="bi bi-chat-square-text fs-3"></i>
                        </div>
                        <h5 class="text-muted mb-2">No Project Selected</h5>
                        <p class="text-muted mb-0 small">Choose a project from the left sidebar to start chatting</p>
                    </div>
                    
                    <!-- Job Selected State -->
                    <div id="jobSelected" class="d-none">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <div class="project-avatar text-white rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 50px; height: 50px;">
                                    <i class="bi bi-briefcase fs-5"></i>
                                </div>
                                <div>
                                    <h5 class="mb-0" id="currentJobTitle">Project Name</h5>
                                    <small class="text-muted" id="currentClient">with Client</small>
                                    <div class="d-flex align-items-center mt-1">
                                        <span id="connectionStatus" class="badge bg-secondary">
                                            <i class="bi bi-circle-fill me-1" style="font-size: 8px;"></i>Disconnected
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="d-flex gap-2">
                                <button class="btn btn-outline-primary btn-sm" title="Voice Call">
                                    <i class="bi bi-telephone"></i>
                                </button>
                                <button class="btn btn-outline-primary btn-sm" title="Video Call">
                                    <i class="bi bi-camera-video"></i>
                                </button>
                                <button class="btn btn-outline-primary btn-sm" title="Project Info">
                                    <i class="bi bi-info-circle"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Chat Messages -->
                <div class="flex-grow-1 d-flex flex-column" style="height: calc(100vh - 160px);">
                    <div id="chatBox" class="flex-grow-1 p-4" style="height: 400px; overflow-y: auto; background: #fafafa;">
                        <div class="text-center text-muted d-flex flex-column justify-content-center empty-state" style="height: 100%;">
                            <div>
                                <i class="bi bi-arrow-left fs-1 mb-3 text-muted opacity-50"></i>
                                <h5 class="text-muted mb-2">Select a Project</h5>
                                <p class="mb-0 small">Choose a project from the sidebar to start chatting with your client</p>
                            </div>
                        </div>
                    </div>

                    <!-- Message Input -->
                    <div class="border-top p-3 bg-white">
                        <div class="input-group">
                            <button class="btn btn-outline-secondary" type="button" title="Attach File">
                                <i class="bi bi-paperclip"></i>
                            </button>
                            <input type="text" class="form-control" id="messageInput" placeholder="Type your message..." onkeypress="if(event.key==='Enter') sendMessage()">
                            <button class="btn btn-outline-secondary" type="button" title="Add Emoji">
                                <i class="bi bi-emoji-smile"></i>
                            </button>
                            <button class="btn btn-primary" onclick="sendMessage()" title="Send Message">
                                <i class="bi bi-send"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <input type="hidden" id="jobId" value="${initJobId != null ? initJobId : ''}">
            <input type="hidden" id="recipientId" value="${initRecipientId != null ? initRecipientId : ''}">

            <!-- Right Sidebar -->
            <div class="col-12 col-lg-3 border-start sidebar-gradient">
                <!-- Project Details -->
                <div class="p-4 border-bottom">
                    <h6 class="mb-3">
                        <i class="bi bi-info-circle text-primary me-2"></i>Project Details
                    </h6>
                    
                    <!-- No Project Selected -->
                    <div id="noProjectDetails" class="text-center py-4 empty-state">
                        <div class="bg-light text-muted rounded-circle d-flex align-items-center justify-content-center mx-auto mb-3" style="width: 45px; height: 45px;">
                            <i class="bi bi-folder-x"></i>
                        </div>
                        <small class="text-muted">No project selected</small>
                    </div>

                    <!-- Project Selected -->
                    <div id="projectDetails" class="project-info d-none">
                        <div class="mb-3">
                            <small class="text-muted d-block">Status</small>
                            <span class="badge bg-success">Active</span>
                        </div>
                        <div class="mb-3">
                            <small class="text-muted d-block">Priority</small>
                            <span class="badge bg-warning text-dark">High</span>
                        </div>
                        <div class="mb-3">
                            <small class="text-muted d-block">Deadline</small>
                            <span class="text-dark">
                                <i class="bi bi-calendar-event text-primary me-1"></i>
                                Dec 31, 2024
                            </span>
                        </div>
                        <div class="mb-3">
                            <small class="text-muted d-block">Progress</small>
                            <div class="progress" style="height: 6px;">
                                <div class="progress-bar bg-primary" role="progressbar" style="width: 75%"></div>
                            </div>
                            <small class="text-muted">75% Complete</small>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="p-4 border-bottom">
                    <h6 class="mb-3">
                        <i class="bi bi-lightning text-primary me-2"></i>Quick Actions
                    </h6>
                    <div class="d-grid gap-2">
                        <button class="btn btn-outline-success btn-sm">
                            <i class="bi bi-file-earmark-arrow-up me-1"></i>Send File
                        </button>
                        <button class="btn btn-outline-info btn-sm">
                            <i class="bi bi-camera me-1"></i>Send Image
                        </button>
                        <button class="btn btn-outline-warning btn-sm">
                            <i class="bi bi-calendar-event me-1"></i>Schedule Meeting
                        </button>
                        <button class="btn btn-outline-danger btn-sm" onclick="clearChat()">
                            <i class="bi bi-trash me-1"></i>Clear Chat
                        </button>
                    </div>
                </div>

                <!-- Chat Statistics -->
                <div class="p-4">
                    <h6 class="mb-3">
                        <i class="bi bi-graph-up text-primary me-2"></i>Chat Stats
                    </h6>
                    <div class="bg-white rounded-3 p-3 border">
                        <div class="d-flex justify-content-between mb-2">
                            <small class="text-muted">Messages Sent:</small>
                            <span class="fw-bold text-primary" id="messagesSent">0</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <small class="text-muted">Messages Received:</small>
                            <span class="fw-bold text-success" id="messagesReceived">0</span>
                        </div>
                        <div class="d-flex justify-content-between">
                            <small class="text-muted">Current Room:</small>
                            <span class="fw-bold text-info" id="currentRoom">None</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    // ====== JSTL -> JS (an toàn) ======
    var CTX               = '<c:out value="${pageContext.request.contextPath}"/>';
    var WS_TOKEN          = '<c:out value="${wsToken}"/>';
    var CURRENT_USER_ID = '<c:out value="${sessionScope.currentUser.id}" default=""/>';
    var CURRENT_PARTNER_NAME = ""; // tên đối phương của phòng đang mở

    // ====== GLOBALS ======
    var authHeader = 'Bearer ' + WS_TOKEN;
    var stompClient = null;
    var connected = false;
    var sub = null;
    var messagesSentCount = 0;
    var messagesReceivedCount = 0;

    // ====== UI HELPERS ======
    function updateConnectionStatus(status) {
        var el = document.getElementById('connectionStatus');
        if (!el) return;
        if (status === 'connected') {
            el.className = 'badge bg-success';
            el.innerHTML = '<i class="bi bi-circle-fill me-1" style="font-size: 8px;"></i>Connected';
        } else if (status === 'connecting') {
            el.className = 'badge bg-warning';
            el.innerHTML = '<i class="bi bi-circle-fill me-1" style="font-size: 8px;"></i>Connecting';
        } else {
            el.className = 'badge bg-danger';
            el.innerHTML = '<i class="bi bi-circle-fill me-1" style="font-size: 8px;"></i>Error';
        }
    }

    function showNotification(message, type) {
        if (!type) type = 'info';
        var alertDiv = document.createElement('div');
        alertDiv.className = 'alert alert-' + type + ' alert-dismissible fade show position-fixed';
        alertDiv.style.cssText = 'top:20px;right:20px;z-index:1050;min-width:300px;';
        alertDiv.innerHTML = message + '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
        document.body.appendChild(alertDiv);
        setTimeout(function(){ if (alertDiv && alertDiv.parentNode) alertDiv.remove(); }, 5000);
    }

    function updateStats() {
        var sent = document.getElementById('messagesSent');
        var recv = document.getElementById('messagesReceived');
        if (sent) sent.textContent = messagesSentCount;
        if (recv) recv.textContent = messagesReceivedCount;
    }

    // "X: text" -> {who, text}
    function splitLabelMessage(s) {
        var idx = s.indexOf(': ');
        if (idx === -1) return { who: '', text: s };
        return { who: s.slice(0, idx), text: s.slice(idx + 2) };
    }

    function showMessage(message, type) {
        if (!type) type = 'received';
        var chatBox = document.getElementById('chatBox');
        if (!chatBox) return;

        var placeholder = chatBox.querySelector('.text-center.text-muted');
        if (placeholder) chatBox.innerHTML = '';

        var messageDiv = document.createElement('div');
        messageDiv.className = 'mb-3';
        var currentTime = new Date().toLocaleTimeString();
        var parsed = splitLabelMessage(message);

        if (type === 'sent') {
            messageDiv.innerHTML =
                '<div class="d-flex justify-content-end">' +
                '<div class="bg-primary text-white rounded-3 p-3 shadow-sm" style="max-width:75%;">' +
                '<div class="fw-medium mb-1">You</div>' +
                '<div>' + (parsed.text || message) + '</div>' +
                '<small class="text-light opacity-75">' + currentTime + '</small>' +
                '</div>' +
                '</div>';
        } else if (type === 'received') {
            messageDiv.innerHTML =
                '<div class="d-flex justify-content-start">' +
                '<div class="bg-white rounded-3 p-3 border shadow-sm" style="max-width:75%;">' +
                '<div class="fw-medium mb-1 text-primary">' + (parsed.who || 'Partner') + '</div>' +
                '<div>' + (parsed.text || message) + '</div>' +
                '<small class="text-muted">' + currentTime + '</small>' +
                '</div>' +
                '</div>';
        } else {
            messageDiv.innerHTML =
                '<div class="d-flex justify-content-center">' +
                '<div class="bg-secondary bg-opacity-10 text-muted rounded-3 p-2 small">' +
                message +
                '</div>' +
                '</div>';
        }

        chatBox.appendChild(messageDiv);
        chatBox.scrollTop = chatBox.scrollHeight;
    }

    // ====== SELECT JOB ITEM ======
    function selectJob(jobId, jobTitle, clientName, partnerId, el) {
        // highlight
        var items = document.querySelectorAll('.job-item');
        for (var i = 0; i < items.length; i++) items[i].classList.remove('active');
        if (el) el.classList.add('active');

        // Show selected states, hide empty states
        var noJobSelected = document.getElementById('noJobSelected');
        var jobSelected = document.getElementById('jobSelected');
        var noProjectDetails = document.getElementById('noProjectDetails');
        var projectDetails = document.getElementById('projectDetails');
        
        if (noJobSelected) noJobSelected.classList.add('d-none');
        if (jobSelected) jobSelected.classList.remove('d-none');
        if (noProjectDetails) noProjectDetails.classList.add('d-none');
        if (projectDetails) projectDetails.classList.remove('d-none');

        // ép số
        var jid = Number(jobId);
        var rid = Number(partnerId);
        if (!Number.isFinite(jid)) {
            alert('Job ID không hợp lệ');
            return;
        }

        // set hidden inputs (server đọc Long)
        var jobInp = document.getElementById('jobId');
        var recInp = document.getElementById('recipientId');
        if (jobInp) jobInp.value = String(jid);
        if (recInp && !Number.isNaN(rid)) recInp.value = String(rid);

        // lưu tên đối tác để hiển thị tin nhắn inbound
        CURRENT_PARTNER_NAME = clientName || 'Partner';

        // cập nhật nhãn
        var titleEl = document.getElementById('currentJobTitle');
        var clientEl = document.getElementById('currentClient');
        var roomEl = document.getElementById('currentRoom');
        if (titleEl)  titleEl.textContent = jobTitle;
        if (clientEl) clientEl.textContent = 'with ' + CURRENT_PARTNER_NAME;
        if (roomEl)   roomEl.textContent = 'Job #' + jid;

        // placeholder chat with loading spinner
        var chatBox = document.getElementById('chatBox');
        if (chatBox) {
            chatBox.innerHTML =
                '<div class="text-center text-muted d-flex flex-column justify-content-center" style="height: 100%;">' +
                '<div>' +
                '<div class="loading-spinner text-primary mb-3">' +
                '<i class="bi bi-arrow-clockwise fs-1"></i>' +
                '</div>' +
                '<h5 class="text-muted mb-2">Loading Chat</h5>' +
                '<p class="mb-0 small">Loading conversation for ' + jobTitle + '...</p>' +
                '</div>' +
                '</div>';
        }

        if (connected) joinJob();
    }

    // ====== LOAD CHAT ITEMS (CONTRACTS) ======
    function loadChatItems() {
        fetch(CTX + '/api/chat/items')
            .then(function(r){ return r.json(); })
            .then(function(items){ renderChatItems(items); })
            .catch(function(err){
                console.error('Load items error:', err);
                var jobList = document.getElementById('jobList');
                if (jobList) {
                    jobList.innerHTML = 
                        '<div class="p-4 text-center empty-state">' +
                        '<div class="bg-light text-muted rounded-circle d-flex align-items-center justify-content-center mx-auto mb-3" style="width: 50px; height: 50px;">' +
                        '<i class="bi bi-exclamation-triangle"></i>' +
                        '</div>' +
                        '<p class="text-muted mb-0 small">Unable to load projects</p>' +
                        '</div>';
                }
            });
    }

    function renderChatItems(items) {
        var wrap = document.getElementById('jobList');
        if (!wrap) return;
        wrap.innerHTML = '';

        if (!items || items.length === 0) {
            wrap.innerHTML = 
                '<div class="p-4 text-center empty-state">' +
                '<div class="bg-light text-muted rounded-circle d-flex align-items-center justify-content-center mx-auto mb-3" style="width: 50px; height: 50px;">' +
                '<i class="bi bi-folder-x fs-4"></i>' +
                '</div>' +
                '<h6 class="text-muted mb-2">No Projects</h6>' +
                '<p class="text-muted mb-0 small">You don\'t have any chat rooms yet.</p>' +
                '</div>';
            return;
        }

        for (var i = 0; i < items.length; i++) {
            var it = items[i];
            var title = it.jobTitle ? it.jobTitle : ('Job #' + it.jobId);
            var partner = it.partnerName ? it.partnerName : 'Partner';
            var isOnline = Math.random() > 0.5; // Random online status for demo

            var el = document.createElement('div');
            el.className = 'job-item p-3 border-bottom position-relative cursor-pointer';
            el.innerHTML =
                '<div class="d-flex align-items-start">' +
                '<div class="flex-shrink-0 me-3 position-relative">' +
                '<div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 45px; height: 45px;">' +
                '<i class="bi bi-briefcase"></i>' +
                '</div>' +
                (isOnline ? '<div class="online-indicator online"></div>' : '<div class="online-indicator"></div>') +
                '</div>' +
                '<div class="flex-grow-1 min-width-0">' +
                '<div class="d-flex justify-content-between align-items-start mb-1">' +
                '<h6 class="mb-0 text-truncate fw-semibold">' + title + '</h6>' +
                '<small class="text-muted">' + Math.floor(Math.random() * 60 + 1) + 'm</small>' +
                '</div>' +
                '<p class="mb-1 text-muted small text-truncate">Last message preview...</p>' +
                '<small class="text-muted">with ' + partner + '</small>' +
                '</div>' +
                '</div>';

            (function(jobId, jobTitle, partnerName, partnerId, node){
                node.addEventListener('click', function(){
                    selectJob(jobId, jobTitle, partnerName, partnerId, node);
                });
            })(it.jobId, title, partner, it.partnerId, el);

            wrap.appendChild(el);
        }
    }

    // ====== CLEAR CHAT ======
    function clearChat() {
        var chatBox = document.getElementById('chatBox');
        if (chatBox) {
            chatBox.innerHTML = 
                '<div class="text-center text-muted d-flex flex-column justify-content-center empty-state" style="height: 100%;">' +
                '<div>' +
                '<i class="bi bi-chat-text fs-1 mb-3 text-muted opacity-50"></i>' +
                '<h5 class="text-muted mb-2">Chat Cleared</h5>' +
                '<p class="mb-0 small">All messages have been cleared from this view</p>' +
                '</div>' +
                '</div>';
        }
        messagesSentCount = 0;
        messagesReceivedCount = 0;
        updateStats();
        showNotification('Chat history cleared', 'info');
    }

    // ====== STOMP / WEBSOCKET ======
    function connect() {
        var socket = new SockJS(CTX + '/ws');
        stompClient = Stomp.over(socket);

        if (!authHeader || authHeader.slice(-4) === 'null' || authHeader.slice(-9) === 'undefined') {
            showNotification('Thiếu JWT – kiểm tra controller sinh token hoặc login lại trước khi vào /chat', 'danger');
            return;
        }

        updateConnectionStatus('connecting');

        stompClient.connect(
            { Authorization: authHeader },
            function(frame) {
                connected = true;

                // Nếu server set "user-name" trong CONNECTED headers
                try {
                    var frameUser = frame && frame.headers && frame.headers['user-name'];
                    if (frameUser) CURRENT_USER_ID = frameUser;
                } catch(e) {}

                updateConnectionStatus('connected');

                // join phòng nếu đã có jobId
                var jidInput = document.getElementById('jobId');
                if (jidInput && jidInput.value && jidInput.value.trim()) {
                    joinJob();
                }
            },
            function(err) {
                connected = false;
                console.error('Connection error:', err);
                updateConnectionStatus('error');
            }
        );
    }

    function joinJob() {
        if (!connected) {
            showNotification('Chưa kết nối WebSocket', 'warning');
            return;
        }

        var jobIdEl = document.getElementById('jobId');
        if (!jobIdEl || !jobIdEl.value || !jobIdEl.value.trim()) {
            showNotification('Nhập Job ID trước khi Join', 'warning');
            return;
        }
        var jobId = jobIdEl.value.trim();

        // Hủy sub cũ
        if (sub) { sub.unsubscribe(); sub = null; }

        var dest = '/user/queue/jobs/' + jobId;
        sub = stompClient.subscribe(dest, function(message) {
            try {
                var m = JSON.parse(message.body);
                var isMe = String(m.senderId) === String(CURRENT_USER_ID);

                // Ưu tiên tên từ server -> tên đối tác -> fallback User #id
                var displayName = isMe
                    ? 'You'
                    : (m.senderName || CURRENT_PARTNER_NAME || ('User #' + m.senderId));

                showMessage(displayName + ': ' + m.content, isMe ? 'sent' : 'received');
                if (isMe) messagesSentCount++; else messagesReceivedCount++;
                updateStats();
            } catch(e) {
                showMessage(message.body, 'received');
                messagesReceivedCount++;
                updateStats();
            }
        });

        var roomEl = document.getElementById('currentRoom');
        if (roomEl) roomEl.textContent = 'Job ' + jobId;
        showNotification('Joined chat room for Job ' + jobId, 'success');

        // Lịch sử
        fetch(CTX + '/api/chat/history?jobId=' + encodeURIComponent(jobId))
            .then(function(r){ return r.json(); })
            .then(function(arr){
                if (!arr || arr.length === 0) {
                    var chatBox = document.getElementById('chatBox');
                    if (chatBox) {
                        chatBox.innerHTML = 
                            '<div class="text-center text-muted d-flex flex-column justify-content-center" style="height: 100%;">' +
                            '<div>' +
                            '<i class="bi bi-chat-text fs-1 mb-3 text-muted opacity-50"></i>' +
                            '<h5 class="text-muted mb-2">No Messages Yet</h5>' +
                            '<p class="mb-0 small">Start the conversation by sending a message</p>' +
                            '</div>' +
                            '</div>';
                    }
                    return;
                }
                var box = document.getElementById('chatBox');
                if (box) box.innerHTML = '';
                for (var i = 0; i < arr.length; i++) {
                    var msg = arr[i];
                    var isMe = String(msg.senderId) === String(CURRENT_USER_ID);
                    var displayName = isMe
                        ? 'You'
                        : (msg.senderName || CURRENT_PARTNER_NAME || ('User #' + msg.senderId));
                    showMessage(displayName + ': ' + msg.content, isMe ? 'sent' : 'received');
                }
            })
            .catch(function(err){ console.error('Load history error:', err); });
    }

    function sendMessage() {
        if (!connected) {
            showNotification('Chưa kết nối WebSocket', 'warning');
            return;
        }

        var jobId = (document.getElementById('jobId') || {}).value || '';
        var recipientId = (document.getElementById('recipientId') || {}).value || '';
        var text = (document.getElementById('messageInput') || {}).value || '';
        jobId = jobId.trim(); recipientId = recipientId.trim(); text = text.trim();

        if (!jobId || !recipientId || !text) {
            showNotification('Thiếu Job ID / Recipient ID / Nội dung', 'warning');
            return;
        }

        stompClient.send('/app/chat.send', {}, JSON.stringify({
            jobId: Number(jobId),
            recipientId: Number(recipientId),
            content: text
        }));

        var msgInput = document.getElementById('messageInput');
        if (msgInput) msgInput.value = '';
    }

    // ====== SEARCH ======
    (function bindSearch(){
        var search = document.getElementById('searchJobs');
        if (!search) return;
        search.addEventListener('input', function(e){
            var term = (e.target.value || '').toLowerCase();
            var items = document.querySelectorAll('.job-item');
            for (var i = 0; i < items.length; i++) {
                var item = items[i];
                var titleEl = item.querySelector('h6');
                var partnerEl = item.querySelector('small.text-muted:last-child');
                var jobTitle = titleEl ? (titleEl.textContent || '').toLowerCase() : '';
                var partner  = partnerEl ? (partnerEl.textContent || '').toLowerCase() : '';
                item.style.display = (jobTitle.indexOf(term) !== -1 || partner.indexOf(term) !== -1) ? 'block' : 'none';
            }
        });
    })();

    // ====== INIT ======
    window.addEventListener('load', function(){
        updateStats();
        loadChatItems();
        connect();

        var jobInput = document.getElementById('jobId');
        if (jobInput) {
            jobInput.addEventListener('change', function(){
                if (connected && jobInput.value && jobInput.value.trim()) joinJob();
            });
            jobInput.addEventListener('input', function(){
                if (!connected) return;
                if (jobInput.value && jobInput.value.trim()) {
                    clearTimeout(jobInput.debounceTimer);
                    jobInput.debounceTimer = setTimeout(function(){ joinJob(); }, 500);
                }
            });
        }
    });
    </script>
</body>
</html>