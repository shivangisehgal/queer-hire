import { useState, useEffect } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import { jobsApi } from '../api/client'
import './ApplicationForm.css'

export default function JobApplication() {
  const { jobId } = useParams()
  const navigate = useNavigate()
  const { user } = useAuth()
  const [job, setJob] = useState(null)
  const [form, setForm] = useState({ name: '', email: '', age: '', contact: '', gender: '', yoe: '' })
  const [resume, setResume] = useState(null)
  const [resumeName, setResumeName] = useState('Resume')
  const [loading, setLoading] = useState(true)
  const [submitting, setSubmitting] = useState(false)
  const [error, setError] = useState('')

  useEffect(() => {
    if (!user) {
      navigate('/login')
      return
    }
    jobsApi.getById(jobId)
      .then(res => {
        setJob(res.data)
        setForm(f => ({ ...f, name: user.name || '', email: user.email || '' }))
      })
      .catch(() => navigate('/jobs'))
      .finally(() => setLoading(false))
  }, [jobId, user, navigate])

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value })
  }

  const handleFileChange = (e) => {
    const file = e.target.files?.[0]
    if (file) {
      setResume(file)
      setResumeName(file.name)
    }
  }

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError('')
    if (!resume) {
      setError('Please upload your resume')
      return
    }
    setSubmitting(true)
    try {
      await jobsApi.apply({
        jobId,
        name: form.name,
        email: form.email,
        age: parseInt(form.age) || 0,
        contact: form.contact,
        gender: form.gender,
        yoe: parseInt(form.yoe) || 0,
      }, resume)
      alert('Application submitted successfully!')
      navigate('/')
    } catch (err) {
      setError(err.response?.data?.message || 'Failed to submit application')
    } finally {
      setSubmitting(false)
    }
  }

  if (loading || !job) return <div className="page-loading"><div className="spinner" /><p>Loading...</p></div>

  return (
    <div className="page application-page">
      <div className="application-card card">
        <h1 className="application-title">Apply for <span>{job.companyName}</span></h1>
        <p className="application-role">{job.roleAvailable}</p>

        <form onSubmit={handleSubmit} className="application-form">
          <input name="name" className="input-field" placeholder="Full name" value={form.name} onChange={handleChange} required />
          <input name="email" type="email" className="input-field" placeholder="Email" value={form.email} onChange={handleChange} required />
          <input name="age" type="number" className="input-field" placeholder="Age" value={form.age} onChange={handleChange} required min="1" />
          <input name="contact" className="input-field" placeholder="Contact number" value={form.contact} onChange={handleChange} required />
          <input name="gender" className="input-field" placeholder="Gender" value={form.gender} onChange={handleChange} required />
          <input name="yoe" type="number" className="input-field" placeholder="Years of experience" value={form.yoe} onChange={handleChange} required min="0" />

          <div className="application-file">
            <input type="text" className="input-field" value={resumeName} readOnly />
            <label className="btn btn-secondary application-file-btn">
              <input type="file" accept=".pdf,.doc,.docx" onChange={handleFileChange} hidden />
              Upload resume
            </label>
          </div>

          {error && <p className="application-error">{error}</p>}
          <button type="submit" className="btn btn-primary application-submit" disabled={submitting}>
            {submitting ? 'Submitting...' : 'Submit application'}
          </button>
        </form>
      </div>
    </div>
  )
}
