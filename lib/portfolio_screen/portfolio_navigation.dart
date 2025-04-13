// Navigation bar for portfolio sections
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:focusable_control_builder/focusable_control_builder.dart';

import '../styles.dart';
import 'portfolio_screen.dart';

class PortfolioNavigation extends StatelessWidget {
  const PortfolioNavigation({
    Key? key,
    required this.currentSection,
    required this.onSectionSelected,
    required this.orbColor,
  }) : super(key: key);

  final PortfolioSection currentSection;
  final Function(PortfolioSection) onSectionSelected;
  final Color orbColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: orbColor.withOpacity(0.5), width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNavButton('HOME', PortfolioSection.intro),
          _buildNavButton('ABOUT', PortfolioSection.about),
          _buildNavButton('SKILLS', PortfolioSection.skills),
          // _buildNavButton('PROJECTS', PortfolioSection.projects),
          _buildNavButton('CONTACT', PortfolioSection.contact),
        ],
      ),
    );
  }

  Widget _buildNavButton(String label, PortfolioSection section) {
    final isSelected = currentSection == section;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: FocusableControlBuilder(
        onPressed: () => onSectionSelected(section),
        builder: (context, state) {
          return AnimatedContainer(
            duration: 200.ms,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: isSelected ? 8.0 : 12.0),
            decoration: BoxDecoration(
              color: isSelected ? orbColor.withOpacity(0.2) : (state.isHovered ? Colors.white10 : Colors.transparent),
              borderRadius: BorderRadius.circular(20),
              border: isSelected ? Border.all(color: orbColor, width: 2) : null,
            ),
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Exo',
                fontSize: isSelected ? 16 : 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? orbColor : Colors.white70,
                letterSpacing: 1.5,
              ),
            ),
          );
        },
      ),
    );
  }
}
