import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import { scholarshipsApi } from '../api/client'
import ScholarshipCard from '../components/ScholarshipCard'
import './Scholarships.css'

export default function Scholarships() {
  const [scholarships, setScholarships] = useState([])
  const [loading, setLoading] = useState(true)
  const { user } = useAuth()
  const navigate = useNavigate()

  useEffect(() => {
    scholarshipsApi.getAll()
      .then(res => setScholarships(res.data))
      .catch(() => setScholarships([]))
      .finally(() => setLoading(false))
  }, [])

  const handleApply = (scholarship) => {
    if (!user) {
      navigate('/login')
    } else {
      navigate(`/scholarships/apply/${scholarship.sid}`)
    }
  }

  return (
    <div className="page scholarships-page">
      <div className="page-header">
        <h1 className="page-title">Scholarships for you</h1>
        <p className="page-subtitle">Financial support for LGBTQ+ students and professionals</p>
      </div>

      {loading ? (
        <div className="page-loading">
          <div className="spinner" />
          <p>Loading scholarships...</p>
        </div>
      ) : scholarships.length === 0 ? (
        <div className="page-empty">
          <div className="empty-icon">🎓</div>
          <h3>No scholarships available yet</h3>
          <p>Check back soon for new opportunities</p>
        </div>
      ) : (
        <div className="scholarships-grid">
          {scholarships.map(sch => (
            <ScholarshipCard key={sch.sid} scholarship={sch} onApply={() => handleApply(sch)} />
          ))}
        </div>
      )}
    </div>
  )
}
