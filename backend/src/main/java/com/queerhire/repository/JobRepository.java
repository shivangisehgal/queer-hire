package com.queerhire.repository;

import com.queerhire.entity.Job;
import org.springframework.data.jpa.repository.JpaRepository;

public interface JobRepository extends JpaRepository<Job, String> {
}
