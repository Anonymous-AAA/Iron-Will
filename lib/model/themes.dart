import 'package:flutter/material.dart';
import 'package:iron_will/controller/appdata.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode thememode = AppData.getSettings().dark?ThemeMode.dark:ThemeMode.light;
  
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: const ColorScheme.dark(),
    appBarTheme: const AppBarTheme(color: Colors.black87),
  );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(secondary: Colors.blueGrey),
    appBarTheme: const AppBarTheme(color: Colors.blueGrey),
  );
}
