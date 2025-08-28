package entities;

import com.fasterxml.jackson.databind.JsonNode;
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
@Table(name = "proposals", indexes = {
        @Index(name = "idx_proposals_price", columnList = "job_id, price"),
        @Index(name = "idx_proposals_job_id", columnList = "job_id"),
        @Index(name = "idx_proposals_freelancer_id", columnList = "freelancer_id"),
        @Index(name = "idx_proposals_status", columnList = "status"),
        @Index(name = "idx_proposals_created_at", columnList = "created_at")
}, uniqueConstraints = {
        @UniqueConstraint(name = "uq_proposals_job_freelancer", columnNames = {"job_id", "freelancer_id"})
})
public class Proposal {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "job_id", nullable = false)
    private Job job;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "freelancer_id", nullable = false)
    private User freelancer;

    @NotNull
    @Column(name = "price", nullable = false, precision = 19, scale = 4)
    private BigDecimal price;

    @Size(max = 10)
    @NotNull
    @Column(name = "currency", nullable = false, length = 10)
    private String currency;

    @Column(name = "duration_days")
    private Integer durationDays;

    @Column(name = "cover_letter")
    @Type(type = "org.hibernate.type.TextType")
    private String coverLetter;

    @Column(name = "portfolio_links")
    @Type(type = "com.vladmihalcea.hibernate.type.json.JsonNodeBinaryType")
    private JsonNode portfolioLinks;

    @Column(name = "attachments")
    @Type(type = "com.vladmihalcea.hibernate.type.json.JsonNodeBinaryType")
    private JsonNode attachments;

    @Size(max = 20)
    @NotNull
    @Column(name = "status", nullable = false, length = 20)
    private String status;

    @Column(name = "rejection_reason")
    @Type(type = "org.hibernate.type.TextType")
    private String rejectionReason;

    @Column(name = "is_shortlisted")
    private Boolean isShortlisted;

    @Column(name = "reviewed_at")
    private Instant reviewedAt;

    @Column(name = "reviewed_by")
    private Long reviewedBy;

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