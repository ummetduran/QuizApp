
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/quiz_app/login_signup.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:untitled1/quiz_app/sign_in.dart';

void main()async{

  runApp(MaterialApp(

    //initialRoute: '/SignIn',
    title: "Stepper Örnek",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primarySwatch: Colors.indigo
    ),
    routes: {
      '/SignIn' :(context) => SignInPage(),

    },
    home: Scaffold(
        resizeToAvoidBottomInset: false,

        appBar: AppBar(

          backgroundColor: Color.fromARGB(230, 11, 65, 150),
          centerTitle: true,
          title: Text("Quiz App", style: TextStyle(color: Colors.white),),
        ),

      body: SignInPage()
    ),
  ));
}