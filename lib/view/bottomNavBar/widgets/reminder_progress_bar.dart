import 'dart:async';

import 'package:flutter/material.dart';

import 'reminder_countdown.dart';

typedef CurrentTime = DateTime Function();

DateTime _systemNow() => DateTime.now();

/// Remaining progress from 1.0 at creation to 0.0 at the scheduled time.
/// Returns null when the original duration cannot be calculated.
double? reminderProgress({
  required DateTime? createdAt,
  required DateTime? scheduledAt,
  required DateTime now,
}) {
  if (createdAt == null || scheduledAt == null) return null;

  final totalMs = scheduledAt.difference(createdAt).inMilliseconds;
  if (totalMs <= 0) return null;

  final remainingMs = scheduledAt.difference(now).inMilliseconds;
  return (remainingMs / totalMs).clamp(0.0, 1.0);
}

class ReminderProgressBar extends StatefulWidget {
  final DateTime? createdAt;
  final DateTime? scheduledAt;
  final Color accentColor;
  final CurrentTime now;

  const ReminderProgressBar({
    super.key,
    required this.createdAt,
    required this.scheduledAt,
    required this.accentColor,
    this.now = _systemNow,
  });

  @override
  State<ReminderProgressBar> createState() => _ReminderProgressBarState();
}

class _ReminderProgressBarState extends State<ReminderProgressBar>
    with WidgetsBindingObserver {
  static const _tickInterval = Duration(seconds: 1);

  Timer? _timer;
  double _progress = 1;
  bool _hasTimingData = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _synchronize();
    _startTimer();
  }

  @override
  void didUpdateWidget(ReminderProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.createdAt != widget.createdAt ||
        oldWidget.scheduledAt != widget.scheduledAt ||
        oldWidget.now != widget.now) {
      _timer?.cancel();
      _synchronize();
      _startTimer();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _synchronize();
      _startTimer();
    } else {
      _timer?.cancel();
      _timer = null;
    }
  }

  void _startTimer() {
    if (!_hasTimingData || _progress <= 0 || _timer?.isActive == true) return;
    _timer = Timer.periodic(_tickInterval, (_) => _synchronize());
  }

  void _synchronize() {
    final progress = reminderProgress(
      createdAt: widget.createdAt,
      scheduledAt: widget.scheduledAt,
      now: widget.now(),
    );

    if (!mounted) return;
    setState(() {
      _hasTimingData = progress != null;
      _progress = progress ?? 1;
    });

    if (_progress <= 0) {
      _timer?.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheduledAt = widget.scheduledAt;
    if (scheduledAt != null && isCountdownDue(scheduledAt, widget.now())) {
      return const SizedBox.shrink();
    }

    final percent = (_progress * 100).round();

    return Semantics(
      label: _hasTimingData ? 'Time remaining' : 'Reminder accent',
      value: _hasTimingData ? '$percent percent' : null,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
        child: SizedBox(
          height: 4,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ColoredBox(
                color: widget.accentColor.withValues(alpha: 0.4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedContainer(
                    key: const Key('reminder-progress-fill'),
                    duration: _hasTimingData ? _tickInterval : Duration.zero,
                    curve: Curves.linear,
                    width: constraints.maxWidth * _progress,
                    color: widget.accentColor,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
