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
@Table(name = "contest_entries", indexes = {
        @Index(name = "idx_entry_score", columnList = "job_id, final_score"),
        @Index(name = "idx_entry_job_id", columnList = "job_id"),
        @Index(name = "idx_entry_participant_id", columnList = "participant_id"),
        @Index(name = "idx_entry_status", columnList = "status")
})
public class ContestEntry {
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
    @JoinColumn(name = "participant_id", nullable = false)
    private User participant;

    @Size(max = 300)
    @NotNull
    @Column(name = "title", nullable = false, length = 300)
    private String title;

    @Column(name = "description")
    @Type(type = "org.hibernate.type.TextType")
    private String description;

    @Column(name = "submission_url")
    @Type(type = "org.hibernate.type.TextType")
    private String submissionUrl;

    @Column(name = "attachments")
    @Type(type = "com.vladmihalcea.hibernate.type.json.JsonNodeBinaryType")
    private JsonNode attachments;

    @Size(max = 20)
    @NotNull
    @Column(name = "status", nullable = false, length = 20)
    private String status;

    @Column(name = "final_score", precision = 10, scale = 2)
    private BigDecimal finalScore;

    @Column(name = "rank_position")
    private Integer rankPosition;

    @Column(name = "is_winner")
    private Boolean isWinner;

    @Column(name = "disqualified_reason")
    @Type(type = "org.hibernate.type.TextType")
    private String disqualifiedReason;

    @NotNull
    @Column(name = "created_at", nullable = false)
    private Instant createdAt;

    @Column(name = "submitted_at")
    private Instant submittedAt;

    @Column(name = "updated_at")
    private Instant updatedAt;

}