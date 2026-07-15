import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app_theme/app_typography.dart';

/// Remaining time until [targetAt] from [now], clamped at zero.
Duration countdownRemaining(DateTime targetAt, DateTime now) {
  final remaining = targetAt.difference(now);
  return remaining.isNegative ? Duration.zero : remaining;
}

bool isCountdownDue(DateTime targetAt, DateTime now) =>
    countdownRemaining(targetAt, now).inSeconds <= 0;

/// Formats a non-negative [remaining] duration for countdown display.
String formatCountdown(Duration remaining) {
  final totalSeconds = remaining.inSeconds;
  final days = totalSeconds ~/ 86400;
  final hours = (totalSeconds % 86400) ~/ 3600;
  final minutes = (totalSeconds % 3600) ~/ 60;
  final seconds = totalSeconds % 60;

  if (days > 0) {
    return '$days'
        'D ${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }
  if (hours > 0) {
    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }
  return '${minutes.toString().padLeft(2, '0')}:'
      '${seconds.toString().padLeft(2, '0')}';
}

String countdownSemanticsLabel(Duration remaining) {
  if (remaining.inSeconds <= 0) return 'Due now';
  final days = remaining.inDays;
  final hours = remaining.inHours % 24;
  final minutes = remaining.inMinutes % 60;
  if (days > 0) {
    return 'Due in $days days $hours hours $minutes minutes';
  }
  if (hours > 0) {
    return 'Due in $hours hours $minutes minutes';
  }
  if (minutes > 0) {
    return 'Due in $minutes minutes';
  }
  return 'Due in ${remaining.inSeconds} seconds';
}

class ReminderCountdownBadge extends StatefulWidget {
  final DateTime targetAt;
  final Color accentColor;

  const ReminderCountdownBadge({
    super.key,
    required this.targetAt,
    required this.accentColor,
  });

  @override
  State<ReminderCountdownBadge> createState() => _ReminderCountdownBadgeState();
}

class _ReminderCountdownBadgeState extends State<ReminderCountdownBadge> {
  Timer? _timer;
  late Duration _remaining;
  String _semanticsLabel = '';

  @override
  void initState() {
    super.initState();
    _tick();
    if (_remaining.inSeconds > 0) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    }
  }

  @override
  void didUpdateWidget(ReminderCountdownBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.targetAt != widget.targetAt) {
      _timer?.cancel();
      _tick();
      if (_remaining.inSeconds > 0) {
        _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
      }
    }
  }

  void _tick() {
    final nextRemaining = countdownRemaining(widget.targetAt, DateTime.now());
    final nextSemantics = countdownSemanticsLabel(nextRemaining);

    if (!mounted) return;
    setState(() {
      _remaining = nextRemaining;
      if (nextSemantics != _semanticsLabel) {
        _semanticsLabel = nextSemantics;
      }
    });

    if (nextRemaining.inSeconds <= 0) {
      _timer?.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDue = _remaining.inSeconds <= 0;
    final label = isDue ? 'Due' : formatCountdown(_remaining);

    return Semantics(
      label: _semanticsLabel.isEmpty
          ? countdownSemanticsLabel(_remaining)
          : _semanticsLabel,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: widget.accentColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: widget.accentColor, width: 1),
        ),
        child: Text(
          label,
          style: AppTypography.label.copyWith(
            color: widget.accentColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
