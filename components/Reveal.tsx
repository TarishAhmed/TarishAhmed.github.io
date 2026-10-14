"use client";
import { motion, type HTMLMotionProps } from "framer-motion";

type Tag = "div" | "li" | "h2" | "article" | "section";
type Props = HTMLMotionProps<"div"> & { as?: Tag; delay?: number };

export default function Reveal({ as = "div", delay = 0, children, ...rest }: Props) {
  const M = motion[as] as typeof motion.div;
  return (
    <M
      initial={{ opacity: 0, y: 16 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true, amount: 0.12 }}
      transition={{ duration: 0.6, ease: "easeOut", delay }}
      {...rest}
    >
      {children}
    </M>
  );
}
