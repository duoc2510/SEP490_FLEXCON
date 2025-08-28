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
@Table(name = "profiles", indexes = {
        @Index(name = "idx_profiles_rating", columnList = "rating_avg, rating_count"),
        @Index(name = "idx_profiles_skills", columnList = "skills"),
        @Index(name = "idx_profiles_location", columnList = "location")
}, uniqueConstraints = {
        @UniqueConstraint(name = "profiles_user_id_key", columnNames = {"user_id"})
})
public class Profile {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "bio")
    @Type(type = "org.hibernate.type.TextType")
    private String bio;

    @Column(name = "portfolio_links")
    @Type(type = "com.vladmihalcea.hibernate.type.json.JsonNodeBinaryType")
    private JsonNode portfolioLinks;

    @Column(name = "rating_avg", precision = 4, scale = 2)
    private BigDecimal ratingAvg;

    @Column(name = "rating_count")
    private Long ratingCount;

    @Column(name = "completed_jobs")
    private Integer completedJobs;

    @Column(name = "skills")
    @Type(type = "com.vladmihalcea.hibernate.type.json.JsonNodeBinaryType")
    private JsonNode skills;

    @Column(name = "experience_years")
    private Integer experienceYears;

    @Size(max = 50)
    @Column(name = "education_level", length = 50)
    private String educationLevel;

    @Size(max = 200)
    @Column(name = "location", length = 200)
    private String location;

    @Column(name = "hourly_rate_min", precision = 19, scale = 4)
    private BigDecimal hourlyRateMin;

    @Column(name = "hourly_rate_max", precision = 19, scale = 4)
    private BigDecimal hourlyRateMax;

    @Size(max = 10)
    @Column(name = "currency", length = 10)
    private String currency;

    @Size(max = 50)
    @Column(name = "availability", length = 50)
    private String availability;

    @Column(name = "is_verified")
    private Boolean isVerified;

    @Column(name = "verification_date")
    private Instant verificationDate;

    @Column(name = "created_at")
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