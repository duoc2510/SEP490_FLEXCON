package auth; // hoặc package bạn muốn

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.Cipher;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.util.Base64;

@Component
public class CryptoService {

    private static final String ALG = "AES";
    private static final String TRANS = "AES/GCM/NoPadding";
    private static final int IV_LEN = 12;         // 96-bit IV khuyến nghị cho GCM
    private static final int TAG_LEN = 128;       // 128-bit tag
    private final SecretKey key;
    private final SecureRandom rnd = new SecureRandom();

    // Khóa base64 32 bytes (256-bit). Đặt trong application.properties: chat.crypto.key=...
    public CryptoService(@Value("${chat.crypto.key}") String base64Key) {
        byte[] raw = Base64.getDecoder().decode(base64Key);
        if (raw.length != 16 && raw.length != 24 && raw.length != 32) {
            throw new IllegalArgumentException("AES key must be 16/24/32 bytes");
        }
        this.key = new SecretKeySpec(raw, ALG);
    }

    public String encrypt(String plaintext) {
        try {
            byte[] iv = new byte[IV_LEN];
            rnd.nextBytes(iv);
            Cipher c = Cipher.getInstance(TRANS);
            c.init(Cipher.ENCRYPT_MODE, key, new GCMParameterSpec(TAG_LEN, iv));
            byte[] cipher = c.doFinal(plaintext.getBytes(StandardCharsets.UTF_8));
            String ivB64 = Base64.getEncoder().encodeToString(iv);
            String ctB64 = Base64.getEncoder().encodeToString(cipher);
            // có prefix version để về sau migrate, và để nhận biết bản cũ (chưa mã hoá)
            return "v1:" + ivB64 + ":" + ctB64;
        } catch (Exception e) {
            throw new RuntimeException("Encrypt failed", e);
        }
    }

    public String decrypt(String payload) {
        try {
            if (payload == null) return null;
            // nếu dữ liệu cũ chưa mã hoá -> trả nguyên văn
            if (!payload.startsWith("v1:")) return payload;

            String[] parts = payload.split(":", 3);
            byte[] iv = Base64.getDecoder().decode(parts[1]);
            byte[] cipher = Base64.getDecoder().decode(parts[2]);

            Cipher c = Cipher.getInstance(TRANS);
            c.init(Cipher.DECRYPT_MODE, key, new GCMParameterSpec(TAG_LEN, iv));
            byte[] plain = c.doFinal(cipher);
            return new String(plain, StandardCharsets.UTF_8);
        } catch (Exception e) {
            throw new RuntimeException("Decrypt failed", e);
        }
    }
}
