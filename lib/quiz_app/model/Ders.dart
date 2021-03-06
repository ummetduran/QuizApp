import 'package:flutter/cupertino.dart';
import 'package:untitled1/quiz_app/model/Student.dart';
import 'package:nanoid/nanoid.dart';

import 'Quiz.dart';
import 'Teacher.dart';

class Ders {
  String _key;
  String _name;
  Teacher _teacher;
  List<Student> _dersiAlanOgrenciler;
  List<Quiz> _quizList=[];


  String get key => _key;

  set key(String value) {
    _key = value;
  }

  Ders(String name,Teacher teacher){
    _key = ObjectKey(this).toString();
    _name = name;
    _teacher = teacher;
    _dersiAlanOgrenciler = [];
    _quizList =  [];
  }
  Ders.empty(){
    _key = ObjectKey(this).toString();

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

  Teacher get teacher => _teacher;

  set teacher(Teacher value) {
    _teacher = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  @override
  String toString() {
    return 'Ders{_key: $_key, _name: $_name, _teacher: $_teacher, _dersiAlanOgrenciler: $_dersiAlanOgrenciler, _quizList: $_quizList}';
  }
}