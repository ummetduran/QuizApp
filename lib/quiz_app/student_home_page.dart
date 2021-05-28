import 'package:flutter/material.dart';
import 'package:untitled1/quiz_app/backend/Student.dart';

class StudentHomePage extends StatefulWidget {

  Student student;
  StudentHomePage({this.student});
  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Burası Öğrneci Ana Sayfası"),);
  }
}
