package com.queerhire.dto;

public class AuthResponse {
    private String token;
    private String id;
    private String email;
    private String name;
    private boolean isRecruiter;

    public AuthResponse(String token, String id, String email, String name, boolean isRecruiter) {
        this.token = token;
        this.id = id;
        this.email = email;
        this.name = name;
        this.isRecruiter = isRecruiter;
    }

    public String getToken() { return token; }
    public String getId() { return id; }
    public String getEmail() { return email; }
    public String getName() { return name; }
    public boolean isRecruiter() { return isRecruiter; }
}
