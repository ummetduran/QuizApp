import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/quiz_app/model/Quiz.dart';
import 'package:untitled1/quiz_app/model/Teacher.dart';
import 'package:untitled1/quiz_app/student_home_page.dart';

import 'model/Ders.dart';
import 'model/Question.dart';
import 'model/Student.dart';


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

        backgroundColor: Colors.cyan.shade600,
        centerTitle: true,
        title: Text("Enroll the Lesson", style: TextStyle(color: Colors.white),),
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
                        color: Colors.cyan.shade600,
                      ),
                      labelText: "Lesson Code",
                      hintText: "Enter Lesson Code",
                      labelStyle: TextStyle(color: Colors.cyan.shade600, fontSize: 18),
                      hintStyle: TextStyle(color: Colors.cyan.shade600, fontSize: 18),
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
                        child: Text("Enroll"),

                      ),
                      SizedBox(width: 15,),
                      RaisedButton(onPressed: (){
                        Navigator.push(
                            context, MaterialPageRoute( builder: (context) => StudentHomePage(student: widget.student,)));
                      }
                        ,
                        child: Text("Cancel"),
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
        var liste = dersDb.data()["kayitliOgrenciler"];
        if (liste != null) {
          for (var element in dersDb.data()["kayitliOgrenciler"]) {
            ogrEkle.add(element);
          }
        }



        //map["derkodu"] = widget.ders.kodu
        map["kayitliOgrenciler"] = ogrEkle;
        await _fireStore.collection("Users").doc(userId)
            .collection("dersler")
            .doc(dersId)
            .update(map);
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