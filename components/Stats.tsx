import Reveal from "./Reveal";
const stats = [
  ["$2B+", "transaction volume"],
  ["7x+", "YoY net revenue growth"],
  ["100+", "corporate clients"],
  ["10M+", "app downloads"],
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
