package com.queerhire.repository;

import com.queerhire.entity.ScholarshipApplication;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface ScholarshipApplicationRepository extends JpaRepository<ScholarshipApplication, Long> {
    List<ScholarshipApplication> findByUserId(String userId);
    Optional<ScholarshipApplication> findByUserIdAndScholarshipSid(String userId, String sid);
}
