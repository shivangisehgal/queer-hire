package com.queerhire.service;

import com.queerhire.dto.AuthResponse;
import com.queerhire.dto.LoginRequest;
import com.queerhire.dto.RegisterRequest;
import com.queerhire.entity.User;
import com.queerhire.repository.UserRepository;
import com.queerhire.security.JwtUtil;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;

    public AuthService(UserRepository userRepository, PasswordEncoder passwordEncoder, JwtUtil jwtUtil) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtUtil = jwtUtil;
    }

    public AuthResponse register(RegisterRequest request) {
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new IllegalArgumentException("Email already registered");
        }

        User user = new User(
                request.getEmail(),
                passwordEncoder.encode(request.getPassword()),
                request.getName(),
                request.isRecruiter()
        );
        user = userRepository.save(user);

        String token = jwtUtil.generateToken(user.getId(), user.getEmail());
        return new AuthResponse(token, user.getId(), user.getEmail(), user.getName(), user.isRecruiter());
    }

    public AuthResponse login(LoginRequest request) {
        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new BadCredentialsException("Invalid email or password"));

        if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            throw new BadCredentialsException("Invalid email or password");
        }

        String token = jwtUtil.generateToken(user.getId(), user.getEmail());
        return new AuthResponse(token, user.getId(), user.getEmail(), user.getName(), user.isRecruiter());
    }

    public boolean checkEmailExists(String email) {
        return userRepository.existsByEmail(email);
    }
}
