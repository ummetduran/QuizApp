import 'package:untitled1/quiz_app/backend/Question.dart';
import 'package:untitled1/quiz_app/backend/Student.dart';

class Quiz {
  String _questionName;
  List<Question> _questions;

  Quiz();

  String get questionName => _questionName;

  set questionName(String value) {
    _questionName = value;
  }

  List<Question> get questions => _questions;

  set questions(List<Question> value) {
    _questions = value;
  }
}