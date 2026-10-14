import Reveal from "./Reveal";
import { EMAIL, GITHUB, LINKEDIN } from "@/lib/site";
export default function Contact() {
  return (
    <Reveal as="section" id="contact" className="wrap section contact" aria-labelledby="h-contact">
      <h2 id="h-contact">Let’s build something reliable.</h2>
      <p>Open to Flutter lead and SDE II roles in fintech. Based in Kochi / Mumbai, India.</p>
      <div className="cta center">
        <a className="btn primary" href={`mailto:${EMAIL}`}>{EMAIL}</a>
        <a className="btn" href={LINKEDIN} target="_blank" rel="noopener">linkedin.com/in/tarishahmed ↗</a>
        <a className="btn" href={GITHUB} target="_blank" rel="noopener">github.com/TarishAhmed ↗</a>
      </div>
    </Reveal>
  );
}
