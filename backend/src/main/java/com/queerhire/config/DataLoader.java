package com.queerhire.config;

import com.queerhire.entity.Job;
import com.queerhire.entity.Scholarship;
import com.queerhire.repository.JobRepository;
import com.queerhire.repository.ScholarshipRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class DataLoader implements CommandLineRunner {

    private final JobRepository jobRepository;
    private final ScholarshipRepository scholarshipRepository;

    public DataLoader(JobRepository jobRepository, ScholarshipRepository scholarshipRepository) {
        this.jobRepository = jobRepository;
        this.scholarshipRepository = scholarshipRepository;
    }

    @Override
    public void run(String... args) {
        if (jobRepository.count() == 0) {
            jobRepository.save(new Job("job1", "Inclusive Tech Corp", "We are an LGBTQ+ inclusive technology company.", 5, "Software Engineer"));
            jobRepository.save(new Job("job2", "Diversity First Inc", "Building diverse teams for a better tomorrow.", 3, "Product Manager"));
            jobRepository.save(new Job("job3", "Rainbow Ventures", "Venture capital focused on LGBTQ+ founders.", 2, "Investment Analyst"));
        }
        if (scholarshipRepository.count() == 0) {
            scholarshipRepository.save(new Scholarship("sch1", "LGBTQ+ STEM Scholarship", "Supporting LGBTQ+ students in STEM fields.", "Open to LGBTQ+ identifying students pursuing STEM degrees."));
            scholarshipRepository.save(new Scholarship("sch2", "Pride Leadership Grant", "Developing future LGBTQ+ leaders.", "For students demonstrating leadership in LGBTQ+ advocacy."));
            scholarshipRepository.save(new Scholarship("sch3", "Queer Arts Fellowship", "Supporting LGBTQ+ artists and creators.", "For artists identifying as LGBTQ+."));
        }
    }
}
