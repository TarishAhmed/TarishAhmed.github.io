"use client";
export default function ThemeToggle() {
  const toggle = () => {
    const r = document.documentElement;
    const cur = r.dataset.theme || (matchMedia("(prefers-color-scheme: light)").matches ? "light" : "dark");
    const n = cur === "light" ? "dark" : "light";
    r.dataset.theme = n;
    try { localStorage.setItem("theme", n); } catch {}
  };
  return (
    <button className="theme" type="button" aria-label="Toggle color theme" onClick={toggle}>
      <span aria-hidden="true">◐</span>
    </button>
  );
}
