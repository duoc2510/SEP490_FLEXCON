package entities;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "job_requirements", indexes = {
        @Index(name = "idx_job_req_job_id", columnList = "job_id"),
        @Index(name = "idx_job_req_name", columnList = "name_requirement")
})
public class JobRequirement {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "job_id", nullable = false)
    private Job job;

    @Size(max = 50)
    @NotNull
    @Column(name = "name_requirement", nullable = false, length = 50)
    private String nameRequirement;

    @Column(name = "requirement")
    @Type(type = "org.hibernate.type.TextType")
    private String requirement;

    @NotNull
    @Column(name = "create_at", nullable = false)
    private Instant createAt;

}