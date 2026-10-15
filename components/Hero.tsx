import Reveal from "./Reveal";
import { EMAIL, LINKEDIN } from "@/lib/site";
export default function Hero() {
  return (
    <section className="hero wrap" aria-labelledby="h-name">
      <Reveal className="hero-text">
        <p className="eyebrow"><span className="pulse" aria-hidden="true"></span>Kochi / Mumbai, India</p>
        <h1 id="h-name">Tarish</h1>
        <p className="title">Software Development Engineer II · Flutter (Mobile + Web)</p>
        <p className="lede">I lead Flutter for a fintech payables platform that moves <strong>₹2,000+ Cr a year</strong> for 100+ corporates — shipping secure, fast releases across Android, iOS and Web.</p>
        <div className="cta">
          <a className="btn primary" href={`mailto:${EMAIL}`}>Email me</a>
          <a className="btn" href={LINKEDIN} target="_blank" rel="noopener">LinkedIn ↗</a>
          <a className="btn ghost" href="/resume.pdf" download>Download résumé</a>
        </div>
      </Reveal>
      <Reveal className="hero-art" aria-hidden="true" delay={0.1}>
        <div className="avatar">TAB</div>
        <div className="orb o1"></div><div className="orb o2"></div>
      </Reveal>
    </section>
  );
}
