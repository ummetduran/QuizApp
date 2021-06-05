import 'package:untitled1/quiz_app/backend/Question.dart';

class MultipleChoiceQuestion implements Question {

  @override
  String answer;

  @override
  int point;

  @override
  String question;

  @override
  int seconds;

  List<String> _choices;


  MultipleChoiceQuestion(
      this.answer, this.point, this.question, this.seconds, this._choices);

  List<String> get choices => _choices;

  set choices(List<String> value) {
    _choices = value;
  }

}