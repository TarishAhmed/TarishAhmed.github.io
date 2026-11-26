import Reveal from "./Reveal";
const groups: [string, string[]][] = [
  ["Mobile & web", ["Flutter", "Dart", "Flutter Web (Wasm)", "Android", "iOS", "Swift", "React", "SASS/CSS"]],
  ["Architecture & quality", ["Riverpod", "Flutter Hooks", "Freezed", "Bloc", "GoRouter", "Melos", "REST", "flutter_test", "SonarQube"]],
  ["Security", ["PCI DSS 4.0", "CSP", "SRI", "SSL pinning", "Biometrics", "AES", "VAPT"]],
  ["Cloud & delivery", ["Bitbucket CI/CD", "AWS S3", "CloudFront", "Firebase", "GCP", "Sentry APM"]],
  ["AI & data", ["Vertex AI", "Gemini API", "OCR extraction", "BigQuery"]],
  ["Domain", ["Fintech", "Corporate cards", "Payables", "BBPS", "GST", "KYC", "Edtech", "E-commerce"]],
];
export default function Skills() {
  return (
    <section id="skills" className="wrap section" aria-labelledby="h-skills">
      <Reveal as="h2" id="h-skills">Skills</Reveal>
      <div className="skills">
        {groups.map(([t, items], i) => (
          <Reveal key={t} delay={i * 0.06}>
            <h3>{t}</h3>
            <ul className="chips">{items.map((c) => <li key={c}>{c}</li>)}</ul>
          </Reveal>
        ))}
      </div>
    </section>
  );
}
