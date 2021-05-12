import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/quiz_app/ders_ekle.dart';

import 'backend/Ders.dart';
import 'backend/Student.dart';
import 'backend/Teacher.dart';

class TeacherHomePage extends StatefulWidget {
  Student student;

  TeacherHomePage({this.student});

  @override
  _TeacherHomePageState createState() => _TeacherHomePageState(student);
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  final formKey = GlobalKey<FormState>();
  Student student;
  int sayac=0;
  List<Ders> dersler;

  _TeacherHomePageState(this.student);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dersler=[new Ders("mat", new Teacher(1, "t1", "e1"))];
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
                      child: Text("${student.email}",
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
              child:  RaisedButton(onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => DersEkle()));
              },
                
                child: Text("Ders Ekle", style: TextStyle(fontSize: 20),),
                textColor: Colors.white,
                color: Colors.indigo,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)), ),

            ),
          //   ListView.builder(itemBuilder: listeElemaniOlustur,
          // itemCount: dersler.length ,
          // ),
        ]
        ),
      ),
    );
  }

  Widget listeElemaniOlustur(BuildContext context, int index) {
    sayac++;
    return Dismissible(
        key: Key(sayac.toString()),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction){
          dersler.removeAt(index);
        },

        child: Container(

          decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(5),
          child: ListTile(
            leading: Icon(
              Icons.done,
              size: 36,

            ),
            title: Text(dersler[index].name),
            trailing: Icon(
              Icons.keyboard_arrow_right,

            ),
          ),
        ));
  }


}

