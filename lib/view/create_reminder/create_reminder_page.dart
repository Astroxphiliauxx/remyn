import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_theme/app_typography.dart';
import '../../utils/schedule_date_format.dart';
import '../../controller/color_provider.dart';
import '../../controller/icon_provider.dart';
import '../../controller/reminders_provider.dart';
import 'widgets/toggle_tile.dart';
import 'widgets/interval_options.dart';
import 'widgets/icon_tile.dart';
import 'widgets/color_picker.dart';
import 'widgets/save_reminder_button.dart';

class NewReminderPage extends StatefulWidget {
  @override
  _NewReminderPageState createState() => _NewReminderPageState();
}

class _NewReminderPageState extends State<NewReminderPage> {
  late TextEditingController _titleController;

  bool interval = false;
  bool dateTime = false;
  bool weekday = false;
  bool repeating = false;
  int? selectedInterval;
  DateTime? selectedDateTime;

  final List<int> intervalOptions = [5, 10, 20, 30];

  final List<Color> colors = [
    Colors.blue,
    Colors.purple,
    Colors.cyan,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.grey,
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final colorProvider = Provider.of<ColorProvider>(context);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "New Reminder",
          style: AppTypography.title.copyWith(color: colorScheme.onSurface),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 75,
                        child: TextField(
                          controller: _titleController,
                          style: AppTypography.body
                              .copyWith(color: colorScheme.onSurface),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: colorProvider.selectedColor,
                            hintText: "Reminder",
                            hintStyle: AppTypography.body
                                .copyWith(color: colorScheme.onSurface),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ToggleTile(
                        title: "Interval",
                        value: interval,
                        onChanged: (value) {
                          setState(() {
                            interval = false;
                            dateTime = false;
                            weekday = false;
                            if (value) interval = true;
                            if (!value) selectedInterval = null;
                          });
                        },
                      ),
                      if (interval)
                        IntervalOptions(
                          intervalOptions: intervalOptions,
                          selectedInterval: selectedInterval,
                          onSelected: (value) =>
                              setState(() => selectedInterval = value),
                        ),
                      SizedBox(height: 8),
                      ToggleTile(
                        title: "Date & time",
                        value: dateTime,
                        onChanged: (value) async {
                          if (value) {
                            final picked = await _pickDateTime();
                            if (!mounted) return;
                            setState(() {
                              interval = false;
                              weekday = false;
                              repeating = false;
                              dateTime = picked != null;
                              selectedDateTime = picked;
                            });
                          } else {
                            setState(() {
                              dateTime = false;
                              selectedDateTime = null;
                            });
                          }
                        },
                      ),
                      if (dateTime && selectedDateTime != null) ...[
                        SizedBox(height: 8),
                        _DateTimeSummary(
                          dateTime: selectedDateTime!,
                          onTap: () async {
                            final picked = await _pickDateTime(
                              initial: selectedDateTime,
                            );
                            if (!mounted || picked == null) return;
                            setState(() => selectedDateTime = picked);
                          },
                        ),
                      ],
                      SizedBox(height: 8),
                      ToggleTile(
                        title: "Weekday",
                        value: weekday,
                        onChanged: (value) {
                          setState(() {
                            interval = false;
                            dateTime = false;
                            weekday = false;
                            if (value) weekday = true;
                          });
                        },
                      ),
                      if (!dateTime) ...[
                        SizedBox(height: 8),
                        ToggleTile(
                          title: "Repeating",
                          value: repeating,
                          onChanged: (value) =>
                              setState(() => repeating = value),
                        ),
                      ],
                      SizedBox(height: 8),
                      IconTile(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text("Color",
                            style: AppTypography.body.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                      SizedBox(height: 5),
                      ColorPicker(colors: colors),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              SaveReminderButton(
                onPressed: () =>
                    _saveReminder(_titleController.text.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _pickDateTime({DateTime? initial}) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initial ?? now.add(const Duration(hours: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 5)),
    );
    if (date == null || !mounted) return null;

    final time = await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay.fromDateTime(initial ?? now.add(const Duration(hours: 1))),
    );
    if (time == null || !mounted) return null;

    final scheduled = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    if (!scheduled.isAfter(now)) {
      _showMessage('Pick a future date and time');
      return null;
    }
    return scheduled;
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _saveReminder(String title) async {
    final trimmedTitle = title.trim();
    if (trimmedTitle.isEmpty) {
      _showMessage('Enter a reminder title');
      return;
    }
    if (dateTime && selectedDateTime == null) {
      _showMessage('Select a date and time');
      return;
    }
    if (dateTime && !selectedDateTime!.isAfter(DateTime.now())) {
      _showMessage('Pick a future date and time');
      return;
    }

    final colorProvider = Provider.of<ColorProvider>(context, listen: false);
    final iconProvider = Provider.of<IconProvider>(context, listen: false);
    final remindersProvider =
        Provider.of<RemindersProvider>(context, listen: false);

    final saved = await remindersProvider.createReminder({
      'title': trimmedTitle,
      'interval': interval ? 1 : 0,
      'dateTime': dateTime ? 1 : 0,
      'weekday': weekday ? 1 : 0,
      'repeating': repeating ? 1 : 0,
      'color': colorProvider.selectedColor.toARGB32(),
      'icon_code': iconProvider.selectedIcon.codePoint,
      'created_at_ms': DateTime.now().millisecondsSinceEpoch,
      if (dateTime && selectedDateTime != null)
        'scheduled_at_ms': selectedDateTime!.millisecondsSinceEpoch,
    });

    if (!saved) {
      if (!mounted) return;
      _showMessage(
        remindersProvider.errorMessage ?? 'Could not save reminder',
      );
      return;
    }

    if (!mounted) return;
    Navigator.pop(context, true);
  }
}

class _DateTimeSummary extends StatelessWidget {
  final DateTime dateTime;
  final VoidCallback onTap;

  const _DateTimeSummary({
    required this.dateTime,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.secondary,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(Icons.schedule, color: colorScheme.onSurface),
              const SizedBox(width: 12),
              Expanded(
                child: ScheduleDateFormat.richSubtitle(
                  dateTime: dateTime,
                  style: AppTypography.body.copyWith(
                    color: colorScheme.onSurface,
                  ),
                  timeLabel: ScheduleDateFormat.formatTime12h(dateTime),
                  now: DateTime.now(),
                ),
              ),
              Icon(Icons.edit,
                  color: colorScheme.onSurface.withValues(alpha: 0.7)),
            ],
          ),
        ),
      ),
    );
  }
}
