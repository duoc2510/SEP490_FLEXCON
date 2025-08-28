package util;

import entities.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.core.oidc.user.DefaultOidcUser;
import org.springframework.stereotype.Component;
import repositories.user.UserRepository;

@Component
public class AuthUtils {

    @Autowired
    private UserRepository userRepository;

    public Long getCurrentUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication == null || !authentication.isAuthenticated()) {
            throw new RuntimeException("User not logged in");
        }

        Object principal = authentication.getPrincipal();

        if (principal instanceof User u) {
            return u.getId();
        } else if (principal instanceof DefaultOidcUser oidcUser) {
            String email = oidcUser.getEmail();
            Long userId = userRepository.findIdByEmail(email).orElseThrow(() -> new RuntimeException("Không tìm thấy User trong DB: " + email));
            return userId;
        }

        throw new RuntimeException("Không nhận diện được principal: " + principal.getClass().getName());
    }


}
