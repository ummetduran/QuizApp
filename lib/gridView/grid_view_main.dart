import 'package:flutter/material.dart';
import 'grid_view.dart';
void main(){
  runApp(MaterialApp(
    title: "Flutter Dersleri",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.orange
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text("GridView Dersleri",
        style: TextStyle(color: Colors.white),),
      ),
      body: GridViewOrnek(),
    ),
  ));
}