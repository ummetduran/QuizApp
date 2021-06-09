import 'package:untitled1/quiz_app/backend/Question.dart';

class OpenEndQuestion implements Question {
  @override
  String answer;

  @override
  int point;

  @override
  String question;

  @override
  int seconds;

  OpenEndQuestion(this.answer, this.point, this.question, this.seconds);

  @override
  String imagePath;

  @override
  List<String> options;
}