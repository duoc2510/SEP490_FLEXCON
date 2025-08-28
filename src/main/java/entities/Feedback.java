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
import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "feedbacks", indexes = {
        @Index(name = "idx_feedbacks_contract", columnList = "contract_id"),
        @Index(name = "idx_feedbacks_ratee", columnList = "ratee_id, visibility"),
        @Index(name = "idx_feedbacks_rating", columnList = "rating"),
        @Index(name = "idx_feedbacks_created_at", columnList = "created_at")
})
public class Feedback {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "contract_id", nullable = false)
    private Contract contract;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "rater_id", nullable = false)
    private User rater;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "ratee_id", nullable = false)
    private User ratee;

    @NotNull
    @Column(name = "rating", nullable = false)
    private Integer rating;

    @Column(name = "comment")
    @Type(type = "org.hibernate.type.TextType")
    private String comment;

    @Column(name = "tags")
    @Type(type = "com.vladmihalcea.hibernate.type.json.JsonNodeBinaryType")
    private JsonNode tags;

    @Size(max = 20)
    @NotNull
    @Column(name = "visibility", nullable = false, length = 20)
    private String visibility;

    @Column(name = "is_anonymous")
    private Boolean isAnonymous;

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