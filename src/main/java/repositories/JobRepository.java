package repositories;

import entities.Job;
import org.springframework.data.repository.Repository;

public interface JobRepository extends Repository<Job, Long> {
}