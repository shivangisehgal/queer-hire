# 🌈 QueerHire

QueerHire is a responsive web application built with **React** and **Spring Boot**, providing an inclusive hiring and opportunity platform specifically designed for the LGBTQ+ community.

## Table of Contents

1. [Features](#features)
2. [Tech Stack](#tech-stack)
3. [Getting Started](#getting-started)
4. [Project Structure](#project-structure)

## Features

- **Login & Register** — User authentication with JWT
- **Home Page** — Platform mission and objectives
- **Jobs Page** — Browse and apply for LGBTQ+ inclusive job opportunities
- **Scholarships Page** — Discover and apply for scholarships
- **Job Application Form** — Apply with resume upload
- **Scholarship Application Form** — Apply with cover letter upload
- **Training Page** — Sign up for future courses
- **Guidance Page** — Career counseling information
- **Profile Page** — View application status

## Tech Stack

- **Frontend**: React 18, Vite, React Router, Axios
- **Backend**: Spring Boot 3, Spring Security, JWT, Spring Data JPA
- **Database**: H2 (development) — easily switchable to PostgreSQL

## Getting Started

### Prerequisites

- Node.js 18+
- Java 17+
- Maven 3.8+

### Backend

```bash
cd backend
./mvnw spring-boot:run
```

The API runs at `http://localhost:8080`.

### Frontend

```bash
cd frontend
npm install
npm run dev
```

The app runs at `http://localhost:5173` and proxies API requests to the backend.

### Production Build

```bash
# Backend
cd backend && ./mvnw clean package
java -jar target/queer-hire-backend-1.0.0.jar

# Frontend
cd frontend && npm run build
# Serve the dist/ folder with any static file server
```

## Project Structure

```
queer-hire/
├── backend/                 # Spring Boot API
│   ├── src/main/java/
│   │   └── com/queerhire/
│   │       ├── config/     # Security, DataLoader
│   │       ├── controller/ # REST endpoints
│   │       ├── dto/        # Request/Response DTOs
│   │       ├── entity/     # JPA entities
│   │       ├── repository/ # Data access
│   │       ├── security/   # JWT filter & util
│   │       └── service/    # Business logic
│   └── pom.xml
│
└── frontend/               # React SPA
    ├── src/
    │   ├── api/            # API client
    │   ├── components/     # Reusable components
    │   ├── context/       # Auth context
    │   └── pages/         # Route pages
    └── package.json
```

## Objectives

- **Helping the Youth** — Jobs, internships, and scholarships for young LGBTQ+ people
- **LGBTQ+ Hiring Platform** — Exclusive inclusive hiring space
- **Workplace Diversity** — Connecting companies with LGBTQ+ talent
- **Social Inclusion** — Creating a more inclusive society
