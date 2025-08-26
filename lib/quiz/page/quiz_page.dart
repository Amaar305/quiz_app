import 'package:flutter/material.dart';
import 'package:quiz_app/core/app_colors.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/quiz/page/add_quiz_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  List<int> correctAns = [];
  int score = 0;

  void checkAnswer(bool userPickedAnswer) {
    quizBrain.checkAnswer(userPickedAnswer);
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        // Step 4 Part A - show an alert using rFlutter_alert,

        //This is the code for the basic alert from the docs for rFlutter Alert:
        //Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();

        //Modified for our purposes:
        Alert(
          context: context,
          title: 'Finished!',
          type: quizBrain.pass ? AlertType.success : AlertType.error,
          desc: quizBrain.pass ? 'You have nailed it!' : 'Try again',
          style: AlertStyle(
            alertBorder: null,
            backgroundColor: Colors.grey.shade900,
            descStyle: TextStyle(color: AppColors.whiteColor),
            titleStyle: TextStyle(color: AppColors.whiteColor),
          ),
          buttons: [
            DialogButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ).show();

        // Step 4 Part C - reset the questionNumber,
        quizBrain.reset();

        // Step 4 Part D - empty out the scoreKeeper.
        scoreKeeper = [];
      }
      // Step 6 - If we've not reached the end, ELSE do the answer checking steps below 👇
      else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(Icons.check, color: Colors.green));
          score++;
        } else {
          scoreKeeper.add(Icon(Icons.close, color: Colors.red));
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddQuizPage()),
              );
            },
            icon: Icon(Icons.settings, color: AppColors.iconColor),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: quizBrain.isEmpty
              ? Center(child: Text('No quiz yet!.'))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            quizBrain.getQuestionText(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: TextButton(
                          // textColor: Colors.white,
                          // color: Colors.green,
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: Text(
                            'True',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          onPressed: () {
                            //The user picked true.
                            checkAnswer(true);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: TextButton(
                          // color: Colors.red,
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Text(
                            'False',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            //The user picked false.
                            checkAnswer(false);
                          },
                        ),
                      ),
                    ),
                    Row(children: scoreKeeper),
                  ],
                ),
        ),
      ),
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
