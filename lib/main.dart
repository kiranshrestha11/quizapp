import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quizapp/question.dart';
import 'package:quizapp/question_controller.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(MyApp());
QuestionController questionController = new QuestionController();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];
  int rightAnswer = 0;
  void checkAnswer(bool userAnswer) {
    setState(() {
      if (questionController.isFinished()) {
        Alert(
            context: context,
            title: "The questions are finished",
            desc: "You have answered $rightAnswer right answers",
            buttons: [
              DialogButton(
                child: Text(
                  "okay",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.blue,
              )
            ]).show();
        questionController.reset();
        scoreKeeper.clear();
        rightAnswer = 0;
      } else {
        if (questionController.getAnswerResult() == userAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            size: 24,
            color: Colors.green,
          ));
          rightAnswer++;
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            size: 24,
            color: Colors.red,
          ));
        }
        questionController.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Right answers:$rightAnswer",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionController.getquestionstext(),
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
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              color: Colors.green,
              child: Text(
                "True",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                "False",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: scoreKeeper,
          ),
        )
      ],
    );
  }
}
