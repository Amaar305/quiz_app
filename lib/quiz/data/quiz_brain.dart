import 'package:hive/hive.dart';

import '../models/question.dart';

class QuizBrain {
  int _questionNumber = 0;
  int _score = 0;

  final Box<Question> _questionBox = Hive.box<Question>('quizzes');

  // Get all Questions
  List<Question> get _questionBank {
    return _questionBox.values.toList();
  }

  // final List<Question> _questionBank =;

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  // int get score => _score;
  bool get pass {
    return _score >= _questionBank.length - 1;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  /// Call this when user submits an answer
  void checkAnswer(bool userAnswer) {
    print(_score);

    if (userAnswer == _questionBank[_questionNumber].questionAnswer) {
      _score++;
    }
  }

  bool get isEmpty => _questionBank.isEmpty;
  void reset() {
    _score = 0;

    _questionNumber = 0;
  }
}
