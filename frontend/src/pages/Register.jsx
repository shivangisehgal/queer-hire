import { useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import { authApi } from '../api/client'
import './Auth.css'

export default function Register() {
  const [name, setName] = useState('')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [isRecruiter, setIsRecruiter] = useState(false)
  const [error, setError] = useState('')
  const { login } = useAuth()
  const navigate = useNavigate()

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError('')
    try {
      const res = await authApi.register({ name, email, password, isRecruiter })
      login(res.data)
      navigate('/')
    } catch (err) {
      setError(err.response?.data?.message || err.response?.data?.error || 'Registration failed')
    }
  }

  return (
    <div className="auth-page">
      <div className="auth-container">
        <div className="auth-card">
          <div className="auth-form-panel">
            <h1 className="auth-title">Create your account</h1>
            <p className="auth-subtitle">Join QueerHire and discover opportunities</p>

            <form onSubmit={handleSubmit} className="auth-form">
              <input
                type="text"
                className="input-field"
                placeholder="Full name"
                value={name}
                onChange={e => setName(e.target.value)}
                required
              />
              <input
                type="email"
                className="input-field"
                placeholder="Email"
                value={email}
                onChange={e => setEmail(e.target.value)}
                required
              />
              <input
                type="password"
                className="input-field"
                placeholder="Password (min 6 characters)"
                value={password}
                onChange={e => setPassword(e.target.value)}
                required
                minLength={6}
              />
              <label className="auth-checkbox">
                <input
                  type="checkbox"
                  checked={isRecruiter}
                  onChange={e => setIsRecruiter(e.target.checked)}
                />
                <span>I'm a recruiter</span>
              </label>
              {error && <p className="auth-error">{error}</p>}
              <button type="submit" className="btn btn-primary auth-submit">Create account</button>
            </form>
          </div>
          <div className="auth-side-panel">
            <h2>Already have an account?</h2>
            <p>Sign in to access your dashboard.</p>
            <Link to="/login" className="btn btn-outline-white">Sign in</Link>
            <Link to="/" className="btn btn-outline-white auth-side-link">Back to home</Link>
          </div>
        </div>
      </div>
    </div>
  )
}
