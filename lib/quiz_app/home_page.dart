import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'backend/Student.dart';

class HomePage extends StatefulWidget {
  Student student;

  HomePage({this.student});

  @override
  _HomePageState createState() => _HomePageState(student);
}

class _HomePageState extends State<HomePage> {
  Student student;

  _HomePageState(this.student);

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
      body: Stack(
        children: [ GestureDetector(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [

              Container(
                height: 100,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.blue,
                  elevation: 30,
                  child: ListTile(
                    title: Text("asdsdas"),
                  ),
                ),
              ),
              Container(
                height: 100,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.blue,
                  elevation: 30,
                  child: ListTile(
                    title: Text("asdsdas"),
                  ),
                ),
              ),   Container(
                height: 100,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.blue,
                  elevation: 30,
                  child: ListTile(
                    title: Text("asdsdas"),
                  ),
                ),
              ),   Container(
                height: 100,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.blue,
                  elevation: 30,
                  child: ListTile(
                    title: Text("asdsdas"),
                  ),
                ),
              ),   Container(
                height: 100,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.blue,
                  elevation: 30,
                  child: ListTile(
                    title: Text("asdsdas"),
                  ),
                ),
              ),

            ],
          ),
          onTap: () {
            debugPrint("adsds");
          },
        ),
          Container(

            padding: EdgeInsets.only(top: 580, left: 100),
            child: Row(
              children: [
                RaisedButton(onPressed: (){},
                  
                  child: Text("Ders Ekle", style: TextStyle(fontSize: 20),),
                  textColor: Colors.white,
                  color: Colors.indigo,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
                SizedBox(width: 10,),
                RaisedButton(onPressed: (){},
                  child: Text("Ders Sil", style: TextStyle(fontSize: 20),),
                  textColor: Colors.white,
                  color: Colors.indigo,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
              ],
            ),
          )
    ]

      ),
    );
  }
}
