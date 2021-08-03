import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/quiz_app/model/Quiz.dart';
import 'package:untitled1/quiz_app/quiz_ekle.dart';
import 'package:untitled1/quiz_app/quiz_results_page.dart';

import 'model/Ders.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class DersPage extends StatefulWidget {
  final Ders ders;

  const DersPage({Key key, this.ders}) : super(key: key);

  @override
  _DersPageState createState() => _DersPageState();
}

class _DersPageState extends State<DersPage> {
  @override
  void initState() {
    // TODO: implement initState
    quizleriGetir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.cyan.shade600 ,
        title: Text(widget.ders.name),
      ),
      body: Container(
        child: Column(children: [
          Container(
            height: 65,
            width: 700,
            margin: EdgeInsets.all(10),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute( builder: (context) => QuizEkle(teacher: widget.ders.teacher,ders: widget.ders)));
              },
              child: Text(
                "Add Quiz",
                style: TextStyle(fontSize: 20),
              ),
              textColor: Colors.white,
              color: Colors.cyan.shade600,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
          Container(
            child: Expanded(
              child: ListView.builder(
                itemBuilder: listeElemaniOlustur,
                itemCount: widget.ders.quizList.length,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void quizleriGetir() async {
    var fireUser = _auth.currentUser;
    await _fireStore.collection("Users").doc(fireUser.uid).collection("dersler")
        .doc("${widget.ders.name}").collection("quizler").get()
        .then((value) {
      setState(() {
        widget.ders.quizList.clear();
        value.docs.forEach((element) {
          Quiz quiz = new Quiz();
          quiz.quizName = element.id;
          quiz.startDate = element.get("startDate");
          quiz.time = element.get("zaman");
          widget.ders.quizList.add(quiz);
        });
      });
    });

  }

  Widget listeElemaniOlustur(BuildContext context, int index) {
    Color colorL;
    String entryText;
    DateFormat dateFormat = DateFormat("yyyy-mm-dd HH:mm");
    print(widget.ders.quizList[index].startDate);
    DateTime quizStartDate = DateTime.parse(widget.ders.quizList[index].startDate);
    DateTime quizEndDate = quizStartDate.add(Duration(minutes: widget.ders.quizList[index].time));
    if( (DateTime.now().isAfter(quizStartDate)) && DateTime.now().isBefore(quizEndDate)){
      colorL = Colors.yellowAccent[700];
      entryText = "Published!";
    }
    else if(DateTime.now().isAfter(quizEndDate)){
      colorL = Colors.greenAccent[700];
      entryText = "Finished!";
    }
    else {
      colorL = Colors.lightBlueAccent[700];
      entryText = "Waiting!";
    }
    return SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: colorL,
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.all(5),
          child: ListTile(
            onTap: () {
              if(entryText=="Finished!"){
                Navigator.push(context, MaterialPageRoute( builder: (context) => QuizResultsPage(quiz: widget.ders.quizList[index], ders: widget.ders)));
              }
              else showAlertDialog(context);
            },

            title: Text(widget.ders.quizList[index].quizName),

          ),
        ));
  }
  void showAlertDialog(BuildContext context) {
    AlertDialog alert  = AlertDialog(
      content: Text("Quiz has not finished and results are not ready!"),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}