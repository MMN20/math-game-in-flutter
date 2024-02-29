// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

enum Level { Easy, Med, Hard, Mix }

String getLevelName(Level level) {
  switch (level) {
    case Level.Easy:
      {
        return 'Easy';
      }
    case Level.Med:
      {
        return 'Medium';
      }
    case Level.Hard:
      {
        return 'Hard';
      }
    case Level.Mix:
      {
        return 'Mix';
      }
  }
}

enum Operation { Add, Sub, Mul, Div }

String getOperationChar(Operation oper) {
  switch (oper) {
    case Operation.Add:
      {
        return '+';
      }
    case Operation.Div:
      {
        return '/';
      }
    case Operation.Mul:
      {
        return '*';
      }
    case Operation.Sub:
      {
        return '-';
      }
  }
}

class MathGame {
  late double num1;
  late double num2;
  late double result;
  late double choosedResult;
  late int numberOfRounds;
  List<Choice> choices = [];
  late Operation oper = Operation.Add;
  Level level = Level.Easy;

  void setLevel(Level level) {
    this.level = level;
  }

  void setOper(Operation oper) {
    this.oper = oper;
  }

  /// setting the 3 false and 1 true choices
  void set4Choices() {
    choices = [];
    int whereToPutTheRightChoice = Random().nextInt(4);
    for (int i = 0; i < 4; i++) {
      if (i == whereToPutTheRightChoice) {
        choices.add(Choice(result: result, isCorrectResult: true));
      } else {
        double number = _getNumberOnDefficulty(level);
        while (number == result) {
          number = _getNumberOnDefficulty(level);
        }
        choices.add(Choice(result: number, isCorrectResult: false));
      }
    }
  }

  double _getNumberOnDefficulty(Level level) {
    Random rand = Random();
    switch (level) {
      case Level.Easy:
        {
          return rand.nextInt(20).toDouble();
        }
      case Level.Med:
        {
          return 20 + rand.nextInt(60 - 20).toDouble();
        }
      case Level.Hard:
        {
          return 60 + rand.nextInt(120 - 60).toDouble();
        }
      case Level.Mix:
        {
          return _getNumberOnDefficulty(Level.values[rand.nextInt(3)]);
        }
    }
  }

  double _getTheResult() {
    switch (oper) {
      case Operation.Add:
        {
          return num1 + num2;
        }
      case Operation.Div:
        {
          return num1 / num2;
        }
      case Operation.Mul:
        {
          return num1 * num2;
        }
      case Operation.Sub:
        {
          return num1 - num2;
        }
    }
  }

  /// this will depend on the oper and the level
  void setNum1AndNum2AndResult() {
    num1 = _getNumberOnDefficulty(this.level);
    num2 = _getNumberOnDefficulty(this.level);
    result = _getTheResult();
  }
}

class Choice {
  double result;
  bool isCorrectResult;
  Choice({
    required this.result,
    required this.isCorrectResult,
  });
}
