package services;

import entities.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repositories.user.UserRepository;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    // Create or Update
    public User save(User user) {
        return userRepository.save(user);
    }

    // Read all
    public List<User> findAll() {
        return userRepository.findAll();
    }

    // Read by id
    public Optional<User> findById(Long id) {
        return userRepository.findById(id);
    }

    // Delete by id
    public void deleteById(Long id) {
        userRepository.deleteById(id);
    }

    // Exists by id
    public boolean existsById(Long id) {
        return userRepository.existsById(id);
    }

    // Count
    public long count() {
        return userRepository.count();
    }
}
