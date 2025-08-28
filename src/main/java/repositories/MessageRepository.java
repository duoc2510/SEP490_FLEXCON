package repositories;

import entities.Message;
import org.springframework.data.repository.Repository;

public interface MessageRepository extends Repository<Message, Long> {
}