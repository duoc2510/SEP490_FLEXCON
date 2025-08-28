package util;

import org.springframework.stereotype.Component;

import java.util.Random;

@Component
public class VerificationCodeGenerator {

    // Tạo mã xác thực ngẫu nhiên gồm 6 chữ số
    public String generateVerificationCode() {
        Random random = new Random();
        int code = random.nextInt(999999); // Mã có 6 chữ số
        return String.format("%06d", code);
    }
}
