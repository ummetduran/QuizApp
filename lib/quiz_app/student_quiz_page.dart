import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'backend/Ders.dart';
import 'backend/Quiz.dart';
import 'backend/Student.dart';

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
  int score =0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            AlertDialog(
            content: Form(
                //  key: _formKey,
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.quiz.questions[index].question.toString(),
                  maxLines: 3,
                ),
                // Buraya image picker gelecek

                optionsWidget(),
              ],
            )),
            actions: <Widget>[
              quiziBitir(),
            ],
          ),
    ]
        ));
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
                      Text(widget.quiz.questions[index].options[0].toString()),
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
                        widget.quiz.questions[index].options[1].toString())),
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
                      Text(widget.quiz.questions[index].options[0].toString()),
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
                        widget.quiz.questions[index].options[1].toString())),
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
                        widget.quiz.questions[index].options[2].toString())),
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
                        widget.quiz.questions[index].options[3].toString())),
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
        child: Text('End Quiz'),
        onPressed: () {
          setState(() {
            debugPrint("Kaydedildi");
              uploadQuizScore();
          });
        },
      );
    } else {
      return TextButton(
        child: Text("Next Question"),
        onPressed: () {
          setState(() {
            if(widget.quiz.questions[index].answer == widget.quiz.questions[index].options[_radioValue]){
              score+=widget.quiz.questions[index].point;
            }

            index++;
            _radioValue = -1;
          });
        },
      );
    }
  }

  void uploadQuizScore() async {
    var fireUser = _auth.currentUser;
    Map<String, int> quizScore = new Map();
    quizScore["QuizScore"] = score;
    await _fireStore.collection("Users").doc("${fireUser.uid}").collection("alinanDersler").
    doc("${widget.ders.name}").collection("quizler").add(quizScore);
  }
}
