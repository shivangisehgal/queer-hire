package com.queerhire.controller;

import com.queerhire.dto.JobApplicationRequest;
import com.queerhire.entity.Job;
import com.queerhire.repository.JobRepository;
import com.queerhire.service.JobApplicationService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/jobs")
public class JobController {

    private final JobRepository jobRepository;
    private final JobApplicationService applicationService;

    public JobController(JobRepository jobRepository, JobApplicationService applicationService) {
        this.jobRepository = jobRepository;
        this.applicationService = applicationService;
    }

    @GetMapping
    public List<Job> getAllJobs() {
        return jobRepository.findAll();
    }

    @GetMapping("/{jobId}")
    public ResponseEntity<Job> getJob(@PathVariable String jobId) {
        return jobRepository.findById(jobId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/apply")
    public ResponseEntity<?> apply(@Valid @RequestPart("application") JobApplicationRequest request,
                                   @RequestPart(value = "resume", required = false) MultipartFile resume,
                                   Authentication auth) {
        if (auth == null || !auth.isAuthenticated()) {
            return ResponseEntity.status(401).body(Map.of("error", "Unauthorized"));
        }
        String userId = (String) auth.getPrincipal();
        applicationService.submitApplication(userId, request, resume);
        return ResponseEntity.ok(Map.of("message", "Application submitted successfully"));
    }

    @GetMapping("/my-applications")
    public List<Job> getMyApplications(Authentication auth) {
        if (auth == null || !auth.isAuthenticated()) {
            return List.of();
        }
        return applicationService.getApplicationsByUser((String) auth.getPrincipal());
    }
}
