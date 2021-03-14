abstract class HomeEvent {}

class Init extends HomeEvent {}

class OnDailyGoalSet extends HomeEvent {
  final int stepsCount;

  OnDailyGoalSet(this.stepsCount);
}

class HomeState {
  final bool isLoading;

  final int goalPercentage;
  final int stepsGoal;
  final int stepsWalked;
  final int burnedCalories;

  HomeState._({this.isLoading, this.goalPercentage, this.stepsGoal, this.stepsWalked, this.burnedCalories});

  factory HomeState.loading() => HomeState._(isLoading: true);

  factory HomeState.ready(
    int goalPercentage,
    int stepsGoal,
    int stepsWalked,
    int burnedCalories,
  ) =>
      HomeState._(
        isLoading: false,
        goalPercentage: goalPercentage,
        stepsGoal: stepsGoal,
        stepsWalked: stepsWalked,
        burnedCalories: burnedCalories,
      );

  HomeState copyWith({
    int goalPercentage,
    int stepsGoal,
    int stepsWalked,
    int burnedCalories,
  }) =>
      HomeState._(
        isLoading: isLoading ?? this.isLoading,
        goalPercentage: goalPercentage ?? this.goalPercentage,
        stepsGoal: stepsGoal ?? this.stepsGoal,
        stepsWalked: stepsWalked ?? this.stepsWalked,
        burnedCalories: burnedCalories ?? this.burnedCalories,
      );
}
