import 'package:flutter/material.dart';
import 'package:my_math_game/models/math_game.dart';
import 'package:my_math_game/widgets/answer_item.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.mathGame});
  final MathGame mathGame;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int selectedIndex = -1;
  bool isSelectedAChoice = false;
  int currentRound = 1;
  String currentQuestion = '';
  int rightAnswers = 0;
  int wrongAnswers = 0;
  bool isGameOver = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.mathGame.setNum1AndNum2AndResult();
    setCurrentQuestion();
    widget.mathGame.set4Choices();
  }

  void checkAnswers(int index) {
    if (widget.mathGame.choices[index].isCorrectResult) {
      rightAnswers++;
    } else {
      wrongAnswers++;
    }
  }

  void endTheGame() {
    isGameOver = true;
  }

  void setCurrentQuestion() {
    currentQuestion =
        '${widget.mathGame.num1.toStringAsFixed(0)} ${getOperationChar(widget.mathGame.oper)} ${widget.mathGame.num2.toStringAsFixed(0)}';
  }

  void nextRound() {
    if (widget.mathGame.numberOfRounds > currentRound && isSelectedAChoice) {
      widget.mathGame.setNum1AndNum2AndResult();
      setCurrentQuestion();
      widget.mathGame.set4Choices();
      currentRound++;
      isSelectedAChoice = false;
      selectedIndex = -1;
      setState(() {});
    } else if (isGameOver) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                '$currentRound/${widget.mathGame.numberOfRounds}',
                style: const TextStyle(color: Colors.white, fontSize: 35),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                currentQuestion,
                style: const TextStyle(color: Colors.white, fontSize: 30),
              ),
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: ((context, index) {
                    return Answeritem(
                      isSelectedAChoice: isSelectedAChoice,
                      choice: widget.mathGame.choices[index],
                      isSelected: selectedIndex == index,
                      onTap: () {
                        if (!isSelectedAChoice) {
                          selectedIndex = index;
                          isSelectedAChoice = true;
                          checkAnswers(index);
                          if (currentRound == widget.mathGame.numberOfRounds) {
                            endTheGame();
                          }
                          setState(() {});
                        }
                      },
                    );
                  }),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    if (isGameOver)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Right: ${rightAnswers}',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 25),
                            ),
                            Text('Wrong: ${wrongAnswers}',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 25)),
                          ],
                        ),
                      ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          maximumSize: const Size(double.infinity, 100)),
                      child: Text(
                        !isGameOver ? 'Next Round' : 'Go Back',
                        style: TextStyle(fontSize: 25),
                      ),
                      onPressed: nextRound,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
