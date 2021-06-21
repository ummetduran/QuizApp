import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/quiz_app/ders_ekle.dart';
import 'package:untitled1/quiz_app/student_quiz_page.dart';

import 'backend/Ders.dart';
import 'backend/Question.dart';
import 'backend/Quiz.dart';
FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
class StudentDersPage extends StatefulWidget {
  final Ders ders;

  const StudentDersPage({Key key, this.ders}) : super(key: key);
  @override
  _StudentDersPageState createState() => _StudentDersPageState();
}

class _StudentDersPageState extends State<StudentDersPage> {

  @override
  void initState() {
    //print(widget.ders.name);
    // TODO: implement initState
    fetchQuizzes();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(
          widget.ders.name.toString(),
        ),
        backgroundColor: Colors.cyan.shade600,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Expanded(
                child: ListView.builder(itemBuilder: listeElemaniOlustur,
                  itemCount: widget.ders.quizList.length ,
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }

  Future fetchQuizzes() async {
    widget.ders.quizList.clear();
    String teacherId = widget.ders.teacher.id;
    String dersId = widget.ders.name;

    var quizler =  await _fireStore.collection("Users").doc(teacherId).collection("dersler")
        .doc(dersId).collection("quizler");
    quizler.snapshots().listen((event) async {
      for(var element in event.docs) {
        Quiz quiz = new Quiz();
        quiz.quizName = element.id;
        quiz.time = element.get("zaman");
        var dbQuestions = await _fireStore.collection("Users").doc(teacherId).collection("dersler")
            .doc(dersId).collection("quizler").doc(element.id).collection("sorular");
        dbQuestions.snapshots().listen((event) {
          for(var element in event.docs) {

            Question q = new Question();
            q.question = element.get("question");
            q.answer = element.get("dogruCevap");
            q.point= element.get("point");
            q.imagePath = element.get("imagePath");

            q.options.clear();
            List qOptions = element.get("cevaplar");
            for(var element in qOptions){
              q.options.add(element.toString());
            }//her seçenek için
            quiz.addQuestion(q);
          }//her soru için


          });

        setState(() {
          widget.ders.quizList.add(quiz);
        });
        }

        });
  }

  Widget listeElemaniOlustur(BuildContext context, int index) {
    return SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.all(5),
          child: ListTile(
            onTap: () {
              debugPrint("dasasd");
              Navigator.push(context, MaterialPageRoute( builder: (context) => StudentQuizPage(quiz: widget.ders.quizList[index], ders: widget.ders)));
            },

            title: Text(widget.ders.quizList[index].quizName),

          ),
        ));
  }
}
