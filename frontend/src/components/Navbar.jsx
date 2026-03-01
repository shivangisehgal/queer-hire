import { useState } from 'react'
import { Link } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import './Navbar.css'

export default function Navbar() {
  const { user } = useAuth()
  const [mobileOpen, setMobileOpen] = useState(false)

  return (
    <header className="navbar">
      <div className="navbar-container">
        <Link to="/" className="nav-logo">
          <img src="/images/logo-icon.png" alt="" className="nav-logo-icon" />
          <span>QueerHire</span>
        </Link>

        <button
          className="nav-mobile-toggle"
          onClick={() => setMobileOpen(!mobileOpen)}
          aria-label="Toggle menu"
        >
          <span className={mobileOpen ? 'open' : ''} />
          <span className={mobileOpen ? 'open' : ''} />
          <span className={mobileOpen ? 'open' : ''} />
        </button>

        <nav className={`nav-links ${mobileOpen ? 'open' : ''}`}>
          <Link to="/" onClick={() => setMobileOpen(false)}>Home</Link>
          <Link to="/jobs" onClick={() => setMobileOpen(false)}>Jobs</Link>
          <Link to="/scholarships" onClick={() => setMobileOpen(false)}>Scholarships</Link>
          <Link to="/training" onClick={() => setMobileOpen(false)}>Training</Link>
          <Link to="/guidance" onClick={() => setMobileOpen(false)}>Guidance</Link>
        </nav>

        <div className="nav-auth">
          {user ? (
            <Link to="/profile" className="nav-user" onClick={() => setMobileOpen(false)}>
              <span className="nav-user-greeting">Hi, <strong>{user.name}</strong></span>
              <div className="nav-avatar">
                <span className="nav-avatar-initial">{user.name?.[0]?.toUpperCase() || '?'}</span>
              </div>
            </Link>
          ) : (
            <Link to="/login" className="btn btn-primary nav-login-btn" onClick={() => setMobileOpen(false)}>
              Get Started
            </Link>
          )}
        </div>
      </div>
    </header>
  )
}
