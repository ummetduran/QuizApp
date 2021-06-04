import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/quiz_app/teacher_home_page.dart';

import 'backend/Ders.dart';
import 'backend/Teacher.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
class DersEkle extends StatefulWidget {

  @override
  _DersEkleState createState() => _DersEkleState();
}
 Ders ders;

class _DersEkleState extends State<DersEkle> {
  final formKey = GlobalKey<FormState>();
  Teacher teacher = TeacherHomePage().teacher;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Color.fromARGB(230, 11, 65, 150),
        centerTitle: true,
        title: Text("Ders Ekle", style: TextStyle(color: Colors.white),),
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
                    labelText: "Ders Adı",
                    hintText: "Ders Adını Giriniz",
                    labelStyle: TextStyle(color: Colors.indigo, fontSize: 18),
                    hintStyle: TextStyle(color: Colors.indigo, fontSize: 18),
                    //suffixStyle: TextStyle(color: Colors.white)

                  ),
                  onSaved: (name) => ders = new Ders(name, teacher)

                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(onPressed: (){

                          dersEkle();

                      },
                        child: Text("Kaydet"),

                      ),
                      SizedBox(width: 15,),
                      RaisedButton(onPressed: (){

                      },
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

  Future dersEkle() async {
    debugPrint(ders.name.toString());
    if(formKey.currentState.validate()) {
      formKey.currentState.save();
      //var fireUser = _auth.currentUser;
      //Map<String, dynamic> dersEkle = Map();
      //dersEkle['dersler'] = ders.name;
      List<String> list = new List<String>();
      list.add("${ders.name}");
      //Users _user = Users(int.parse(_newUser.uid), fullName, _newUser.email);
      await _fireStore.collection("Users").doc("${ders.teacher.id}").update(
          {'dersler': FieldValue.arrayUnion(list)});
//    await _fireStore.collection("Users").doc("${ders.teacher.id}").set('dersler': ).then((value) => debugPrint("eklendi"));
      // await _fireStore.collection("Users").doc("${_newUser.uid}").collection("dersler").add(dersEkle);

    }
  }


}