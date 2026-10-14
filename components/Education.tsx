import Reveal from "./Reveal";
export default function Education() {
  return (
    <section id="education" className="wrap section" aria-labelledby="h-edu">
      <Reveal as="h2" id="h-edu">Education &amp; research</Reveal>
      <div className="edu">
        <Reveal className="card">
          <p className="tag">May 2020</p>
          <h3>Master of Computer Applications (MCA)</h3>
          <p>Amrita School of Arts and Sciences, Kochi</p>
        </Reveal>
        <Reveal className="card" delay={0.06}>
          <p className="tag">IEEE ICCMC 2020</p>
          <h3>A Predictive analysis on the influence of WIFI 6 in fog computing with OFDMA and MU-MIMO</h3>
          <p><a href="https://doi.org/10.1109/ICCMC48092.2020.ICCMC-000133" target="_blank" rel="noopener">DOI 10.1109/ICCMC48092.2020.ICCMC-000133 ↗</a></p>
        </Reveal>
      </div>
    </section>
  );
}
