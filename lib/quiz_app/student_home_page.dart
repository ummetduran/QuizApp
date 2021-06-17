import 'package:flutter/material.dart';
import 'package:untitled1/quiz_app/backend/Student.dart';
import 'package:untitled1/quiz_app/derse_kaydol.dart';

class StudentHomePage extends StatefulWidget {

  Student student;
  StudentHomePage({this.student});
  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
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
                color: Colors.indigo,
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

  Widget listeElemaniOlustur(BuildContext context, int index) {

    return Container(

      decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.all(5),
      child: ListTile(
        onTap: (){
          debugPrint("${widget.student.alinanDersler[index]} Basıldı");
          //Navigator.push(context, MaterialPageRoute( builder: (context) => DersPage(ders: widget.teacher.verilenDersler[index])));
        },
        leading: Icon(
          Icons.done,
          size: 36,

        ),
        title:  Text(widget.student.alinanDersler[index].getName()),
        //subtitle: Text(widget.student.alinanDersler[index].key.toString()),

        trailing: Icon(
          Icons.keyboard_arrow_right,

        ),
      ),
    );
  }

}
