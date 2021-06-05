import 'package:untitled1/quiz_app/backend/Question.dart';

class TrueFalseQuestion implements Question {

  @override
  String answer;

  @override
  int point;

  @override
  String question;

  @override
  int seconds;

  TrueFalseQuestion(this.answer, this.point, this.question, this.seconds);
}