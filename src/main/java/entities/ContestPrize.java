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
@Table(name = "contest_prizes", indexes = {
        @Index(name = "idx_prize_job_id", columnList = "job_id, rank")
}, uniqueConstraints = {
        @UniqueConstraint(name = "uq_prize_job_rank", columnNames = {"job_id", "rank"})
})
public class ContestPrize {
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
    @Column(name = "rank", nullable = false)
    private Integer rank;

    @NotNull
    @Column(name = "amount", nullable = false, precision = 19, scale = 4)
    private BigDecimal amount;

    @Size(max = 10)
    @NotNull
    @Column(name = "currency", nullable = false, length = 10)
    private String currency;

    @Size(max = 100)
    @Column(name = "title", length = 100)
    private String title;

    @Column(name = "description")
    @Type(type = "org.hibernate.type.TextType")
    private String description;

    @Column(name = "created_at")
    private Instant createdAt;

}