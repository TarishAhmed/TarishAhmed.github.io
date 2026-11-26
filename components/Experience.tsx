import Reveal from "./Reveal";
const jobs = [
  { when: "Mar 2023 — Present", role: "Software Development Engineer II", org: "Tijoree Money, Mumbai",
    desc: "Lead the Flutter client (Android, iOS, Web) for a corporate cards & payables platform with $2B+ in transaction volume and 7x+ YoY net revenue growth, serving 100+ corporates including Reliance, Godrej, TVS Motor, Pidilite and Lodha. Frontend lead for web/Flutter, including frontend hiring.",
    bullets: [
      "Built 3 production AI/OCR document-extraction flows (prototyped with Gemini structured JSON schemas) across utility bills (20+ structured fields), vendor invoices and prepaid receipts, powering duplicate/mismatch fraud flags, audit trails and spend & consumption analytics.",
      "Engineered a Flutter Web Wasm delivery pipeline: 16 deferred-loaded GoRouter modules, content-hashed S3 chunk pruning across deploys, and max-quality Brotli pre-compression for a ~10.4 MB main.dart.wasm (beyond CloudFront's 10 MB auto-compression cap).",
      "Architected a Melos monorepo of 7 feature packages with Riverpod 3, Flutter Hooks and Freezed, cutting duplication and CI build times ~25%; migrated 66 module paths off GetX to 0 legacy files (CI-enforced) with 300+ unit/widget tests (flutter_test) and SonarQube checks.",
      "Built 4-stage Bitbucket CI/CD (Dev → Stage → Pre-prod → Prod) to AWS S3/CloudFront and Firebase, with Sentry APM (source maps, debug symbols, error boundaries, fallback UI) for a crash-free production experience.",
      "Shipped PCI DSS 4.0 web + mobile security: remote-rotatable SSL pinning (Dio + Firebase Remote Config), biometric lock (BiometricPrompt / Face ID), strict CSP, automated SRI, AES encryption and PII scrubbing.",
      "Shipped GST reconciliation, invoice discounting, BBPS utility payments, vendor verification and maker-checker approval workflows.",
    ] },
  { when: "Feb 2022 — Mar 2023", role: "Software Developer", org: "uFaber Edutech, Mumbai",
    desc: "Led Flutter delivery for FluentLife, UPSC Pathshala and IELTS Ninja — 10M+ downloads and 10K+ DAU across the portfolio.",
    bullets: [
      "AI chatbots, cloud calling, group activities and masterclasses with Flutter + Bloc.",
      "Serverless on Firebase + Cloud Functions; BigQuery / Cloud Logging funnel analytics.",
    ] },
  { when: "Mar 2021 — Feb 2022", role: "Software Developer", org: "Corbel Business Applications, Kochi",
    desc: "Built and delivered Abemart (e-commerce) and Progresser (ERP) Flutter apps end to end, from REST API integration to client handoff.", bullets: [] },
  { when: "Aug 2020 — Mar 2021", role: "Software Developer", org: "Ingerem India Pvt Ltd, Kochi",
    desc: "R&D engineer building interactive training and operations apps; managed cloud architecture and document systems.", bullets: [] },
];
export default function Experience() {
  return (
    <section id="experience" className="wrap section" aria-labelledby="h-exp">
      <Reveal as="h2" id="h-exp">Experience</Reveal>
      <ol className="timeline">
        {jobs.map((j) => (
          <Reveal as="li" key={j.when}>
            <div className="when">{j.when}</div>
            <div className="card">
              <h3>{j.role} <span>· {j.org}</span></h3>
              <p>{j.desc}</p>
              {j.bullets.length > 0 && <ul>{j.bullets.map((b) => <li key={b}>{b}</li>)}</ul>}
            </div>
          </Reveal>
        ))}
      </ol>
    </section>
  );
}
