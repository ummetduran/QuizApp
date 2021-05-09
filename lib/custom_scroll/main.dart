import 'package:flutter/material.dart';
import 'custom_scroll_ve_slivers.dart';

void main(){
  runApp(MaterialApp(
    title: "Flutter Dersleri",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.orange
    ),
    home: Scaffold(
      body: CollapsableToolBarOrnek(),
    ),
  ));
}