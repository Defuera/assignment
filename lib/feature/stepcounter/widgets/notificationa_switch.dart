import 'package:fastic_demo/theme/fastic_colors.dart';
import 'package:flutter/material.dart';

class NotificationSwitch extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;
  final IconData icon;

  NotificationSwitch({this.isEnabled, this.onPressed})
      : icon = isEnabled ? Icons.notifications_on_outlined : Icons.notifications_off_outlined;

  @override
  Widget build(BuildContext context) => IconButton(
        icon: Icon(icon, color: FasticColors.darkBlue),
        onPressed: () {
          onPressed();
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Reminder is ${isEnabled ? 'off' : 'on'}'),
            behavior: SnackBarBehavior.fixed,
            duration: Duration(seconds: 1),
          ));
        },
      );
}
