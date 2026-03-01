package com.queerhire.service;

import com.queerhire.dto.ScholarshipApplicationRequest;
import com.queerhire.entity.Scholarship;
import com.queerhire.entity.ScholarshipApplication;
import com.queerhire.entity.User;
import com.queerhire.repository.ScholarshipApplicationRepository;
import com.queerhire.repository.ScholarshipRepository;
import com.queerhire.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ScholarshipApplicationService {

    private final ScholarshipApplicationRepository applicationRepository;
    private final ScholarshipRepository scholarshipRepository;
    private final UserRepository userRepository;
    private final FileStorageService fileStorageService;

    public ScholarshipApplicationService(ScholarshipApplicationRepository applicationRepository,
                                          ScholarshipRepository scholarshipRepository,
                                          UserRepository userRepository,
                                          FileStorageService fileStorageService) {
        this.applicationRepository = applicationRepository;
        this.scholarshipRepository = scholarshipRepository;
        this.userRepository = userRepository;
        this.fileStorageService = fileStorageService;
    }

    @Transactional
    public ScholarshipApplication submitApplication(String userId, ScholarshipApplicationRequest request, MultipartFile coverLetter) {
        Scholarship scholarship = scholarshipRepository.findById(request.getSid())
                .orElseThrow(() -> new IllegalArgumentException("Scholarship not found"));
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        String coverLetterPath = null;
        if (coverLetter != null && !coverLetter.isEmpty()) {
            try {
                coverLetterPath = fileStorageService.storeFile(coverLetter, "cover-letters");
            } catch (Exception e) {
                throw new RuntimeException("Failed to store cover letter", e);
            }
        }

        ScholarshipApplication application = applicationRepository
                .findByUserIdAndScholarshipSid(userId, request.getSid())
                .orElse(null);

        if (application != null) {
            application.setName(request.getName());
            application.setEmail(request.getEmail());
            application.setAge(request.getAge());
            application.setContact(request.getContact());
            application.setGender(request.getGender());
            application.setCoverletter(request.getCoverletter());
            if (coverLetterPath != null) application.setCoverLetterPath(coverLetterPath);
            return applicationRepository.save(application);
        }

        application = new ScholarshipApplication();
        application.setScholarship(scholarship);
        application.setUser(user);
        application.setName(request.getName());
        application.setEmail(request.getEmail());
        application.setAge(request.getAge());
        application.setContact(request.getContact());
        application.setGender(request.getGender());
        application.setCoverletter(request.getCoverletter());
        application.setCoverLetterPath(coverLetterPath);
        return applicationRepository.save(application);
    }

    public List<Scholarship> getApplicationsByUser(String userId) {
        return applicationRepository.findByUserId(userId).stream()
                .map(ScholarshipApplication::getScholarship)
                .collect(Collectors.toList());
    }
}
