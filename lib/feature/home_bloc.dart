import 'package:fastic_demo/feature/home_model.dart';
import 'package:fastic_demo/model/app_prefs.dart';
import 'package:fastic_demo/model/health_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AppPrefs _prefs = GetIt.instance.get();
  final HealthKit _healthKit = GetIt.instance.get();

  HomeBloc() : super(HomeState.loading()) {
    add(Init());
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is Init) {
      final goal = _prefs.getStepsGoal() ?? 30000; //todo
      final stepsWalked = await _healthKit.steps;
      final burnedCalories = await _healthKit.burnedCalories;

      final goalPercentage = _calculatePercentage(stepsWalked, goal);
      yield HomeState.ready(goalPercentage, goal, stepsWalked, burnedCalories);
    } else if (event is OnDailyGoalSet) {
      _prefs.setStepsGoal(event.stepsCount);
      yield state.copyWith(
          stepsGoal: event.stepsCount,
          goalPercentage: _calculatePercentage(state.stepsWalked, event.stepsCount)
      );
    }
  }

  int _calculatePercentage(int stepsWalked, int goal) => (stepsWalked / goal * 100).toInt();
}
