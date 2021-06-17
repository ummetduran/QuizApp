import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/quiz_app/backend/Teacher.dart';
import 'package:untitled1/quiz_app/home_page.dart';
import 'package:untitled1/quiz_app/login_signup.dart';
import 'package:untitled1/quiz_app/student_home_page.dart';
import 'package:untitled1/quiz_app/teacher_home_page.dart';

import 'backend/Student.dart';
import 'backend/Users.dart';


FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class SignInPage extends StatefulWidget {

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  static int userType;
  Users signInUser;
  String _email, password;
  Widget err = Text("");
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
/*    _auth.authStateChanges().listen((User user){
      if(user==null)
        print("Kullanııc oturumu kapatıı");
      else
        print("Kullanıcı oturum açtı");
    });*/
  }
  @override  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(

            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [
                      Colors.cyan[400],
                      Colors.cyan[800],
                      Colors.cyan[400]
                    ]
                )
            ),
            child: Form( key: formKey,
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 80,),
                  Padding(padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Login",
                          style: TextStyle(color: Colors.white, fontSize: 40),),
                        SizedBox(height: 10,),
                        Text("Welcome to QuizApp!",
                          style: TextStyle(color: Colors.white, fontSize: 18),),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60))
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(20),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 60,),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [BoxShadow(
                                          color: Colors.cyan,
                                          blurRadius: 20,
                                          offset: Offset(0, 2)
                                      )
                                      ]
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(
                                                color: Colors.grey[200]))
                                        ),
                                        child: TextFormField(
                                          keyboardType: TextInputType.emailAddress,
                                          decoration: InputDecoration(

                                              hintText: "Email",
                                              labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                                              border: InputBorder.none
                                          ),
                                          onChanged: (mail) => _email = mail,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(
                                                color: Colors.grey[200]))
                                        ),
                                        child: TextFormField(
                                          obscureText: true,
                                          decoration: InputDecoration(

                                              hintText: "Password",
                                              labelStyle: TextStyle(
                                                  color: Colors.grey,fontSize: 20),
                                              border: InputBorder.none
                                          ),
                                          onSaved: (sifre) => password = sifre,
                                        ),

                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 40,),
                                Padding(

                                  padding: const EdgeInsets.only(),
                                  child: TextButton(onPressed: () {
                                    _resetPassword();
                                  }, child: Text("Forgot password?",
                                      style: TextStyle(color: Colors.grey)),),
                                ),


                                SizedBox(height: 40,),
                                Container(


                                  height: 50,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.cyan[900]
                                  ),
                                  child: TextButton(onPressed: () {
                                    _girisYap();
                                  },

                                    child: Text("Login", style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),),

                                  ),
                                ),
                                SizedBox(height: 40,),
                                Container(

                                  height: 50,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.cyan[600]
                                  ),
                                  child: TextButton(onPressed: () {
                                    Navigator.push(
                                        context, MaterialPageRoute(
                                        builder: (context) => LoginSignUp()));
                                  },

                                    child: Text("Signup", style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),),

                                  ),
                                ),

                              ],
                            ),
                          )


                      ),
                    ),
                  )
                ],
              ),
            )
        )
    );
  }





  void _girisYap() async{
    if(formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        await Firebase.initializeApp();
        User user= (await _auth.signInWithEmailAndPassword(
            email: _email, password: password)).user;

        if(user.emailVerified){
          debugPrint("Email onaylı");


          String name;
          var fireUser= _auth.currentUser;
          await _fireStore.collection("Users").doc(fireUser.uid).get().then((value){
            debugPrint("${value.data()["userType"]}");

            userType=value.data()["userType"];
            name = value.data()["name"];


            debugPrint("${value.data()["name"]}");
            debugPrint(name);
            debugPrint("$userType");

          });
          if(userType == 0){
            signInUser = new Student(user.uid, name, _email);
            Navigator.push(
                context, MaterialPageRoute( builder: (context) => StudentHomePage(student: signInUser)));
          }
          else{
            signInUser = new Teacher(user.uid, name, _email);
            Navigator.push(
                context, MaterialPageRoute( builder: (context) => TeacherHomePage(teacher: signInUser)));
          }


        }else{
          debugPrint("Lütfen emailinizi onaylayınız");
          _auth.signOut();
        }

      } catch (e) {
        setState(() {
          err=Text("Kullanıcı bulunamadı!", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15),);
        });

        debugPrint("********** HATA *********");

        debugPrint(e.toString());
      }
    }
  }

  void _resetPassword() async {
    await Firebase.initializeApp();
    try{
      await _auth.sendPasswordResetEmail(email: _email);
      debugPrint("Resetleme maili gönderildi.");
    }catch(e){
      debugPrint("Şifre resetlenirken hata $e");

    }

  }


}
