import 'package:untitled1/quiz_app/backend/Student.dart';

import 'Quiz.dart';
import 'Teacher.dart';

class Ders {

  String _name;
  Teacher _teacher;
  List<Student> _dersiAlanOgrenciler;
  List<Quiz> _quizList;

  Ders(String name,Teacher teacher){
    _name = name;
    _teacher = teacher;
    _dersiAlanOgrenciler = [];
    _quizList =  [];
  }
  Ders.empty(){
    _name="";
    _teacher =null;
    _quizList = [];
  }



  List<Quiz> get quizList => _quizList;

  set quizList(List<Quiz> value) {
    _quizList = value;
  }

  List<Student> get dersiAlanOgrenciler => _dersiAlanOgrenciler;

  set dersiAlanOgrenciler(List<Student> value) {
    _dersiAlanOgrenciler = value;
  }

  Teacher getTeacher(){
    return _teacher;
  }

  void setTeacher(Teacher value) {
    _teacher = value;
  }

  String getName(){
    return _name;
  }

  void setName(String value) {
    _name = value;
  }
}