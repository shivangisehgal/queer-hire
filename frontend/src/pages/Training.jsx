import { useState } from 'react'
import './Training.css'

const COURSES = [
  { title: 'App Development', emoji: '📱', desc: 'Build mobile and web applications' },
  { title: 'UI/UX Design', emoji: '🎨', desc: 'Create beautiful, inclusive experiences' },
  { title: 'Product Management', emoji: '📊', desc: 'Lead products that matter' },
  { title: 'Digital Marketing', emoji: '📣', desc: 'Reach and engage your audience' },
  { title: 'HR & People Ops', emoji: '👥', desc: 'Build inclusive teams' },
  { title: 'Data Analysis', emoji: '📈', desc: 'Turn data into decisions' },
]

export default function Training() {
  const [showDialog, setShowDialog] = useState(false)
  const [selectedCourse, setSelectedCourse] = useState('')

  const handleCourseClick = (title) => {
    setSelectedCourse(title)
    setShowDialog(true)
  }

  return (
    <div className="page training-page">
      <div className="page-header">
        <h1 className="page-title">Be job ready</h1>
        <p className="page-subtitle">Upskill with courses designed for your growth</p>
      </div>

      <div className="training-grid">
        {COURSES.map(course => (
          <button
            key={course.title}
            className="training-card card"
            onClick={() => handleCourseClick(course.title)}
          >
            <div className="training-icon">{course.emoji}</div>
            <h3>{course.title}</h3>
            <p>{course.desc}</p>
          </button>
        ))}
      </div>

      {showDialog && (
        <div className="training-dialog-overlay" onClick={() => setShowDialog(false)}>
          <div className="training-dialog card" onClick={e => e.stopPropagation()}>
            <h2>Thanks for your interest!</h2>
            <p>
              You've taken the first step towards mastering <strong>{selectedCourse}</strong>.
              Our team is excited to bring you an exceptional learning experience.
            </p>
            <p>
              We're preparing to launch soon. We'll notify you via email when this course becomes available.
            </p>
            <p className="training-dialog-cta">Keep exploring, keep growing.</p>
            <button className="btn btn-primary" onClick={() => setShowDialog(false)}>Close</button>
          </div>
        </div>
      )}
    </div>
  )
}
