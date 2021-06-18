import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/quiz_app/backend/Quiz.dart';
import 'package:untitled1/quiz_app/backend/Teacher.dart';
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

                    ],
                  ),
                )
              ],
            )

        ),
      ),
    );
  }

  Future kaydol() async {
    Teacher teacher = new Teacher.empty();

    String dersId;
    List<String> dersler = new List();
    QuerySnapshot teachers = await _fireStore.collection("Users").where("userType", isEqualTo: 1).get();
    String userId;
    for(var element in teachers.docs ) {
      userId = element.id;
      print(userId);
      teacher.id = element.id.toString();
      String dersName = await _fireStore
          .collection("Users")
          .doc(userId)
          .collection("dersler")
          .doc()
          .id
          .toString();
      dersler.add(dersName);
      var teacherDersler = await _fireStore.collection("Users").doc(userId)
          .collection("dersler")
          .where("derskodu", isEqualTo: ders.key)
          .get();

      for (var elementTD in teacherDersler.docs) {
        if (elementTD.exists) dersId = elementTD.id.toString();
        await _fireStore.collection("Users").doc(userId).get().then((value) {
          //teacher.id=userId.toString();
          teacher.name = value.data()["name"];
          teacher.email = value.data()["email"];
          ders.teacher = teacher;
          //widget.student.alinanDersler.add(ders);

        });


        await useraDersEkle(dersId);

        List ogrEkle = List();
        ogrEkle.add(widget.student.email);
        Map<String, List> map = new Map();

        var dersDb = await _fireStore.collection("Users").doc(userId)
            .collection("dersler")
            .doc(dersId)
            .get();
        for(var element in dersDb.data()["kayitliOgrenciler"]){
          ogrEkle.add(element);
        }
        map["kayitliOgrenciler"] = ogrEkle;
        _fireStore.collection("Users").doc(userId)
            .collection("dersler")
            .doc(dersId)
            .set(map);
      }
    }
 }

  Future useraDersEkle(String dersId) async{
    Map<String, dynamic> dersEkle = Map();
    dersEkle["teacherId"] = ders.teacher.id;
    dersEkle["derskodu"] = ders.key;
    await _fireStore.collection("Users").doc(widget.student.id).collection("alinanDersler").doc(dersId).set(dersEkle);

  }

}