import { useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import { authApi } from '../api/client'
import './Auth.css'

export default function Login() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [showReset, setShowReset] = useState(false)
  const [resetEmail, setResetEmail] = useState('')
  const { login } = useAuth()
  const navigate = useNavigate()

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError('')
    try {
      const res = await authApi.login({ email, password })
      login(res.data)
      navigate('/')
    } catch (err) {
      setError(err.response?.data?.message || 'Invalid email or password')
    }
  }

  const handleResetPassword = async (e) => {
    e.preventDefault()
    setError('')
    try {
      const exists = (await authApi.checkEmail(resetEmail)).data
      if (!exists) {
        setError('Email does not exist')
        return
      }
      setError('Password reset is not yet implemented. Please contact support.')
    } catch (err) {
      setError('Failed to check email')
    }
  }

  return (
    <div className="auth-page">
      <div className="auth-container">
        <div className="auth-card">
          <div className="auth-form-panel">
            <h1 className="auth-title">Welcome back</h1>
            <p className="auth-subtitle">Sign in to continue to QueerHire</p>

            {showReset ? (
              <form onSubmit={handleResetPassword} className="auth-form">
                <p className="auth-reset-text">Enter your email to reset your password.</p>
                <input
                  type="email"
                  className="input-field"
                  placeholder="Email"
                  value={resetEmail}
                  onChange={e => setResetEmail(e.target.value)}
                  required
                />
                {error && <p className="auth-error">{error}</p>}
                <div className="auth-form-actions">
                  <button type="button" className="btn btn-ghost" onClick={() => setShowReset(false)}>Cancel</button>
                  <button type="submit" className="btn btn-primary">Reset Password</button>
                </div>
              </form>
            ) : (
              <form onSubmit={handleSubmit} className="auth-form">
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
                  placeholder="Password"
                  value={password}
                  onChange={e => setPassword(e.target.value)}
                  required
                />
                <button type="button" className="auth-link" onClick={() => setShowReset(true)}>
                  Forgot password?
                </button>
                {error && <p className="auth-error">{error}</p>}
                <button type="submit" className="btn btn-primary auth-submit">Sign in</button>
              </form>
            )}
          </div>
          <div className="auth-side-panel">
            <h2>New here?</h2>
            <p>Create an account and start exploring opportunities.</p>
            <Link to="/register" className="btn btn-outline-white">Create account</Link>
            <Link to="/" className="btn btn-outline-white auth-side-link">Back to home</Link>
          </div>
        </div>
      </div>
    </div>
  )
}
