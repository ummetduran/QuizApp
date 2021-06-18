import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/quiz_app/ders_ekle.dart';

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

    String teacherId = widget.ders.teacher.id;
    String dersId = widget.ders.name;

    var quizler =  await _fireStore.collection("Users").doc(teacherId).collection("dersler")
        .doc(dersId).collection("quizler").get();
    for(var element in quizler.docs){
      Quiz quiz = new Quiz();
      quiz.quizName = element.id;
      quiz.time = element.get("zaman");
      var dbQuestions = await _fireStore.collection("Users").doc(teacherId).collection("dersler")
          .doc(dersId).collection("quizler").doc(element.id).collection("sorular").get();
      for(var element in dbQuestions.docs){
        Question q = new Question();
        q.question = element.get("question");
        q.answer = element.get("dogruCevap");
        q.point= element.get("point");

        q.options.clear();
        List qOptions = element.get("cevaplar");
        for(var element in qOptions){
          q.options.add(element.toString());
        }//her seçenek için
        quiz.addQuestion(q);
      }//her soru için
      widget.ders.quizList.add(quiz);
    }//her quiz için


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
              //Navigator.push(context, MaterialPageRoute( builder: (context) => DersPage(ders: widget.teacher.verilenDersler[index])));
            },

            title: Text(widget.ders.quizList[index].quizName),

          ),
        ));
  }
}
