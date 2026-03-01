package com.queerhire.entity;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "scholarships")
public class Scholarship {

    @Id
    @Column(name = "sid")
    private String sid;

    @Column(nullable = false)
    private String name;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(columnDefinition = "TEXT")
    private String eligibility;

    @OneToMany(mappedBy = "scholarship", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ScholarshipApplication> applications = new ArrayList<>();

    public Scholarship() {}

    public Scholarship(String sid, String name, String description, String eligibility) {
        this.sid = sid;
        this.name = name;
        this.description = description;
        this.eligibility = eligibility;
    }

    public String getSid() { return sid; }
    public void setSid(String sid) { this.sid = sid; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getEligibility() { return eligibility; }
    public void setEligibility(String eligibility) { this.eligibility = eligibility; }
}
