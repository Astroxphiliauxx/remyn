import 'package:flutter/material.dart';

class IconProvider extends ChangeNotifier {
  IconData _selectedIcon = Icons.notifications;

  IconData get selectedIcon => _selectedIcon;

  void changeIcon(IconData newIcon) {
    _selectedIcon = newIcon;
    notifyListeners();
  }
}
