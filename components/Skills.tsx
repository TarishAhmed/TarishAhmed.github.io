import Reveal from "./Reveal";
const groups: [string, string[]][] = [
  ["Languages & frameworks", ["Flutter", "Dart", "React", "Android", "Rust", "SASS/CSS"]],
  ["State & architecture", ["Riverpod", "Bloc", "GetX", "Melos", "REST"]],
  ["Cloud & delivery", ["GCP", "Firebase", "AWS S3", "CloudFront", "Secrets Manager", "Lambda", "Bitbucket CI/CD", "Sentry"]],
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
