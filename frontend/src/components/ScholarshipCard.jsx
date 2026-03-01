import './ScholarshipCard.css'

export default function ScholarshipCard({ scholarship, onApply }) {
  return (
    <article className="scholarship-card card">
      <div className="scholarship-card-header">
        <span className="scholarship-icon">🎓</span>
        <span className="scholarship-name">{scholarship.name}</span>
      </div>
      <p className="scholarship-description">{scholarship.description}</p>
      <div className="scholarship-eligibility">
        <span className="scholarship-eligibility-label">Eligibility</span>
        <p className="scholarship-eligibility-value">{scholarship.eligibility}</p>
      </div>
      <button className="btn btn-primary scholarship-apply-btn" onClick={onApply}>
        Apply now
      </button>
    </article>
  )
}
