import Reveal from "./Reveal";
const jobs = [
  { when: "Mar 2023 — Present", role: "Software Development Engineer II", org: "Tijoree Money, Mumbai",
    desc: "Own the Flutter client (Android, iOS, Web) for a corporate cards & payables platform used by 100+ corporates including Reliance, Godrej and TVS Motor. Frontend lead for web/Flutter.",
    bullets: [
      "Designed a Melos monorepo with 6 feature packages (Virtual Cards, Vendor KYC, Payments, Analytics…), cutting duplication and CI build times ~25%.",
      "Built 4-stage Bitbucket CI/CD (Dev → Stage → Pre-prod → Prod) to AWS S3/CloudFront and Firebase Hosting, with Sentry APM + source maps.",
      "Web security: build-time AES transport-key injection via AWS Secrets Manager and Subresource Integrity, supporting PCI DSS / SOC 2 / ISO 27001 controls.",
      "Shipped GST reconciliation, invoice discounting, BBPS utility payments, vendor verification and multi-level approval workflows.",
    ] },
  { when: "Feb 2022 — Mar 2023", role: "Software Developer", org: "uFaber Edutech, Mumbai",
    desc: "Led Flutter delivery for FluentLife, UPSC Pathshala and IELTS Ninja — 10M+ downloads and 10K+ DAU across the portfolio.",
    bullets: [
      "AI chatbots, cloud calling, group activities and masterclasses with Flutter + Bloc.",
      "Serverless on Firebase + Cloud Functions; BigQuery / Cloud Logging for retention insights.",
    ] },
  { when: "Mar 2021 — Feb 2022", role: "Software Developer", org: "Corbel Business Applications, Kochi",
    desc: "Built Abemart (e-commerce) and Progresser (ERP) in Flutter.", bullets: [] },
  { when: "Aug 2020 — Mar 2021", role: "Software Developer", org: "Ingerem India Pvt Ltd, Kochi",
    desc: "Part of a 4-person R&D team building training/operations apps; worked on cloud architecture and document systems.", bullets: [] },
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
