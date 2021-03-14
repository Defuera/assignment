import 'dart:math';

import 'package:fastic_demo/theme/fastic_colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StepsProgressIndicator extends StatelessWidget {
  final int percent;

  StepsProgressIndicator(this.percent);

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
                percent == null ? '...' : '$percent%',
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
          radius: MediaQuery.of(context).size.width / 2,
          percent: percent == null ? 0 : min(percent / 100, 1),
        ),
      ],
    );
  }
}
