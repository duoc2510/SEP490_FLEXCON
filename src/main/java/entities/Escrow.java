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
@Table(name = "escrows", indexes = {
        @Index(name = "idx_escrows_contract", columnList = "contract_id"),
        @Index(name = "idx_escrows_state", columnList = "state")
}, uniqueConstraints = {
        @UniqueConstraint(name = "escrows_milestone_id_key", columnNames = {"milestone_id"})
})
public class Escrow {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "contract_id", nullable = false)
    private Contract contract;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "milestone_id")
    private Milestone milestone;

    @NotNull
    @Column(name = "amount", nullable = false, precision = 19, scale = 4)
    private BigDecimal amount;

    @Size(max = 10)
    @NotNull
    @Column(name = "currency", nullable = false, length = 10)
    private String currency;

    @Size(max = 20)
    @NotNull
    @Column(name = "state", nullable = false, length = 20)
    private String state;

    @Column(name = "released_at")
    private Instant releasedAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "released_to")
    private User releasedTo;

    @Column(name = "refunded_at")
    private Instant refundedAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "refunded_to")
    private User refundedTo;

    @Column(name = "notes")
    @Type(type = "org.hibernate.type.TextType")
    private String notes;

    @NotNull
    @Column(name = "created_at", nullable = false)
    private Instant createdAt;

    @Column(name = "created_by")
    private Long createdBy;

    @Column(name = "updated_at")
    private Instant updatedAt;

    @Column(name = "updated_by")
    private Long updatedBy;

    @Column(name = "deleted_at")
    private Instant deletedAt;

}