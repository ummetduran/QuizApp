import 'package:untitled1/quiz_app/backend/Student.dart';

abstract class Question {
  int _point;
  int _seconds;
  String _question;
  String _answer;

  Question(this._point, this._seconds, this._question, this._answer);

  String get answer => _answer;

  set answer(String value) {
    _answer = value;
  }

  String get question => _question;

  set question(String value) {
    _question = value;
  }

  int get seconds => _seconds;

  set seconds(int value) {
    _seconds = value;
  }

  int get point => _point;

  set point(int value) {
    _point = value;
  }
}