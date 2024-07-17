import 'package:flutter/material.dart';
import 'package:quiz_app/QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'Question.dart';

Quizbrain quizBrain = Quizbrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
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
  int correctAnswers = 0;

  // list of scoreIcons
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      // Add the icon for the current answer
      scoreKeeper.add(createScoreWidget(userPickedAnswer == correctAnswer));

      if (userPickedAnswer == correctAnswer) {
        correctAnswers++;
      }

      if (quizBrain.isFinished()) {
        // Showing the alert after a slight delay to ensure the UI updates
        Future.delayed(Duration(milliseconds: 100), () {
          Alert(
            context: context,
            title: 'Quiz finished',
            desc: 'You got $correctAnswers correct answers.',
            type: AlertType.success,
            buttons: [
              DialogButton(
                child: Text('Confirm'),
                onPressed: () {
                  setState(() {
                    quizBrain.reset();
                    scoreKeeper = [];
                    correctAnswers = 0;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ).show();
        });
      } else {
        quizBrain.nextQuestion();
      }
    });
  }


  Icon createScoreWidget(bool isCorrect) {
    return new Icon(
      isCorrect ? Icons.check : Icons.close,
      color: isCorrect ? Colors.green : Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                  textStyle: TextStyle(fontSize: 32),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green.shade500,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)))),
              onPressed: () {
                checkAnswer(true);
              },
              child: Text(
                'True',
              ),
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 32,
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red.shade500,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)))),
              onPressed: () {
                checkAnswer(false);
              },
              child: Text('False'),
            ),
          ),
        ),
        //ToDo: Add a row here as your score keeper
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: 40,
            child: Row(
              children: scoreKeeper,
            ),
          ),
        )
      ],
    );
  }
}
