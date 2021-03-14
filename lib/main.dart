import 'dart:async';

import 'package:fastic_demo/di.dart';
import 'package:fastic_demo/feature/home_screen.dart';
import 'package:fastic_demo/theme/fastic_colors.dart';
import 'package:flutter/material.dart';

void main() {
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
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: FasticColors.darkBlue),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
