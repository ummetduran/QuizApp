import 'package:flutter/material.dart';
import 'package:untitled1/Date_islemleri/date_time_picker.dart';
import 'package:untitled1/Stepper/stepper_kullanimi.dart';


void main(){
  runApp(MaterialApp(
    title: "Stepper Örnek",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primarySwatch: Colors.orange
    ),
    home: Scaffold(
      body: StepperOrnek(),
    ),
  ));
}