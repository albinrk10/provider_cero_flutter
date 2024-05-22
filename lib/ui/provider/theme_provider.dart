import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool isLight = true;

  void changeTheme() {
    isLight = !isLight;
    notifyListeners();
  }
}
