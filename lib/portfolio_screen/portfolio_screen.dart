// Main portfolio screen with navigation between sections
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../assets.dart';
import '../models/resume_data.dart';
import '../orb_shader/orb_shader_config.dart';
import '../orb_shader/orb_shader_widget.dart';
import '../styles.dart';
import '../title_screen/particle_overlay.dart';
import '../common/cursor_follower.dart';
import 'portfolio_sections/about_section.dart';
import 'portfolio_sections/contact_section.dart';
import 'portfolio_sections/projects_section.dart';
import 'portfolio_sections/skills_section.dart';
import 'portfolio_sections/intro_section.dart';
import 'portfolio_navigation.dart';

enum PortfolioSection { intro, about, skills, projects, contact }

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> with SingleTickerProviderStateMixin {
  final _orbKey = GlobalKey<OrbShaderWidgetState>();
  final _resumeData = ResumeData.sampleData();

  /// Orb animation settings
  final _minReceiveLightAmt = .35;
  final _maxReceiveLightAmt = .7;
  final _minEmitLightAmt = .5;
  final _maxEmitLightAmt = 1;

  /// Currently active section
  PortfolioSection _currentSection = PortfolioSection.intro;

  /// Mouse position for orb effect
  var _mousePos = Offset.zero;

  /// Animation values
  double _orbEnergy = 0;
  double _minOrbEnergy = 0;

  /// Color settings based on section
  Color get _orbColor => _getSectionColor(_currentSection);
  Color get _emitColor => _getSectionColor(_currentSection).withOpacity(0.8);

  Color _getSectionColor(PortfolioSection section) {
    switch (section) {
      case PortfolioSection.intro:
        return Colors.blue;
      case PortfolioSection.about:
        return Colors.purple;
      case PortfolioSection.skills:
        return Colors.green;
      case PortfolioSection.projects:
        return Colors.orange;
      case PortfolioSection.contact:
        return Colors.red;
    }
  }

  double get _finalReceiveLightAmt {
    final light = lerpDouble(_minReceiveLightAmt, _maxReceiveLightAmt, _orbEnergy) ?? 0;
    return light + _pulseEffect.value * .05 * _orbEnergy;
  }

  double get _finalEmitLightAmt {
    return lerpDouble(_minEmitLightAmt, _maxEmitLightAmt, _orbEnergy) ?? 0;
  }

  late final _pulseEffect = AnimationController(
    vsync: this,
    duration: _getRndPulseDuration(),
    lowerBound: -1,
    upperBound: 1,
  );

  Duration _getRndPulseDuration() => 100.ms + 200.ms * Random().nextDouble();

  @override
  void initState() {
    super.initState();
    _pulseEffect.forward();
    _pulseEffect.addListener(_handlePulseEffectUpdate);
  }

  @override
  void dispose() {
    _pulseEffect.dispose();
    super.dispose();
  }

  void _handlePulseEffectUpdate() {
    if (_pulseEffect.status == AnimationStatus.completed) {
      _pulseEffect.reverse();
      _pulseEffect.duration = _getRndPulseDuration();
    } else if (_pulseEffect.status == AnimationStatus.dismissed) {
      _pulseEffect.duration = _getRndPulseDuration();
      _pulseEffect.forward();
    }
  }

  void _handleMouseMove(PointerHoverEvent e) {
    setState(() {
      _mousePos = e.localPosition;
    });
  }

  void _handleSectionChange(PortfolioSection section) {
    setState(() {
      _currentSection = section;
      _bumpOrbEnergy();
    });
  }

  Future<void> _bumpOrbEnergy([double amount = 0.2]) async {
    setState(() {
      _minOrbEnergy = 0.5 + amount;
    });
    await Future<void>.delayed(.3.seconds);
    setState(() {
      _minOrbEnergy = 0.3;
    });
  }

  Widget _buildCurrentSection() {
    switch (_currentSection) {
      case PortfolioSection.intro:
        return IntroSection(
          name: _resumeData.name,
          title: _resumeData.title,
          tagline: _resumeData.tagline,
          onExplorePressed: () => _handleSectionChange(PortfolioSection.about),
        );
      case PortfolioSection.about:
        return AboutSection(resumeData: _resumeData);
      case PortfolioSection.skills:
        return SkillsSection(skills: _resumeData.skills, orbColor: _orbColor);
      case PortfolioSection.projects:
        return ProjectsSection(projects: _resumeData.projects);
      case PortfolioSection.contact:
        return ContactSection(
          email: _resumeData.email,
          phone: _resumeData.phone,
          linkedIn: _resumeData.linkedIn,
          github: _resumeData.github,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MouseRegion(
        onHover: _handleMouseMove,
        child: _AnimatedColors(
          orbColor: _orbColor,
          emitColor: _emitColor,
          builder: (_, orbColor, emitColor) {
            return Stack(
              fit: StackFit.expand, // Make the Stack fill all available space
              children: [
                /// Background base
                Image.asset(AssetPaths.titleBgBase, fit: BoxFit.cover),

                /// Background with light effect
                _LitImage(
                  color: orbColor,
                  imgSrc: AssetPaths.titleBgReceive,
                  pulseEffect: _pulseEffect,
                  lightAmt: _finalReceiveLightAmt,
                ),

                /// Orb effect
                Positioned.fill(
                  child: OrbShaderWidget(
                    key: _orbKey,
                    mousePos: _mousePos,
                    minEnergy: _minOrbEnergy,
                    config: OrbShaderConfig(ambientLightColor: orbColor, materialColor: orbColor, lightColor: orbColor),
                    onUpdate:
                        (energy) => setState(() {
                          _orbEnergy = energy;
                        }),
                  ),
                ),

                /// Mid-ground with light effects
                _LitImage(
                  imgSrc: AssetPaths.titleMgBase,
                  color: orbColor,
                  pulseEffect: _pulseEffect,
                  lightAmt: _finalReceiveLightAmt,
                ),

                _LitImage(
                  imgSrc: AssetPaths.titleMgReceive,
                  color: orbColor,
                  pulseEffect: _pulseEffect,
                  lightAmt: _finalReceiveLightAmt,
                ),

                _LitImage(
                  imgSrc: AssetPaths.titleMgEmit,
                  color: emitColor,
                  pulseEffect: _pulseEffect,
                  lightAmt: _finalEmitLightAmt,
                ),

                /// Particle effect overlay
                Positioned.fill(child: IgnorePointer(child: ParticleOverlay(color: orbColor, energy: _orbEnergy))),

                /// Foreground rocks
                Image.asset(AssetPaths.titleFgBase, fit: BoxFit.cover),

                /// Foreground with light effects
                _LitImage(
                  imgSrc: AssetPaths.titleFgReceive,
                  color: orbColor,
                  pulseEffect: _pulseEffect,
                  lightAmt: _finalReceiveLightAmt,
                ),

                _LitImage(
                  imgSrc: AssetPaths.titleFgEmit,
                  color: emitColor,
                  pulseEffect: _pulseEffect,
                  lightAmt: _finalEmitLightAmt,
                ),

                /// Content area
                Positioned.fill(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          /// Navigation bar
                          PortfolioNavigation(
                            currentSection: _currentSection,
                            onSectionSelected: _handleSectionChange,
                            orbColor: orbColor,
                          ),

                          /// Main content area
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                child: _buildCurrentSection(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 1.seconds, delay: .3.seconds);
          },
        ),
      ),
    );
  }
}

class _LitImage extends StatelessWidget {
  const _LitImage({required this.color, required this.imgSrc, required this.pulseEffect, required this.lightAmt});
  final Color color;
  final String imgSrc;
  final AnimationController pulseEffect;
  final double lightAmt;

  @override
  Widget build(BuildContext context) {
    final hsl = HSLColor.fromColor(color);
    return ListenableBuilder(
      listenable: pulseEffect,
      builder: (context, child) {
        return Image.asset(
          imgSrc,
          fit: BoxFit.cover,
          color: hsl.withLightness(hsl.lightness * lightAmt).toColor(),
          colorBlendMode: BlendMode.modulate,
        );
      },
    );
  }
}

class _AnimatedColors extends StatelessWidget {
  const _AnimatedColors({required this.emitColor, required this.orbColor, required this.builder});

  final Color emitColor;
  final Color orbColor;

  final Widget Function(BuildContext context, Color orbColor, Color emitColor) builder;

  @override
  Widget build(BuildContext context) {
    final duration = .5.seconds;
    return TweenAnimationBuilder(
      tween: ColorTween(begin: emitColor, end: emitColor),
      duration: duration,
      builder: (_, emitColor, __) {
        return TweenAnimationBuilder(
          tween: ColorTween(begin: orbColor, end: orbColor),
          duration: duration,
          builder: (context, orbColor, __) {
            return builder(context, orbColor!, emitColor!);
          },
        );
      },
    );
  }
}
