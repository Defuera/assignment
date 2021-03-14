import 'package:fastic_demo/feature/home_bloc.dart';
import 'package:fastic_demo/feature/home_model.dart';
import 'package:fastic_demo/theme/fastic_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _bloc = HomeBloc();

  // final AppPrefs _prefs = GetIt.instance.get();

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        // backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: Icon(Icons.arrow_back_ios_rounded),
          // titleText: 'Home',
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_off_outlined),
              // onPressed: () => showNameDialog(
              //   context: context,
              //   titleText: 'New Movie',
              //   onNameInput: (name) => _bloc.add(CreateMovie(name)),
              // ),
            )
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
            cubit: _bloc,
            builder: (context, state) => state.isLoading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Stepcounter',
                              style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.2)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 54.0),
                          child: _StepsProgressIndicator(state.goalPercentage),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _CounterWidget(
                              icon: Icons.directions_walk, //todo icon
                              title: '${state.stepsWalked} / ${state.stepsGoal}',
                              description: 'Steps',
                            ),
                            _CounterWidget(
                              icon: Icons.local_fire_department_rounded,
                              title: '${state.burnedCalories}',
                              description: 'Calories',
                            ),
                          ],
                        ),
                        _DailyGoalButton(onPressed: () {}),
                      ],
                    ),
                  )),
      );
}

class _StepsProgressIndicator extends StatelessWidget {
  final double percent;

  _StepsProgressIndicator(this.percent);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          '${(percent * 100).toInt()}%', //todo calculate in bloc
          style: TextStyle(fontSize: 68),
        ),
        CircularPercentIndicator(
          animationDuration: 200,
          lineWidth: 10,
          backgroundColor: FasticColors.gray,
          animation: true,
          circularStrokeCap: CircularStrokeCap.round,
          radius: MediaQuery.of(context).size.width / 2,
          percent: percent,
        ),
      ],
    );
  }
}

class _CounterWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  _CounterWidget({this.icon, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(icon, color: Theme.of(context).primaryColor),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(title, style: Theme.of(context).textTheme.bodyText1),
          ),
          Text(description, style: Theme.of(context).textTheme.bodyText2),
        ],
      ),
    );
  }
}

class _DailyGoalButton extends StatelessWidget {
  final VoidCallback onPressed;

  _DailyGoalButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: FasticColors.fadeGray,
        shadowColor: Colors.transparent,
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.edit_outlined, size: 16, color: FasticColors.gray),
            Padding(padding: EdgeInsets.only(left: 8)),
            Text('DailyGoal', style: TextStyle(fontSize: 12, color: FasticColors.gray)),
          ],
        ),
      ),
    );
  }
}
