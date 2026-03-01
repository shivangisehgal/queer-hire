import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import { jobsApi, scholarshipsApi } from '../api/client'
import './Profile.css'

export default function Profile() {
  const { user, logout } = useAuth()
  const navigate = useNavigate()
  const [jobApps, setJobApps] = useState([])
  const [scholarApps, setScholarApps] = useState([])

  useEffect(() => {
    if (!user) {
      navigate('/login')
      return
    }
    jobsApi.getMyApplications().then(res => setJobApps(res.data)).catch(() => setJobApps([]))
    scholarshipsApi.getMyApplications().then(res => setScholarApps(res.data)).catch(() => setScholarApps([]))
  }, [user, navigate])

  const handleLogout = () => {
    logout()
    navigate('/')
  }

  if (!user) return null

  return (
    <div className="page profile-page">
      <div className="profile-container">
        <div className="profile-header card">
          <div className="profile-avatar">
            <span>{user.name?.[0]?.toUpperCase() || '?'}</span>
          </div>
          <div className="profile-info">
            <h1 className="profile-name">{user.name}</h1>
            <p className="profile-email">{user.email}</p>
          </div>
          <button className="btn btn-ghost profile-logout" onClick={handleLogout}>
            Sign out
          </button>
        </div>

        <div className="profile-sections">
          <section className="profile-section card">
            <h2>Job applications</h2>
            {jobApps.length === 0 ? (
              <div className="profile-empty">
                <p>You haven't applied for any jobs yet.</p>
                <button className="btn btn-primary" onClick={() => navigate('/jobs')}>Browse jobs</button>
              </div>
            ) : (
              <ul className="profile-list">
                {jobApps.map(job => (
                  <li key={job.jobId}>
                    <div>
                      <strong>{job.companyName}</strong>
                      <span>{job.roleAvailable} — Applied</span>
                    </div>
                  </li>
                ))}
              </ul>
            )}
          </section>

          <section className="profile-section card">
            <h2>Scholarship applications</h2>
            {scholarApps.length === 0 ? (
              <div className="profile-empty">
                <p>You haven't applied to any scholarships yet.</p>
                <button className="btn btn-primary" onClick={() => navigate('/scholarships')}>Browse scholarships</button>
              </div>
            ) : (
              <ul className="profile-list">
                {scholarApps.map(sch => (
                  <li key={sch.sid}>
                    <div>
                      <strong>{sch.name}</strong>
                      <span>Applied</span>
                    </div>
                  </li>
                ))}
              </ul>
            )}
          </section>
        </div>
      </div>
    </div>
  )
}
