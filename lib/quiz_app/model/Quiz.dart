import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled1/quiz_app/model/Question.dart';
import 'package:untitled1/quiz_app/model/Student.dart';

class Quiz {
  String _quizName;
  List<Question> questions=[];
  int _time;
  String startDate;
  bool _hasSolved = false;


  bool get hasSolved => _hasSolved;

  set hasSolved(bool value) {
    _hasSolved = value;
  }

  int get time => _time;

  set time(int value) {
    _time = value;
  }

  Quiz();

  String get quizName => _quizName;

  set quizName(String value) {
    _quizName = value;
  }



  void addQuestion(Question question){
    this.questions.add(question);
  }

  @override
  String toString() {
    return 'Quiz{_quizName: $_quizName, questions: $questions, _time: $_time}';
  }
}