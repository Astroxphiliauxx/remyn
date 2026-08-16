import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_theme/app_typography.dart';
import '../../../../controller/reminders_provider.dart';
import '../../../components/auto_scrolling_icons.dart';
import '../../../components/reminder_reveal_animation.dart';
import '../reminder_card.dart';

class RemindersTab extends StatefulWidget {
  final bool isActive;

  const RemindersTab({
    super.key,
    this.isActive = true,
  });

  @override
  State<RemindersTab> createState() => _RemindersTabState();
}

class _RemindersTabState extends State<RemindersTab> {
  // ponytail: fixed row estimate; upgrade path is per-item layout callback if card height changes
  static const _estimatedRowHeight = 132.0;

  final ScrollController _scrollController = ScrollController();
  final Set<int> _revealedIndices = <int>{};

  int _animationTrigger = 0;
  bool _wasLoading = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    if (widget.isActive) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _resetAndRevealVisible();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(RemindersTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _resetAndRevealVisible();
    }
  }

  void _onScroll() {
    _updateRevealedFromScroll();
  }

  void _resetAndRevealVisible() {
    setState(() {
      _animationTrigger++;
      _revealedIndices.clear();
    });
    _updateRevealedFromScroll();
  }

  void _updateRevealedFromScroll() {
    final reminders = context.read<RemindersProvider>().reminders;
    if (reminders.isEmpty) return;

    var first = 0;
    var last = math.min(4, reminders.length - 1);

    if (_scrollController.hasClients) {
      final offset = _scrollController.offset;
      final viewport = _scrollController.position.viewportDimension;
      first = (offset / _estimatedRowHeight).floor().clamp(0, reminders.length - 1);
      last = ((offset + viewport) / _estimatedRowHeight)
          .ceil()
          .clamp(0, reminders.length - 1);
    }

    var changed = false;
    for (var i = first; i <= last; i++) {
      if (_revealedIndices.add(i)) {
        changed = true;
      }
    }

    if (changed && mounted) {
      setState(() {});
    }
  }

  Object _reminderKey(Map<String, dynamic> reminder, int index) {
    return reminder['id'] ?? index;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final remindersProvider = context.watch<RemindersProvider>();
    final reminders = remindersProvider.reminders;
    final isLoading = remindersProvider.isLoading;

    if (_wasLoading && !isLoading && reminders.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _resetAndRevealVisible();
      });
    }
    _wasLoading = isLoading;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradient = isDark
        ? const LinearGradient(
            colors: [Color.fromARGB(255, 13, 2, 33), Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : const LinearGradient(
            colors: [Color(0xFFE8E0FF), Color(0xFFF5F5F5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/createReminder'),
        backgroundColor: colorScheme.onSurface,
        foregroundColor: colorScheme.surface,
        child: const Icon(Icons.add),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        child: SafeArea(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : reminders.isEmpty
                  ? _EmptyRemindersState(colorScheme: colorScheme)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                          child: Text(
                            'Reminders',
                            style: AppTypography.editorialTitle
                                .copyWith(color: colorScheme.onSurface),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.fromLTRB(20, 8, 20, 96),
                            itemCount: reminders.length,
                            itemBuilder: (context, index) {
                              final reminder = reminders[index];
                              final key = _reminderKey(reminder, index);

                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: index < reminders.length - 1 ? 16 : 0,
                                ),
                                child: ReminderRevealAnimation(
                                  key: ValueKey('reveal-$key'),
                                  index: index,
                                  trigger: _animationTrigger,
                                  revealed: _revealedIndices.contains(index),
                                  child: RepaintBoundary(
                                    child: ReminderCard(
                                      key: ValueKey('card-$key'),
                                      reminder: reminder,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}

class _EmptyRemindersState extends StatelessWidget {
  final ColorScheme colorScheme;

  const _EmptyRemindersState({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        AutoScrollingIcons(paddingOfIcons: 20, sizeOfIcons: 53),
        const SizedBox(height: 60),
        Text(
          'No Reminders Yet',
          style: AppTypography.label.copyWith(color: colorScheme.onSurface),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/createReminder'),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: colorScheme.onSurface,
              borderRadius: BorderRadius.circular(60),
            ),
            child: Center(
              child: Text(
                '+   Create Reminder',
                style: AppTypography.body.copyWith(color: colorScheme.surface),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
