import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_theme/app_typography.dart';
import '../../controller/color_provider.dart';
import '../../controller/icon_provider.dart';
import '../../model/database_helper.dart';
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
                          style:
                              AppTypography.body.copyWith(color: colorScheme.onSurface),
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
                        onChanged: (value) {
                          setState(() {
                            interval = false;
                            dateTime = false;
                            weekday = false;
                            if (value) dateTime = true;
                          });
                        },
                      ),
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
                      SizedBox(height: 8),
                      ToggleTile(
                        title: "Repeating",
                        value: repeating,
                        onChanged: (value) => setState(() => repeating = value),
                      ),
                      SizedBox(height: 8),
                      IconTile(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(
                            "Color",
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

  void _saveReminder(String title) async {
    final colorProvider = Provider.of<ColorProvider>(context, listen: false);
    final iconProvider = Provider.of<IconProvider>(context, listen: false);

    final dbHelper = DatabaseHelper();
    await dbHelper.insertReminder({
      'title': title,
      'interval': interval ? 1 : 0,
      'dateTime': dateTime ? 1 : 0,
      'weekday': weekday ? 1 : 0,
      'repeating': repeating ? 1 : 0,
      'color': colorProvider.selectedColor.toARGB32(),
      'icon_code': iconProvider.selectedIcon.codePoint,
    });

    Navigator.pop(context, true);
  }
}
