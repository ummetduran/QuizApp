
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/quiz_app/sign_in.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

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
    );
  }
}