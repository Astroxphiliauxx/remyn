import 'package:flutter/material.dart';

class ColorProvider with ChangeNotifier {
  Color _selectedColor = Colors.red;

  Color get selectedColor => _selectedColor;

  void changeColor(Color color) {
    _selectedColor = color;
    notifyListeners();
  }
}
