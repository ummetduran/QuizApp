import 'package:flutter/material.dart';
import 'package:untitled1/form_ve_textFormField/form_ve_textFormField_ornek.dart';
void main(){
  runApp(MaterialApp(
    title: "Flutter Dersleri",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primarySwatch: Colors.orange
    ),
    home: Scaffold(
      body: FormvetextFormField(),
    ),
  ));
}