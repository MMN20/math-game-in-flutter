import 'package:flutter/material.dart';
import 'package:my_math_game/models/math_game.dart';
import 'package:my_math_game/screens/game_screen.dart';
import 'package:my_math_game/widgets/my_check_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MathGame mathGame = MathGame();
  String numberOfRounds = '';

  void setChoosedLevel(int index) {
    mathGame.setLevel(Level.values[index]);
    setState(() {});
  }

  void setChoosedOperation(int index) {
    mathGame.setOper(Operation.values[index]);
    setState(() {});
  }

  void startTheGame() {
    if (numberOfRounds != '') {
      int? tryPrasing = int.tryParse(numberOfRounds);
      if (tryPrasing != null && tryPrasing > 0) {
        mathGame.numberOfRounds = int.parse(numberOfRounds);
        Navigator.push(context,
            MaterialPageRoute(builder: (c) => GameScreen(mathGame: mathGame)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please enter a correct number")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Level',
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                      SizedBox(
                        width: 140,
                        height: 240,
                        child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return MyCheckBox(
                                  text: getLevelName(
                                    Level.values[index],
                                  ),
                                  onTap: () {
                                    setChoosedLevel(index);
                                  },
                                  checked:
                                      mathGame.level == Level.values[index]);
                            }),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Operation',
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                      SizedBox(
                        width: 140,
                        height: 240,
                        child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return MyCheckBox(
                                  text:
                                      getOperationChar(Operation.values[index]),
                                  onTap: () {
                                    setChoosedOperation(index);
                                  },
                                  checked:
                                      mathGame.oper == Operation.values[index]);
                            }),
                      ),
                    ],
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Number of rounds:',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextField(
                onChanged: (value) {
                  numberOfRounds = value;
                },
                maxLength: 2,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white, fontSize: 25),
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.5),
                  ),
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
                child: const Text(
                  'Start',
                  style: TextStyle(fontSize: 25),
                ),
                onPressed: startTheGame,
              )
            ],
          ),
        ),
      ),
    );
  }
}
