import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remyn/view/components/icon_picker.dart';
import '../controller/color_provider.dart';
import '../controller/icon_provider.dart';
import '../model/database_helper.dart';

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
          style: TextStyle(color: colorScheme.onSurface, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        height: 75,
                        child: TextField(
                          controller: _titleController,
                          style: TextStyle(color: colorScheme.onSurface),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: colorScheme.secondary,
                            hintText: "Reminder",
                            hintStyle: TextStyle(color: Colors.white54, fontSize: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                          ),
                        ),
                      ),
                    ),

                    _buildToggleTile("Interval", interval, (value) {
                      setState(() {
                        interval = value;
                        if (!value) {
                          selectedInterval = null; // Reset selection when toggled off
                        }
                      });
                    }),
                    if (interval) _buildIntervalOptions(), 
                    _buildToggleTile("Date & time", dateTime, (value) => setState(() => dateTime = value)),
                    _buildToggleTile("Weekday", weekday, (value) => setState(() => weekday = value)),
                    _buildToggleTile("Repeating", repeating, (value) => setState(() => repeating = value)),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                      child: _buildIconTile(context),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text("Color", style: TextStyle(color: colorScheme.onSurface, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),

                    SizedBox(height: 5),
                    _buildColorPicker(),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),


            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              color: colorScheme.surface,
              child: CupertinoButton(
                color: colorProvider.selectedColor,
                borderRadius: BorderRadius.circular(30),
                onPressed: () => _saveReminder(_titleController.text.toString()),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.add, color: colorScheme.onPrimary),
                    SizedBox(width: 8),
                    Text("Create reminder", style: TextStyle(color: colorScheme.onPrimary, fontSize: 18)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),


    );
  }

  Widget _buildToggleTile(String title, bool value, Function(bool) onChanged) {
    final colorScheme = Theme.of(context).colorScheme;
    final colorProvider= Provider.of<ColorProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 20,
                  ),
                ),
              ),
            ),

            Switch(
              activeColor: colorProvider.selectedColor,
              value: value,
              onChanged: (newValue) {
                setState(() {
                  if (title == "Repeating") {
                    repeating = newValue;
                  } else {

                    interval = false;
                    dateTime = false;
                    weekday = false;

                    if (newValue) {
                      if (title == "Interval") interval = true;
                      if (title == "Date & time") dateTime = true;
                      if (title == "Weekday") weekday = true;
                    }
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIntervalOptions() {
    final colorScheme = Theme.of(context).colorScheme;
    final colorProvider = Provider.of<ColorProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Container(
        width:  MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            SizedBox(height: 8),
            Text(
              "Select Interval",
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: intervalOptions.map((minutes) {
                return ChoiceChip(
                  label: Text('$minutes mins'),
                  selected: selectedInterval == minutes,
                  onSelected: (selected) {
                    setState(() {
                      selectedInterval = selected ? minutes : null;
                    });
                  },
                  selectedColor: colorProvider.selectedColor,
                  labelStyle: TextStyle(
                    color: selectedInterval == minutes 
                      ? colorScheme.onPrimary 
                      : colorScheme.onSurface,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildIconTile(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final iconProvider = Provider.of<IconProvider>(context);
    final colorProvider = Provider.of<ColorProvider>(context);

    return GestureDetector(
      onTap: () => IconPicker.showIconPicker(context),
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 23.0),
                child: Text(
                  "Icon",
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Icon(iconProvider.selectedIcon, color: colorProvider.selectedColor),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildColorPicker() {
    final colorScheme = Theme.of(context).colorScheme;
    final colorProvider = Provider.of<ColorProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(colors.length, (index) {
          return GestureDetector(
            onTap: () => colorProvider.changeColor(colors[index]),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: colors[index],
                shape: BoxShape.circle,
                border: colorProvider.selectedColor == colors[index]
                    ? Border.all(color: colorScheme.onSurface, width: 3)
                    : null,
              ),
            ),
          );
        }),
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
      'color': colorProvider.selectedColor.value, 
      'icon_code': iconProvider.selectedIcon.codePoint,
    });


    Navigator.pop(context, true); 
  }

}
