import 'package:flutter/material.dart';

abstract final class ScheduleDateFormat {
  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'April',
    'May',
    'June',
    'July',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static String ordinalSuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  static String monthDay(DateTime dateTime) {
    return '${_months[dateTime.month - 1]} ${dateTime.day}';
  }

  static bool isToday(DateTime dateTime, DateTime now) {
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  static String formatTime12h(DateTime dateTime) {
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }

  static Widget richSubtitle({
    required DateTime dateTime,
    required TextStyle style,
    required String timeLabel,
    DateTime? now,
  }) {
    final reference = now ?? DateTime.now();
    final showToday = isToday(dateTime, reference);
    final superscriptSize = (style.fontSize ?? 14) * 0.62;

    return RichText(
      text: TextSpan(
        style: style,
        children: [
          if (showToday) const TextSpan(text: 'Today, '),
          TextSpan(text: '${_months[dateTime.month - 1]} ${dateTime.day}'),
          WidgetSpan(
            alignment: PlaceholderAlignment.top,
            child: Text(
              ordinalSuffix(dateTime.day),
              style: style.copyWith(
                fontSize: superscriptSize,
                height: 1,
              ),
            ),
          ),
          TextSpan(text: ', $timeLabel'),
        ],
      ),
    );
  }
}
