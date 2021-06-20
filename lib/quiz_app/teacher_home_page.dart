import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/quiz_app/ders_ekle.dart';

import 'backend/Ders.dart';

import 'backend/Teacher.dart';
import 'ders_page.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class TeacherHomePage extends StatefulWidget {
  final Teacher teacher;

   const TeacherHomePage({Key key, this.teacher}): super(key: key);

  @override
  _TeacherHomePageState createState() => _TeacherHomePageState(teacher);
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  Teacher teacher;



  _TeacherHomePageState(this.teacher);


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
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text("${widget.teacher.email}",
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
                        MaterialPageRoute(builder: (context) => DersEkle(teacher: widget.teacher)));
                  },

                  child: Text("Add Lesson", style: TextStyle(fontSize: 20),),
                  textColor: Colors.white,
                  color: Colors.cyan.shade600,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),),

              ),
                Container(
                  child: Expanded(
                    child: ListView.builder(itemBuilder: listeElemaniOlustur,
              itemCount: widget.teacher.verilenDersler.length ,
              ),
                  ),
                ),

            ]
        ),
      ),
    );
  }


  void dersleriGetir() async {

    var fireUser = _auth.currentUser;
    var teacherDb = await _fireStore.collection("Users").doc(fireUser.uid).get();

    await _fireStore.collection("Users").doc(fireUser.uid).collection("dersler").get().then((value) {
      setState(() {
        widget.teacher.name = teacherDb.get("name");
        widget.teacher.email = teacherDb.get("email");
        widget.teacher.id = teacherDb.id;
        widget.teacher.verilenDersler.clear();
        for(var element in value.docs) {
          Ders ders = new Ders.empty();
          ders.key=element.data()["derskodu"];
          ders.name = element.id;
          ders.teacher=widget.teacher;
          widget.teacher.verilenDersler.add(ders);
        };

      });
      debugPrint("${widget.teacher.verilenDersler.first.name}");
    });
  }


 Widget listeElemaniOlustur(BuildContext context, int index) {

    return Dismissible(

        key: UniqueKey(),
        direction: DismissDirection.startToEnd,

        onDismissed: (direction)  {
  //SİLERKEN İNDEXLERİ KONTROL ET
       _fireStore.collection("Users").doc("${widget.teacher.id}").collection("dersler")
           .doc(widget.teacher.verilenDersler[index].name).delete();
       setState(() {
         widget.teacher.verilenDersler.removeAt(index);
       });
        },

        child: Container(

          decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.all(5),
          child: ListTile(
            onTap: (){
              debugPrint("${widget.teacher.verilenDersler[index]} Basıldı");
              Navigator.push(
                  context, MaterialPageRoute( builder: (context) => DersPage(ders: widget.teacher.verilenDersler[index])));
            },
            leading: Icon(
              Icons.done,
              size: 36,

            ),
            title:  Text(widget.teacher.verilenDersler[index].name),
            subtitle: Text(widget.teacher.verilenDersler[index].key.toString()),

            trailing: Icon(
              Icons.keyboard_arrow_right,

            ),
          ),
        ));
  }


}