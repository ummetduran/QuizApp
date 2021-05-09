import 'package:flutter/material.dart';
import 'package:untitled1/diger_form_elemanlari/diger_form_elemanlari.dart';

void main(){
  runApp(MaterialApp(
    title: "Flutter Dersleri",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primarySwatch: Colors.orange
    ),
    home: Scaffold(
      body: DigerFormElemanlari(),
    ),
  ));
}