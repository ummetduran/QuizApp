import 'package:untitled1/quiz_app/backend/Question.dart';
import 'package:untitled1/quiz_app/backend/Student.dart';

class Quiz {
  String _quizName;
  List<Question> _questions;
  int _time;

  int get time => _time;

  set time(int value) {
    _time = value;
  }

  Quiz();

  String get quizName => _quizName;

  set quizName(String value) {
    _quizName = value;
  }

  List<Question> get questions => _questions;

  set questions(List<Question> value) {
    _questions = value;
  }
}