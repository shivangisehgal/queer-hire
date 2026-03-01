import './JobCard.css'

export default function JobCard({ job, onApply }) {
  return (
    <article className="job-card card">
      <div className="job-card-header">
        <span className="job-company">{job.companyName}</span>
      </div>
      <p className="job-description">{job.description}</p>
      <div className="job-meta">
        <div className="job-meta-item">
          <span className="job-meta-label">Role</span>
          <span className="job-meta-value">{job.roleAvailable}</span>
        </div>
        <div className="job-meta-item">
          <span className="job-meta-label">Openings</span>
          <span className="job-meta-value">{job.openings}</span>
        </div>
      </div>
      <button className="btn btn-primary job-apply-btn" onClick={onApply}>
        Apply now
      </button>
    </article>
  )
}
