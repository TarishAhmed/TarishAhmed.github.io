// Custom cursor follower effect for portfolio
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CursorFollower extends StatefulWidget {
  const CursorFollower({
    Key? key,
    required this.child,
    this.color = Colors.blue,
    this.size = 30.0,
    this.trailCount = 5,
    this.trailOpacity = 0.3,
    this.trailDecay = 0.8,
    this.smoothing = 0.5,
  }) : super(key: key);

  final Widget child;
  final Color color;
  final double size;
  final int trailCount;
  final double trailOpacity;
  final double trailDecay;
  final double smoothing; // 0 = instant follow, 1 = maximum lag

  @override
  State<CursorFollower> createState() => _CursorFollowerState();
}

class _CursorFollowerState extends State<CursorFollower> with SingleTickerProviderStateMixin {
  Offset _mousePosition = Offset.zero;
  Offset _currentPosition = Offset.zero;
  final List<Offset> _trail = [];

  // For animations
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: 1.5.seconds, lowerBound: 0.8, upperBound: 1.2);
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _updatePosition(PointerHoverEvent event) {
    setState(() {
      _mousePosition = event.position;

      // Calculate smoothed position
      final dx = _mousePosition.dx - _currentPosition.dx;
      final dy = _mousePosition.dy - _currentPosition.dy;

      _currentPosition = Offset(
        _currentPosition.dx + dx * (1 - widget.smoothing),
        _currentPosition.dy + dy * (1 - widget.smoothing),
      );

      // Update trail
      if (_trail.length >= widget.trailCount) {
        _trail.removeLast();
      }
      _trail.insert(0, _currentPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _updatePosition,
      child: Stack(
        children: [
          // Main content
          widget.child,

          // Trail effects
          ..._buildTrail(),

          // Main cursor effect
          Positioned(
            left: _currentPosition.dx - (widget.size / 2),
            top: _currentPosition.dy - (widget.size / 2),
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Container(
                    width: widget.size * _pulseController.value,
                    height: widget.size * _pulseController.value,
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.3),
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: widget.color.withOpacity(0.5), blurRadius: 12, spreadRadius: 2)],
                    ),
                    child: Center(
                      child: Container(
                        width: widget.size * 0.4 * _pulseController.value,
                        height: widget.size * 0.4 * _pulseController.value,
                        decoration: BoxDecoration(color: widget.color.withOpacity(0.8), shape: BoxShape.circle),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTrail() {
    List<Widget> trailWidgets = [];

    for (int i = 0; i < _trail.length; i++) {
      final opacity = widget.trailOpacity * pow(widget.trailDecay, i);
      final size = widget.size * pow(0.9, i);

      trailWidgets.add(
        Positioned(
          left: _trail[i].dx - (size / 2),
          top: _trail[i].dy - (size / 2),
          child: IgnorePointer(
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(color: widget.color.withOpacity(opacity), shape: BoxShape.circle),
            ),
          ),
        ),
      );
    }

    return trailWidgets;
  }
}

// Convenience extension to decorate a page with cursor follower
extension CursorFollowerExtension on Widget {
  Widget withCustomCursor({
    Color color = Colors.blue,
    double size = 30.0,
    int trailCount = 5,
    double trailOpacity = 0.3,
    double trailDecay = 0.8,
    double smoothing = 0.5,
  }) {
    return CursorFollower(
      color: color,
      size: size,
      trailCount: trailCount,
      trailOpacity: trailOpacity,
      trailDecay: trailDecay,
      smoothing: smoothing,
      child: this,
    );
  }
}
