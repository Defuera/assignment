abstract class StepcounterEvent {}

class Init extends StepcounterEvent {}

class OnDailyGoalSet extends StepcounterEvent {
  final int stepsCount;

  OnDailyGoalSet(this.stepsCount);
}

class OnSwitchReminderPressed extends StepcounterEvent {}

class StepcounterState {
  final bool isLoading;

  final int goalPercentage;
  final int stepsGoal;
  final int stepsWalked;
  final int burnedCalories;
  final bool isReminderEnabled;

  StepcounterState._({this.isLoading, this.goalPercentage, this.stepsGoal, this.stepsWalked, this.burnedCalories, this.isReminderEnabled});

  factory StepcounterState.loading() => StepcounterState._(isLoading: true);

  factory StepcounterState.ready({
    int goalPercentage,
    int stepsGoal,
    int stepsWalked,
    int burnedCalories,
    bool isReminderEnabled,
  }) =>
      StepcounterState._(
        isLoading: false,
        goalPercentage: goalPercentage,
        stepsGoal: stepsGoal,
        stepsWalked: stepsWalked,
        burnedCalories: burnedCalories,
        isReminderEnabled: isReminderEnabled,
      );

  StepcounterState copyWith({
    int goalPercentage,
    int stepsGoal,
    int stepsWalked,
    int burnedCalories,
    bool isReminderEnabled,
  }) =>
      StepcounterState._(
        isLoading: isLoading ?? this.isLoading,
        goalPercentage: goalPercentage ?? this.goalPercentage,
        stepsGoal: stepsGoal ?? this.stepsGoal,
        stepsWalked: stepsWalked ?? this.stepsWalked,
        burnedCalories: burnedCalories ?? this.burnedCalories,
        isReminderEnabled: isReminderEnabled ?? this.isReminderEnabled,
      );
}
