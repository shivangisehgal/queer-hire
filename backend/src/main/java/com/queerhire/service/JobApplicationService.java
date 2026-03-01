package com.queerhire.service;

import com.queerhire.dto.JobApplicationRequest;
import com.queerhire.entity.Job;
import com.queerhire.entity.JobApplication;
import com.queerhire.entity.User;
import com.queerhire.repository.JobApplicationRepository;
import com.queerhire.repository.JobRepository;
import com.queerhire.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class JobApplicationService {

    private final JobApplicationRepository applicationRepository;
    private final JobRepository jobRepository;
    private final UserRepository userRepository;
    private final FileStorageService fileStorageService;

    public JobApplicationService(JobApplicationRepository applicationRepository,
                                 JobRepository jobRepository,
                                 UserRepository userRepository,
                                 FileStorageService fileStorageService) {
        this.applicationRepository = applicationRepository;
        this.jobRepository = jobRepository;
        this.userRepository = userRepository;
        this.fileStorageService = fileStorageService;
    }

    @Transactional
    public JobApplication submitApplication(String userId, JobApplicationRequest request, MultipartFile resume) {
        Job job = jobRepository.findById(request.getJobId())
                .orElseThrow(() -> new IllegalArgumentException("Job not found"));
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        String resumePath = null;
        if (resume != null && !resume.isEmpty()) {
            try {
                resumePath = fileStorageService.storeFile(resume, "resumes");
            } catch (Exception e) {
                throw new RuntimeException("Failed to store resume", e);
            }
        }

        JobApplication application = applicationRepository
                .findByUserIdAndJobJobId(userId, request.getJobId())
                .orElse(null);

        if (application != null) {
            application.setName(request.getName());
            application.setEmail(request.getEmail());
            application.setAge(request.getAge());
            application.setContact(request.getContact());
            application.setGender(request.getGender());
            application.setYoe(request.getYoe());
            if (resumePath != null) application.setResumePath(resumePath);
            return applicationRepository.save(application);
        }

        application = new JobApplication();
        application.setJob(job);
        application.setUser(user);
        application.setName(request.getName());
        application.setEmail(request.getEmail());
        application.setAge(request.getAge());
        application.setContact(request.getContact());
        application.setGender(request.getGender());
        application.setYoe(request.getYoe());
        application.setResumePath(resumePath);
        return applicationRepository.save(application);
    }

    public List<Job> getApplicationsByUser(String userId) {
        return applicationRepository.findByUserId(userId).stream()
                .map(JobApplication::getJob)
                .collect(Collectors.toList());
    }
}
