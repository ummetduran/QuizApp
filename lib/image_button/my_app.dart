import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/ummet/IdeaProjects/untitled1/lib/image_button/resim_ve_button.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal, accentColor: Colors.black),
        home: new Scaffold(
            appBar: AppBar(
              title: Text(
                "Flutter Dersleri",
                style: TextStyle(fontSize: 36, color: Colors.white),
              ),
            ),
            body: ResimveButton()
        )
    );
  }

}