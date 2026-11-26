import Reveal from "./Reveal";
const Chips = ({ items }: { items: string[] }) => <ul className="chips">{items.map((c) => <li key={c}>{c}</li>)}</ul>;
export default function CaseStudies() {
  return (
    <section id="work" className="wrap section" aria-labelledby="h-work">
      <Reveal as="h2" id="h-work">Featured work</Reveal>
      <Reveal as="article" className="case">
        <div className="case-art" aria-hidden="true">
          <div className="mock-web">
            <div className="bar"><i></i><i></i><i></i></div>
            <div className="mw-body">
              <div className="vcard"><span></span><span></span></div>
              <div className="rows"><span></span><span></span><span></span><span></span></div>
              <div className="chart">
                {["40%", "65%", "50%", "85%", "70%"].map((h, i) => <i key={i} style={{ ["--h" as string]: h }}></i>)}
              </div>
            </div>
          </div>
          <div className="mock-phone small"><div className="vcard"><span></span><span></span></div><div className="rows"><span></span><span></span><span></span></div></div>
        </div>
        <div className="case-body">
          <p className="tag">Fintech · Tijoree Money</p>
          <h3>Corporate cards &amp; payables platform</h3>
          <dl>
            <dt>Problem</dt>
            <dd>One Flutter client had to serve Android, iOS and Web for 100+ corporates — $2B+ in transaction volume through 7x+ YoY net revenue growth — under PCI DSS 4.0 expectations.</dd>
            <dt>Approach</dt>
            <dd>Melos monorepo of 7 feature packages on Riverpod 3, Flutter Hooks and Freezed; a Flutter Web Wasm pipeline with 16 deferred-loaded GoRouter modules, content-hashed S3 chunk pruning and max-quality Brotli for a ~10.4 MB main.dart.wasm; 3 AI/OCR document-extraction flows built on Gemini structured JSON schemas; remote-rotatable SSL pinning (Dio + Firebase Remote Config), biometric lock, CSP and SRI; Sentry APM with source maps.</dd>
            <dt>Impact</dt>
            <dd>~25% faster CI builds and less duplication; 66 module paths migrated off GetX to 0 legacy files with 300+ unit/widget tests; 20+ structured fields extracted from utility bills powering fraud flags and spend analytics; a crash-free production experience across GST reconciliation, invoice discounting, BBPS payments, vendor verification and maker-checker approvals.</dd>
          </dl>
          <Chips items={["Flutter Web (Wasm)", "Melos", "Riverpod", "Gemini", "PCI DSS 4.0", "Sentry"]} />
        </div>
      </Reveal>
      <Reveal as="article" className="case alt">
        <div className="case-art" aria-hidden="true">
          <div className="mock-phone"><div className="bubble l"></div><div className="bubble r"></div><div className="bubble l short"></div><div className="rows"><span></span><span></span></div></div>
          <div className="mock-phone tilt"><div className="hero-tile"></div><div className="rows"><span></span><span></span><span></span></div></div>
        </div>
        <div className="case-body">
          <p className="tag">Edtech · uFaber</p>
          <h3>Consumer learning apps</h3>
          <dl>
            <dt>Problem</dt>
            <dd>Three consumer apps — FluentLife, UPSC Pathshala and IELTS Ninja — needed rich, live learning features at scale.</dd>
            <dt>Approach</dt>
            <dd>Led Flutter delivery with Bloc: AI chatbots, cloud calling, group activities and masterclasses, on a serverless Firebase + Cloud Functions backend, with BigQuery / Cloud Logging funnel analytics.</dd>
            <dt>Impact</dt>
            <dd>10M+ downloads and 10K+ daily active users across the portfolio.</dd>
          </dl>
          <Chips items={["Flutter", "Bloc", "Firebase", "Cloud Functions", "BigQuery"]} />
        </div>
      </Reveal>
    </section>
  );
}
