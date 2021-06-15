import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/quiz_app/student_home_page.dart';

import 'backend/Ders.dart';
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
    List<String> dersler = new List();
    QuerySnapshot query1 = await _fireStore.collection("Users").where("userType", isEqualTo: 1).get();
    query1.docs.forEach((element) async {
      String userId = element.id;
      dersler.add(await _fireStore.collection("Users").doc(userId).collection("dersler").doc().get().toString());
      dersler.forEach((element) async {
        await _fireStore.collection("Users").doc(userId).collection("dersler").doc(element).get().then((value) {
          debugPrint(value.data().toString());
        });
      });
    });

  }
}
