import 'dart:async';

import 'package:fastic_demo/di.dart';
import 'package:fastic_demo/feature/stepcounter/home_screen.dart';
import 'package:fastic_demo/model/alarm_manager.dart';
import 'package:fastic_demo/theme/fastic_colors.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runZoned(
    () async {
      await DiModule.setup();
      await AlarmManager.init();
      initializeTimeZones();
      setLocalLocation(getLocation('Europe/Amsterdam'));

      runApp(MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: FasticColors.orange,
          accentColor: FasticColors.orange,
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
