import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

const _stepsDailyGoalKey = '_stepsDailyGoalKey';
const _reminderKey = '_reminderKey';

class AppPrefs {
  SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setStepsGoal(int stepsDailyGoal) async {
    await _prefs.setInt(_stepsDailyGoalKey, stepsDailyGoal);
  }

  int getStepsGoal() => _prefs.get(_stepsDailyGoalKey);

  Future<void> setReminderEnabled(bool enabled) async {
    await _prefs.setBool(_reminderKey, enabled);
  }

  bool isReminderEnabled() => _prefs.get(_reminderKey) ?? true;
}
