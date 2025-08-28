package entities;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "job_contest")
public class JobContest {
    @Id
    @Column(name = "job_id", nullable = false)
    private Long id;

    @MapsId
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "job_id", nullable = false)
    private Job jobs;

    @NotNull
    @Column(name = "submission_ends_at", nullable = false)
    private Instant submissionEndsAt;

    @Column(name = "judging_ends_at")
    private Instant judgingEndsAt;

    @NotNull
    @Column(name = "winner_count", nullable = false)
    private Integer winnerCount;

    @Column(name = "max_submissions_per_user")
    private Integer maxSubmissionsPerUser;

    @Column(name = "is_blind_judging")
    private Boolean isBlindJudging;

    @Column(name = "allow_public_voting")
    private Boolean allowPublicVoting;

    @Column(name = "public_voting_weight", precision = 3, scale = 2)
    private BigDecimal publicVotingWeight;

    @Column(name = "created_at")
    private Instant createdAt;

    @Column(name = "updated_at")
    private Instant updatedAt;

}