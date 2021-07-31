import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/quiz_app/student_home_page.dart';

import 'model/Ders.dart';
import 'model/Quiz.dart';
import 'model/Student.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class StudentQuizPage extends StatefulWidget {
  final Quiz quiz;
  final Ders ders;

  const StudentQuizPage({Key key, this.quiz, this.ders}) : super(key: key);

  @override
  _StudentQuizPageState createState() => _StudentQuizPageState();
}

class _StudentQuizPageState extends State<StudentQuizPage> {
  int _radioValue = -1;
  int index = 0;
  int score = 0;
  Student student = new Student(_auth.currentUser.uid, _auth.currentUser.displayName, _auth.currentUser.email);
  @override
  void initState() {
    // TODO: implement initState
    widget.quiz.questions.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    DateTime quizStartDate = dateFormat.parse(widget.quiz.startDate);
    DateTime nowMinusStart = DateTime.now().subtract(Duration(minutes: quizStartDate.minute));
    int timer = widget.quiz.time - nowMinusStart.minute;
    return Scaffold(

        body: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15, top: 60,bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child:
                      Icon(Icons.timer, size: 22, color: Colors.cyan.shade600),
                ),
                CountdownFormatted(
                    duration: Duration(minutes: timer),
                    builder: (BuildContext ctx, String remaining) {
                      return Text(
                        remaining,
                        style: TextStyle(
                            fontSize: 25, color: Colors.cyan.shade600),
                      );
                    },
                    onFinish: timeOut),
              ],
            ),
          ),

          Text("Soru ${index + 1}"+"/${widget.quiz.questions.length}",style: TextStyle(fontSize: 25),),

          AlertDialog(
            content: Form(
                //  key: _formKey,
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.quiz.questions[index].question.toString(),
                  maxLines: 3,style: TextStyle(fontSize: 20),
                ),
                 imageWidget(),

                optionsWidget(),
              ],
            )),
            actions: <Widget>[
              quiziBitir(),

            ],
          ),
        ]));
  }

  void radioChanged(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  Widget optionsWidget() {

    if (widget.quiz.questions[index].options.length == 2) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Radio(
                    value: 0, groupValue: _radioValue, onChanged: radioChanged),
                SizedBox(
                  width: 200,
                  child:
                      Text(widget.quiz.questions[index].options[0].toString(), style: TextStyle(fontSize: 20),),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Radio(
                    value: 1, groupValue: _radioValue, onChanged: radioChanged),
                SizedBox(
                    width: 200,
                    child: Text(
                        widget.quiz.questions[index].options[1].toString(),style: TextStyle(fontSize: 20),)),
              ],
            ),
          ),
        ],
      );
    } else if (widget.quiz.questions[index].options.length == 4) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Radio(
                    value: 0, groupValue: _radioValue, onChanged: radioChanged),
                SizedBox(
                  width: 200,
                  child:
                      Text(widget.quiz.questions[index].options[0].toString(), style: TextStyle(fontSize: 20),),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Radio(
                    value: 1, groupValue: _radioValue, onChanged: radioChanged),
                SizedBox(
                    width: 200,
                    child: Text(
                        widget.quiz.questions[index].options[1].toString(), style: TextStyle(fontSize: 20))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Radio(
                    value: 2, groupValue: _radioValue, onChanged: radioChanged),
                SizedBox(
                    width: 200,
                    child: Text(
                        widget.quiz.questions[index].options[2].toString(), style: TextStyle(fontSize: 20))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Radio(
                  value: 3,
                  groupValue: _radioValue,
                  onChanged: radioChanged,
                ),
                SizedBox(
                    width: 200,
                    child: Text(
                        widget.quiz.questions[index].options[3].toString(), style: TextStyle(fontSize: 20))),
              ],
            ),
          )
        ],
      );
    }
  }

  Widget quiziBitir() {
    if (index == widget.quiz.questions.length - 1) {
      return TextButton(
        child: Text(
          'End Quiz',
          style: TextStyle(color: Colors.cyan.shade600),
        ),
        onPressed: () {
          setState(() async {
            if (widget.quiz.questions[index].answer ==  widget.quiz.questions[index].options[_radioValue]) {
              debugPrint("${widget.quiz.questions[index].answer}");
              debugPrint("${widget.quiz.questions[index].options[_radioValue]}");
              score += widget.quiz.questions[index].point;

            }
            widget.quiz.hasSolved = true;
            debugPrint("${widget.quiz.hasSolved}");
            AlertDialog alert = new AlertDialog(
              content: Text("Quiz bitti"),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context, "OK"), child: Text("OK"))
              ],
            );
            showDialog(context: context, builder: (BuildContext context){

              return alert;
            });
            uploadQuizScore();
            await Future.delayed(const Duration(seconds: 3), (){});
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StudentHomePage(student: student,ders: widget.ders)));
          });
        },
      );
    } else {
      return TextButton(
        child: Text("Next Question",
            style: TextStyle(color: Colors.cyan.shade600)),
        onPressed: () {
          setState(() {
            if (widget.quiz.questions[index].answer ==  widget.quiz.questions[index].options[_radioValue]) {
              debugPrint("${widget.quiz.questions[index].answer}");
              debugPrint("${widget.quiz.questions[index].options[_radioValue]}");
              score += widget.quiz.questions[index].point;
            }

            index++;
            _radioValue = -1;
            widget.quiz.questions[index].options.shuffle();
          });
        },
      );
    }
  }

  void uploadQuizScore() async {
    var fireUser = _auth.currentUser;
    Map<String, dynamic> quizScore = new Map();
    quizScore["QuizScore"] = score;
    //quizScore["hasSolved"] = true;
    await _fireStore
        .collection("Users")
        .doc("${fireUser.uid}")
        .collection("alinanDersler")
        .doc("${widget.ders.name}")
        .collection("quizler").doc("${widget.quiz.quizName}").set(quizScore);
  }

  Widget imageWidget() {
    if (widget.quiz.questions[index].imagePath == null || widget.quiz.questions[index].imagePath == "") {
      return Text("");
    }
    else {
      return Container(
          padding: EdgeInsets.only(top: 25),
          height: 200,
          width: 200,
          child: Image.network(widget.quiz.questions[index].imagePath));

  }
  }
  void timeOut(){
    uploadQuizScore();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StudentHomePage(student: student,ders: widget.ders)));
  }
}
