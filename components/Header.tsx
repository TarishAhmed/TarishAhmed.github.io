import ThemeToggle from "./ThemeToggle";
export default function Header() {
  return (
    <header className="nav" id="top">
      <div className="wrap nav-in">
        <a href="#top" className="brand" aria-label="Tarish Ahmed, home">
          <span className="dot" aria-hidden="true">TA</span>Tarish Ahmed
        </a>
        <nav aria-label="Primary">
          <ul>
            <li><a href="#experience">Experience</a></li>
            <li><a href="#work">Work</a></li>
            <li><a href="#skills">Skills</a></li>
            <li><a href="#contact">Contact</a></li>
          </ul>
        </nav>
        <ThemeToggle />
      </div>
    </header>
  );
}
