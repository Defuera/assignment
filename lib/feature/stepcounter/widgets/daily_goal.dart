import 'package:fastic_demo/theme/fastic_colors.dart';
import 'package:flutter/material.dart';

class DailyGoalButton extends StatelessWidget {
  final VoidCallback onPressed;

  DailyGoalButton({this.onPressed});

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
            Text('Daily Goal', style: TextStyle(fontSize: 12, color: FasticColors.gray)),
          ],
        ),
      ),
    );
  }
}
