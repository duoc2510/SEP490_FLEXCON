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
@Table(name = "wallets", indexes = {
        @Index(name = "idx_wallets_user_id", columnList = "user_id")
}, uniqueConstraints = {
        @UniqueConstraint(name = "wallets_user_id_key", columnNames = {"user_id"})
})
public class Wallet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @NotNull
    @Column(name = "balance_available", nullable = false, precision = 19, scale = 4)
    private BigDecimal balanceAvailable;

    @NotNull
    @Column(name = "balance_frozen", nullable = false, precision = 19, scale = 4)
    private BigDecimal balanceFrozen;

    @Column(name = "total_earned", precision = 19, scale = 4)
    private BigDecimal totalEarned;

    @Column(name = "total_spent", precision = 19, scale = 4)
    private BigDecimal totalSpent;

    @Size(max = 10)
    @NotNull
    @Column(name = "currency", nullable = false, length = 10)
    private String currency;

    @Column(name = "created_at")
    private Instant createdAt;

    @Column(name = "updated_at")
    private Instant updatedAt;

    @Column(name = "updated_by")
    private Long updatedBy;

}