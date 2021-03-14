import 'dart:math';

import 'package:fastic_demo/feature/home_bloc.dart';
import 'package:fastic_demo/feature/home_model.dart';
import 'package:fastic_demo/theme/fastic_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

// As a User I want to synchronization my steps with my preferred health source
// As a User I want to get a reminder at 8pm if I haven’t achieved my goal

//Done:
// As a User I want to set my daily goal
// As a User I want to see how much steps I achieved today
// As a User I want to see how much calories I have burned with my steps
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _bloc = HomeBloc();

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder(
        cubit: _bloc,
        builder: (context, HomeState state) =>
            Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                leading: Icon(Icons.arrow_back_ios_rounded),
                actions: [
                  NotificationSwitch(
                    isEnabled: state.isReminderEnabled,
                    onPressed: () => _bloc.add(OnSwitchReminderPressed()),
                  )
                ],
              ),
              body: state.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Stepcounter',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.2, color: FasticColors.darkBlue),
                      ),
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
                    Padding(padding: const EdgeInsets.only(top: 16.0)),
                    _DailyGoalButton(onPressed: () => _showDailyGoalDialog(context)),
                  ],
                ),
              ),
            ),
      );

  void _showDailyGoalDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Daily goal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('How many steps you want to walk every day?'),
              TextField(
                autofocus: true,
                controller: controller,
                keyboardType: TextInputType.number,
                maxLength: 6,
                maxLengthEnforced: true,
                decoration: InputDecoration(
                  counterText: '',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ],
              )
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel')),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _bloc.add(OnDailyGoalSet(int.parse(controller.text)));
              },
              child: Text('OK'),
            )
          ],
        ));
  }
}

class _StepsProgressIndicator extends StatelessWidget {
  final int percent;

  _StepsProgressIndicator(this.percent);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          // flex: 1,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                '$percent%',
                style: TextStyle(color: FasticColors.darkBlue, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        CircularPercentIndicator(
          animationDuration: 200,
          lineWidth: 10,
          backgroundColor: FasticColors.fadeGray,
          animation: true,
          circularStrokeCap: CircularStrokeCap.round,
          radius: MediaQuery
              .of(context)
              .size
              .width / 2,
          percent: min(percent / 100, 1),
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
            child: Icon(icon, color: Theme
                .of(context)
                .primaryColor),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(title, style: Theme
                .of(context)
                .textTheme
                .bodyText1
                .copyWith(color: FasticColors.softBlue)),
          ),
          Text(description, style: Theme
              .of(context)
              .textTheme
              .bodyText2
              .copyWith(color: FasticColors.softBlue)),
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

class NotificationSwitch extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;
  final IconData icon;

  NotificationSwitch({this.isEnabled, this.onPressed})
      : icon = isEnabled ? Icons.notifications_on_outlined : Icons.notifications_off_outlined;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) =>
          IconButton(
            icon: Icon(icon, color: FasticColors.darkBlue),
            onPressed: () {
              onPressed();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Reminder is ${isEnabled ? 'off' : 'on'}'),
                behavior: SnackBarBehavior.fixed,
                duration: Duration(seconds: 1),
              ));
            },
          ),
    );
  }
}
