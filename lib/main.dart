import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.teal,
      accentColor: Colors.black),
      home: new Scaffold(
        appBar: AppBar(
          title: Text(
            "Denemeler",
            style: TextStyle(fontSize: 36, color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          debugPrint("FAB tıklandı");
        },
            backgroundColor: Colors.orange,
        child: Icon(Icons.access_alarms,color:Colors.white,size: 48.0,)
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Center(


            child:Container(
                color:Colors.brown.shade400,
                height: 200.0,
                width: 200.0,
            alignment: Alignment.bottomRight,
            child:Text(
          "Faraşlı İrfan",
          style: TextStyle(
            fontSize: 24,

          ),
          textAlign: TextAlign.center,



        )
        )
        )
      ))
  );
}

