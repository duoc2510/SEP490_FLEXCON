# Hướng dẫn Cài đặt Môi trường

### 1 PostgreSQL 17.5
- **Tải**: [https://www.enterprisedb.com/downloads/postgres-postgresql-downloads](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads)
- **Cài đặt**:
  1. Chọn **PostgreSQL Server**, **pgAdmin 4**, **Command Line Tools**.
  2. Đặt mật khẩu cho `postgres`.
  3. Port mặc định: `5432`.
- **Kiểm tra**:
  - Mở `pgAdmin 4` hoặc **SQL Shell (psql)**.
  - Kết nối: `jdbc:postgresql://localhost:5432/postgres`.

### 2 Apache Tomcat 9
- **Tải**: [https://tomcat.apache.org/download-90.cgi](https://tomcat.apache.org/download-90.cgi)
- **Cài đặt**:
  1. Chọn **64-bit Windows zip**.
  2. Giải nén vào `C:\dev\apache-tomcat-9.0.xx`.
  3. Cấu hình server trong IDE.

### 3 JDK 21
- **Tải**:
  - Oracle JDK: [https://www.oracle.com/java/technologies/downloads/](https://www.oracle.com/java/technologies/downloads/)
  - Hoặc OpenJDK (Temurin): [https://adoptium.net/temurin/releases/?version=21](https://adoptium.net/temurin/releases/?version=21)
- **Cấu hình biến môi trường**:
  - `JAVA_HOME=C:\Program Files\Java\jdk-21`
  - PATH: `%JAVA_HOME%\bin`
- **Kiểm tra**:
  ```bash
  java -version


# FLEXCON – Nền tảng Việc làm Linh hoạt cho Sinh viên & Freelancer

## 1. Giới thiệu
FLEXCON là nền tảng web kết nối sinh viên và freelancer với nhà tuyển dụng, hỗ trợ ba mô hình công việc:
- **Bidding (Đấu thầu)**
- **Contest (Thi tuyển)**
- **Microtask (Nhiệm vụ nhỏ)**

Hệ thống bao gồm:
- Ví nội bộ & ký quỹ (Escrow)
- Chat 1–1 qua WebSocket
- Đánh giá hai chiều (Double-blind review)
- AI moderation (lọc spam, đạo văn, nội dung cấm)
- Tìm kiếm & lọc nâng cao
- Quản trị tranh chấp, nội dung và người dùng
- Thanh toán qua PayOS (nạp tiền), rút thủ công (Admin xử lý)

---

## 2. Phạm vi & Nhóm người dùng

### 2.1. Nhóm người dùng
- **Guest (Khách)**: Xem danh sách và chi tiết công việc, không được tương tác.
- **Freelancer**: Ứng tuyển, nộp bài, thực hiện task, nhận thanh toán, đánh giá, báo cáo vi phạm.
- **Employer**: Tạo & quản lý job, ký quỹ, chọn người thắng, duyệt/chi trả.
- **Admin**: Quản lý người dùng, job, thanh toán, tranh chấp, kiểm duyệt.

### 2.2. Công nghệ & Phạm vi bản đầu (MVP)
- Nền tảng web: **Spring MVC** + **PostgreSQL**
- Thanh toán: **PayOS** (nạp tiền), rút thủ công qua Admin
- AI moderation: áp dụng với chat, mô tả job, proposal, entry contest, proof microtask, report
- Hỗ trợ đầy đủ 3 mô hình công việc với quy tắc escrow riêng
- Không làm mobile native, đa ngôn ngữ, NFR chi tiết (theo yêu cầu bỏ NFR)

---

## 3. Mô hình công việc

### 3.1. Bidding (Đấu thầu)
- Job yêu cầu: tiêu đề, mô tả, ngân sách, kỹ năng, deadline nhận đề xuất, bid deviation %, danh sách milestone.
- Bắt buộc ký quỹ milestone 1 trước khi public job.
- Proposal hợp lệ: đáp ứng kỹ năng, báo giá trong biên độ, có mô tả năng lực hoặc portfolio.
- Chọn người trúng: auto (giá thấp nhất) hoặc thủ công.
- Milestone flow: nộp bản thử → phản hồi → bản chính → duyệt trong 72h (auto-approve nếu quá hạn).
- Quy tắc hủy/tranh chấp theo phần trăm giữ/lấy phí.

### 3.2. Contest (Thi tuyển)
- Contest yêu cầu: tiêu đề, đề bài, tiêu chí (trọng số), deadline, chế độ công khai.
- Ký quỹ toàn bộ giải thưởng khi tạo.
- Freelancer nộp bài 1 lần trước deadline.
- Employer chấm điểm theo tiêu chí → hệ thống tính tổng → chọn người thắng → payout.
- Có tùy chọn mua lại bài không thắng.

### 3.3. Microtask (Nhiệm vụ nhỏ)
- Job yêu cầu: nội dung, proof requirement, số lượt × đơn giá, deadline.
- Ký quỹ tổng tiền khi tạo.
- Freelancer nhận task → giữ slot 60 phút → nộp proof.
- Employer duyệt trong 48h hoặc auto-approve.

---

## 4. Ví & Ký quỹ (Wallet & Escrow)
- **Nạp tiền**: PayOS vào ví nội bộ → tăng số dư ngay, ghi bút toán.
- **Ký quỹ**: Bắt buộc tùy theo mô hình (Bidding milestone 1, Contest full prize, Microtask full total).
- **Giải ngân**: khi milestone/giải/task được duyệt hoặc auto-approve (trừ phí 10%).
- **Rút tiền**: yêu cầu ≥ 100.000 VNĐ, bắt buộc MFA, Admin xử lý thủ công.
- **Tranh chấp**: đóng băng escrow liên quan đến mốc/giải/task cho đến khi có quyết định.

---

## 5. Chat & Thông báo
- **Chat**: WebSocket 1–1, gắn với job, lưu PostgreSQL, AI moderation chặn spam/off-platform contact.
- **Notification**:
  - Realtime: tin nhắn mới, proposal mới, job cập nhật, payout, dispute.
  - Email digest: gửi khi user offline ≥ 1 giờ.
  - Lịch sử thông báo: trạng thái đã đọc/chưa đọc.

---

## 6. Review & Report
- **Review**: double-blind 7 ngày, 1–5 sao, tag lý do, mô tả tự do.
- **Report**: có ở mọi đối tượng (job, proposal, contest entry, proof, chat), AI phân loại, auto-suspend khi ≥ 3 vi phạm/30 ngày.

---

## 7. Search & Filter
- Search full-text tiêu đề + mô tả (ưu tiên tiêu đề).
- Filter theo loại job, ngân sách, kỹ năng, trạng thái job.
- Sort theo deadline mặc định, mới nhất, hoặc ngân sách cao nhất.
- Saved Search + email digest.

---

## 8. Permission & Security
- **Auth**: Email + Google OAuth, MFA khi rút tiền/đổi mật khẩu.
- **Role-based permission**:
  - Admin: toàn quyền job, xử lý dispute, khóa/mở tài khoản.
  - Employer: xóa job nếu chưa ký quỹ.
  - Freelancer: giới hạn chỉnh sửa/withdraw proposal, proof.
- Dispute visibility: mỗi bên chỉ thấy dispute job mình.

---

## 9. MVP Scope & Demo Flow

### 9.1. Bắt buộc
- Auth & Profile (email, Google OAuth, MFA, portfolio tùy chọn).
- Job Management: full 3 mô hình với quy tắc escrow riêng.
- Wallet & Escrow: nạp PayOS, rút thủ công, freeze khi dispute.
- Chat & Notification: WebSocket, AI moderation, realtime notify, email digest.
- Review & Report: double-blind, AI classify, auto-suspend.
- Search & Filter: full-text, filter, sort, saved search.
- Admin Panel: quản lý user, job, escrow, dispute, moderation.

### 9.2. Demo Flow
- **Bidding**: Employer tạo job → ký quỹ milestone 1 → Freelancer gửi proposal → chọn người thắng → đặt cọc milestone → thực hiện → bản thử → bản chính → duyệt/auto → payout → review.
- **Contest**: Employer tạo contest → ký quỹ giải → Freelancer nộp bài → chấm điểm → chọn người thắng → payout → review.
- **Microtask**: Employer tạo task → ký quỹ → Freelancer nhận & nộp proof → duyệt/auto → payout → đóng job.

---

## 10. User Stories (Tóm tắt)
### Guest
- Xem danh sách & chi tiết job (không tương tác).
- Đăng ký email hoặc Google.
- Xem trang giới thiệu & gửi câu hỏi đến Admin.

### Freelancer
- Cập nhật hồ sơ & portfolio.
- Gửi, chỉnh, rút proposal.
- Nộp bài contest, proof microtask.
- Nạp & rút tiền.
- Chat 1–1, nhận thông báo realtime & email digest.
- Đánh giá Employer, báo cáo vi phạm.

### Employer
- Cập nhật hồ sơ.
- Tạo & quản lý job theo 3 mô hình.
- Ký quỹ, chọn người thắng, duyệt kết quả.
- Chat 1–1, nhận thông báo.
- Đánh giá Freelancer, báo cáo vi phạm.

### Admin
- Quản lý người dùng, job, escrow, dispute.
- Xử lý report & moderation.
- Thống kê vận hành.
- Duyệt rút tiền.

---

## 11. Hạng mục còn mở
- Thời gian lưu job nháp: 14/30/90 ngày.
- Timeout microtask slot: 60 phút (xem xét đổi).
- Wording đăng ký Google + đặt mật khẩu nội bộ.

---

## 12. Rủi ro & Giả định (Tổng hợp)
- **Pháp lý escrow**: cần điều chỉnh điều khoản theo luật.
- **Phụ thuộc PayOS**: gián đoạn ảnh hưởng nạp ví.
- **Spam/gian lận Microtask**: tăng chi phí kiểm duyệt.
- **Chat lưu SQL**: nguy cơ phình dữ liệu.
- **Auto-approve gây khiếu nại**: cần hỗ trợ hậu kiểm.
- **Không lưu log đăng nhập**: khó điều tra bảo mật.

---

## 13. Lý do chọn PostgreSQL
- **Full-Text Search (FTS) mạnh mẽ**: hỗ trợ to_tsvector/to_tsquery, ranking (ts_rank), highlight, ngôn ngữ; kết hợp GIN/ GiST index cho truy vấn nhanh. Rất hợp để tìm kiếm theo tiêu đề JD, mô tả, kỹ năng.
- **Chỉ mục đa dạng & tối ưu**: partial index, expression index, covering index, trigram (pg_trgm) cho tìm kiếm gần đúng (typo-tolerant), unaccent để loại dấu tiếng Việt.
- **JSONB linh hoạt**: lưu metadata động (kỹ năng, phúc lợi, tags) mà vẫn truy vấn/index hiệu quả.
- **MVCC & tính toàn vẹn**: khóa ngoại, check, exclusion constraints… giúp dữ liệu “sạch”, an toàn giao dịch.
- **Phân mảnh/Partitioning & hiệu năng**: dữ liệu lớn theo thời gian/khu vực, dễ mở rộng đọc/ghi.
- **Row-Level Security**: phân quyền theo row (ứng viên/nhà tuyển dụng/HR), tiện cho đa bên.
- **Materialized View & CTE**: dựng bảng xếp hạng, thống kê, feed gợi ý, job trending.

---

## 14. PostgreSQL Naming Convention – `snake_case` (lowercase, separated by `_`)

**Detailed Rules:**

### Tables
- **Use plural form or collective noun** → represents multiple records.  
- **Keep names short, descriptive, and meaningful.**  
- **Examples:**
  - `users`, `jobs`, `companies`, `applications`
  - Many-to-many tables: join both table names with `_` → `job_skills`, `user_roles`

### Columns
- **Lowercase** + `snake_case`.
- **ID columns**: `<entity>_id` → easier joins.
- **Descriptive names**, avoid unclear abbreviations.
- **Examples:**
  - `user_id`, `job_id`, `company_name`, `created_at`, `updated_at`

### Primary Keys
- **Format:** `<table>_id` (e.g., `user_id` in `users` table).
- Use `serial`/`bigserial` or identity columns.

### Foreign Keys
- **Format:** `<referenced_table>_id`.
- If multiple FKs reference the same table → add a prefix for clarity.
- **Examples:**
  - `created_by_user_id` *(creator reference)*
  - `company_id` *(associated company)*

### Indexes
- **Format:** `idx_<table>_<column>` or `idx_<table>_<column1>_<column2>`.
- **Examples:**
  - `idx_jobs_title`
  - `idx_applications_user_id_job_id`

### Constraints
- **Check:** `chk_<table>_<column>`  
- **Foreign Key:** `fk_<table>_<column>`  
- **Unique:** `uq_<table>_<column>`  
- **Examples:**
  - `fk_jobs_company_id`
  - `uq_users_email`

### Views
- **Format:** `vw_<description>`.
- **Examples:**
  - `vw_active_jobs`
  - `vw_user_statistics`

### Stored Procedures / Functions
- **Format:** `sp_<action>_<object>` or `fn_<description>`.
- **Examples:**
  - `sp_insert_job`
  - `fn_calculate_salary`

---

## 15. Reasons for Choosing `snake_case` Naming Standard

- **Consistency** → Improves readability, memorability, and searchability.  
- **Ease of Maintenance** → No confusion when adding new features or debugging.  
- **Error Prevention** → Avoids mistakes when joining multiple tables.  
- **Cross-Platform Compatibility** → Prevents issues with special characters, spaces, or SQL reserved keywords.  
- **Code Review Friendly** → Clear, descriptive names make it easier for teammates and reviewers to understand.  



#   S E P 4 9 0 _ F L E X C O N  
 