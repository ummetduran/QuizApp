import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/quiz_app/home_page.dart';
import 'package:untitled1/quiz_app/login_signup.dart';
import 'package:untitled1/quiz_app/teacher_home_page.dart';

import 'backend/Student.dart';


FirebaseAuth _auth = FirebaseAuth.instance;
class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  Student student;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/solid-color-1.jpg'),
                  fit: BoxFit.cover
              ),
            ),
          ),
          SingleChildScrollView(
            child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        //borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/logo2.png', width: 225, height: 225,),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail),
                          labelText: "Email",
                          labelStyle: TextStyle(fontSize: 20)

                        ),
                        onChanged: (mail) => _email = mail,

                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: "Password",
                            labelStyle: TextStyle(fontSize: 20)
                        ),
                        onSaved: (sifre) => password = sifre,

                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 160, top: 15),
                        child: err,
                      ),
                      Padding(

                        padding: const EdgeInsets.only(top: 10,right: 160),
                        child: TextButton(onPressed: (){
                          _resetPassword();
                        }, child: Text("Forgot my password", style: TextStyle(decoration: TextDecoration.underline)),),
                      ),
                      SizedBox(height: 25,),
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: RaisedButton(onPressed: () {
                          _girisYap();
                        },

                            child: Text("Sign In", style: TextStyle(fontSize: 20),),
                            textColor: Colors.white,
                            color: Colors.indigo,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)), ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TextButton(onPressed: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => LoginSignUp()));
                        }, child: Text("If you are not registered tap here to sign up")),
                      ),


                    
                    ],
                  ),
                )


            ),
          )
        ],
      ),

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
          student= new Student(1, "sds", _email);
          Navigator.push(
              context, MaterialPageRoute( builder: (context) => TeacherHomePage(student: student)));
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
