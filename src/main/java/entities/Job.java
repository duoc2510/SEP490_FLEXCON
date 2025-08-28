package entities;

import com.fasterxml.jackson.databind.JsonNode;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.math.BigDecimal;
import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "jobs", indexes = {
        @Index(name = "idx_jobs_employer_id", columnList = "employer_id"),
        @Index(name = "idx_jobs_type", columnList = "type"),
        @Index(name = "idx_jobs_deadline", columnList = "deadline_at"),
        @Index(name = "idx_jobs_status_public", columnList = "status, is_public"),
        @Index(name = "idx_jobs_featured", columnList = "is_featured, created_at"),
        @Index(name = "idx_jobs_skills", columnList = "required_skills"),
        @Index(name = "idx_jobs_created_at", columnList = "created_at")
})
public class Job {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "employer_id", nullable = false)
    private User employer;

    @Size(max = 20)
    @NotNull
    @Column(name = "type", nullable = false, length = 20)
    private String type;

    @Size(max = 300)
    @NotNull
    @Column(name = "title", nullable = false, length = 300)
    private String title;

    @Column(name = "description")
    @Type(type = "org.hibernate.type.TextType")
    private String description;

    @Column(name = "requirements")
    @Type(type = "org.hibernate.type.TextType")
    private String requirements;

    @Column(name = "budget_min", precision = 19, scale = 4)
    private BigDecimal budgetMin;

    @Column(name = "budget_max", precision = 19, scale = 4)
    private BigDecimal budgetMax;

    @Size(max = 10)
    @NotNull
    @Column(name = "currency", nullable = false, length = 10)
    private String currency;

    @Column(name = "deadline_at")
    private Instant deadlineAt;

    @Column(name = "expected_duration_days")
    private Integer expectedDurationDays;

    @Size(max = 20)
    @NotNull
    @Column(name = "status", nullable = false, length = 20)
    private String status;

    @NotNull
    @Column(name = "is_public", nullable = false)
    private Boolean isPublic = false;

    @Column(name = "is_featured")
    private Boolean isFeatured;

    @Column(name = "view_count")
    private Integer viewCount;

    @Column(name = "application_count")
    private Integer applicationCount;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    private Category category;

    @Size(max = 200)
    @Column(name = "location", length = 200)
    private String location;

    @Column(name = "is_remote")
    private Boolean isRemote;

    @Column(name = "required_skills")
    @Type(type = "com.vladmihalcea.hibernate.type.json.JsonNodeBinaryType")
    private JsonNode requiredSkills;

    @Column(name = "published_at")
    private Instant publishedAt;

    @Column(name = "completed_at")
    private Instant completedAt;

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