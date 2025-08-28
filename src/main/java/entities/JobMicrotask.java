package entities;

import com.fasterxml.jackson.databind.JsonNode;
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
@Table(name = "job_microtask")
public class JobMicrotask {
    @Id
    @Column(name = "job_id", nullable = false)
    private Long id;

    @MapsId
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "job_id", nullable = false)
    private Job jobs;

    @NotNull
    @Column(name = "unit_price", nullable = false, precision = 19, scale = 4)
    private BigDecimal unitPrice;

    @NotNull
    @Column(name = "max_workers", nullable = false)
    private Integer maxWorkers;

    @Column(name = "max_tasks_per_worker")
    private Integer maxTasksPerWorker;

    @Column(name = "estimated_time_minutes")
    private Integer estimatedTimeMinutes;

    @Column(name = "guidelines")
    @Type(type = "org.hibernate.type.TextType")
    private String guidelines;

    @Column(name = "sample_data")
    @Type(type = "com.vladmihalcea.hibernate.type.json.JsonNodeBinaryType")
    private JsonNode sampleData;

    @Column(name = "quality_threshold", precision = 3, scale = 2)
    private BigDecimal qualityThreshold;

    @Column(name = "created_at")
    private Instant createdAt;

    @Column(name = "updated_at")
    private Instant updatedAt;

}