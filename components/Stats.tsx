import Reveal from "./Reveal";
const stats = [
  ["₹400 Cr+", "monthly transaction volume"],
  ["100+", "corporate clients"],
  ["10M+", "app downloads"],
  ["~25%", "faster CI builds"],
];
export default function Stats() {
  return (
    <section className="stats" aria-label="Impact at a glance">
      <ul className="wrap stats-in">
        {stats.map(([b, s], i) => (
          <Reveal as="li" key={b} delay={i * 0.06}><b>{b}</b><span>{s}</span></Reveal>
        ))}
      </ul>
    </section>
  );
}
