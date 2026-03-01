import { Link } from 'react-router-dom'
import './Home.css'

export default function Home() {
  return (
    <div className="home">
      <section className="hero">
        <div className="hero-bg" />
        <div className="hero-content">
          <div className="hero-badge">Inclusive Hiring Platform</div>
          <h1 className="hero-title">
            Build your career in a space that <span className="highlight">celebrates you</span>
          </h1>
          <p className="hero-tagline">
            QueerHire connects the LGBTQ+ community with inclusive employers, scholarships, and opportunities. Your identity is your strength.
          </p>
          <div className="hero-actions">
            <Link to="/jobs" className="btn btn-primary hero-btn">Find Jobs</Link>
            <Link to="/scholarships" className="btn btn-secondary hero-btn">Browse Scholarships</Link>
          </div>
        </div>
        <div className="hero-visual">
          <img src="/images/hero-illustration.png" alt="" className="hero-image" />
        </div>
      </section>

      <section className="section section-mission">
        <div className="section-inner">
          <div className="mission-content">
            <h2 className="section-title">Fostering representation in the workplace</h2>
            <p className="section-subtitle">Connecting the LGBTQ+ community with inclusive employers</p>
            <p className="section-body">
              QueerHire promotes diversity and equality by creating an inclusive job market for all job seekers.
              We advance LGBTQ+ representation and provide equal opportunities to everyone, regardless of their identity.
            </p>
          </div>
          <div className="mission-visual">
            <img src="/images/workplace-diversity.png" alt="Inclusive workplace" className="mission-image" />
          </div>
        </div>
      </section>

      <section className="section section-training">
        <div className="section-inner narrow">
          <h2 className="section-title text-center">Building inclusive workplaces</h2>
          <p className="section-subtitle text-center">LGBTQ+ inclusive training for employers</p>
          <p className="section-body text-center max-w">
            Our training program equips employers with the tools to create a safe and welcoming environment for LGBTQ+ employees. Learn to build a culture where everyone thrives.
          </p>
          <Link to="/training" className="btn btn-ghost section-cta">Explore Training</Link>
        </div>
      </section>

      <section className="section section-cta-block">
        <div className="cta-block">
          <h2 className="cta-title">Ready to get started?</h2>
          <p className="cta-subtitle">Your next opportunity is waiting</p>
          <div className="cta-buttons">
            <Link to="/jobs" className="btn btn-primary btn-lg">Browse Jobs</Link>
            <Link to="/scholarships" className="btn btn-outline-white btn-lg">Browse Scholarships</Link>
          </div>
        </div>
      </section>

      <footer className="footer">
        <div className="footer-inner">
          <p className="footer-text">© {new Date().getFullYear()} QueerHire — Building Inclusive Futures</p>
        </div>
      </footer>
    </div>
  )
}
