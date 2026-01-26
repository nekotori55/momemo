import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const seedColor = Colors.red;
  static final lightColorScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.light,
  );
  static final darkColorScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: .dark,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: lightColorScheme),
      darkTheme: ThemeData(colorScheme: darkColorScheme),
      themeMode: .dark,
      home: HomePage(title: "momemo"),
    );
  }
}
