

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'model/Quiz.dart';


FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class QuizCalendar extends StatefulWidget {
  const QuizCalendar({Key key}) : super(key: key);

  @override
  _QuizCalendarState createState() => _QuizCalendarState();
}

List<Quiz> quizList = <Quiz>[];
class _QuizCalendarState extends State<QuizCalendar> {
  @override
  void initState() {
    fetchDate();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.week,
      firstDayOfWeek: 7,
      dataSource: QuizDataSource(getAppointments()),
      onTap: showInfo,

    );
  }


  Future fetchDate() async {
    var dersler = await _fireStore.collection("Users").doc(
        _auth.currentUser.uid).
    collection("alinanDersler").get();

    for (var ders in dersler.docs) {
      var quizler = await _fireStore.collection("Users").doc(
          ders.data()["teacherId"]).collection("dersler")
          .doc(ders.id).collection("quizler");
      quizler.snapshots().listen((event) {
        for (var element in event.docs) {
          Quiz quiz = new Quiz();
          quiz.quizName = element.id;
          quiz.startDate = element.get("startDate");
          quiz.time = element.get("zaman");
          quizList.add(quiz);
        }
      }
      );
    }

  }


  showInfo(CalendarTapDetails details) {
    String quizName="";
      var infoMap = details.appointments;
      infoMap.forEach((element) {

        if(element.toString().contains("subject")) {
          setState(() {
            quizName = element.toString().substring(element.toString().indexOf("subject")+10, element.toString().indexOf("color")-3);
          });
        }
      });
      return showDialog(context: context, builder: (context){

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 200),
          child: AlertDialog(

            title: Text("Quiz Detail"),
            content: Container(
              child: Column(
                children: [
                  Text(quizName, style: TextStyle(fontSize: 25),),
                  SizedBox(height:20),
                  Text(details.date.toString().substring(0,16), style: TextStyle(fontSize: 25),)
                ],
              )

            ),
            actions: <Widget>[RaisedButton(
                onPressed: ()
          {
            Navigator.of(context).pop();
          },
                child: Text("OK")
            )],
          ),
        );

    });


  }
}

List<Appointment> getAppointments() {
  DateFormat dateFormat = DateFormat("yyyy-mm-dd HH:mm");

  List<Appointment> quizes = <Appointment>[];
  for (var quiz in quizList) {
    DateTime quizStartDate = DateTime.parse(quiz.startDate);
    print(quizStartDate);
    DateTime quizEndDate = quizStartDate.add(Duration(minutes: quiz.time));
    quizes.add(Appointment(
        startTime: quizStartDate,
        endTime: quizEndDate,
        subject: quiz.quizName,
      color: Colors.teal.shade600,
      isAllDay: false
    ));

  }
  return quizes;
}

class QuizDataSource extends CalendarDataSource {
  QuizDataSource(List<Appointment> source) {
    appointments = source;
  }
}