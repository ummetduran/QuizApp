import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'model/Ders.dart';
import 'model/Quiz.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class QuizResultsPage extends StatefulWidget {
  final Quiz quiz;
  final Ders ders;

  const QuizResultsPage({Key key, this.quiz, this.ders}) : super(key: key);
  @override
  _QuizResultsPageState createState() => _QuizResultsPageState();
}

class _QuizResultsPageState extends State<QuizResultsPage> {

  void initState() {
    // TODO: implement initState
    fetchResults();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void fetchResults() async {
    /*var fireUser = _auth.currentUser;
    var className  =await _fireStore.collection("Users").doc(fireUser.uid)
        .collection("dersler").doc("${widget.ders.name}").get();
    var enrolledStudents = className.get("kayitliOgrenciler");
    for(String e in enrolledStudents){
      var data  =await _fireStore.collection("Users").doc()
          .collection("alinanDersler").where("derkodu" == widget.ders.key).get();
      print(data.toString());
    }


  */}
}

