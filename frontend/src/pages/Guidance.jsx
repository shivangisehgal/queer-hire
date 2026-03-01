import './Guidance.css'

export default function Guidance() {
  return (
    <div className="page guidance-page">
      <div className="guidance-container">
        <div className="page-header">
          <h1 className="page-title">Career guidance</h1>
          <p className="page-subtitle">Support tailored for the LGBTQ+ community</p>
        </div>

        <div className="guidance-content card">
          <div className="guidance-intro">
            <p>
              QueerHire offers career counseling and guidance specifically designed for the LGBTQ+ community.
              Our counselors understand the unique challenges you may face and are here to support your journey.
            </p>
          </div>

          <div className="guidance-features">
            <div className="guidance-feature">
              <span className="guidance-feature-icon">💬</span>
              <div>
                <h3>One-on-one sessions</h3>
                <p>Personalized career counseling at your pace</p>
              </div>
            </div>
            <div className="guidance-feature">
              <span className="guidance-feature-icon">📄</span>
              <div>
                <h3>Resume & interview prep</h3>
                <p>Present your best self with confidence</p>
              </div>
            </div>
            <div className="guidance-feature">
              <span className="guidance-feature-icon">🏢</span>
              <div>
                <h3>Workplace navigation</h3>
                <p>Thrive in inclusive environments</p>
              </div>
            </div>
            <div className="guidance-feature">
              <span className="guidance-feature-icon">🔄</span>
              <div>
                <h3>Career transitions</h3>
                <p>Support for your next chapter</p>
              </div>
            </div>
          </div>

          <p className="guidance-cta">
            Interested in career guidance? Reach out and we'll connect you with a counselor.
          </p>
        </div>
      </div>
    </div>
  )
}
