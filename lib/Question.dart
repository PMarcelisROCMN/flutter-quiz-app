class Question {

  // properties
  final String questionText;
  final bool questionAnswer;

  // with the curly brackets and required keyword we can now use named parameters
  // this also means that it is now required to always use named parameters
  Question({ required this.questionText, required this.questionAnswer});

  // methods
  bool answeredCorrectly(bool answer) {
    return answer == questionAnswer;
  }
}
