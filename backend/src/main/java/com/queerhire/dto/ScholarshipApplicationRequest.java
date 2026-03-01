package com.queerhire.dto;

import jakarta.validation.constraints.*;

public class ScholarshipApplicationRequest {
    @NotBlank
    private String sid;
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
    private String coverletter;

    public String getSid() { return sid; }
    public void setSid(String sid) { this.sid = sid; }
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
    public String getCoverletter() { return coverletter; }
    public void setCoverletter(String coverletter) { this.coverletter = coverletter; }
}
