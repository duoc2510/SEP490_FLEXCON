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
@Table(name = "notifications", indexes = {
        @Index(name = "idx_notifications_user_unread_priority", columnList = "user_id, is_read, priority, created_at"),
        @Index(name = "idx_notifications_unread", columnList = "user_id, is_read"),
        @Index(name = "idx_notifications_created_at", columnList = "user_id, created_at"),
        @Index(name = "idx_notifications_user_id", columnList = "user_id"),
        @Index(name = "idx_notifications_type", columnList = "type"),
        @Index(name = "idx_notifications_entity", columnList = "related_entity_type, related_entity_id"),
        @Index(name = "idx_notifications_priority", columnList = "priority"),
        @Index(name = "idx_notifications_expires_at", columnList = "expires_at")
})
public class Notification {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Size(max = 200)
    @NotNull
    @Column(name = "title", nullable = false, length = 200)
    private String title;

    @Column(name = "content")
    @Type(type = "org.hibernate.type.TextType")
    private String content;

    @Size(max = 20)
    @NotNull
    @Column(name = "type", nullable = false, length = 20)
    private String type;

    @Size(max = 50)
    @Column(name = "related_entity_type", length = 50)
    private String relatedEntityType;

    @Column(name = "related_entity_id")
    private Long relatedEntityId;

    @Size(max = 500)
    @Column(name = "action_url", length = 500)
    private String actionUrl;

    @NotNull
    @Column(name = "is_read", nullable = false)
    private Boolean isRead = false;

    @Size(max = 20)
    @NotNull
    @Column(name = "priority", nullable = false, length = 20)
    private String priority;

    @Column(name = "expires_at")
    private Instant expiresAt;

    @Column(name = "metadata")
    @Type(type = "com.vladmihalcea.hibernate.type.json.JsonNodeBinaryType")
    private JsonNode metadata;

    @NotNull
    @Column(name = "created_at", nullable = false)
    private Instant createdAt;

    @Column(name = "read_at")
    private Instant readAt;

    @Column(name = "deleted_at")
    private Instant deletedAt;

}