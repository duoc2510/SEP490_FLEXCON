/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package auth;

/**
 * Mô tả phương thức: [Mô tả ngắn gọn về phương thức].
 *
 * Account người tạo: [Truong Cong Quoc Trung].
 * Ngày tháng năm sinh: [14/08/2003].
 *
 * Các thông tin khác: 
 * - [Thông tin 1: Giải thích chi tiết về phương thức].
 * - [Thông tin 2: Những lưu ý cần thiết nếu có].
 *
 * @param [tên tham số] [Mô tả tham số]
 * @return [Mô tả giá trị trả về nếu có]
 * @throws [Ngoại lệ có thể phát sinh nếu có]
 */
import io.jsonwebtoken.*;
import java.nio.charset.StandardCharsets;
import java.util.Date;

public class JwtTokenService {
    private String secret;
    public void setSecret(String secret) { this.secret = secret; }

    public String generateForUserId(Long userId) {
        long now = System.currentTimeMillis();
        return Jwts.builder()
                .setSubject(String.valueOf(userId))
                .setIssuedAt(new Date(now))
                .setExpiration(new Date(now + 24*3600_000L))  // 1 ngày
                .signWith(SignatureAlgorithm.HS256, secret.getBytes(StandardCharsets.UTF_8))
                .compact();
    }

    public Long getUserId(String token) {
        Claims claims = Jwts.parser()
                .setSigningKey(secret.getBytes(StandardCharsets.UTF_8))
                .parseClaimsJws(token)
                .getBody();
        return Long.valueOf(claims.getSubject());
    }

    public boolean validate(String token) {
        try {
            Jwts.parser().setSigningKey(secret.getBytes(StandardCharsets.UTF_8)).parseClaimsJws(token);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}

