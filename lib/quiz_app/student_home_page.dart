import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/quiz_app/backend/Student.dart';
import 'package:untitled1/quiz_app/backend/Teacher.dart';
import 'package:untitled1/quiz_app/derse_kaydol.dart';
import 'package:untitled1/quiz_app/student_ders_page.dart';

import 'backend/Ders.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
class StudentHomePage extends StatefulWidget {

  final Student student;

  const StudentHomePage({Key key, this.student, Ders ders}) : super(key: key);
  @override
  _StudentHomePageState createState() => _StudentHomePageState(student);
}


class _StudentHomePageState extends State<StudentHomePage> {
  Student student;

  _StudentHomePageState(this.student);

  @override
  void initState() {
    // TODO: implement initState
    dersleriGetir();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade600,
        title: Text("Home Page"),
      ),
      drawer: Container(
        width: 250,
        child: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.cyan.shade600),
                child: Column(
                  children: [
                    ClipRRect(
                      //borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/logo2.png',
                        width: 110,
                        height: 110,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text("${widget.student.email}",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text("İtem1"),
                onTap: () {},
              ),
              ListTile(
                title: Text("İtem2"),
              )
            ],
          ),
        ),
      ),

      body: Container(
        child: Column(
          children: [
            Container(
              height: 65,
              width: 700,
              margin: EdgeInsets.all(10),
              child: RaisedButton(

                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DerseKaydol(student: widget.student)));
                },

                child: Text("Derse Kaydol", style: TextStyle(fontSize: 20),),
                textColor: Colors.white,
                color: Colors.cyan.shade600,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),),

            ),

            Container(
              child: Expanded(
                child: ListView.builder(itemBuilder: listeElemaniOlustur,
                  itemCount: widget.student.alinanDersler.length ,
                ),
              ),
            ),

          ],

        ),
      ),
    );
  }

  Future dersleriGetir() async {

    var fireUser = _auth.currentUser;
    var ref = await _fireStore.collection("Users").doc(fireUser.uid).collection("alinanDersler");
    ref.snapshots().listen((event) {
      widget.student.alinanDersler.clear();

      for( var element in event.docs){
        Ders ders = new Ders.empty();
        ders.key=element.data()["derskodu"];
        ders.name = element.id;
        ders.teacher = new Teacher.empty();
        ders.teacher.id = element.data()["teacherId"];
        //Buradan student Ders page E dersin teachri bilgisi gönderilcecek galiba
        setState(() {
          widget.student.alinanDersler.add(ders);
        });
      };

    });



      //debugPrint("${widget.student.alinanDersler.first.getName()}");

  }


  Widget listeElemaniOlustur(BuildContext context, int index) {

    return Container(

      decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.all(5),
      child: ListTile(
        onTap: (){
          debugPrint("${widget.student.alinanDersler[index].name} Basıldı");
          Navigator.push(context, MaterialPageRoute( builder: (context) => StudentDersPage(ders: widget.student.alinanDersler[index])));
        },
        leading: Icon(
          Icons.done,
          size: 36,

        ),
        title:  Text(widget.student.alinanDersler[index].name),
        //subtitle: Text(widget.student.alinanDersler[index].key.toString()),

        trailing: Icon(
          Icons.keyboard_arrow_right,

        ),
      ),
    );
  }

}
