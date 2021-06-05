import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/quiz_app/ders_ekle.dart';

import 'backend/Ders.dart';

import 'backend/Teacher.dart';

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
  final formKey = GlobalKey<FormState>();

  int sayac = 0;
  List<String> dersler = <String>[];

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
        title: Text("Home Page"),
      ),
      drawer: Container(
        width: 250,
        child: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.indigo),
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

                  child: Text("Ders Ekle", style: TextStyle(fontSize: 20),),
                  textColor: Colors.white,
                  color: Colors.indigo,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),),

              ),
                Container(
                  child: Expanded(
                    child: ListView.builder(itemBuilder: listeElemaniOlustur,
              itemCount: dersler.length ,
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
    await _fireStore.collection("Users").doc(fireUser.uid).get().then((value) {
      setState(() {
        dersler = List.from(value['dersler']);
      });

      debugPrint("${dersler}");

    });
  }


 Widget listeElemaniOlustur(BuildContext context, int index) {
    sayac++;
    return Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.startToEnd,

        onDismissed: (direction){

  //SİLERKEN İNDEXLERİ KONTROL ET
       var val =[];
       val.add(dersler[index]);
       _fireStore.collection("Users").doc(_auth.currentUser.uid).update({
         'dersler' : FieldValue.arrayRemove(val)
       });
       setState(() {
         dersler.removeAt(index);

       });
        },

        child: Container(

          decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.all(5),
          child: ListTile(
            leading: Icon(
              Icons.done,
              size: 36,

            ),
            title: Text(dersler[index]),
            trailing: Icon(
              Icons.keyboard_arrow_right,

            ),
          ),
        ));
  }


}