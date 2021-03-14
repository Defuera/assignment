import 'package:fastic_demo/feature/stepcounter/stepcounter_bloc.dart';
import 'package:fastic_demo/feature/stepcounter/stepcounter_model.dart';
import 'package:fastic_demo/feature/stepcounter/widgets/daily_goal.dart';
import 'package:fastic_demo/feature/stepcounter/widgets/info.dart';
import 'package:fastic_demo/feature/stepcounter/widgets/notificationa_switch.dart';
import 'package:fastic_demo/feature/stepcounter/widgets/stepcounter.dart';
import 'package:fastic_demo/theme/fastic_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepcounterScreen extends StatefulWidget {
  const StepcounterScreen({Key key}) : super(key: key);

  @override
  _StepcounterScreenState createState() => _StepcounterScreenState();
}

class _StepcounterScreenState extends State<StepcounterScreen> {
  final _bloc = StepcounterBloc();

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder(
        cubit: _bloc,
        builder: (context, StepcounterState state) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: InkWell(
              child: Icon(Icons.arrow_back_ios_rounded),
              onTap: () {
                //do nothing
              },
            ),
            actions: [
              if (!state.isLoading)
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
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.2, color: FasticColors.darkBlue),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 54.0),
                        child: StepsProgressIndicator(state.goalPercentage),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CounterWidget(
                            icon: Icons.directions_walk,
                            title: '${state.stepsWalked} / ${state.stepsGoal ?? '...'}',
                            description: 'Steps',
                          ),
                          CounterWidget(
                            icon: Icons.local_fire_department_rounded,
                            title: '${state.burnedCalories}',
                            description: 'Calories',
                          ),
                        ],
                      ),
                      Padding(padding: const EdgeInsets.only(top: 16.0)),
                      DailyGoalButton(onPressed: () => _showDailyGoalDialog(context)),
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
