import 'package:flutter/material.dart';
import 'file:///C:/Users/ummet/IdeaProjects/untitled1/lib/etkin_liste/etkin_liste.dart';

void main() {
  runApp(MaterialApp(
      title: "Flutter dersleri",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.orange
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Liste Dersleri", style: TextStyle(color: Colors.white),)),
        //body: EtkinListeOrnek(),
      )
  ));
}