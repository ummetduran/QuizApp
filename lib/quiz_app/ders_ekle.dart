import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/async.dart';
import 'package:untitled1/quiz_app/teacher_home_page.dart';

import 'backend/Ders.dart';
import 'backend/Teacher.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
class DersEkle extends StatefulWidget {
  final Teacher teacher;
  const DersEkle({Key key, this.teacher}):super(key: key);
  @override
  _DersEkleState createState() => _DersEkleState();
}
Ders ders;


class _DersEkleState extends State<DersEkle> {
  final formKey = GlobalKey<FormState>();
  //Teacher teacher = TeacherHomePage().teacher;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.cyan.shade600,
        centerTitle: true,
        title: Text("Add Lesson", style: TextStyle(color: Colors.white),),
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
                    labelText: "Lesson Name",

                    labelStyle: TextStyle(color: Colors.cyan.shade600, fontSize: 18),
                    hintStyle: TextStyle(color: Colors.cyan.shade600, fontSize: 18),
                    //suffixStyle: TextStyle(color: Colors.white)

                  ),
                  onChanged: (name) {
                    setState(() {
                      ders = new Ders.empty();
                      ders.name=name;
                      ders.teacher = widget.teacher;
                    });
                  }
                    ),
                    Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    RaisedButton(onPressed: (){

                    dersEkle();
                    Navigator.push(
                        context, MaterialPageRoute( builder: (context) => TeacherHomePage(teacher: widget.teacher,)));

                    },
                      color: Colors.cyan.shade900,
                    child: Text("Save", style: TextStyle(color: Colors.white),),

                    ),
                    SizedBox(width: 15,),
                    RaisedButton(onPressed: (){
                      Navigator.push(
                          context, MaterialPageRoute( builder: (context) => TeacherHomePage(teacher: widget.teacher,)));
                    },

                      color: Colors.grey.shade600,
                      child: Text("Cancel", style: TextStyle(color: Colors.white),),
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


  Future dersEkle() async {
      Map<String, dynamic> dersEkle = Map();

      dersEkle["derskodu"] = ders.key;
      dersEkle["teacherId"] = ders.teacher.id;
      await _fireStore.collection("Users").doc("${widget.teacher.id}").collection("dersler")
          .doc(ders.name).set(dersEkle);
  }


}