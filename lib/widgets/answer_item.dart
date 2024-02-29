import 'package:flutter/material.dart';
import 'package:my_math_game/models/math_game.dart';

class Answeritem extends StatelessWidget {
  const Answeritem(
      {super.key,
      required this.choice,
      required this.isSelected,
      required this.onTap,
      required this.isSelectedAChoice});
  final Choice choice;
  final bool isSelected;
  final bool isSelectedAChoice;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: isSelectedAChoice
                ? (choice.isCorrectResult ? Colors.green : Colors.red)
                : Colors.amber,
            borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 10),
        child: Text(
          choice.result.toStringAsFixed(0),
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
