package entities;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.math.BigDecimal;
import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "job_bidding", indexes = {
        @Index(name = "idx_job_bidding_selection_mode", columnList = "selection_mode"),
        @Index(name = "idx_job_bidding_budget", columnList = "budget_min, budget_max")
})
public class JobBidding {
    @Id
    @Column(name = "job_id", nullable = false)
    private Long id;

    @MapsId
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "job_id", nullable = false)
    private Job jobs;

    @Column(name = "bid_deviation_pct")
    private Integer bidDeviationPct;

    @Size(max = 20)
    @NotNull
    @Column(name = "selection_mode", nullable = false, length = 20)
    private String selectionMode;

    @Column(name = "lowest_bid_price", precision = 19, scale = 4)
    private BigDecimal lowestBidPrice;

    @Column(name = "highest_bid_price", precision = 19, scale = 4)
    private BigDecimal highestBidPrice;

    @Column(name = "budget_min", precision = 19, scale = 4)
    private BigDecimal budgetMin;

    @Column(name = "budget_max", precision = 19, scale = 4)
    private BigDecimal budgetMax;

    @Column(name = "auto_accept_threshold", precision = 19, scale = 4)
    private BigDecimal autoAcceptThreshold;

    @Column(name = "created_at")
    private Instant createdAt;

    @Column(name = "updated_at")
    private Instant updatedAt;

}