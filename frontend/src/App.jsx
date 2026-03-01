import { Routes, Route } from 'react-router-dom'
import Layout from './components/Layout'
import Home from './pages/Home'
import Jobs from './pages/Jobs'
import Scholarships from './pages/Scholarships'
import Training from './pages/Training'
import Guidance from './pages/Guidance'
import Login from './pages/Login'
import Register from './pages/Register'
import Profile from './pages/Profile'
import JobApplication from './pages/JobApplication'
import ScholarshipApplication from './pages/ScholarshipApplication'

export default function App() {
  return (
    <Routes>
      <Route path="/" element={<Layout />}>
        <Route index element={<Home />} />
        <Route path="jobs" element={<Jobs />} />
        <Route path="scholarships" element={<Scholarships />} />
        <Route path="training" element={<Training />} />
        <Route path="guidance" element={<Guidance />} />
        <Route path="login" element={<Login />} />
        <Route path="register" element={<Register />} />
        <Route path="profile" element={<Profile />} />
        <Route path="jobs/apply/:jobId" element={<JobApplication />} />
        <Route path="scholarships/apply/:sid" element={<ScholarshipApplication />} />
      </Route>
    </Routes>
  )
}
