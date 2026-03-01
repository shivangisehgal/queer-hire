package com.queerhire.entity;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "jobs")
public class Job {

    @Id
    @Column(name = "job_id")
    private String jobId;

    @Column(nullable = false)
    private String companyName;

    @Column(columnDefinition = "TEXT")
    private String description;

    private int openings;

    @Column(name = "role_available")
    private String roleAvailable;

    @OneToMany(mappedBy = "job", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<JobApplication> applications = new ArrayList<>();

    public Job() {}

    public Job(String jobId, String companyName, String description, int openings, String roleAvailable) {
        this.jobId = jobId;
        this.companyName = companyName;
        this.description = description;
        this.openings = openings;
        this.roleAvailable = roleAvailable;
    }

    public String getJobId() { return jobId; }
    public void setJobId(String jobId) { this.jobId = jobId; }
    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public int getOpenings() { return openings; }
    public void setOpenings(int openings) { this.openings = openings; }
    public String getRoleAvailable() { return roleAvailable; }
    public void setRoleAvailable(String roleAvailable) { this.roleAvailable = roleAvailable; }
}
