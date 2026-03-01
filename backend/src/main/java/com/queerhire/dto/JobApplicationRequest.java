package com.queerhire.dto;

import jakarta.validation.constraints.*;
import org.springframework.web.multipart.MultipartFile;

public class JobApplicationRequest {
    @NotBlank
    private String jobId;
    @NotBlank
    private String name;
    @NotBlank
    @Email
    private String email;
    @Min(1) @Max(120)
    private int age;
    @NotBlank
    private String contact;
    @NotBlank
    private String gender;
    @Min(0)
    private int yoe;

    public String getJobId() { return jobId; }
    public void setJobId(String jobId) { this.jobId = jobId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }
    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    public int getYoe() { return yoe; }
    public void setYoe(int yoe) { this.yoe = yoe; }
}
