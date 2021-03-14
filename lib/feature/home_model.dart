abstract class HomeEvent {}

abstract class _Event extends HomeEvent {}

class Init extends HomeEvent {}

class SelectMovie extends _Event {}

class CreateMovie extends HomeEvent {
  final String name;

  CreateMovie(this.name);
}

class EditMovie extends _Event {}

class HomeState {
  final bool isLoading;

  final double goalPercentage;
  final int stepsGoal;
  final int stepsWalked;
  final int burnedCalories;

  HomeState._({this.isLoading, this.goalPercentage, this.stepsGoal, this.stepsWalked, this.burnedCalories});

  factory HomeState.loading() => HomeState._(isLoading: true);

  factory HomeState.ready(
    double goalPercentage,
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
//
// HomeState copyWith({List<String> movies, int selectedMovieId}) => HomeState._(
//       isLoading: isLoading ?? this.isLoading,
//       movies: movies ?? this.movies,
//       isCreatorMode: isCreatorMode ?? this.isCreatorMode,
//       selectedMovieId: selectedMovieId ?? this.selectedMovieId,
//     );
}
