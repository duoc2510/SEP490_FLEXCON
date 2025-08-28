package entities;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "contest_scores", indexes = {
        @Index(name = "idx_score_entry", columnList = "entry_id"),
        @Index(name = "idx_score_criteria", columnList = "criteria_id"),
        @Index(name = "idx_score_judge", columnList = "judge_id")
}, uniqueConstraints = {
        @UniqueConstraint(name = "uq_score_judge_entry_criteria", columnNames = {"entry_id", "criteria_id", "judge_id"})
})
public class ContestScore {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "entry_id", nullable = false)
    private ContestEntry entry;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "criteria_id", nullable = false)
    private ContestCriterion criteria;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "judge_id")
    private User judge;

    @NotNull
    @Column(name = "score", nullable = false, precision = 10, scale = 2)
    private BigDecimal score;

    @Column(name = "comment")
    @Type(type = "org.hibernate.type.TextType")
    private String comment;

    @Column(name = "is_public_vote")
    private Boolean isPublicVote;

    @NotNull
    @Column(name = "created_at", nullable = false)
    private Instant createdAt;

    @Column(name = "updated_at")
    private Instant updatedAt;

}