package entities;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.math.BigDecimal;
import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "withdraw_requests", indexes = {
        @Index(name = "idx_withdraw_user", columnList = "user_id"),
        @Index(name = "idx_withdraw_status", columnList = "status"),
        @Index(name = "idx_withdraw_created_at", columnList = "created_at")
})
public class WithdrawRequest {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "wallet_id", nullable = false)
    private Wallet wallet;

    @NotNull
    @Column(name = "amount", nullable = false, precision = 19, scale = 4)
    private BigDecimal amount;

    @Column(name = "fee_amount", precision = 19, scale = 4)
    private BigDecimal feeAmount;

    @NotNull
    @Column(name = "net_amount", nullable = false, precision = 19, scale = 4)
    private BigDecimal netAmount;

    @Size(max = 20)
    @NotNull
    @Column(name = "method", nullable = false, length = 20)
    private String method;

    @Size(max = 100)
    @Column(name = "bank_name", length = 100)
    private String bankName;

    @Size(max = 50)
    @Column(name = "account_number", length = 50)
    private String accountNumber;

    @Size(max = 100)
    @Column(name = "account_name", length = 100)
    private String accountName;

    @Size(max = 100)
    @Column(name = "branch_name", length = 100)
    private String branchName;

    @Size(max = 255)
    @Column(name = "qr_code_path")
    private String qrCodePath;

    @Column(name = "notes")
    @Type(type = "org.hibernate.type.TextType")
    private String notes;

    @Size(max = 20)
    @NotNull
    @Column(name = "status", nullable = false, length = 20)
    private String status;

    @Column(name = "admin_notes")
    @Type(type = "org.hibernate.type.TextType")
    private String adminNotes;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "reviewed_by")
    private User reviewedBy;

    @Column(name = "reviewed_at")
    private Instant reviewedAt;

    @Column(name = "processed_at")
    private Instant processedAt;

    @Column(name = "rejected_reason")
    @Type(type = "org.hibernate.type.TextType")
    private String rejectedReason;

    @NotNull
    @Column(name = "created_at", nullable = false)
    private Instant createdAt;

    @Column(name = "updated_at")
    private Instant updatedAt;

}