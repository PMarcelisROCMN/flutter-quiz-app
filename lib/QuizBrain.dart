import 'package:quiz_app/Question.dart';

class Quizbrain{

  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question(questionText: 'am I going to be okay?', questionAnswer: true),
    Question(questionText: 'should I go to the gym today?', questionAnswer: false),
    Question(questionText: 'should I consume more protein?', questionAnswer: true),
    Question(questionText: 'should I just binge shows?', questionAnswer: false),
    Question(questionText: '2 + 2 = 4', questionAnswer: true),
    Question(questionText: 'is edging goated?', questionAnswer: false),
  ];

  bool isFinished(){
    return _questionNumber >= _questionBank.length -1 ;
  }

  void nextQuestion(){
    if (_questionNumber < _questionBank.length - 1){
      _questionNumber++;
    }
  }

  String getQuestionText(){
    return _questionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer(){
    return _questionBank[_questionNumber].questionAnswer;
  }

  void reset() {
    _questionNumber = 0;
  }
}