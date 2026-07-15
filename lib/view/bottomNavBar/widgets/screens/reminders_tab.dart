import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_theme/app_typography.dart';
import '../../../../controller/reminders_provider.dart';
import '../../../components/auto_scrolling_icons.dart';
import '../reminder_card.dart';

class RemindersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final remindersProvider = context.watch<RemindersProvider>();
    final reminders = remindersProvider.reminders;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/createReminder'),
        backgroundColor: colorScheme.onSurface,
        foregroundColor: colorScheme.surface,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: remindersProvider.isLoading
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
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 96),
                          itemCount: reminders.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            return ReminderCard(reminder: reminders[index]);
                          },
                        ),
                      ),
                    ],
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
