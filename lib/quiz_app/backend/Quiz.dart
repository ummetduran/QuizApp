import 'package:untitled1/quiz_app/backend/Question.dart';
import 'package:untitled1/quiz_app/backend/Student.dart';

class Quiz {
  String _quizName;
  List<Question> questions=[];
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



  void addQuestion(Question question){
    this.questions.add(question);
  }

  @override
  String toString() {
    return 'Quiz{_quizName: $_quizName, _time: $_time}';
  }
}