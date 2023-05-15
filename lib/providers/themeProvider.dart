import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  bool isDarkMode = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}