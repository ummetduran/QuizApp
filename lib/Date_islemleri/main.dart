import 'package:flutter/material.dart';
import 'package:untitled1/Date_islemleri/date_time_picker.dart';


void main(){
  runApp(MaterialApp(
    title: "Flutter Dersleri",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primarySwatch: Colors.orange
    ),
    home: Scaffold(
      body: TarihSaatOrnekState(),
    ),
  ));
}