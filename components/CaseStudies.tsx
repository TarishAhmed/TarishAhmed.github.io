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
            <dd>One Flutter client had to serve Android, iOS and Web for 100+ corporates moving ₹2,000+ Cr a year — under PCI DSS, SOC 2 and ISO 27001 expectations.</dd>
            <dt>Approach</dt>
            <dd>Melos monorepo with 6 feature packages; 4-stage Bitbucket CI/CD to AWS S3/CloudFront and Firebase Hosting; Sentry APM with source maps; build-time AES key injection via AWS Secrets Manager plus Subresource Integrity.</dd>
            <dt>Impact</dt>
            <dd>~25% faster CI builds, less duplication, and a steady stream of shipped features: GST reconciliation, invoice discounting, BBPS payments, vendor verification and multi-level approvals.</dd>
          </dl>
          <Chips items={["Flutter Web", "Melos", "AWS", "Sentry", "Bitbucket CI/CD"]} />
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
            <dd>Led Flutter delivery with Bloc: AI chatbots, cloud calling, group activities and masterclasses, on a serverless Firebase + Cloud Functions backend, with BigQuery / Cloud Logging for retention analysis.</dd>
            <dt>Impact</dt>
            <dd>10M+ downloads and 10K+ daily active users across the portfolio.</dd>
          </dl>
          <Chips items={["Flutter", "Bloc", "Firebase", "Cloud Functions", "BigQuery"]} />
        </div>
      </Reveal>
    </section>
  );
}
