import 'package:fastic_demo/theme/fastic_colors.dart';
import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  CounterWidget({this.icon, this.title, this.description});

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
            child: Text(title, style: Theme.of(context).textTheme.bodyText1.copyWith(color: FasticColors.softBlue)),
          ),
          Text(description, style: Theme.of(context).textTheme.bodyText2.copyWith(color: FasticColors.softBlue)),
        ],
      ),
    );
  }
}
