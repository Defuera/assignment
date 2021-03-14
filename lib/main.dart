import 'dart:async';

import 'package:fastic_demo/di.dart';
import 'package:fastic_demo/feature/home_screen.dart';
import 'package:fastic_demo/theme/fastic_colors.dart';
import 'package:flutter/material.dart';

// As a User I want to synchronization my steps with my prefered health source
// As a User I want to set my daily goal
// As a User I want to see how much steps I achieved today
// As a User I want to see how much calories I have burned with my steps
// As a User I want to get a reminder at 8pm if I haven’t achieved my goal

void main() {
  // runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();

  runZoned(
    () async {
      await DiModule.setup();
      runApp(MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: FasticColors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // buttonTheme: ButtonThemeData(splashColor: FasticColors.orange),
        // accentColor: FasticColors.orange,
        // splashColor: FasticColors.orange,
        appBarTheme: AppBarTheme(color: Colors.transparent, elevation: 0)
      ),
      home: HomeScreen(),
    );
  }
}
