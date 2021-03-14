import 'dart:async';

import 'package:fastic_demo/di.dart';
import 'package:fastic_demo/feature/home_screen.dart';
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
  final Color orange = Color.fromRGBO(247, 165, 108, 1);
  final Color fadeGray = Color.fromRGBO(237, 241, 243, 1);
  final Color gray = Color.fromRGBO(166, 172, 180, 1);
  final Color softBlue = Color.fromRGBO(89, 98, 116, 1);
  final Color darkBlue = Color.fromRGBO(31, 52, 85, 1);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: gray,
      ),
      home: HomeScreen(),
    );
  }
}
