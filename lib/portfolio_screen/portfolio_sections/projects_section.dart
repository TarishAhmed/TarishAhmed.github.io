// Projects section for portfolio webapp
import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../assets.dart';
import '../../common/shader_effect.dart';
import '../../common/ticking_builder.dart';
import '../../models/resume_data.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({Key? key, required this.projects}) : super(key: key);

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildSectionHeader('MY PROJECTS'),

          const Gap(30),

          // Projects grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.3,
              ),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return _ProjectCard(project: projects[index], index: index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(width: 4, height: 24, color: Colors.orange),
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

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({required this.project, required this.index});

  final Project project;
  final int index;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _glitchController;
  Timer? _glitchTimer;

  @override
  void initState() {
    super.initState();
    _glitchController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    // Occasional glitch effect for sci-fi feeling
    _scheduleRandomGlitch();
  }

  void _scheduleRandomGlitch() {
    final randomDuration = Duration(seconds: 5 + Random().nextInt(15));
    _glitchTimer = Timer(randomDuration, () {
      if (mounted) {
        _glitchController.forward(from: 0).then((_) {
          _scheduleRandomGlitch();
        });
      }
    });
  }

  @override
  void dispose() {
    _glitchController.dispose();
    _glitchTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter:
          (_) => setState(() {
            _isHovered = true;
            _glitchController.forward(from: 0);
          }),
      onExit:
          (_) => setState(() {
            _isHovered = false;
          }),
      child: AnimatedBuilder(
        animation: _glitchController,
        builder: (context, child) {
          return Transform.translate(
            offset:
                _glitchController.value < 0.2 && _glitchController.value > 0.05
                    ? Offset(sin(_glitchController.value * 100) * 3, 0)
                    : Offset.zero,
            child: child,
          );
        },
        child: _buildCard(),
      ),
    ).animate().fadeIn(duration: 0.7.seconds, delay: (0.2 * widget.index).seconds).scale(begin: const Offset(0.9, 0.9));
  }

  Widget _buildCard() {
    return Consumer<FragmentPrograms?>(
      builder: (context, fragmentPrograms, _) {
        Widget content = Container(
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: _isHovered ? Colors.orange : Colors.white24, width: _isHovered ? 2 : 1),
            boxShadow:
                _isHovered ? [BoxShadow(color: Colors.orange.withOpacity(0.3), blurRadius: 15, spreadRadius: 2)] : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Stack(
              children: [
                // Background image or placeholder
                Positioned.fill(
                  child: ShaderMask(
                    blendMode: BlendMode.srcATop,
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black.withOpacity(0.7), Colors.black.withOpacity(0.9)],
                      ).createShader(bounds);
                    },
                    child: Image.asset(
                      widget.project.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.orange.withOpacity(0.1),
                          child: Center(child: Icon(Icons.code, size: 50, color: Colors.orange.withOpacity(0.3))),
                        );
                      },
                    ),
                  ),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.project.title,
                        style: const TextStyle(
                          fontFamily: 'Exo',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        widget.project.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14, height: 1.4, color: Colors.white70),
                      ),
                      const Spacer(),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children:
                            widget.project.technologies.map((tech) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                                ),
                                child: Text(
                                  tech,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white70,
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                ),

                // Hover overlay with view button
                if (_isHovered)
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          color: Colors.black.withOpacity(0.4),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle project details view
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.orange,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                elevation: 5,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [Icon(Icons.visibility), Gap(8), Text('VIEW PROJECT')],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );

        // Apply shader effect if available
        if (fragmentPrograms != null && (_glitchController.value > 0 || _isHovered)) {
          return TickingBuilder(
            builder: (context, time) {
              return AnimatedSampler((image, size, canvas) {
                const double overdrawPx = 20;
                final shader = fragmentPrograms.ui.fragmentShader();
                shader
                  ..setFloat(0, size.width)
                  ..setFloat(1, size.height)
                  ..setFloat(2, time * (_isHovered ? 2 : 1))
                  ..setImageSampler(0, image);
                Rect rect = Rect.fromLTWH(-overdrawPx, -overdrawPx, size.width + overdrawPx, size.height + overdrawPx);
                canvas.drawRect(rect, Paint()..shader = shader);
              }, child: content);
            },
          );
        }

        return content;
      },
    );
  }
}
