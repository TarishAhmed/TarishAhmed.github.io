// Intro section for portfolio webapp
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:focusable_control_builder/focusable_control_builder.dart';
import 'package:gap/gap.dart';

import '../../styles.dart';

class IntroSection extends StatelessWidget {
  const IntroSection({
    Key? key,
    required this.name,
    required this.title,
    required this.tagline,
    required this.onExplorePressed,
  }) : super(key: key);

  final String name;
  final String title;
  final String tagline;
  final VoidCallback onExplorePressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Name with animated reveal
          Text(
            name.toUpperCase(),
            style: TextStyle(
              fontFamily: 'Exo',
              fontSize: 72,
              fontWeight: FontWeight.bold,
              letterSpacing: 8.0,
              color: Colors.white,
              shadows: [Shadow(color: Colors.blue.withOpacity(0.5), offset: const Offset(0, 0), blurRadius: 20)],
            ),
          ).animate().fadeIn(duration: 1.seconds, delay: 0.3.seconds).slide(begin: const Offset(0, -0.2)),

          const Gap(10),

          // Title with animated reveal
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Exo',
              fontSize: 32,
              fontWeight: FontWeight.w500,
              letterSpacing: 4.0,
              color: Colors.blue.shade300,
            ),
          ).animate().fadeIn(duration: 0.8.seconds, delay: 0.8.seconds).slide(begin: const Offset(0, 0.2)),

          const Gap(30),

          // Tagline with animated reveal
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white24, width: 1),
            ),
            child: Text(
              tagline,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Exo',
                fontSize: 24,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
                color: Colors.white70,
              ),
            ),
          ).animate().fadeIn(duration: 0.8.seconds, delay: 1.2.seconds).scale(begin: const Offset(0.95, 0.95)),

          const Gap(60),

          // Explore button
          FocusableControlBuilder(
            cursor: SystemMouseCursors.click,
            onPressed: onExplorePressed,
            builder: (context, state) {
              return AnimatedContainer(
                    duration: 200.ms,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    decoration: BoxDecoration(
                      color: state.isHovered ? Colors.blue.withOpacity(0.3) : Colors.black45,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: state.isHovered ? Colors.blue : Colors.white30, width: 2),
                      boxShadow:
                          state.isHovered
                              ? [BoxShadow(color: Colors.blue.withOpacity(0.5), blurRadius: 20, spreadRadius: 2)]
                              : null,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "EXPLORE MY WORK",
                          style: TextStyle(
                            fontFamily: 'Exo',
                            fontSize: 18,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            color: state.isHovered ? Colors.white : Colors.white70,
                          ),
                        ),
                        const Gap(12),
                        Icon(Icons.arrow_forward, color: state.isHovered ? Colors.white : Colors.white70),
                      ],
                    ),
                  )
                  .animate(target: state.isHovered ? 1 : 0)
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.05, 1.05),
                    curve: Curves.easeOutCubic,
                    duration: 0.2.seconds,
                  );
            },
          ).animate().fadeIn(duration: 0.8.seconds, delay: 1.5.seconds).slide(begin: const Offset(0, 0.3)),
        ],
      ),
    );
  }
}
