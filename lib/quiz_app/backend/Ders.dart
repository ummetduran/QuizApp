import 'package:untitled1/quiz_app/backend/Student.dart';

import 'Teacher.dart';

class Ders {

  String name;
  Teacher teacher;
  List<Student> dersiAlanOgrenciler;

  Ders(String name,Teacher teacher){
    this.name = name;
    this.teacher = teacher;
    dersiAlanOgrenciler = [];
  }


}
