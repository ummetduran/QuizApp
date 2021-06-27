import 'package:untitled1/quiz_app/model/Question.dart';

class TrueFalseQuestion implements Question {

  @override
  String answer;

  @override
  int point;

  @override
  String question;

  @override
  int seconds;


  @override
  String imagePath;

  @override
  List<String> options;
}