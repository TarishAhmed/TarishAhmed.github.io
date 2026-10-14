import Header from "@/components/Header";
import Hero from "@/components/Hero";
import Stats from "@/components/Stats";
import Experience from "@/components/Experience";
import CaseStudies from "@/components/CaseStudies";
import Skills from "@/components/Skills";
import Education from "@/components/Education";
import Contact from "@/components/Contact";

export default function Home() {
  return (
    <>
      <a className="skip" href="#main">Skip to content</a>
      <Header />
      <main id="main">
        <Hero />
        <Stats />
        <Experience />
        <CaseStudies />
        <Skills />
        <Education />
        <Contact />
      </main>
      <footer className="wrap foot">
        <p>© {new Date().getFullYear()} Tarish Ahmed</p>
        <a href="#top">Back to top ↑</a>
      </footer>
    </>
  );
}
