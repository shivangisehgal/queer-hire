package com.queerhire.repository;

import com.queerhire.entity.JobApplication;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface JobApplicationRepository extends JpaRepository<JobApplication, Long> {
    List<JobApplication> findByUserId(String userId);
    Optional<JobApplication> findByUserIdAndJobJobId(String userId, String jobId);
}
