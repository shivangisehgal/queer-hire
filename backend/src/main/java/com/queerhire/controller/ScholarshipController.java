package com.queerhire.controller;

import com.queerhire.dto.ScholarshipApplicationRequest;
import com.queerhire.entity.Scholarship;
import com.queerhire.repository.ScholarshipRepository;
import com.queerhire.service.ScholarshipApplicationService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/scholarships")
public class ScholarshipController {

    private final ScholarshipRepository scholarshipRepository;
    private final ScholarshipApplicationService applicationService;

    public ScholarshipController(ScholarshipRepository scholarshipRepository,
                                ScholarshipApplicationService applicationService) {
        this.scholarshipRepository = scholarshipRepository;
        this.applicationService = applicationService;
    }

    @GetMapping
    public List<Scholarship> getAllScholarships() {
        return scholarshipRepository.findAll();
    }

    @GetMapping("/{sid}")
    public ResponseEntity<Scholarship> getScholarship(@PathVariable String sid) {
        return scholarshipRepository.findById(sid)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/apply")
    public ResponseEntity<?> apply(@Valid @RequestPart("application") ScholarshipApplicationRequest request,
                                  @RequestPart(value = "coverLetter", required = false) MultipartFile coverLetter,
                                  Authentication auth) {
        if (auth == null || !auth.isAuthenticated()) {
            return ResponseEntity.status(401).body(Map.of("error", "Unauthorized"));
        }
        String userId = (String) auth.getPrincipal();
        applicationService.submitApplication(userId, request, coverLetter);
        return ResponseEntity.ok(Map.of("message", "Application submitted successfully"));
    }

    @GetMapping("/my-applications")
    public List<Scholarship> getMyApplications(Authentication auth) {
        if (auth == null || !auth.isAuthenticated()) {
            return List.of();
        }
        return applicationService.getApplicationsByUser((String) auth.getPrincipal());
    }
}
