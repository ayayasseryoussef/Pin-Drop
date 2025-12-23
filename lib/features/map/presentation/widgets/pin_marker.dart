// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class PinMarker extends StatefulWidget {
  final bool isDragging;
  final bool isAvailable;

  const PinMarker({
    super.key,
    required this.isDragging,
    required this.isAvailable,
  });

  @override
  State<PinMarker> createState() => _PinMarkerState();
}

class _PinMarkerState extends State<PinMarker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _dropAnim;
  late Animation<double> _shadowScale;
  late Animation<double> _shadowOpacity;

  static const double _liftHeight = -32.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _dropAnim = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: _liftHeight, end: 6.0)
            .chain(CurveTween(curve: const Cubic(0.18, 0.8, 0.25, 1))),
        weight: 45,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 6.0, end: -6.0)
            .chain(CurveTween(curve: const Cubic(0.24, 0.9, 0.32, 1))),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -6.0, end: 0.0)
            .chain(CurveTween(curve: const Cubic(0.2, 0.8, 0.3, 1))),
        weight: 35,
      ),
    ]).animate(_controller);

    _shadowScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.6, end: 1.2), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 0.9), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.0), weight: 35),
    ]).animate(_controller);

    _shadowOpacity = Tween<double>(begin: 0.35, end: 0.65).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant PinMarker oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isDragging != oldWidget.isDragging) {
      if (widget.isDragging) {
        _controller.stop();
      } else {
        _controller.forward(from: 0);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final offset = widget.isDragging ? _liftHeight : _dropAnim.value;

        return Transform.translate(
          offset: Offset(0, offset),
          child: Column(
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 160),
                scale: widget.isAvailable ? 1.0 : 0.92,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 160),
                  transitionBuilder: (c, anim) =>
                      ScaleTransition(scale: anim, child: c),
                  child: Icon(
                    Icons.location_pin,
                    key: ValueKey(widget.isAvailable),
                    size: 46,
                    color: widget.isAvailable
                        ? const Color(0xFF2ECC71)
                        : const Color(0xFFE74C3C),
                  ),
                ),
              ),
              Transform.scale(
                scale: _shadowScale.value,
                child: Opacity(
                  opacity: _shadowOpacity.value,
                  child: Container(
                    width: 26,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
