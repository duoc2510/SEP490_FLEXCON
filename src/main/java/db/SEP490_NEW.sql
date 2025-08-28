BEGIN;
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
SET
search_path TO public;

-- ====================== CORE TABLES ======================
CREATE TYPE user_role AS ENUM ('ADMIN', 'USER');
CREATE TYPE user_status AS ENUM ('ACTIVE', 'INACTIVE', 'BANNED', 'SUSPENDED');
CREATE TYPE user_active_status AS ENUM ('ONLINE', 'OFFLINE', 'AWAY', 'BUSY');
CREATE TYPE job_type AS ENUM ('BIDDING', 'MICROTASK', 'CONTEST');
CREATE TYPE job_status AS ENUM ('DRAFT', 'PENDING_REVIEW' ,'OPEN', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED', 'CLOSED');
CREATE TYPE proposal_status AS ENUM ('SUBMITTED', 'SHORTLISTED', 'REJECTED', 'ACCEPTED', 'WITHDRAWN');
CREATE TYPE contract_status AS ENUM ('ACTIVE', 'PENDING', 'PAUSED', 'COMPLETED', 'CANCELLED', 'TERMINATED');
CREATE TYPE milestone_status AS ENUM ('PENDING', 'FUNDED', 'SUBMITTED', 'APPROVED', 'PAID', 'REJECTED');
CREATE TYPE escrow_state AS ENUM ('HELD', 'RELEASED', 'REFUNDED', 'EXPIRED');
CREATE TYPE transaction_type AS ENUM ('DEPOSIT', 'WITHDRAW', 'PAYMENT', 'REFUND', 'FEE');
CREATE TYPE transaction_status AS ENUM ('PENDING', 'SUCCESS', 'FAILED', 'REFUNDED', 'CANCELLED');
CREATE TYPE feedback_visibility AS ENUM ('PUBLIC', 'PRIVATE', 'HIDDEN');
CREATE TYPE microtask_state AS ENUM ('ASSIGNED', 'IN_PROGRESS', 'SUBMITTED', 'APPROVED', 'REJECTED', 'PAID');
CREATE TYPE contest_entry_status AS ENUM ('SUBMITTED', 'SHORTLISTED', 'WINNER', 'REJECTED');
CREATE TYPE selection_mode AS ENUM ('MANUAL', 'LOWEST_BID', 'BEST_SCORE', 'AUTO_ACCEPT');
CREATE TYPE withdraw_method AS ENUM ('BANK', 'QR');
CREATE TYPE withdraw_status AS ENUM ('PENDING', 'APPROVED', 'REJECTED', 'CANCELLED', 'PROCESSING', 'COMPLETED');
CREATE TYPE notification_type AS ENUM ('JOB', 'PROPOSAL', 'CONTRACT', 'CHAT', 'WALLET', 'SYSTEM', 'MILESTONE', 'CONTEST', 'MICROTASK');
CREATE TYPE notification_priority AS ENUM ('LOW', 'NORMAL', 'HIGH', 'URGENT');
-- ====================== users ======================
CREATE TABLE public.users
(
    id                BIGSERIAL PRIMARY KEY,
    username          VARCHAR(100) NOT NULL UNIQUE,
    password_hash     VARCHAR(255) NOT NULL,
    email             VARCHAR(150) NOT NULL UNIQUE,
    full_name         VARCHAR(150),
    role              VARCHAR(100) NOT NULL CHECK (role IN ('ADMIN', 'USER')),
    status            VARCHAR(20)  NOT NULL DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'INACTIVE', 'BANNED', 'SUSPENDED')),
    active_status     VARCHAR(20)           DEFAULT 'OFFLINE' CHECK (active_status IN ('ONLINE', 'OFFLINE', 'AWAY', 'BUSY')),
    last_login_at     TIMESTAMP WITHOUT TIME ZONE,
    email_verified_at TIMESTAMP WITHOUT TIME ZONE,
    phone             VARCHAR(20),
    avatar_url        TEXT,
    timezone          VARCHAR(50)           DEFAULT 'UTC',
    language          VARCHAR(10)           DEFAULT 'vi',
    created_at        TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    created_by        BIGINT,
    updated_at        TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    updated_by        BIGINT,
    deleted_at        TIMESTAMP WITHOUT TIME ZONE
);

COMMENT
ON TABLE public.users IS 'Tài khoản người dùng hệ thống.';
COMMENT
ON COLUMN public.users.id IS 'Khóa chính tự tăng.';
COMMENT
ON COLUMN public.users.username IS 'Tên đăng nhập duy nhất, dùng để đăng nhập/tra cứu.';
COMMENT
ON COLUMN public.users.password_hash IS 'Mật khẩu đã băm (không lưu plaintext).';
COMMENT
ON COLUMN public.users.email IS 'Email duy nhất của người dùng.';
COMMENT
ON COLUMN public.users.full_name IS 'Họ tên hiển thị.';
COMMENT
ON COLUMN public.users.role IS 'Vai trò người dùng.';
COMMENT
ON COLUMN public.users.status IS 'Trạng thái tài khoản.';
COMMENT
ON COLUMN public.users.active_status IS 'Tình trạng hoạt động hiện tại.';
COMMENT
ON COLUMN public.users.last_login_at IS 'Lần đăng nhập cuối.';
COMMENT
ON COLUMN public.users.email_verified_at IS 'Thời điểm xác thực email.';
COMMENT
ON COLUMN public.users.phone IS 'Số điện thoại.';
COMMENT
ON COLUMN public.users.avatar_url IS 'Đường dẫn ảnh đại diện.';
COMMENT
ON COLUMN public.users.timezone IS 'Múi giờ của người dùng.';
COMMENT
ON COLUMN public.users.language IS 'Ngôn ngữ ưa thích.';

CREATE INDEX idx_users_email ON public.users (email) WHERE deleted_at IS NULL;
CREATE INDEX idx_users_role_status ON public.users (role, status) WHERE deleted_at IS NULL;
CREATE INDEX idx_users_created_at ON public.users (created_at DESC);

-- ====================== profiles (1–1 users) ======================
CREATE TABLE public.profiles
(
    id                BIGSERIAL PRIMARY KEY,
    user_id           BIGINT NOT NULL UNIQUE,
    bio               TEXT,
    portfolio_links   JSONB         DEFAULT '[]',
    rating_avg        NUMERIC(4, 2) DEFAULT 0.00 CHECK (rating_avg >= 0 AND rating_avg <= 5),
    rating_count      BIGINT        DEFAULT 0 CHECK (rating_count >= 0),
    completed_jobs    INTEGER       DEFAULT 0 CHECK (completed_jobs >= 0),
    skills            JSONB         DEFAULT '[]',
    experience_years  INTEGER       DEFAULT 0 CHECK (experience_years >= 0),
    education_level   VARCHAR(50),
    location          VARCHAR(200),
    hourly_rate_min   NUMERIC(19, 4) CHECK (hourly_rate_min >= 0),
    hourly_rate_max   NUMERIC(19, 4) CHECK (hourly_rate_max >= 0),
    currency          VARCHAR(10)   DEFAULT 'VND',
    availability      VARCHAR(50),
    is_verified       BOOLEAN       DEFAULT FALSE,
    verification_date TIMESTAMP WITHOUT TIME ZONE,
    created_at        TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    created_by        BIGINT,
    updated_at        TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    updated_by        BIGINT,
    deleted_at        TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_profiles_user
        FOREIGN KEY (user_id) REFERENCES public.users (id) ON DELETE CASCADE,
    CONSTRAINT chk_profiles_hourly_rate
        CHECK (hourly_rate_min IS NULL OR hourly_rate_max IS NULL OR hourly_rate_min <= hourly_rate_max)
);

COMMENT
ON TABLE public.profiles IS 'Hồ sơ chi tiết của người dùng (1–1 với users).';
COMMENT
ON COLUMN public.profiles.bio IS 'Giới thiệu cá nhân.';
COMMENT
ON COLUMN public.profiles.portfolio_links IS 'Các đường dẫn portfolio (JSON array).';
COMMENT
ON COLUMN public.profiles.rating_avg IS 'Điểm trung bình đánh giá (0–5).';
COMMENT
ON COLUMN public.profiles.rating_count IS 'Tổng số lượt đánh giá.';
COMMENT
ON COLUMN public.profiles.completed_jobs IS 'Số công việc đã hoàn thành.';
COMMENT
ON COLUMN public.profiles.skills IS 'Danh sách kỹ năng (JSON array).';
COMMENT
ON COLUMN public.profiles.experience_years IS 'Số năm kinh nghiệm.';
COMMENT
ON COLUMN public.profiles.education_level IS 'Trình độ học vấn.';
COMMENT
ON COLUMN public.profiles.location IS 'Địa điểm làm việc.';
COMMENT
ON COLUMN public.profiles.hourly_rate_min IS 'Mức lương tối thiểu/giờ.';
COMMENT
ON COLUMN public.profiles.hourly_rate_max IS 'Mức lương tối đa/giờ.';
COMMENT
ON COLUMN public.profiles.is_verified IS 'Trạng thái xác thực hồ sơ.';

CREATE INDEX idx_profiles_rating ON public.profiles (rating_avg DESC, rating_count DESC) WHERE deleted_at IS NULL;
CREATE INDEX idx_profiles_skills ON public.profiles USING GIN (skills) WHERE deleted_at IS NULL;
CREATE INDEX idx_profiles_location ON public.profiles (location) WHERE deleted_at IS NULL;

-- ====================== wallets (1–1 users) ======================
CREATE TABLE public.wallets
(
    id                BIGSERIAL PRIMARY KEY,
    user_id           BIGINT         NOT NULL UNIQUE,
    balance_available NUMERIC(19, 4) NOT NULL DEFAULT 0.0000,
    balance_frozen    NUMERIC(19, 4) NOT NULL DEFAULT 0.0000,
    total_earned      NUMERIC(19, 4)          DEFAULT 0.0000,
    total_spent       NUMERIC(19, 4)          DEFAULT 0.0000,
    currency          VARCHAR(10)    NOT NULL DEFAULT 'VND',
    created_at        TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    updated_at        TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    updated_by        BIGINT,
    CONSTRAINT fk_wallets_user
        FOREIGN KEY (user_id) REFERENCES public.users (id) ON DELETE CASCADE,
    CONSTRAINT chk_wallets_nonneg
        CHECK (balance_available >= 0 AND balance_frozen >= 0 AND total_earned >= 0 AND total_spent >= 0)
);

COMMENT
ON TABLE public.wallets IS 'Ví tiền của người dùng (1–1 với users).';
COMMENT
ON COLUMN public.wallets.balance_available IS 'Số dư khả dụng (có thể chi tiêu).';
COMMENT
ON COLUMN public.wallets.balance_frozen IS 'Số dư bị đóng băng (đang chờ giao dịch).';
COMMENT
ON COLUMN public.wallets.total_earned IS 'Tổng số tiền đã kiếm được.';
COMMENT
ON COLUMN public.wallets.total_spent IS 'Tổng số tiền đã chi tiêu.';

CREATE INDEX idx_wallets_user_id ON public.wallets (user_id);

-- ====================== wallet_transactions ======================
CREATE TABLE public.wallet_transactions
(
    id           BIGSERIAL PRIMARY KEY,
    wallet_id    BIGINT         NOT NULL,
    type         VARCHAR(20)    NOT NULL CHECK (type IN ('DEPOSIT', 'WITHDRAW', 'PAYMENT', 'REFUND', 'FEE')),
    amount       NUMERIC(19, 4) NOT NULL CHECK (amount > 0),
    currency     VARCHAR(10)    NOT NULL DEFAULT 'VND',
    ref_type     VARCHAR(50),
    ref_id       BIGINT,
    provider     VARCHAR(50),
    provider_ref VARCHAR(255),
    status       VARCHAR(20)    NOT NULL DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'SUCCESS', 'FAILED', 'REFUNDED', 'CANCELLED')),
    description  TEXT,
    notes        TEXT,
    processed_at TIMESTAMP WITHOUT TIME ZONE,
    created_at   TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    created_by   BIGINT,
    updated_at   TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    updated_by   BIGINT,
    deleted_at   TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_tx_wallet
        FOREIGN KEY (wallet_id) REFERENCES public.wallets (id) ON DELETE CASCADE
);

COMMENT
ON TABLE public.wallet_transactions IS 'Lịch sử giao dịch của ví.';
COMMENT
ON COLUMN public.wallet_transactions.type IS 'Loại giao dịch.';
COMMENT
ON COLUMN public.wallet_transactions.amount IS 'Số tiền giao dịch (> 0).';
COMMENT
ON COLUMN public.wallet_transactions.ref_type IS 'Loại đối tượng liên quan.';
COMMENT
ON COLUMN public.wallet_transactions.ref_id IS 'ID đối tượng liên quan.';
COMMENT
ON COLUMN public.wallet_transactions.provider IS 'Nhà cung cấp thanh toán.';
COMMENT
ON COLUMN public.wallet_transactions.provider_ref IS 'Mã tham chiếu của provider.';
COMMENT
ON COLUMN public.wallet_transactions.description IS 'Mô tả giao dịch.';
COMMENT
ON COLUMN public.wallet_transactions.processed_at IS 'Thời điểm xử lý thành công.';

CREATE INDEX idx_tx_wallet_id ON public.wallet_transactions (wallet_id);
CREATE INDEX idx_tx_provider_ref ON public.wallet_transactions (provider_ref) WHERE provider_ref IS NOT NULL;
CREATE INDEX idx_tx_ref_combo ON public.wallet_transactions (ref_type, ref_id) WHERE ref_type IS NOT NULL;
CREATE INDEX idx_tx_status ON public.wallet_transactions (status);
CREATE INDEX idx_tx_created_at ON public.wallet_transactions (created_at DESC);

-- ====================== categories ======================
CREATE TABLE public.categories
(
    id          BIGSERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    slug        VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    icon_url    TEXT,
    parent_id   BIGINT,
    sort_order  INTEGER DEFAULT 0,
    is_active   BOOLEAN DEFAULT TRUE,
    created_at  TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    updated_at  TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT fk_category_parent
        FOREIGN KEY (parent_id) REFERENCES public.categories (id) ON DELETE SET NULL
);

COMMENT
ON TABLE public.categories IS 'Danh mục công việc.';
COMMENT
ON COLUMN public.categories.slug IS 'URL slug duy nhất.';
COMMENT
ON COLUMN public.categories.parent_id IS 'Danh mục cha (để tạo cây).';
COMMENT
ON COLUMN public.categories.sort_order IS 'Thứ tự hiển thị.';

CREATE INDEX idx_categories_parent ON public.categories (parent_id);
CREATE INDEX idx_categories_active ON public.categories (is_active, sort_order);

-- ====================== skills ======================
CREATE TABLE public.skills
(
    id          BIGSERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL UNIQUE,
    slug        VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    category_id BIGINT,
    is_active   BOOLEAN DEFAULT TRUE,
    created_at  TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT fk_skill_category
        FOREIGN KEY (category_id) REFERENCES public.categories (id) ON DELETE SET NULL
);

COMMENT
ON TABLE public.skills IS 'Danh sách kỹ năng.';

CREATE INDEX idx_skills_category ON public.skills (category_id);
CREATE INDEX idx_skills_active ON public.skills (is_active);

-- ====================== jobs ======================
CREATE TABLE public.jobs
(
    id                     BIGSERIAL PRIMARY KEY,
    employer_id            BIGINT       NOT NULL,
    type                   VARCHAR(20)  NOT NULL CHECK (type IN ('BIDDING', 'MICROTASK', 'CONTEST')),
    title                  VARCHAR(300) NOT NULL,
    description            TEXT,
    requirements           TEXT,
    budget_min             NUMERIC(19, 4) CHECK (budget_min >= 0),
    budget_max             NUMERIC(19, 4) CHECK (budget_max >= 0),
    currency               VARCHAR(10)  NOT NULL DEFAULT 'VND',
    deadline_at            TIMESTAMP WITHOUT TIME ZONE,
    expected_duration_days INTEGER CHECK (expected_duration_days > 0),
    status                 VARCHAR(20)  NOT NULL DEFAULT 'DRAFT' CHECK (status IN ('DRAFT', 'PENDING_REVIEW', 'OPEN',
                                                                                   'IN_PROGRESS', 'COMPLETED',
                                                                                   'CANCELLED', 'CLOSED')),
    is_public              BOOLEAN      NOT NULL DEFAULT TRUE,
    is_featured            BOOLEAN               DEFAULT FALSE,
    view_count             INTEGER               DEFAULT 0,
    application_count      INTEGER               DEFAULT 0,
    category_id            BIGINT,
    location               VARCHAR(200),
    is_remote              BOOLEAN               DEFAULT TRUE,
    required_skills        JSONB                 DEFAULT '[]',
    published_at           TIMESTAMP WITHOUT TIME ZONE,
    completed_at           TIMESTAMP WITHOUT TIME ZONE,
    created_at             TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    created_by             BIGINT,
    updated_at             TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    updated_by             BIGINT,
    deleted_at             TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_jobs_employer
        FOREIGN KEY (employer_id) REFERENCES public.users (id) ON DELETE RESTRICT,
    CONSTRAINT fk_jobs_category
        FOREIGN KEY (category_id) REFERENCES public.categories (id) ON DELETE SET NULL,
    CONSTRAINT chk_jobs_budget
        CHECK (budget_min IS NULL OR budget_max IS NULL OR budget_min <= budget_max)
);

COMMENT
ON TABLE public.jobs IS 'Tin tuyển dụng do employer tạo.';
COMMENT
ON COLUMN public.jobs.employer_id IS 'Người đăng job.';
COMMENT
ON COLUMN public.jobs.type IS 'Phân loại job: BIDDING/MICROTASK/CONTEST.';
COMMENT
ON COLUMN public.jobs.title IS 'Tiêu đề job.';
COMMENT
ON COLUMN public.jobs.description IS 'Mô tả chi tiết công việc.';
COMMENT
ON COLUMN public.jobs.requirements IS 'Yêu cầu công việc.';
COMMENT
ON COLUMN public.jobs.budget_min IS 'Ngân sách tối thiểu.';
COMMENT
ON COLUMN public.jobs.budget_max IS 'Ngân sách tối đa.';
COMMENT
ON COLUMN public.jobs.deadline_at IS 'Hạn cuối nhận ứng tuyển.';
COMMENT
ON COLUMN public.jobs.expected_duration_days IS 'Thời gian dự kiến hoàn thành (ngày).';
COMMENT
ON COLUMN public.jobs.status IS 'Trạng thái job.';
COMMENT
ON COLUMN public.jobs.is_featured IS 'Job nổi bật (trả phí).';
COMMENT
ON COLUMN public.jobs.view_count IS 'Số lượt xem.';
COMMENT
ON COLUMN public.jobs.application_count IS 'Số lượt ứng tuyển.';
COMMENT
ON COLUMN public.jobs.required_skills IS 'Kỹ năng yêu cầu (JSON array).';

CREATE INDEX idx_jobs_employer_id ON public.jobs (employer_id);
CREATE INDEX idx_jobs_type ON public.jobs (type);
CREATE INDEX idx_jobs_status_public ON public.jobs (status, is_public) WHERE deleted_at IS NULL;
CREATE INDEX idx_jobs_deadline ON public.jobs (deadline_at) WHERE deadline_at IS NOT NULL;
CREATE INDEX idx_jobs_created_at ON public.jobs (created_at DESC);
CREATE INDEX idx_jobs_featured ON public.jobs (is_featured, created_at DESC) WHERE is_featured = TRUE;
CREATE INDEX idx_jobs_skills ON public.jobs USING GIN (required_skills) WHERE deleted_at IS NULL;
CREATE INDEX idx_jobs_search_tsv ON public.jobs USING GIN (to_tsvector('simple', coalesce (title, '') || ' ' || coalesce (description, '')));

-- ====================== job_requirements ======================
CREATE TABLE public.job_requirements
(
    id               BIGSERIAL PRIMARY KEY,
    job_id           BIGINT      NOT NULL,
    name_requirement VARCHAR(50) NOT NULL, -- tên yêu cầu (vd: min_experience_years)
    requirement      TEXT,                 -- giá trị chi tiết
    create_at        TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    CONSTRAINT fk_req_job
        FOREIGN KEY (job_id) REFERENCES public.jobs (id) ON DELETE CASCADE
);

COMMENT
ON TABLE public.job_requirements IS 'Các yêu cầu bắt buộc cho một job (kinh nghiệm, kỹ năng, học vấn).';
COMMENT
ON COLUMN public.job_requirements.job_id IS 'Job mà requirement này thuộc về.';
COMMENT
ON COLUMN public.job_requirements.name_requirement IS 'Tên yêu cầu: min_experience_years, rating_avg, required_skills, min_education_level.';
COMMENT
ON COLUMN public.job_requirements.requirement IS 'Chi tiết yêu cầu (vd: 3 năm, kỹ năng Java).';

CREATE INDEX idx_job_req_job_id ON public.job_requirements (job_id);
COMMENT
ON INDEX idx_job_req_job_id IS 'Tìm yêu cầu theo job.';

CREATE INDEX idx_job_req_name ON public.job_requirements (name_requirement);
COMMENT
ON INDEX idx_job_req_name IS 'Truy vấn nhanh các yêu cầu theo tên.';
-- ====================== JOB TYPE SPECIFIC TABLES ======================

-- ====================== job_bidding ======================
CREATE TABLE public.job_bidding
(
    job_id                BIGINT PRIMARY KEY,
    bid_deviation_pct     INTEGER CHECK (bid_deviation_pct >= 0 AND bid_deviation_pct <= 100),
    selection_mode        VARCHAR(20) NOT NULL DEFAULT 'MANUAL' CHECK (selection_mode IN ('MANUAL', 'LOWEST_BID', 'BEST_SCORE', 'AUTO_ACCEPT')),
    lowest_bid_price      NUMERIC(19, 4) CHECK (lowest_bid_price >= 0),
    highest_bid_price     NUMERIC(19, 4) CHECK (highest_bid_price >= 0),
    budget_min            NUMERIC(19, 4) CHECK (budget_min >= 0),
    budget_max            NUMERIC(19, 4) CHECK (budget_max >= 0),
    auto_accept_threshold NUMERIC(19, 4) CHECK (auto_accept_threshold >= 0),
    created_at            TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    updated_at            TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT fk_job_bidding_job
        FOREIGN KEY (job_id) REFERENCES public.jobs (id) ON DELETE CASCADE,
    CONSTRAINT chk_job_bidding_budget
        CHECK (budget_min IS NULL OR budget_max IS NULL OR budget_min <= budget_max),
    CONSTRAINT chk_job_bidding_bid_range
        CHECK (lowest_bid_price IS NULL OR highest_bid_price IS NULL OR lowest_bid_price <= highest_bid_price)
);

COMMENT
ON TABLE public.job_bidding IS 'Thiết lập đấu thầu cho job loại BIDDING.';
COMMENT
ON COLUMN public.job_bidding.job_id IS 'Job áp dụng đấu thầu (PK, FK jobs.id).';
COMMENT
ON COLUMN public.job_bidding.bid_deviation_pct IS '% lệch giá cho phép khi chấm thầu.';
COMMENT
ON COLUMN public.job_bidding.selection_mode IS 'Chế độ chọn thầu.';
COMMENT
ON COLUMN public.job_bidding.lowest_bid_price IS 'Giá thầu thấp nhất hiện tại.';
COMMENT
ON COLUMN public.job_bidding.highest_bid_price IS 'Giá thầu cao nhất hiện tại.';
COMMENT
ON COLUMN public.job_bidding.budget_min IS 'Ngân sách tối thiểu dự kiến.';
COMMENT
ON COLUMN public.job_bidding.budget_max IS 'Ngân sách tối đa dự kiến.';
COMMENT
ON COLUMN public.job_bidding.auto_accept_threshold IS 'Ngưỡng tự động chấp nhận bid.';

CREATE INDEX idx_job_bidding_selection_mode ON public.job_bidding (selection_mode);
CREATE INDEX idx_job_bidding_budget ON public.job_bidding (budget_min, budget_max);

-- ====================== job_microtask ======================
CREATE TABLE public.job_microtask
(
    job_id                 BIGINT PRIMARY KEY,
    unit_price             NUMERIC(19, 4) NOT NULL CHECK (unit_price > 0),
    max_workers            INT            NOT NULL CHECK (max_workers > 0),
    max_tasks_per_worker   INT CHECK (max_tasks_per_worker > 0),
    estimated_time_minutes INT CHECK (estimated_time_minutes > 0),
    guidelines             TEXT,
    sample_data            JSONB DEFAULT '[]',
    quality_threshold      NUMERIC(3, 2) CHECK (quality_threshold >= 0 AND quality_threshold <= 1),
    created_at             TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    updated_at             TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT fk_job_microtask
        FOREIGN KEY (job_id) REFERENCES public.jobs (id) ON DELETE CASCADE
);

COMMENT
ON TABLE public.job_microtask IS 'Cấu hình microtask cho job loại MICROTASK.';
COMMENT
ON COLUMN public.job_microtask.job_id IS 'Job áp dụng microtask.';
COMMENT
ON COLUMN public.job_microtask.unit_price IS 'Đơn giá mỗi microtask (> 0).';
COMMENT
ON COLUMN public.job_microtask.max_workers IS 'Số worker tối đa có thể tham gia.';
COMMENT
ON COLUMN public.job_microtask.max_tasks_per_worker IS 'Số task tối đa mỗi worker có thể nhận.';
COMMENT
ON COLUMN public.job_microtask.estimated_time_minutes IS 'Thời gian ước tính cho mỗi task (phút).';
COMMENT
ON COLUMN public.job_microtask.guidelines IS 'Hướng dẫn chi tiết cho microtask.';
COMMENT
ON COLUMN public.job_microtask.sample_data IS 'Dữ liệu mẫu (JSON array).';
COMMENT
ON COLUMN public.job_microtask.quality_threshold IS 'Ngưỡng chất lượng tối thiểu (0-1).';

-- ====================== job_contest ======================
CREATE TABLE public.job_contest
(
    job_id                   BIGINT PRIMARY KEY,
    submission_ends_at       TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    judging_ends_at          TIMESTAMP WITHOUT TIME ZONE,
    winner_count             INT NOT NULL  DEFAULT 1 CHECK (winner_count > 0),
    max_submissions_per_user INT           DEFAULT 1 CHECK (max_submissions_per_user > 0),
    is_blind_judging         BOOLEAN       DEFAULT FALSE,
    allow_public_voting      BOOLEAN       DEFAULT FALSE,
    public_voting_weight     NUMERIC(3, 2) DEFAULT 0 CHECK (public_voting_weight >= 0 AND public_voting_weight <= 1),
    created_at               TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    updated_at               TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT fk_job_contest
        FOREIGN KEY (job_id) REFERENCES public.jobs (id) ON DELETE CASCADE,
    CONSTRAINT chk_contest_judging_after_submission
        CHECK (judging_ends_at IS NULL OR judging_ends_at >= submission_ends_at)
);

COMMENT
ON TABLE public.job_contest IS 'Thông tin cuộc thi cho job loại CONTEST.';
COMMENT
ON COLUMN public.job_contest.job_id IS 'Job thuộc về contest.';
COMMENT
ON COLUMN public.job_contest.submission_ends_at IS 'Thời điểm kết thúc nhận bài.';
COMMENT
ON COLUMN public.job_contest.judging_ends_at IS 'Thời điểm kết thúc chấm điểm.';
COMMENT
ON COLUMN public.job_contest.winner_count IS 'Số lượng người thắng cuộc.';
COMMENT
ON COLUMN public.job_contest.max_submissions_per_user IS 'Số bài tối đa mỗi user có thể nộp.';
COMMENT
ON COLUMN public.job_contest.is_blind_judging IS 'Chấm điểm ẩn danh hay không.';
COMMENT
ON COLUMN public.job_contest.allow_public_voting IS 'Cho phép bình chọn công khai.';
COMMENT
ON COLUMN public.job_contest.public_voting_weight IS 'Trọng số của vote công khai trong tổng điểm.';

-- ====================== proposals (chỉ cho BIDDING jobs) ======================
CREATE TABLE public.proposals
(
    id               BIGSERIAL PRIMARY KEY,
    job_id           BIGINT         NOT NULL,
    freelancer_id    BIGINT         NOT NULL,
    price            NUMERIC(19, 4) NOT NULL CHECK (price >= 0),
    currency         VARCHAR(10)    NOT NULL DEFAULT 'VND',
    duration_days    INTEGER CHECK (duration_days > 0),
    cover_letter     TEXT,
    portfolio_links  JSONB                   DEFAULT '[]',
    attachments      JSONB                   DEFAULT '[]',
    status           VARCHAR(20)    NOT NULL DEFAULT 'SUBMITTED' CHECK (status IN
                                                                        ('SUBMITTED', 'SHORTLISTED', 'REJECTED',
                                                                         'ACCEPTED', 'WITHDRAWN')),
    rejection_reason TEXT,
    is_shortlisted   BOOLEAN                 DEFAULT FALSE,
    reviewed_at      TIMESTAMP WITHOUT TIME ZONE,
    reviewed_by      BIGINT,
    created_at       TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    created_by       BIGINT,
    updated_at       TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    updated_by       BIGINT,
    deleted_at       TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_prop_job
        FOREIGN KEY (job_id) REFERENCES public.jobs (id) ON DELETE CASCADE,
    CONSTRAINT fk_prop_freelancer
        FOREIGN KEY (freelancer_id) REFERENCES public.users (id) ON DELETE CASCADE,
    CONSTRAINT uq_proposals_job_freelancer UNIQUE (job_id, freelancer_id)
);

COMMENT
ON TABLE public.proposals IS 'Đề xuất/giá thầu của freelancer cho job BIDDING.';
COMMENT
ON COLUMN public.proposals.price IS 'Giá đề xuất.';
COMMENT
ON COLUMN public.proposals.duration_days IS 'Thời lượng ước tính hoàn thành (ngày).';
COMMENT
ON COLUMN public.proposals.cover_letter IS 'Thư ứng tuyển.';
COMMENT
ON COLUMN public.proposals.portfolio_links IS 'Các đường dẫn portfolio (JSON array).';
COMMENT
ON COLUMN public.proposals.attachments IS 'Tệp đính kèm (JSON array).';
COMMENT
ON COLUMN public.proposals.is_shortlisted IS 'Được shortlist hay không.';

CREATE INDEX idx_proposals_job_id ON public.proposals (job_id);
CREATE INDEX idx_proposals_freelancer_id ON public.proposals (freelancer_id);
CREATE INDEX idx_proposals_status ON public.proposals (status);
CREATE INDEX idx_proposals_price ON public.proposals (job_id, price ASC);
CREATE INDEX idx_proposals_created_at ON public.proposals (created_at DESC);

-- ====================== microtask_assignments ======================
CREATE TABLE public.microtask_assignments
(
    id            BIGSERIAL PRIMARY KEY,
    job_id        BIGINT      NOT NULL,
    worker_id     BIGINT      NOT NULL,
    task_data     JSONB,
    taken_at      TIMESTAMP WITHOUT TIME ZONE,
    submitted_at  TIMESTAMP WITHOUT TIME ZONE,
    reviewed_at   TIMESTAMP WITHOUT TIME ZONE,
    reason        VARCHAR(300),
    result        JSONB,
    quality_score NUMERIC(3, 2) CHECK (quality_score >= 0 AND quality_score <= 1),
    state         VARCHAR(20) NOT NULL DEFAULT 'ASSIGNED' CHECK (state IN
                                                                 ('ASSIGNED', 'IN_PROGRESS', 'SUBMITTED', 'APPROVED',
                                                                  'REJECTED', 'PAID')),
    created_at    TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    created_by    BIGINT,
    updated_at    TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    updated_by    BIGINT,
    deleted_at    TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_microtask_job
        FOREIGN KEY (job_id) REFERENCES public.jobs (id) ON DELETE CASCADE,
    CONSTRAINT fk_microtask_worker
        FOREIGN KEY (worker_id) REFERENCES public.users (id) ON DELETE CASCADE
);

COMMENT
ON TABLE public.microtask_assignments IS 'Gán microtask cụ thể cho worker.';
COMMENT
ON COLUMN public.microtask_assignments.job_id IS 'Job chứa microtask.';
COMMENT
ON COLUMN public.microtask_assignments.worker_id IS 'Worker thực hiện task.';
COMMENT
ON COLUMN public.microtask_assignments.task_data IS 'Dữ liệu cụ thể của task (JSON).';
COMMENT
ON COLUMN public.microtask_assignments.taken_at IS 'Thời điểm worker nhận task.';
COMMENT
ON COLUMN public.microtask_assignments.submitted_at IS 'Thời điểm nộp kết quả.';
COMMENT
ON COLUMN public.microtask_assignments.reviewed_at IS 'Thời điểm được review.';
COMMENT
ON COLUMN public.microtask_assignments.result IS 'Kết quả task (JSON).';
COMMENT
ON COLUMN public.microtask_assignments.quality_score IS 'Điểm chất lượng (0-1).';
COMMENT
ON COLUMN public.microtask_assignments.state IS 'Trạng thái workflow task.';

CREATE INDEX idx_microtask_job ON public.microtask_assignments (job_id);
CREATE INDEX idx_microtask_worker ON public.microtask_assignments (worker_id);
CREATE INDEX idx_microtask_state ON public.microtask_assignments (state);
CREATE INDEX idx_microtask_submit ON public.microtask_assignments (submitted_at) WHERE submitted_at IS NOT NULL;

-- ====================== contest_criteria ======================
CREATE TABLE public.contest_criteria
(
    id          BIGSERIAL PRIMARY KEY,
    job_id      BIGINT       NOT NULL,
    name        VARCHAR(100) NOT NULL,
    description TEXT,
    weight      INTEGER      NOT NULL DEFAULT 1 CHECK (weight > 0),
    max_score   INTEGER      NOT NULL DEFAULT 10 CHECK (max_score > 0),
    sort_order  INTEGER               DEFAULT 0,
    is_active   BOOLEAN               DEFAULT TRUE,
    created_at  TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT fk_criteria_job
        FOREIGN KEY (job_id) REFERENCES public.jobs (id) ON DELETE CASCADE
);

COMMENT
ON TABLE public.contest_criteria IS 'Các tiêu chí chấm điểm contest.';
COMMENT
ON COLUMN public.contest_criteria.name IS 'Tên tiêu chí (VD: Sáng tạo, Tính khả thi).';
COMMENT
ON COLUMN public.contest_criteria.weight IS 'Trọng số tiêu chí trong tổng điểm.';
COMMENT
ON COLUMN public.contest_criteria.max_score IS 'Điểm tối đa cho tiêu chí.';
COMMENT
ON COLUMN public.contest_criteria.sort_order IS 'Thứ tự hiển thị tiêu chí.';

CREATE INDEX idx_criteria_job ON public.contest_criteria (job_id, sort_order);

-- ====================== contest_entries ======================
CREATE TABLE public.contest_entries
(
    id                  BIGSERIAL PRIMARY KEY,
    job_id              BIGINT       NOT NULL,
    participant_id      BIGINT       NOT NULL,
    title               VARCHAR(300) NOT NULL,
    description         TEXT,
    submission_url      TEXT,
    attachments         JSONB                 DEFAULT '[]',
    status              VARCHAR(20)  NOT NULL DEFAULT 'SUBMITTED' CHECK (status IN ('SUBMITTED', 'SHORTLISTED', 'WINNER', 'REJECTED')),
    final_score         NUMERIC(10, 2),
    rank_position       INTEGER,
    is_winner           BOOLEAN               DEFAULT FALSE,
    disqualified_reason TEXT,
    created_at          TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    submitted_at        TIMESTAMP WITHOUT TIME ZONE,
    updated_at          TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT fk_entry_job
        FOREIGN KEY (job_id) REFERENCES public.jobs (id) ON DELETE CASCADE,
    CONSTRAINT fk_entry_participant
        FOREIGN KEY (participant_id) REFERENCES public.users (id) ON DELETE CASCADE,
    CONSTRAINT chk_entry_score CHECK (final_score IS NULL OR final_score >= 0),
    CONSTRAINT chk_entry_rank CHECK (rank_position IS NULL OR rank_position > 0)
);

COMMENT
ON TABLE public.contest_entries IS 'Bài dự thi trong contest.';
COMMENT
ON COLUMN public.contest_entries.job_id IS 'Contest mà entry thuộc về.';
COMMENT
ON COLUMN public.contest_entries.participant_id IS 'Người nộp bài.';
COMMENT
ON COLUMN public.contest_entries.submission_url IS 'Link bài nộp chính.';
COMMENT
ON COLUMN public.contest_entries.attachments IS 'File đính kèm (JSON array).';
COMMENT
ON COLUMN public.contest_entries.final_score IS 'Điểm tổng kết.';
COMMENT
ON COLUMN public.contest_entries.rank_position IS 'Thứ hạng trong contest.';
COMMENT
ON COLUMN public.contest_entries.is_winner IS 'Có phải người thắng cuộc không.';

CREATE INDEX idx_entry_job_id ON public.contest_entries (job_id);
CREATE INDEX idx_entry_participant_id ON public.contest_entries (participant_id);
CREATE INDEX idx_entry_status ON public.contest_entries (status);
CREATE INDEX idx_entry_score ON public.contest_entries (job_id, final_score DESC) WHERE final_score IS NOT NULL;

-- ====================== contest_scores ======================
CREATE TABLE public.contest_scores
(
    id             BIGSERIAL PRIMARY KEY,
    entry_id       BIGINT         NOT NULL,
    criteria_id    BIGINT         NOT NULL,
    judge_id       BIGINT,
    score          NUMERIC(10, 2) NOT NULL CHECK (score >= 0),
    comment        TEXT,
    is_public_vote BOOLEAN DEFAULT FALSE,
    created_at     TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at     TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT fk_score_entry
        FOREIGN KEY (entry_id) REFERENCES public.contest_entries (id) ON DELETE CASCADE,
    CONSTRAINT fk_score_criteria
        FOREIGN KEY (criteria_id) REFERENCES public.contest_criteria (id) ON DELETE CASCADE,
    CONSTRAINT fk_score_judge
        FOREIGN KEY (judge_id) REFERENCES public.users (id) ON DELETE SET NULL,
    CONSTRAINT uq_score_judge_entry_criteria
        UNIQUE (entry_id, criteria_id, judge_id)
);

COMMENT
ON TABLE public.contest_scores IS 'Điểm số của entry theo từng tiêu chí và judge.';
COMMENT
ON COLUMN public.contest_scores.entry_id IS 'Entry được chấm.';
COMMENT
ON COLUMN public.contest_scores.criteria_id IS 'Tiêu chí được chấm.';
COMMENT
ON COLUMN public.contest_scores.judge_id IS 'Judge chấm điểm (NULL nếu là public vote).';
COMMENT
ON COLUMN public.contest_scores.score IS 'Điểm số cho entry theo tiêu chí.';
COMMENT
ON COLUMN public.contest_scores.is_public_vote IS 'Có phải điểm bình chọn công khai không.';

CREATE INDEX idx_score_entry ON public.contest_scores (entry_id);
CREATE INDEX idx_score_criteria ON public.contest_scores (criteria_id);
CREATE INDEX idx_score_judge ON public.contest_scores (judge_id) WHERE judge_id IS NOT NULL;

-- ====================== contest_prizes ======================
CREATE TABLE public.contest_prizes
(
    id          BIGSERIAL PRIMARY KEY,
    job_id      BIGINT         NOT NULL,
    rank        INTEGER        NOT NULL CHECK (rank > 0),
    amount      NUMERIC(19, 4) NOT NULL CHECK (amount >= 0),
    currency    VARCHAR(10)    NOT NULL DEFAULT 'VND',
    title       VARCHAR(100),
    description TEXT,
    created_at  TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT fk_prize_job
        FOREIGN KEY (job_id) REFERENCES public.jobs (id) ON DELETE CASCADE,
    CONSTRAINT uq_prize_job_rank UNIQUE (job_id, rank)
);

COMMENT
ON TABLE public.contest_prizes IS 'Cơ cấu giải thưởng cho contest.';
COMMENT
ON COLUMN public.contest_prizes.job_id IS 'Contest liên quan.';
COMMENT
ON COLUMN public.contest_prizes.rank IS 'Thứ hạng nhận giải (1=giải nhất).';
COMMENT
ON COLUMN public.contest_prizes.amount IS 'Số tiền thưởng.';
COMMENT
ON COLUMN public.contest_prizes.title IS 'Tên giải thưởng (VD: Giải Nhất, Giải Khuyến Khích).';

CREATE INDEX idx_prize_job_id ON public.contest_prizes (job_id, rank);

-- ====================== contracts (chỉ cho BIDDING jobs) ======================
CREATE TABLE public.contracts
(
    id                 BIGSERIAL PRIMARY KEY,
    job_id             BIGINT         NOT NULL UNIQUE,
    proposal_id        BIGINT         NOT NULL,
    employer_id        BIGINT         NOT NULL,
    freelancer_id      BIGINT         NOT NULL,
    title              VARCHAR(300)   NOT NULL,
    description        TEXT,
    total_amount       NUMERIC(19, 4) NOT NULL CHECK (total_amount >= 0),
    currency           VARCHAR(10)    NOT NULL DEFAULT 'VND',
    start_date         DATE,
    end_date           DATE,
    status             VARCHAR(20)    NOT NULL DEFAULT 'ACTIVE' CHECK (status IN
                                                                       ('ACTIVE', 'PENDING', 'PAUSED', 'COMPLETED',
                                                                        'CANCELLED', 'TERMINATED')),
    termination_reason TEXT,
    terms_conditions   TEXT,
    created_at         TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    created_by         BIGINT,
    updated_at         TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    updated_by         BIGINT,
    deleted_at         TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_contract_job
        FOREIGN KEY (job_id) REFERENCES public.jobs (id) ON DELETE RESTRICT,
    CONSTRAINT fk_contract_proposal
        FOREIGN KEY (proposal_id) REFERENCES public.proposals (id) ON DELETE RESTRICT,
    CONSTRAINT fk_contract_employer
        FOREIGN KEY (employer_id) REFERENCES public.users (id) ON DELETE RESTRICT,
    CONSTRAINT fk_contract_freelancer
        FOREIGN KEY (freelancer_id) REFERENCES public.users (id) ON DELETE RESTRICT,
    CONSTRAINT chk_contract_dates
        CHECK (start_date IS NULL OR end_date IS NULL OR start_date <= end_date)
);

COMMENT
ON TABLE public.contracts IS 'Hợp đồng giữa employer và freelancer (chỉ cho BIDDING jobs).';
COMMENT
ON COLUMN public.contracts.total_amount IS 'Tổng giá trị hợp đồng.';
COMMENT
ON COLUMN public.contracts.start_date IS 'Ngày bắt đầu hợp đồng.';
COMMENT
ON COLUMN public.contracts.end_date IS 'Ngày kết thúc hợp đồng.';
COMMENT
ON COLUMN public.contracts.terms_conditions IS 'Điều khoản hợp đồng.';

CREATE INDEX idx_contracts_status ON public.contracts (status);
CREATE INDEX idx_contracts_parties ON public.contracts (employer_id, freelancer_id);
CREATE INDEX idx_contracts_dates ON public.contracts (start_date, end_date);
CREATE INDEX idx_contracts_created_at ON public.contracts (created_at DESC);

-- ====================== milestones ======================
CREATE TABLE public.milestones
(
    id           BIGSERIAL PRIMARY KEY,
    contract_id  BIGINT         NOT NULL,
    title        VARCHAR(300)   NOT NULL,
    description  TEXT,
    amount       NUMERIC(19, 4) NOT NULL CHECK (amount >= 0),
    currency     VARCHAR(10)    NOT NULL DEFAULT 'VND',
    due_date     DATE,
    status       VARCHAR(20)    NOT NULL DEFAULT 'PENDING' CHECK (status IN
                                                                  ('PENDING', 'FUNDED', 'SUBMITTED', 'APPROVED', 'PAID',
                                                                   'REJECTED')),
    sequence_no  INTEGER        NOT NULL CHECK (sequence_no >= 1),
    completed_at TIMESTAMP WITHOUT TIME ZONE,
    approved_at  TIMESTAMP WITHOUT TIME ZONE,
    approved_by  BIGINT,
    created_at   TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    created_by   BIGINT,
    updated_at   TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    updated_by   BIGINT,
    deleted_at   TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_milestone_contract
        FOREIGN KEY (contract_id) REFERENCES public.contracts (id) ON DELETE CASCADE,
    CONSTRAINT uq_milestone_sequence UNIQUE (contract_id, sequence_no)
);

COMMENT
ON TABLE public.milestones IS 'Các mốc thanh toán trong hợp đồng.';
COMMENT
ON COLUMN public.milestones.sequence_no IS 'Thứ tự milestone (>= 1).';
COMMENT
ON COLUMN public.milestones.due_date IS 'Hạn hoàn thành milestone.';
COMMENT
ON COLUMN public.milestones.completed_at IS 'Thời điểm hoàn thành.';
COMMENT
ON COLUMN public.milestones.approved_at IS 'Thời điểm được duyệt.';

CREATE INDEX idx_milestones_contract ON public.milestones (contract_id, sequence_no);
CREATE INDEX idx_milestones_status ON public.milestones (status);
CREATE INDEX idx_milestones_due_date ON public.milestones (due_date) WHERE due_date IS NOT NULL;

-- ====================== deliverables ======================
CREATE TABLE public.deliverables
(
    id           BIGSERIAL PRIMARY KEY,
    milestone_id BIGINT       NOT NULL,
    title        VARCHAR(300) NOT NULL,
    description  TEXT,
    file_urls    JSONB DEFAULT '[]',
    notes        TEXT,
    submitted_at TIMESTAMP WITHOUT TIME ZONE,
    reviewed_at  TIMESTAMP WITHOUT TIME ZONE,
    review_notes TEXT,
    created_at   TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    created_by   BIGINT,
    updated_at   TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    updated_by   BIGINT,
    deleted_at   TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_deliverable_milestone
        FOREIGN KEY (milestone_id) REFERENCES public.milestones (id) ON DELETE CASCADE
);

COMMENT
ON TABLE public.deliverables IS 'Sản phẩm bàn giao cho milestone.';
COMMENT
ON COLUMN public.deliverables.file_urls IS 'Danh sách file đính kèm (JSON array).';
COMMENT
ON COLUMN public.deliverables.submitted_at IS 'Thời điểm nộp bài.';
COMMENT
ON COLUMN public.deliverables.reviewed_at IS 'Thời điểm review.';
COMMENT
ON COLUMN public.deliverables.review_notes IS 'Ghi chú review.';

CREATE INDEX idx_deliverables_milestone ON public.deliverables (milestone_id);
CREATE INDEX idx_deliverables_submitted ON public.deliverables (submitted_at) WHERE submitted_at IS NOT NULL;

-- ====================== escrows ======================
CREATE TABLE public.escrows
(
    id           BIGSERIAL PRIMARY KEY,
    contract_id  BIGINT         NOT NULL,
    milestone_id BIGINT UNIQUE,
    amount       NUMERIC(19, 4) NOT NULL CHECK (amount >= 0),
    currency     VARCHAR(10)    NOT NULL DEFAULT 'VND',
    state        VARCHAR(20)    NOT NULL DEFAULT 'HELD' CHECK (state IN ('HELD', 'RELEASED', 'REFUNDED', 'EXPIRED')),
    released_at  TIMESTAMP WITHOUT TIME ZONE,
    released_to  BIGINT,
    refunded_at  TIMESTAMP WITHOUT TIME ZONE,
    refunded_to  BIGINT,
    notes        TEXT,
    created_at   TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    created_by   BIGINT,
    updated_at   TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    updated_by   BIGINT,
    deleted_at   TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_escrow_contract
        FOREIGN KEY (contract_id) REFERENCES public.contracts (id) ON DELETE CASCADE,
    CONSTRAINT fk_escrow_milestone
        FOREIGN KEY (milestone_id) REFERENCES public.milestones (id) ON DELETE SET NULL,
    CONSTRAINT fk_escrow_released_to
        FOREIGN KEY (released_to) REFERENCES public.users (id),
    CONSTRAINT fk_escrow_refunded_to
        FOREIGN KEY (refunded_to) REFERENCES public.users (id)
);

COMMENT
ON TABLE public.escrows IS 'Ký quỹ tiền cho hợp đồng/milestone.';
COMMENT
ON COLUMN public.escrows.released_at IS 'Thời điểm giải ngân.';
COMMENT
ON COLUMN public.escrows.released_to IS 'Người nhận tiền giải ngân.';
COMMENT
ON COLUMN public.escrows.refunded_at IS 'Thời điểm hoàn tiền.';
COMMENT
ON COLUMN public.escrows.refunded_to IS 'Người nhận tiền hoàn.';

CREATE INDEX idx_escrows_contract ON public.escrows (contract_id);
CREATE INDEX idx_escrows_state ON public.escrows (state);

-- ====================== feedbacks ======================
CREATE TABLE public.feedbacks
(
    id           BIGSERIAL PRIMARY KEY,
    contract_id  BIGINT      NOT NULL,
    rater_id     BIGINT      NOT NULL,
    ratee_id     BIGINT      NOT NULL,
    rating       INTEGER     NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment      TEXT,
    tags         JSONB                DEFAULT '[]',
    visibility   VARCHAR(20) NOT NULL DEFAULT 'PUBLIC' CHECK (visibility IN ('PUBLIC', 'PRIVATE', 'HIDDEN')),
    is_anonymous BOOLEAN              DEFAULT FALSE,
    created_at   TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    created_by   BIGINT,
    updated_at   TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    updated_by   BIGINT,
    deleted_at   TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_feedback_contract
        FOREIGN KEY (contract_id) REFERENCES public.contracts (id) ON DELETE CASCADE,
    CONSTRAINT fk_feedback_rater
        FOREIGN KEY (rater_id) REFERENCES public.users (id) ON DELETE CASCADE,
    CONSTRAINT fk_feedback_ratee
        FOREIGN KEY (ratee_id) REFERENCES public.users (id) ON DELETE CASCADE,
    CONSTRAINT chk_feedback_different_users CHECK (rater_id != ratee_id
)
    );

COMMENT
ON TABLE public.feedbacks IS 'Đánh giá giữa users trong hợp đồng.';
COMMENT
ON COLUMN public.feedbacks.rating IS 'Điểm đánh giá (1–5).';
COMMENT
ON COLUMN public.feedbacks.tags IS 'Các thẻ đánh giá (JSON array).';
COMMENT
ON COLUMN public.feedbacks.is_anonymous IS 'Đánh giá ẩn danh.';

CREATE INDEX idx_feedbacks_contract ON public.feedbacks (contract_id);
CREATE INDEX idx_feedbacks_ratee ON public.feedbacks (ratee_id, visibility);
CREATE INDEX idx_feedbacks_rating ON public.feedbacks (rating DESC);
CREATE INDEX idx_feedbacks_created_at ON public.feedbacks (created_at DESC);

-- ====================== messages ======================
CREATE TABLE public.messages
(
    id           BIGSERIAL PRIMARY KEY,
    contract_id  BIGINT,
    job_id       BIGINT,
    sender_id    BIGINT NOT NULL,
    recipient_id BIGINT,
    content      TEXT,
    attachments  JSONB       DEFAULT '[]',
    is_read      BOOLEAN     DEFAULT FALSE,
    read_at      TIMESTAMP WITHOUT TIME ZONE,
    message_type VARCHAR(50) DEFAULT 'TEXT',
    created_at   TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    created_by   BIGINT,
    updated_at   TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    updated_by   BIGINT,
    deleted_at   TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_message_contract
        FOREIGN KEY (contract_id) REFERENCES public.contracts (id) ON DELETE CASCADE,
    CONSTRAINT fk_message_job
        FOREIGN KEY (job_id) REFERENCES public.jobs (id) ON DELETE CASCADE,
    CONSTRAINT fk_message_sender
        FOREIGN KEY (sender_id) REFERENCES public.users (id) ON DELETE CASCADE,
    CONSTRAINT fk_message_recipient
        FOREIGN KEY (recipient_id) REFERENCES public.users (id) ON DELETE CASCADE,
    CONSTRAINT chk_message_context CHECK (
        (contract_id IS NOT NULL AND job_id IS NULL) OR
        (contract_id IS NULL AND job_id IS NOT NULL) OR
        (contract_id IS NULL AND job_id IS NULL AND recipient_id IS NOT NULL)
        )
);

COMMENT
ON TABLE public.messages IS 'Tin nhắn giữa users (theo contract, job, hoặc riêng tư).';
COMMENT
ON COLUMN public.messages.contract_id IS 'Thuộc contract nào (nếu có).';
COMMENT
ON COLUMN public.messages.job_id IS 'Thuộc job nào (nếu có).';
COMMENT
ON COLUMN public.messages.sender_id IS 'Người gửi.';
COMMENT
ON COLUMN public.messages.recipient_id IS 'Người nhận (cho tin nhắn riêng).';
COMMENT
ON COLUMN public.messages.attachments IS 'Tệp đính kèm (JSON array).';
COMMENT
ON COLUMN public.messages.message_type IS 'Loại tin nhắn (TEXT, IMAGE, FILE, etc).';

CREATE INDEX idx_messages_contract ON public.messages (contract_id, created_at DESC) WHERE contract_id IS NOT NULL;
CREATE INDEX idx_messages_job ON public.messages (job_id, created_at DESC) WHERE job_id IS NOT NULL;
CREATE INDEX idx_messages_conversation ON public.messages (sender_id, recipient_id, created_at DESC) WHERE recipient_id IS NOT NULL;
CREATE INDEX idx_messages_unread ON public.messages (recipient_id) WHERE is_read = FALSE;

-- ====================== withdraw_requests ======================
CREATE TABLE public.withdraw_requests
(
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT         NOT NULL,
    wallet_id       BIGINT         NOT NULL,
    amount          NUMERIC(19, 4) NOT NULL CHECK (amount >= 100000), -- tối thiểu 100k VND
    fee_amount      NUMERIC(19, 4)          DEFAULT 0 CHECK (fee_amount >= 0),
    net_amount      NUMERIC(19, 4) NOT NULL CHECK (net_amount > 0),
    method          VARCHAR(20)    NOT NULL CHECK (method IN ('BANK', 'QR')),
    bank_name       VARCHAR(100),
    account_number  VARCHAR(50),
    account_name    VARCHAR(100),
    branch_name     VARCHAR(100),
    qr_code_path    VARCHAR(255),
    notes           TEXT,
    status          VARCHAR(20)    NOT NULL DEFAULT 'PENDING' CHECK (status IN
                                                                     ('PENDING', 'APPROVED', 'REJECTED', 'CANCELLED',
                                                                      'PROCESSING', 'COMPLETED')),
    admin_notes     TEXT,
    reviewed_by     BIGINT,
    reviewed_at     TIMESTAMP WITHOUT TIME ZONE,
    processed_at    TIMESTAMP WITHOUT TIME ZONE,
    rejected_reason TEXT,
    created_at      TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    CONSTRAINT fk_withdraw_user
        FOREIGN KEY (user_id) REFERENCES public.users (id) ON DELETE CASCADE,
    CONSTRAINT fk_withdraw_wallet
        FOREIGN KEY (wallet_id) REFERENCES public.wallets (id) ON DELETE CASCADE,
    CONSTRAINT fk_withdraw_reviewer
        FOREIGN KEY (reviewed_by) REFERENCES public.users (id)
);

COMMENT
ON TABLE public.withdraw_requests IS 'Yêu cầu rút tiền của người dùng.';
COMMENT
ON COLUMN public.withdraw_requests.amount IS 'Số tiền yêu cầu rút.';
COMMENT
ON COLUMN public.withdraw_requests.fee_amount IS 'Phí rút tiền.';
COMMENT
ON COLUMN public.withdraw_requests.net_amount IS 'Số tiền thực nhận.';
COMMENT
ON COLUMN public.withdraw_requests.method IS 'Phương thức rút tiền.';
COMMENT
ON COLUMN public.withdraw_requests.reviewed_by IS 'Admin xử lý.';

CREATE INDEX idx_withdraw_user ON public.withdraw_requests (user_id);
CREATE INDEX idx_withdraw_status ON public.withdraw_requests (status);
CREATE INDEX idx_withdraw_created_at ON public.withdraw_requests (created_at DESC);

-- ====================== notifications ======================
CREATE TABLE public.notifications
(
    id                  BIGSERIAL PRIMARY KEY,
    user_id             BIGINT       NOT NULL,
    title               VARCHAR(200) NOT NULL,
    content             TEXT,
    type                VARCHAR(20)  NOT NULL CHECK (type IN ('JOB', 'PROPOSAL', 'CONTRACT', 'CHAT', 'WALLET', 'SYSTEM',
                                                              'MILESTONE', 'CONTEST', 'MICROTASK')),
    related_entity_type VARCHAR(50),
    related_entity_id   BIGINT,
    action_url          VARCHAR(500),
    is_read             BOOLEAN      NOT NULL DEFAULT FALSE,
    priority            VARCHAR(20)  NOT NULL DEFAULT 'NORMAL' CHECK (priority IN ('LOW', 'NORMAL', 'HIGH', 'URGENT')),
    expires_at          TIMESTAMP WITHOUT TIME ZONE,
    metadata            JSONB                 DEFAULT '{}',
    created_at          TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    read_at             TIMESTAMP WITHOUT TIME ZONE,
    deleted_at          TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_notifications_user
        FOREIGN KEY (user_id) REFERENCES public.users (id) ON DELETE CASCADE
);

COMMENT
ON TABLE public.notifications IS 'Hệ thống thông báo cho người dùng.';
COMMENT
ON COLUMN public.notifications.id IS 'Khóa chính tự tăng.';
COMMENT
ON COLUMN public.notifications.user_id IS 'Người nhận thông báo (FK users.id).';
COMMENT
ON COLUMN public.notifications.title IS 'Tiêu đề thông báo (tối đa 200 ký tự).';
COMMENT
ON COLUMN public.notifications.content IS 'Nội dung chi tiết thông báo.';
COMMENT
ON COLUMN public.notifications.type IS 'Loại thông báo: JOB, PROPOSAL, CONTRACT, CHAT, WALLET, SYSTEM, etc.';
COMMENT
ON COLUMN public.notifications.related_entity_type IS 'Loại entity liên quan (jobs, proposals, contracts, messages, etc.).';
COMMENT
ON COLUMN public.notifications.related_entity_id IS 'ID của entity liên quan.';
COMMENT
ON COLUMN public.notifications.action_url IS 'URL để redirect khi click vào thông báo.';
COMMENT
ON COLUMN public.notifications.is_read IS 'Trạng thái đã đọc hay chưa.';
COMMENT
ON COLUMN public.notifications.priority IS 'Mức độ ưu tiên thông báo.';
COMMENT
ON COLUMN public.notifications.expires_at IS 'Thời điểm hết hạn thông báo (NULL = không hết hạn).';
COMMENT
ON COLUMN public.notifications.metadata IS 'Thông tin bổ sung dạng JSON.';
COMMENT
ON COLUMN public.notifications.created_at IS 'Thời điểm tạo thông báo.';
COMMENT
ON COLUMN public.notifications.read_at IS 'Thời điểm đọc thông báo.';
COMMENT
ON COLUMN public.notifications.deleted_at IS 'Thời điểm xóa mềm thông báo.';

CREATE INDEX idx_notifications_user_id ON public.notifications (user_id);
CREATE INDEX idx_notifications_unread ON public.notifications (user_id, is_read) WHERE is_read = FALSE AND deleted_at IS NULL;
CREATE INDEX idx_notifications_type ON public.notifications (type);
CREATE INDEX idx_notifications_priority ON public.notifications (priority);
CREATE INDEX idx_notifications_created_at ON public.notifications (user_id, created_at DESC) WHERE deleted_at IS NULL;
CREATE INDEX idx_notifications_entity ON public.notifications (related_entity_type, related_entity_id) WHERE related_entity_type IS NOT NULL;
CREATE INDEX idx_notifications_expires_at ON public.notifications (expires_at) WHERE expires_at IS NOT NULL;
CREATE INDEX idx_notifications_user_unread_priority ON public.notifications (user_id, is_read, priority, created_at DESC) WHERE deleted_at IS NULL;
-- ====================== DUMMY DATA FOR FREELANCE PLATFORM ======================
-- Chạy sau khi tạo schema
-- Insert Categories (15 records)
INSERT INTO public.categories (name, slug, description, sort_order, is_active)
VALUES ('Lập trình & Phát triển', 'lap-trinh-phat-trien', 'Phát triển web, mobile, desktop applications', 1, true),
       ('Thiết kế & Sáng tạo', 'thiet-ke-sang-tao', 'Thiết kế UI/UX, graphic design, branding', 2, true),
       ('Viết lách & Dịch thuật', 'viet-lach-dich-thuat', 'Content writing, copywriting, translation', 3, true),
       ('Marketing & Quảng cáo', 'marketing-quang-cao', 'Digital marketing, SEO, social media', 4, true),
       ('Video & Animation', 'video-animation', 'Video editing, motion graphics, 3D animation', 5, true),
       ('Kinh doanh & Tư vấn', 'kinh-doanh-tu-van', 'Business consulting, project management', 6, true),
       ('Âm nhạc & Audio', 'am-nhac-audio', 'Music production, voice over, sound design', 7, true),
       ('Nhiếp ảnh', 'nhiep-anh', 'Photography, photo editing, product photos', 8, true),
       ('Dữ liệu & Phân tích', 'du-lieu-phan-tich', 'Data entry, analysis, reporting', 9, true),
       ('Mobile App', 'mobile-app', 'iOS/Android app development', 10, true),
       ('E-commerce', 'e-commerce', 'Online store setup, product management', 11, true),
       ('Giáo dục & Đào tạo', 'giao-duc-dao-tao', 'Online teaching, course creation', 12, true),
       ('Kế toán & Tài chính', 'ke-toan-tai-chinh', 'Accounting, bookkeeping, financial analysis', 13, true),
       ('Pháp lý', 'phap-ly', 'Legal consulting, document drafting', 14, true),
       ('Khác', 'khac', 'Other services', 15, true);

-- Insert Skills (40 records)
INSERT INTO public.skills (name, slug, description, category_id, is_active)
VALUES
-- Programming skills (category 1)
('JavaScript', 'javascript', 'Ngôn ngữ lập trình JavaScript', 1, true),
('Python', 'python', 'Ngôn ngữ lập trình Python', 1, true),
('React', 'react', 'Framework React.js', 1, true),
('Node.js', 'nodejs', 'Runtime Node.js', 1, true),
('Vue.js', 'vuejs', 'Framework Vue.js', 1, true),
('PHP', 'php', 'Ngôn ngữ lập trình PHP', 1, true),
('Laravel', 'laravel', 'Framework Laravel', 1, true),
('MySQL', 'mysql', 'Database MySQL', 1, true),
('PostgreSQL', 'postgresql', 'Database PostgreSQL', 1, true),
('Java', 'java', 'Ngôn ngữ lập trình Java', 1, true),
-- Design skills (category 2)
('Photoshop', 'photoshop', 'Adobe Photoshop', 2, true),
('Illustrator', 'illustrator', 'Adobe Illustrator', 2, true),
('Figma', 'figma', 'Công cụ thiết kế Figma', 2, true),
('UI/UX Design', 'ui-ux-design', 'Thiết kế giao diện người dùng', 2, true),
('Logo Design', 'logo-design', 'Thiết kế logo', 2, true),
('Sketch', 'sketch', 'Công cụ thiết kế Sketch', 2, true),
-- Writing skills (category 3)
('Content Writing', 'content-writing', 'Viết nội dung', 3, true),
('Copywriting', 'copywriting', 'Viết quảng cáo', 3, true),
('Translation', 'translation', 'Dịch thuật', 3, true),
('Blog Writing', 'blog-writing', 'Viết blog', 3, true),
-- Marketing skills (category 4)
('SEO', 'seo', 'Tối ưu hóa công cụ tìm kiếm', 4, true),
('Google Ads', 'google-ads', 'Quảng cáo Google', 4, true),
('Facebook Ads', 'facebook-ads', 'Quảng cáo Facebook', 4, true),
('Social Media Marketing', 'social-media-marketing', 'Marketing trên mạng xã hội', 4, true),
-- Video skills (category 5)
('Video Editing', 'video-editing', 'Chỉnh sửa video', 5, true),
('After Effects', 'after-effects', 'Adobe After Effects', 5, true),
('Premiere Pro', 'premiere-pro', 'Adobe Premiere Pro', 5, true),
-- Mobile skills (category 10)
('iOS Development', 'ios-development', 'Phát triển ứng dụng iOS', 10, true),
('Android Development', 'android-development', 'Phát triển ứng dụng Android', 10, true),
('React Native', 'react-native', 'Framework React Native', 10, true),
('Flutter', 'flutter', 'Framework Flutter', 10, true),
-- Data skills (category 9)
('Excel', 'excel', 'Microsoft Excel', 9, true),
('Data Entry', 'data-entry', 'Nhập liệu', 9, true),
('Data Analysis', 'data-analysis', 'Phân tích dữ liệu', 9, true),
('SQL', 'sql', 'Ngôn ngữ truy vấn SQL', 9, true),
-- Business skills (category 6)
('Project Management', 'project-management', 'Quản lý dự án', 6, true),
('Business Analysis', 'business-analysis', 'Phân tích kinh doanh', 6, true),
-- Other skills
('WordPress', 'wordpress', 'CMS WordPress', 1, true),
('Shopify', 'shopify', 'Platform Shopify', 11, true),
('Customer Service', 'customer-service', 'Chăm sóc khách hàng', 15, true),
('Virtual Assistant', 'virtual-assistant', 'Trợ lý ảo', 15, true);

-- Insert Users (120 users total)
-- Admins (5)
INSERT INTO public.users (username, password_hash, email, full_name, role, status, active_status, phone, timezone,
                          language)
VALUES ('admin_1', '123', 'admin1@platform.vn', 'Nguyễn Văn Admin', 'ADMIN', 'ACTIVE', 'ONLINE', '0901000001',
        'Asia/Ho_Chi_Minh', 'vi'),
       ('admin_2', '123', 'admin2@platform.vn', 'Trần Thị Manager', 'ADMIN', 'ACTIVE', 'OFFLINE', '0901000002',
        'Asia/Ho_Chi_Minh', 'vi'),
       ('admin_3', '123', 'admin3@platform.vn', 'Lê Văn Support', 'ADMIN', 'ACTIVE', 'AWAY', '0901000003',
        'Asia/Ho_Chi_Minh', 'vi'),
       ('admin_4', '123', 'admin4@platform.vn', 'Phạm Thị System', 'ADMIN', 'ACTIVE', 'BUSY', '0901000004',
        'Asia/Ho_Chi_Minh', 'vi'),
       ('admin_5', '123', 'admin5@platform.vn', 'Hoàng Văn Tech', 'ADMIN', 'ACTIVE', 'ONLINE', '0901000005',
        'Asia/Ho_Chi_Minh', 'vi');

-- Generate Employers (35 users)
DO
$$
DECLARE
i INTEGER;
    company_names
TEXT[] := ARRAY[
        'Công ty TNHH ABC', 'Startup Tech XYZ', 'Digital Agency Pro', 'E-commerce Solutions', 
        'Marketing Hub', 'Creative Studio', 'Software House', 'Business Consulting',
        'Fashion Brand', 'Food & Beverage Co', 'Real Estate Group', 'Healthcare Solutions',
        'Education Platform', 'Financial Services', 'Travel Company'
    ];
BEGIN
FOR i IN 1..35 LOOP
        INSERT INTO public.users (username, password_hash, email, full_name, role, status, active_status, phone, timezone, language, created_at) VALUES
        ('employer_' || LPAD(i::TEXT, 3, '0'), 
         '123', 
         'employer' || i || '@company.vn', 
         company_names[1 + (i % array_length(company_names, 1))] || ' ' || i,
         'USER', 'ACTIVE', 
         CASE (i % 4) WHEN 0 THEN 'ONLINE' WHEN 1 THEN 'OFFLINE' WHEN 2 THEN 'AWAY' ELSE 'BUSY' END,
         '090200' || LPAD(i::TEXT, 4, '0'), 
         'Asia/Ho_Chi_Minh', 'vi',
         NOW() - INTERVAL '1 day' * (RANDOM() * 365));
END LOOP;
END $$;

-- Generate Freelancers (80 users)
DO
$$
DECLARE
i INTEGER;
    first_names
TEXT[] := ARRAY['Nguyễn', 'Trần', 'Lê', 'Phạm', 'Hoàng', 'Phan', 'Vũ', 'Đặng', 'Bùi', 'Đỗ', 'Hồ', 'Ngô', 'Dương', 'Lý', 'Mai', 'Tô', 'Đinh', 'Cao'];
    middle_names
TEXT[] := ARRAY['Văn', 'Thị', 'Minh', 'Hoàng', 'Thu', 'Anh', 'Đức', 'Hà', 'Linh', 'Quang', 'Hương', 'Tuấn'];
    last_names
TEXT[] := ARRAY['An', 'Bình', 'Cường', 'Dũng', 'Em', 'Giang', 'Hải', 'Khánh', 'Long', 'Nam', 'Oanh', 'Phúc', 'Quân', 'Sơn', 'Thắng', 'Uyên', 'Vân', 'Xuân', 'Yến', 'Zung'];
BEGIN
FOR i IN 1..80 LOOP
        INSERT INTO public.users (username, password_hash, email, full_name, role, status, active_status, phone, timezone, language, created_at) VALUES
        ('freelancer_' || LPAD(i::TEXT, 3, '0'), 
         '123', 
         'freelancer' || i || '@gmail.com', 
         first_names[1 + (i % array_length(first_names, 1))] || ' ' || 
         middle_names[1 + ((i * 2) % array_length(middle_names, 1))] || ' ' || 
         last_names[1 + ((i * 3) % array_length(last_names, 1))],
         'USER', 'ACTIVE', 
         CASE (i % 4) WHEN 0 THEN 'ONLINE' WHEN 1 THEN 'OFFLINE' WHEN 2 THEN 'AWAY' ELSE 'BUSY' END,
         '090300' || LPAD(i::TEXT, 4, '0'), 
         'Asia/Ho_Chi_Minh', 
         CASE WHEN i % 5 = 0 THEN 'en' ELSE 'vi' END,
         NOW() - INTERVAL '1 day' * (RANDOM() * 300));
END LOOP;
END $$;

-- Insert Wallets for all users
INSERT INTO public.wallets (user_id, balance_available, balance_frozen, total_earned, total_spent, currency)
SELECT u.id,
       CASE
           WHEN u.role = 'ADMIN' THEN 0
           WHEN u.username LIKE 'freelancer_%' THEN ROUND((RANDOM() * 8000000 + 500000):: NUMERIC, 2) -- 500k - 8.5M VND
           ELSE ROUND((RANDOM() * 25000000 + 2000000):: NUMERIC, 2) -- 2M - 27M VND for employers
           END,
       CASE WHEN RANDOM() > 0.8 THEN ROUND((RANDOM() * 2000000):: NUMERIC, 2) ELSE 0 END, -- 20% có tiền frozen
       CASE
           WHEN u.username LIKE 'freelancer_%' THEN ROUND((RANDOM() * 100000000):: NUMERIC, 2)
           ELSE 0
           END,
       CASE
           WHEN u.username LIKE 'employer_%' THEN ROUND((RANDOM() * 50000000):: NUMERIC, 2)
           WHEN u.username LIKE 'freelancer_%' THEN ROUND((RANDOM() * 10000000):: NUMERIC, 2)
           ELSE 0
           END,
       'VND'
FROM public.users u;

-- Insert Profiles for all users
INSERT INTO public.profiles (user_id, bio, rating_avg, rating_count, completed_jobs,
                             skills, experience_years, education_level, location,
                             hourly_rate_min, hourly_rate_max, currency, is_verified)
SELECT u.id,
       CASE
           WHEN u.username LIKE 'freelancer_%' THEN
               'Tôi là freelancer chuyên nghiệp với ' || (RANDOM() * 8 + 1)::INTEGER ||
            ' năm kinh nghiệm trong lĩnh vực ' || 
            CASE (u.id % 6) 
                WHEN 0 THEN 'lập trình web và mobile'
                WHEN 1 THEN 'thiết kế UI/UX và đồ họa' 
                WHEN 2 THEN 'digital marketing và SEO'
                WHEN 3 THEN 'viết nội dung và copywriting'
                WHEN 4 THEN 'chỉnh sửa video và animation'
                ELSE 'phân tích dữ liệu và tư vấn'
END
|| '. Cam kết chất lượng cao và giao hàng đúng hạn.'
        WHEN u.username LIKE 'employer_%' THEN 
            'Chúng tôi là công ty chuyên nghiệp hoạt động trong lĩnh vực ' ||
            CASE (u.id % 5)
                WHEN 0 THEN 'công nghệ thông tin'
                WHEN 1 THEN 'thương mại điện tử'
                WHEN 2 THEN 'marketing và quảng cáo'
                WHEN 3 THEN 'giáo dục và đào tạo'
                ELSE 'dịch vụ tài chính'
END
|| '. Tìm kiếm freelancer tài năng để hợp tác dài hạn.'
        ELSE 'Quản trị viên hệ thống.'
END
,
    CASE WHEN u.username LIKE 'freelancer_%' THEN ROUND((RANDOM() * 4 + 1)::NUMERIC, 2) ELSE NULL
END
,
    CASE WHEN u.username LIKE 'freelancer_%' THEN (RANDOM() * 200)::INTEGER ELSE 0
END
,
    CASE WHEN u.username LIKE 'freelancer_%' THEN (RANDOM() * 100)::INTEGER ELSE 0
END
,
    CASE 
        WHEN u.username LIKE 'freelancer_%' THEN 
            JSON_BUILD_ARRAY(
                'JavaScript', 'HTML/CSS', 
                CASE (u.id % 8)
                    WHEN 0 THEN 'React'
                    WHEN 1 THEN 'Vue.js'
                    WHEN 2 THEN 'Python'
                    WHEN 3 THEN 'PHP'
                    WHEN 4 THEN 'Photoshop'
                    WHEN 5 THEN 'SEO'
                    WHEN 6 THEN 'Content Writing'
                    ELSE 'Video Editing'
                END
            )::JSONB
        ELSE '[]'::JSONB
END
,
    CASE WHEN u.username LIKE 'freelancer_%' THEN (RANDOM() * 12)::INTEGER ELSE NULL
END
,
    CASE 
        WHEN u.username LIKE 'freelancer_%' THEN 
            CASE (u.id % 5)
                WHEN 0 THEN 'Đại học'
                WHEN 1 THEN 'Cao đẳng' 
                WHEN 2 THEN 'Trung cấp'
                WHEN 3 THEN 'Tự học'
                ELSE 'Thạc sĩ'
END
ELSE NULL
END
,
    CASE (u.id % 8)
        WHEN 0 THEN 'Hà Nội'
        WHEN 1 THEN 'Hồ Chí Minh'
        WHEN 2 THEN 'Đà Nẵng'
        WHEN 3 THEN 'Hải Phòng'
        WHEN 4 THEN 'Cần Thơ'
        WHEN 5 THEN 'Nghệ An'
        WHEN 6 THEN 'Thừa Thiên Huế'
        ELSE 'Bình Dương'
END
,
    -- gán cứng để khỏi vi phạm constraint
    CASE WHEN u.username LIKE 'freelancer_%' THEN 200000 ELSE NULL
END
,
    CASE WHEN u.username LIKE 'freelancer_%' THEN 500000 ELSE NULL
END
,
    'VND',
    RANDOM() > 0.4
FROM public.users u;

-- Insert Jobs (150 jobs với 3 loại)
DO
$$
DECLARE
i INTEGER;
    employer_id
BIGINT;
    category_id
BIGINT;
    job_type_val
VARCHAR(20);
    bidding_titles
TEXT[] := ARRAY[
        'Thiết kế website responsive cho doanh nghiệp',
        'Phát triển ứng dụng mobile iOS và Android', 
        'Thiết kế logo và brand identity hoàn chỉnh',
        'Viết content blog và SEO cho 6 tháng',
        'Quản lý fanpage và chạy ads Facebook/Google',
        'Làm video marketing và motion graphics',
        'Phát triển API REST và tích hợp database',
        'Thiết kế UI/UX cho ứng dụng fintech',
        'Dịch tài liệu từ tiếng Anh sang tiếng Việt',
        'Tạo hệ thống CRM cho công ty',
        'Phát triển website e-commerce với Shopify',
        'Thiết kế brochure và catalog sản phẩm',
        'Tư vấn chiến lược marketing online',
        'Phát triển chatbot tự động cho website',
        'Thiết kế giao diện admin panel'
    ];
    microtask_titles
TEXT[] := ARRAY[
        'Nhập liệu từ hóa đơn giấy vào Excel',
        'Kiểm tra và sửa lỗi chính tả trong database',
        'Thu thập email công ty từ website',
        'Phân loại và tag hình ảnh sản phẩm',
        'Transcribe file audio thành văn bản',
        'Tìm kiếm thông tin liên hệ doanh nghiệp',
        'Kiểm tra link và cập nhật trạng thái',
        'Dịch các câu ngắn từ tiếng Anh sang Việt',
        'Đánh giá chất lượng ảnh sản phẩm',
        'Nhập thông tin sản phẩm vào catalog',
        'Kiểm tra và cập nhật giá sản phẩm',
        'Thu thập dữ liệu từ mạng xã hội',
        'Làm sạch dữ liệu khách hàng',
        'Tạo danh sách công ty theo ngành',
        'Kiểm tra chất lượng nội dung website'
    ];
    contest_titles
TEXT[] := ARRAY[
        'Cuộc thi thiết kế poster quảng cáo sản phẩm',
        'Contest viết slogan cho thương hiệu mới',
        'Thiết kế mascot cho công ty game mobile',
        'Cuộc thi ảnh chủ đề du lịch Việt Nam',
        'Contest thiết kế packaging sản phẩm',
        'Viết kịch bản video viral marketing',
        'Thiết kế infographic về chuyển đổi số',
        'Contest tạo TikTok challenge',
        'Thiết kế t-shirt cho sự kiện công ty',
        'Cuộc thi viết bài blog về công nghệ AI',
        'Contest thiết kế app icon',
        'Thiết kế banner quảng cáo online',
        'Contest viết story Instagram',
        'Thiết kế UI cho landing page',
        'Cuộc thi sáng tạo video ngắn'
    ];
BEGIN
FOR i IN 1..150 LOOP
        -- Random employer (bỏ qua admin)
SELECT id
INTO employer_id
FROM public.users
WHERE username LIKE 'employer_%'
ORDER BY RANDOM() LIMIT 1;

-- Random category
SELECT id
INTO category_id
FROM public.categories
ORDER BY RANDOM() LIMIT 1;

-- Phân phối job type
CASE
            WHEN i <= 75 THEN job_type_val := 'BIDDING';
WHEN i <= 120 THEN job_type_val := 'MICROTASK';
ELSE job_type_val := 'CONTEST';
END
CASE;

INSERT INTO public.jobs (employer_id, type, title, description, requirements,
                         budget_min, budget_max, currency, deadline_at, expected_duration_days,
                         status, is_public, is_featured, category_id, location, is_remote,
                         required_skills, published_at, created_at)
VALUES (employer_id,
        job_type_val,
        CASE job_type_val
            WHEN 'BIDDING' THEN bidding_titles[1 + (i % array_length(bidding_titles, 1))]
            WHEN 'MICROTASK' THEN microtask_titles[1 + (i % array_length(microtask_titles, 1))]
            ELSE contest_titles[1 + (i % array_length(contest_titles, 1))]
            END,
        CASE job_type_val
            WHEN 'BIDDING' THEN 'Dự án yêu cầu freelancer có kinh nghiệm ' || (1 + RANDOM() * 5)::INTEGER || '+ năm. Yêu cầu chất lượng cao và cập nhật tiến độ thường xuyên.'
                WHEN 'MICROTASK' THEN 'Công việc đơn giản, có thể làm từ xa trong thời gian linh hoạt. Phù hợp cho người mới bắt đầu freelance.'
                ELSE 'Cuộc thi sáng tạo với giải thưởng hấp dẫn. Chấm điểm dựa trên sáng tạo, tính khả thi và thẩm mỹ.'
            END,
        CASE job_type_val
            WHEN 'BIDDING' THEN 'Yêu cầu: Portfolio chất lượng, kinh nghiệm thực tế.'
            WHEN 'MICROTASK' THEN 'Yêu cầu: Cẩn thận, chính xác, có máy tính và internet ổn định.'
            ELSE 'Yêu cầu: Sáng tạo, cập nhật xu hướng, thể hiện ý tưởng rõ ràng.'
            END,
        CASE job_type_val
            WHEN 'BIDDING' THEN 5000000 -- gán thẳng: min 5 triệu
            WHEN 'MICROTASK' THEN 20000 -- gán thẳng: min 20k
            ELSE 5000000 -- gán thẳng: contest prize min 5 triệu
            END,
        CASE job_type_val
            WHEN 'BIDDING' THEN 15000000 -- gán thẳng: max 15 triệu
            WHEN 'MICROTASK' THEN 100000 -- gán thẳng: max 100k
            ELSE NULL -- contest không có budget_max
            END,
        'VND',
        NOW() + make_interval(days := (RANDOM() * 90 + 7)::INTEGER),
        CASE job_type_val
            WHEN 'BIDDING' THEN 30
            WHEN 'MICROTASK' THEN 7
            ELSE 20
            END,
        CASE (i % 8)
            WHEN 0 THEN 'DRAFT'
            WHEN 1 THEN 'OPEN'
            WHEN 2 THEN 'OPEN'
            WHEN 3 THEN 'IN_PROGRESS'
            WHEN 4 THEN 'OPEN'
            WHEN 5 THEN 'COMPLETED'
            WHEN 6 THEN 'OPEN'
            ELSE 'OPEN'
            END,
        TRUE, -- luôn public
        RANDOM() > 0.85,
        category_id,
        CASE (i % 6)
            WHEN 0 THEN 'Remote work'
            WHEN 1 THEN 'Hà Nội'
            WHEN 2 THEN 'TP.HCM'
            WHEN 3 THEN 'Đà Nẵng'
            WHEN 4 THEN 'Hybrid'
            ELSE 'Toàn quốc'
            END,
        CASE job_type_val
            WHEN 'MICROTASK' THEN TRUE
            ELSE RANDOM() > 0.25
            END,
        JSON_BUILD_ARRAY('JavaScript', 'HTML/CSS')::jsonb,
        NOW() - make_interval(days := (RANDOM() * 60)::INTEGER),
        NOW() - make_interval(days := (RANDOM() * 30)::INTEGER));
END LOOP;
END $$;

-- Insert job type specific data
-- Job Bidding configurations
INSERT INTO public.job_bidding (job_id, bid_deviation_pct, selection_mode, budget_min, budget_max,
                                auto_accept_threshold)
SELECT j.id,
       (RANDOM() * 25 + 5)::INTEGER,  -- 5-30% deviation CASE (j.id % 4)
                                                             WHEN 0 THEN 'MANUAL'
                                                             WHEN 1 THEN 'LOWEST_BID'
                                                             WHEN 2 THEN 'BEST_SCORE'
                                                             ELSE 'AUTO_ACCEPT'
END
,
       j.budget_min,
       j.budget_max,
       CASE WHEN RANDOM() > 0.6 THEN j.budget_min * (1 + RANDOM() * 0.3) ELSE NULL
END
FROM public.jobs j
WHERE j.type = 'BIDDING';

-- Job Microtask configurations
INSERT INTO public.job_microtask (job_id, unit_price, max_workers, max_tasks_per_worker, estimated_time_minutes,
                                  guidelines, quality_threshold)
SELECT j.id,
       j.budget_min,
       (RANDOM() * 80 + 20)::INTEGER,    -- 20-100 workers (RANDOM() * 30 + 5)::INTEGER,     -- 5-35 tasks per worker (RANDOM() * 40 + 5)::INTEGER,     -- 5-45 minutes per task 'Vui lòng đọc kỹ hướng dẫn trước khi bắt đầu. Đảm bảo chất lượng công việc để được thanh toán. Liên hệ support nếu có thắc mắc.', (RANDOM() * 0.4 + 0.6)::NUMERIC   -- Quality threshold 0.6-1.0
FROM public.jobs j
WHERE j.type = 'MICROTASK';

-- Job Contest configurations
INSERT INTO public.job_contest (job_id, submission_ends_at, judging_ends_at, winner_count, max_submissions_per_user,
                                is_blind_judging, allow_public_voting, public_voting_weight)
SELECT j.id,
       j.deadline_at,
       j.deadline_at + INTERVAL '7 days', CASE (j.id % 5)
    WHEN 0 THEN 1
    WHEN 1 THEN 3
    WHEN 2 THEN 5
    WHEN 3 THEN 2
    ELSE 1
END
,
    CASE WHEN RANDOM() > 0.8 THEN (RANDOM() * 2 + 2)::INTEGER ELSE 1
END
,  -- 20% allow multiple submissions
    RANDOM() > 0.5,   -- 50% blind judging
    RANDOM() > 0.4,   -- 60% allow public voting
    CASE WHEN RANDOM() > 0.3 THEN (RANDOM() * 0.4)::NUMERIC ELSE 0
END  -- 0-40% public weight
FROM public.jobs j
WHERE j.type = 'CONTEST';

-- Contest Criteria
DO
$$
DECLARE
contest_rec RECORD;
    criteria_sets
TEXT[][] := ARRAY[
    	ARRAY['Sáng tạo', 'Tính khả thi', 'Thẩm mỹ', 'Tổng thể'],
    	ARRAY['Độc đáo', 'Phù hợp chủ đề', 'Chất lượng kỹ thuật', 'Tổng thể'],
    	ARRAY['Ý tưởng', 'Thực thi', 'Tác động', 'Tổng thể'],
    	ARRAY['Sáng tạo', 'Thẩm mỹ', 'Tính ứng dụng', 'Tổng thể']
	];
    criteria_names
TEXT[];
    i
INTEGER;
BEGIN
FOR contest_rec IN (SELECT id FROM public.jobs WHERE type = 'CONTEST') LOOP
    criteria_names := criteria_sets[1 + (contest_rec.id % array_length(criteria_sets, 1))];

    IF
criteria_names IS NOT NULL THEN
        FOR i IN 1..COALESCE(array_length(criteria_names, 1), 0) LOOP
            INSERT INTO public.contest_criteria (
                job_id, name, description, weight, max_score, sort_order
            ) VALUES (
                contest_rec.id,
                criteria_names[i],
                'Tiêu chí đánh giá ' || criteria_names[i] || ' của bài dự thi',
                CASE i WHEN 1 THEN 3 WHEN 2 THEN 2 ELSE 1 END,
                10,
                i
            );
END LOOP;
END IF;
END LOOP;

END $$;

-- Contest Prizes
DO
$$
DECLARE
contest_rec RECORD;
    prize_amounts
NUMERIC[];
    prize_titles
TEXT[] := ARRAY['Giải Nhất', 'Giải Nhì', 'Giải Ba', 'Giải Khuyến Khích', 'Giải Phụ'];
    i
INTEGER;
BEGIN
FOR contest_rec IN (
        SELECT j.id, j.budget_min, jc.winner_count 
        FROM public.jobs j 
        JOIN public.job_contest jc ON j.id = jc.job_id 
        WHERE j.type = 'CONTEST'
    ) LOOP
        -- Phân chia giải thưởng
        CASE contest_rec.winner_count
            WHEN 1 THEN prize_amounts := ARRAY[contest_rec.budget_min];
WHEN 2 THEN prize_amounts := ARRAY[contest_rec.budget_min * 0.65, contest_rec.budget_min * 0.35];
WHEN 3 THEN prize_amounts := ARRAY[contest_rec.budget_min * 0.5, contest_rec.budget_min * 0.3, contest_rec.budget_min * 0.2];
WHEN 5 THEN prize_amounts := ARRAY[contest_rec.budget_min * 0.4, contest_rec.budget_min * 0.25, contest_rec.budget_min * 0.2, contest_rec.budget_min * 0.1, contest_rec.budget_min * 0.05];
ELSE prize_amounts := ARRAY[contest_rec.budget_min * 0.45, contest_rec.budget_min * 0.35, contest_rec.budget_min * 0.2];
END
CASE;

FOR i IN 1..contest_rec.winner_count LOOP
            INSERT INTO public.contest_prizes (job_id, rank, amount, title, description) VALUES (
                contest_rec.id,
                i,
                ROUND(prize_amounts[i], 2),
                prize_titles[i],
                'Giải thưởng thứ ' || i || ' trong cuộc thi'
            );
END LOOP;
END LOOP;
END $$;

-- Insert Wallet Transactions
DO
$$
DECLARE
user_rec RECORD;
    i
INTEGER;
    transaction_types
TEXT[] := ARRAY['DEPOSIT', 'WITHDRAW', 'PAYMENT', 'REFUND'];
    providers
TEXT[] := ARRAY['VNPAY', 'MOMO', 'ZALOPAY', 'BANK_TRANSFER'];
BEGIN
FOR user_rec IN (SELECT id FROM public.users WHERE role = 'USER' LIMIT 100) LOOP
        FOR i IN 1..(RANDOM() * 15 + 5)::INTEGER LOOP
            INSERT INTO public.wallet_transactions (
                wallet_id, type, amount, currency, provider, 
                status, description, created_at, processed_at
            ) VALUES (
                (SELECT id FROM public.wallets WHERE user_id = user_rec.id),
                transaction_types[1 + (i % array_length(transaction_types, 1))],
                ROUND((RANDOM() * 5000000 + 100000)::NUMERIC, 2),
                'VND',
                providers[1 + (i % array_length(providers, 1))],
                CASE (i % 5)
                    WHEN 0 THEN 'FAILED'
                    WHEN 1 THEN 'PENDING'
                    ELSE 'SUCCESS'
                END,
                'Giao dịch ' || transaction_types[1 + (i % array_length(transaction_types, 1))],
                NOW() - (RANDOM() * 90 || ' days')::INTERVAL,
                CASE WHEN RANDOM() > 0.2 THEN NOW() - (RANDOM() * 85 || ' days')::INTERVAL ELSE NULL END
            );
END LOOP;
END LOOP;
END $$;

-- Final summary
SELECT 'Users'  as table_name,
       COUNT(*) as record_count
FROM public.users
UNION ALL
SELECT 'Categories', COUNT(*)
FROM public.categories
UNION ALL
SELECT 'Skills', COUNT(*)
FROM public.skills
UNION ALL
SELECT 'Jobs', COUNT(*)
FROM public.jobs
UNION ALL
SELECT 'Proposals', COUNT(*)
FROM public.proposals
UNION ALL
SELECT 'Contracts', COUNT(*)
FROM public.contracts
UNION ALL
SELECT 'Milestones', COUNT(*)
FROM public.milestones
UNION ALL
SELECT 'Messages', COUNT(*)
FROM public.messages
UNION ALL
SELECT 'Notifications', COUNT(*)
FROM public.notifications
UNION ALL
SELECT 'Wallet Transactions', COUNT(*)
FROM public.wallet_transactions
ORDER BY record_count DESC;
COMMIT;
