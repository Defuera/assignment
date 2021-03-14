import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

const _stepsDailyGoalKet = '_stepsDailyGoalKet';

class AppPrefs {
  SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setStepsGoal(int stepsDailyGoal) async {
    await _prefs.setInt(_stepsDailyGoalKet, stepsDailyGoal);
  }

  int getStepsGoal() => _prefs.get(_stepsDailyGoalKet);

  Future<bool> clear() => _prefs.clear();
}
