// Skills section for portfolio webapp
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import '../../models/resume_data.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({Key? key, required this.skills, required this.orbColor}) : super(key: key);

  final List<Skill> skills;
  final Color orbColor;

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  String _selectedCategory = 'All';

  List<String> get _categories {
    final categories = _getCategories(widget.skills);
    return ['All', ...categories];
  }

  List<Skill> get _filteredSkills {
    if (_selectedCategory == 'All') {
      return widget.skills;
    } else {
      return _filterSkillsByCategory(widget.skills, _selectedCategory);
    }
  }

  // Get unique skill categories
  List<String> _getCategories(List<Skill> skills) {
    final Set<String> categories = {};
    for (var skill in skills) {
      categories.addAll(skill.categories);
    }
    return categories.toList()..sort();
  }

  // Filter skills by category
  List<Skill> _filterSkillsByCategory(List<Skill> skills, String category) {
    return skills.where((skill) => skill.categories.contains(category)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildSectionHeader('MY SKILLS'),

            const Gap(20),

            // Category filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    _categories.map((category) {
                      final isSelected = category == _selectedCategory;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: FilterChip(
                          selected: isSelected,
                          showCheckmark: false,
                          label: Text(category),
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.white70,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          backgroundColor: Colors.black45,
                          selectedColor: widget.orbColor.withOpacity(0.3),
                          side: BorderSide(color: isSelected ? widget.orbColor : Colors.white24),
                          onSelected: (_) {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                        ),
                      );
                    }).toList(),
              ),
            ),

            const Gap(30),

            // Skills visualization
            _SkillsVisualization(skills: _filteredSkills, orbColor: widget.orbColor),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(width: 4, height: 24, color: widget.orbColor),
        const Gap(10),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Exo',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Colors.white,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 0.5.seconds).slide(begin: const Offset(-0.2, 0));
  }
}

class _SkillsVisualization extends StatelessWidget {
  const _SkillsVisualization({required this.skills, required this.orbColor});

  final List<Skill> skills;
  final Color orbColor;

  @override
  Widget build(BuildContext context) {
    // Sort skills by level in descending order
    final sortedSkills = List<Skill>.from(skills)..sort((a, b) => b.level.compareTo(a.level));

    return Row(
      children: [
        // Skill bars visualization
        Expanded(
          child: Column(
            children: [
              ...List.generate(
                sortedSkills.length,
                (index) => _SkillBar(skill: sortedSkills[index], orbColor: orbColor, delay: 0.1 * index),
              ),
            ],
          ),
        ),

        const Gap(40),

        // Radar chart visualization
        if (sortedSkills.length > 3)
          Expanded(child: _RadarChart(skills: sortedSkills.take(8).toList(), orbColor: orbColor))
        else
          Expanded(child: SizedBox()),
      ],
    );
  }
}

class _SkillBar extends StatelessWidget {
  const _SkillBar({required this.skill, required this.orbColor, required this.delay});

  final Skill skill;
  final Color orbColor;
  final double delay;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill.name,
                style: const TextStyle(
                  fontFamily: 'Exo',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '${(skill.level * 100).toInt()}%',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: orbColor.withOpacity(0.8)),
              ),
            ],
          ),
          const Gap(5),
          Stack(
            children: [
              // Background bar
              Container(
                height: 10,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(5)),
              ),
              // Skill level bar with animation
              AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOutCubic,
                height: 10,
                width: MediaQuery.of(context).size.width * skill.level * 0.7,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [orbColor.withOpacity(0.6), orbColor]),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [BoxShadow(color: orbColor.withOpacity(0.3), blurRadius: 5, spreadRadius: 1)],
                ),
              ).animate().fadeIn(duration: 0.8.seconds, delay: delay.seconds).slideX(begin: -1, end: 0),
            ],
          ),
        ],
      ),
    );
  }
}

class _RadarChart extends StatefulWidget {
  const _RadarChart({required this.skills, required this.orbColor});

  final List<Skill> skills;
  final Color orbColor;

  @override
  _RadarChartState createState() => _RadarChartState();
}

class _RadarChartState extends State<_RadarChart> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'SKILL RADAR',
          style: TextStyle(
            fontFamily: 'Exo',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: widget.orbColor,
            letterSpacing: 1.5,
          ),
        ),
        const Gap(20),
        SizedBox(
          height: 300,
          width: double.infinity,
          child: FittedBox(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  painter: _RadarChartPainter(
                    skills: widget.skills,
                    color: widget.orbColor,
                    animationValue: _animation.value,
                  ),
                  size: const Size(300, 300),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _RadarChartPainter extends CustomPainter {
  final List<Skill> skills;
  final Color color;
  final double animationValue;

  _RadarChartPainter({required this.skills, required this.color, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4;

    final paint =
        Paint()
          ..color = Colors.white24
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;

    // Draw background circles
    for (int i = 1; i <= 5; i++) {
      final currentRadius = radius * i / 5;
      canvas.drawCircle(center, currentRadius, paint);
    }

    // Draw spokes
    if (skills.isEmpty) return;

    final angleStep = 2 * pi / skills.length;

    for (int i = 0; i < skills.length; i++) {
      final angle = -pi / 2 + i * angleStep;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);

      canvas.drawLine(center, Offset(x, y), paint);

      // Draw skill labels
      final labelPainter = TextPainter(
        text: TextSpan(
          text: skills[i].name,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12, fontWeight: FontWeight.w500),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      labelPainter.layout();

      final labelX = center.dx + (radius + 20) * cos(angle) - labelPainter.width / 2;
      final labelY = center.dy + (radius + 20) * sin(angle) - labelPainter.height / 2;

      labelPainter.paint(canvas, Offset(labelX, labelY));
    }

    // Draw skill data
    final skillPaint =
        Paint()
          ..color = color.withOpacity(0.2)
          ..style = PaintingStyle.fill;

    final skillStrokePaint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0;

    final path = Path();

    for (int i = 0; i < skills.length; i++) {
      final angle = -pi / 2 + i * angleStep;
      final skillLevel = skills[i].level * animationValue;
      final x = center.dx + radius * skillLevel * cos(angle);
      final y = center.dy + radius * skillLevel * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      // Draw skill points
      final pointPaint =
          Paint()
            ..color = color
            ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), 5, pointPaint);
    }

    path.close();
    canvas.drawPath(path, skillPaint);
    canvas.drawPath(path, skillStrokePaint);
  }

  @override
  bool shouldRepaint(covariant _RadarChartPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue || oldDelegate.color != color || oldDelegate.skills != skills;
  }
}
