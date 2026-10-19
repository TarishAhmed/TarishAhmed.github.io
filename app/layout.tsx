import type { Metadata, Viewport } from "next";
import { Inter } from "next/font/google";
import Providers from "@/components/Providers";
import { DESCRIPTION, EMAIL, GITHUB, LINKEDIN, SITE_URL, TITLE } from "@/lib/site";
import "./globals.css";

const inter = Inter({ subsets: ["latin"], weight: ["400", "500", "600", "700", "800"], display: "swap" });

export const metadata: Metadata = {
  metadataBase: new URL(SITE_URL),
  title: TITLE,
  description: DESCRIPTION,
  alternates: { canonical: "/" },
  openGraph: {
    type: "website",
    url: SITE_URL,
    title: TITLE,
    description: "Flutter lead for a fintech payables platform used by 100+ corporates. ₹400 Cr+ monthly volume, 10M+ app downloads.",
  },
  twitter: { card: "summary", title: TITLE },
};

export const viewport: Viewport = {
  colorScheme: "dark light",
  themeColor: [
    { media: "(prefers-color-scheme: dark)", color: "#0b0d12" },
    { media: "(prefers-color-scheme: light)", color: "#f7f8fb" },
  ],
};

const jsonLd = {
  "@context": "https://schema.org",
  "@type": "Person",
  name: "Tarish",
  jobTitle: "Software Development Engineer II",
  url: SITE_URL,
  email: `mailto:${EMAIL}`,
  sameAs: [LINKEDIN, GITHUB],
  address: { "@type": "PostalAddress", addressCountry: "IN", addressLocality: "Mumbai" },
};

const themeInit = `try{var t=localStorage.getItem('theme');if(t)document.documentElement.dataset.theme=t}catch(e){}`;

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="en" suppressHydrationWarning>
      <head>
        <script dangerouslySetInnerHTML={{ __html: themeInit }} />
        <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }} />
      </head>
      <body style={{ fontFamily: `${inter.style.fontFamily}, system-ui, -apple-system, Segoe UI, Roboto, sans-serif` }}>
        <Providers>{children}</Providers>
      </body>
    </html>
  );
}
