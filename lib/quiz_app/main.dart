
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/quiz_app/login_signup.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:untitled1/quiz_app/sign_in.dart';

void main()async{

  runApp(MaterialApp(

    //initialRoute: '/SignIn',

    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primarySwatch: Colors.indigo
    ),
    routes: {
      '/SignIn' :(context) => SignInPage(),

    },
    home: Scaffold(
        resizeToAvoidBottomInset: false,



      body: SignInPage()
    ),
  ));
}