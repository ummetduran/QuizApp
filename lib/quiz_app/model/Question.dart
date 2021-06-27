import 'package:untitled1/quiz_app/model/Student.dart';

 class Question {
  int _point;
  String _question;
  String _answer= " ";
  String _imagePath;
  List<String> options = ["a", "b","c","d"];


  @override
  String toString() {
    return 'Question{_point: $_point, _question: $_question, _answer: $_answer, _imagePath: $_imagePath, options: $options}';
  }

  String get imagePath => _imagePath;

  set imagePath(String value) {
    _imagePath = value;
  }

  //Question(this._point,  this._question, this._answer);

  String get answer => _answer;

  set answer(String value) {
    _answer = value;
  }

  String get question => _question;

  set question(String value) {
    _question = value;
  }



  int get point => _point;

  set point(int value) {
    _point = value;
  }


}