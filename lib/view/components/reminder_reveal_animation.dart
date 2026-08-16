import 'dart:async';

import 'package:flutter/material.dart';

class ReminderRevealAnimation extends StatefulWidget {
  final int index;
  final int trigger;
  final bool revealed;
  final Widget child;

  const ReminderRevealAnimation({
    super.key,
    required this.index,
    required this.trigger,
    required this.revealed,
    required this.child,
  });

  @override
  State<ReminderRevealAnimation> createState() =>
      _ReminderRevealAnimationState();
}

class _ReminderRevealAnimationState extends State<ReminderRevealAnimation>
    with SingleTickerProviderStateMixin {
  static const _duration = Duration(milliseconds: 580);
  static const _maxStagger = Duration(milliseconds: 560);
  static const _staggerStep = Duration(milliseconds: 160);

  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  int _lastTrigger = 0;
  bool _wasRevealed = false;
  Timer? _delayTimer;

  Duration get _delay {
    final stagger = Duration(milliseconds: widget.index * _staggerStep.inMilliseconds);
    return stagger > _maxStagger ? _maxStagger : stagger;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
    _fade = curve;
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(curve);
    _lastTrigger = widget.trigger;
    _wasRevealed = widget.revealed;
    if (widget.revealed) {
      _playAnimation();
    }
  }

  @override
  void didUpdateWidget(ReminderRevealAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.trigger != _lastTrigger) {
      _lastTrigger = widget.trigger;
      _cancelDelay();
      _controller.reset();
      if (widget.revealed) {
        _playAnimation();
      }
    } else if (widget.revealed && !_wasRevealed) {
      _playAnimation();
    }

    _wasRevealed = widget.revealed;
  }

  void _playAnimation() {
    _cancelDelay();
    _delayTimer = Timer(_delay, () {
      if (!mounted) return;
      unawaited(_controller.forward(from: 0));
    });
  }

  void _cancelDelay() {
    _delayTimer?.cancel();
    _delayTimer = null;
  }

  @override
  void dispose() {
    _cancelDelay();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.revealed) {
      return Opacity(
        opacity: 0,
        child: IgnorePointer(child: widget.child),
      );
    }

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}
