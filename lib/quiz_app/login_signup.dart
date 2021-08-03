import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:untitled1/quiz_app/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';


FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;


class LoginSignUp extends StatefulWidget {
  @override
  _LoginSignUpState createState() => _LoginSignUpState();

}

class _LoginSignUpState extends State<LoginSignUp> {
  String fullName, _sifre, _email = "";
  int userType=0;
  List<Color> list = new List();

  final formKey = GlobalKey<FormState>();
  bool otoControl=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    list.add(Colors.cyan.shade600);
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: Text("Quiz App", style: TextStyle(color: Colors.white),),
      ),
      body: Stack(children: [

        Form(
          key: formKey,
          autovalidate: otoControl,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                ClipRRect(
                  child: Image.asset(
                    'assets/images/logo2.png',
                    width: 225,
                    height: 225,
                    color: Colors.cyan.shade900,
                  ),

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ToggleSwitch(
                      dividerColor: Colors.cyan.shade600,
                      minWidth: 100,labels: ["Student", "Teacher"], initialLabelIndex: 0, onToggle: (index){
                        userType = index;
                      },fontSize: 16, totalSwitches: 2, ),
                  ],
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.account_circle,
                        color: Colors.cyan,
                      ),
                      labelText: "Full Name",
                      hintText: "Enter your full name",
                      labelStyle: TextStyle(color: Colors.cyan, fontSize: 18),
                      hintStyle: TextStyle(color: Colors.cyan, fontSize: 18)),
                  validator: _nameControl,
                  onSaved: (deger) => fullName = deger,
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.cyan,
                    ),
                    labelText: "Email",
                    hintText: "Enter your email adress",
                    labelStyle: TextStyle(color: Colors.cyan, fontSize: 18),
                    hintStyle: TextStyle(color: Colors.cyan, fontSize: 18),
                    //suffixStyle: TextStyle(color: Colors.white)
                  ),
                  validator: _emailControl,
                  onSaved: (deger) => _email = deger,
                ),
                SizedBox(height: 20),
                TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.cyan),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.cyan, fontSize: 18),
                      hintStyle: TextStyle(color: Colors.cyan, fontSize: 18),
                    ),
                    validator: (girilenVeri) {
                      if (girilenVeri.length < 6)
                        return "Password must contain minimum 6 characters.";
                    },
                    onSaved: (girilenVeri) => _sifre = girilenVeri),
                SizedBox(height: 60),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 20),
                      ),
                      color: Colors.cyan,
                      textColor: Colors.white,
                      onPressed: () {

                        _girisBilgileriniOnayla();

                      }),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  String _emailControl(String mail) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(mail))
      return "Invalid email";
    else
      return null;
  }

  String _nameControl(String isim) {
    RegExp regex = RegExp("^[a-zA-Z ]+\$");
    if (!regex.hasMatch(isim))
      return "Name cannot contain number.";
    else
      return null;
  }

  Future<User> _girisBilgileriniOnayla() async{

    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try{

        UserCredential _credential = await _auth.createUserWithEmailAndPassword(email: _email, password: _sifre);
        User _newUser= _credential.user;
        await _newUser.sendEmailVerification();




        if(_auth.currentUser!=null){

          Map<String, dynamic> userEkle = Map();
          userEkle['name'] = fullName;
          userEkle['email'] = _email;
          userEkle['userType'] = userType;

          await _fireStore.collection("Users").doc("${_newUser.uid}").set(userEkle).then((value) => debugPrint("$_email eklendi"));


          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignInPage()));}
      }catch(e){
        debugPrint(e.toString());

      }

    }else{
      setState(() {
        otoControl=true;
      });

    }
  }
}