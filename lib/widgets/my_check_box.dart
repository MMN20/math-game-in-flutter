import 'package:flutter/material.dart';
import '../models/math_game.dart';

class MyCheckBox extends StatelessWidget {
  const MyCheckBox(
      {super.key,
      required this.checked,
      required this.text,
      required this.onTap});
  final bool checked;
  final String text;
  final void Function() onTap;

  Color getLevelColor(String level) {
    switch (level) {
      case 'Easy':
        return Colors.green;
      case 'Medium':
        return Colors.yellow[600]!;
      case 'Hard':
        return Colors.red;
      case 'Mix':
        return Colors.blue;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            checked ? Icons.check_box : Icons.check_box_outline_blank,
            color: checked ? Colors.white : Colors.black,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 30, color: getLevelColor(text)),
          ),
        ],
      ),
    );
  }
}
