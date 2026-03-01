import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import { jobsApi } from '../api/client'
import JobCard from '../components/JobCard'
import './Jobs.css'

export default function Jobs() {
  const [jobs, setJobs] = useState([])
  const [loading, setLoading] = useState(true)
  const { user } = useAuth()
  const navigate = useNavigate()

  useEffect(() => {
    jobsApi.getAll()
      .then(res => setJobs(res.data))
      .catch(() => setJobs([]))
      .finally(() => setLoading(false))
  }, [])

  const handleApply = (job) => {
    if (!user) {
      navigate('/login')
    } else {
      navigate(`/jobs/apply/${job.jobId}`)
    }
  }

  return (
    <div className="page jobs-page">
      <div className="page-header">
        <h1 className="page-title">Find your next opportunity</h1>
        <p className="page-subtitle">LGBTQ+ inclusive roles from employers who value you</p>
      </div>

      {loading ? (
        <div className="page-loading">
          <div className="spinner" />
          <p>Loading opportunities...</p>
        </div>
      ) : jobs.length === 0 ? (
        <div className="page-empty">
          <div className="empty-icon">💼</div>
          <h3>No jobs listed yet</h3>
          <p>Check back soon for new opportunities</p>
        </div>
      ) : (
        <div className="jobs-grid">
          {jobs.map(job => (
            <JobCard key={job.jobId} job={job} onApply={() => handleApply(job)} />
          ))}
        </div>
      )}
    </div>
  )
}
