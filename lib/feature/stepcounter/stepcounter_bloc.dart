import 'package:fastic_demo/feature/stepcounter/stepcounter_model.dart';
import 'package:fastic_demo/model/alarm_manager.dart';
import 'package:fastic_demo/model/app_prefs.dart';
import 'package:fastic_demo/model/health_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:timezone/timezone.dart';

class StepcounterBloc extends Bloc<StepcounterEvent, StepcounterState> {
  final AppPrefs _prefs = GetIt.instance.get();
  final HealthKit _healthKit = GetIt.instance.get();
  final AlarmManager _alarmManager = GetIt.instance.get();

  StepcounterBloc() : super(StepcounterState.loading()) {
    add(Init());
  }

  @override
  Stream<StepcounterState> mapEventToState(StepcounterEvent event) async* {
    if (event is Init) {
      yield* _processInit(event);
    } else if (event is OnDailyGoalSet) {
      yield* _processOnDailyGoalSet(event);
    } else if (event is OnSwitchReminderPressed) {
      yield* _processOnSwitchReminderPressed(event);
    }
  }

  int _calculatePercentage(int stepsWalked, int goal) => goal == null ? null : (stepsWalked / goal * 100).toInt();

  Stream<StepcounterState> _processInit(Init event) async* {
    final goal = _prefs.getStepsGoal();
    final isReminderEnabled = _prefs.isReminderEnabled();
    final stepsWalked = await _healthKit.steps;
    final burnedCalories = await _healthKit.burnedCalories;

    final goalPercentage = _calculatePercentage(stepsWalked, goal);
    yield StepcounterState.ready(
      goalPercentage: goalPercentage,
      stepsGoal: goal,
      stepsWalked: stepsWalked,
      burnedCalories: burnedCalories,
      isReminderEnabled: isReminderEnabled,
    );
  }

  Stream<StepcounterState> _processOnDailyGoalSet(OnDailyGoalSet event) async* {
    _prefs.setStepsGoal(event.stepsCount);
    yield state.copyWith(
      stepsGoal: event.stepsCount,
      goalPercentage: _calculatePercentage(state.stepsWalked, event.stepsCount),
    );
  }

  Stream<StepcounterState> _processOnSwitchReminderPressed(OnSwitchReminderPressed event) async* {
    final isReminderEnabled = !state.isReminderEnabled;
    _prefs.setReminderEnabled(isReminderEnabled);
    if (isReminderEnabled) {
      await _alarmManager.scheduleNotification(
        title: 'Time to walk',
        body: 'Get your ass up the couch and walk, pal',
        scheduledTime: TZDateTime.now(local).add(const Duration(seconds: 5)),
      );
    } else {
      await _alarmManager.removeScheduledNotifications();
    }
    yield state.copyWith(isReminderEnabled: isReminderEnabled);
  }
}
