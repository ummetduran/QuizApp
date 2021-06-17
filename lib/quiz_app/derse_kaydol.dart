import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/quiz_app/backend/Quiz.dart';
import 'package:untitled1/quiz_app/student_home_page.dart';

import 'backend/Ders.dart';
import 'backend/Question.dart';
import 'backend/Student.dart';


FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class DerseKaydol extends StatefulWidget {

  final Student student;



  const DerseKaydol({Key key, this.student}) : super(key: key);
  @override
  _DerseKaydolState createState() => _DerseKaydolState();
}

Ders ders;

class _DerseKaydolState extends State<DerseKaydol> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        backgroundColor: Color.fromARGB(230, 11, 65, 150),
        centerTitle: true,
        title: Text("Derse Kaydol", style: TextStyle(color: Colors.white),),
      ),

      body: Form(
        child: SingleChildScrollView(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.book_outlined,
                        color: Colors.indigo,
                      ),
                      labelText: "Ders Kodu",
                      hintText: "Ders Kodunu Giriniz",
                      labelStyle: TextStyle(color: Colors.indigo, fontSize: 18),
                      hintStyle: TextStyle(color: Colors.indigo, fontSize: 18),
                      //suffixStyle: TextStyle(color: Colors.white)

                    ),
                    onChanged: (key) {
                      setState(() {
                        ders = new Ders.empty();
                        ders.key = key;
                      });
                    }
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(onPressed: (){

                        kaydol();
                        Navigator.push(
                            context, MaterialPageRoute( builder: (context) => StudentHomePage(student: widget.student)));

                      },
                        child: Text("Kaydol"),

                      ),
                      SizedBox(width: 15,),
                      RaisedButton(onPressed: (){
                        Navigator.push(
                            context, MaterialPageRoute( builder: (context) => StudentHomePage(student: widget.student,)));
                      }
                        ,
                        child: Text("İptal"),
                      ),

                      RaisedButton(onPressed: (){
                        sina();
                      }
                        ,
                        child: Text("Sına"),
                      )

                    ],
                  ),
                )
              ],
            )

        ),
      ),
    );
  }

  void kaydol() async {
    String dersId;
    List<String> dersler = new List();
    QuerySnapshot teachers = await _fireStore.collection("Users").where("userType", isEqualTo: 1).get();
    for(var element in teachers.docs ){
      String userId  = element.id;
      String dersName = await _fireStore.collection("Users").doc(userId).collection("dersler").doc().id.toString();
      dersler.add(dersName);
        var teacherDersler = await _fireStore.collection("Users").doc(userId).collection("dersler")
            .where("derskodu", isEqualTo: ders.key).get();
        for(var element in teacherDersler.docs){
          if(element.exists) dersId = element.id.toString();

        }
        var quizler =  await _fireStore.collection("Users").doc(userId).collection("dersler")
            .doc(dersId).collection("quizler").get();
        for(var element in quizler.docs){
          Quiz quiz = new Quiz();
          quiz.quizName = element.id;
          quiz.time = element.get("zaman");
          var dbQuestions = await _fireStore.collection("Users").doc(userId).collection("dersler")
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
          ders.quizList.add(quiz);
    }//her quiz için
      widget.student.alinanDersler.add(ders);

  }
 }

  void sina() {
    for(var element in ders.quizList){
      print("Quiz Bilgileri: ");
      print(element.toString());
      for(var element2 in element.questions){
        print("SORU BILGILERI");
        print(element2.toString());
      }
    }

  }

}