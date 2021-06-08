import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/quiz_app/backend/Quiz.dart';
import 'package:untitled1/quiz_app/quiz_ekle.dart';

import 'backend/Ders.dart';

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
        title: Text(widget.ders.getName()),
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
                    context, MaterialPageRoute( builder: (context) => QuizEkle()));
              },
              child: Text(
                "Quiz Ekle",
                style: TextStyle(fontSize: 20),
              ),
              textColor: Colors.white,
              color: Colors.indigo,
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

// DERSİ SİLİNCE QUİZ SİLİNCEKMİ???

  void quizleriGetir() async {
    var fireUser = _auth.currentUser;
    await _fireStore.collection("Users").doc(fireUser.uid).collection("dersler")
        .doc(widget.ders.getName()).collection("quizler").get()
        .then((value) {
      setState(() {
        widget.ders.quizList.clear();
        value.docs.forEach((element) {
          Quiz quiz = new Quiz();
          quiz.quizName = element.id;
          //quiz.time = element['zaman'];
          widget.ders.quizList.add(quiz);
        });
      });
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
              //Navigator.push(context, MaterialPageRoute( builder: (context) => DersPage(ders: widget.teacher.verilenDersler[index])));
            },
            leading: Icon(
              Icons.quiz,
              size: 36,
            ),
            title: Text(widget.ders.quizList[index].quizName),

          ),
        ));
  }

}