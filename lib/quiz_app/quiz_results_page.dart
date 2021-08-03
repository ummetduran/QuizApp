
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as P ;
import 'model/Ders.dart';
import 'model/Quiz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

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
  Map<String, int> scoreMap = Map();

  void initState() {
    // TODO: implement initState
    fetchResults();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(
          widget.ders.name.toString() + " Results",
        ),
        backgroundColor: Colors.cyan.shade600,
      
      ),


      body: Container(
        child: Column(
          children: [
            Container(
              child: Expanded(
                child: ListView.builder(itemBuilder: listElementBuilder,
                  itemCount: scoreMap.length ,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 280, bottom: 50),
              child: FloatingActionButton(onPressed: createExcel,
                  backgroundColor: Colors.green,

                  child: Image.asset('assets/images/excel.png',
                    height: 40,
                    width: 40,
                  )
              ),
            )
          ],
        ),
      ),
    );
  }

  Future fetchResults() async {
    scoreMap.clear();
    String email;
    String teacherId = widget.ders.teacher.id;
    String dersId = widget.ders.name;
    String quizName = widget.quiz.quizName;
    var dersler =  await _fireStore.collection("Users").doc(teacherId).collection("dersler")
        .doc(dersId).get();
    var enrolledStudentsMails = dersler.data()["kayitliOgrenciler"];
      for(var element in enrolledStudentsMails){
        email = element.toString();
        QuerySnapshot enrolledStudents = await _fireStore.collection("Users").where("email", isEqualTo: element.toString()).get();
        for(var element in enrolledStudents.docs){
            var studentID = element.id;
            var quiz = await _fireStore.collection("Users").doc(studentID).collection("alinanDersler").doc(dersId)
            .collection("quizler");
            quiz.snapshots().listen((event) {
              for(var element in event.docs) {
              //element.
                if(element.id == quizName){
                  setState(() {
                    scoreMap[email] = element.data()["QuizScore"];
                    print(element.data().toString());
                  });

                }

            }
          });
        }
      }

  }



    Widget listElementBuilder(BuildContext context, int index) {
      return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.all(5),
            child: ListTile(
              onTap: () {
              },

              title: Text(scoreMap.keys.elementAt(index).toString(),
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text("Quiz Score: "+scoreMap.values.elementAt(index).toString(),
                style: TextStyle(color: Colors.black),
              ),


            ),
          ));
    }

  Future<void> createExcel() async {
    final P.Workbook workbook = P.Workbook();
    final P.Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText(widget.quiz.quizName);
    sheet.getRangeByName('A2').setText("Student emails");
    sheet.getRangeByName('B2').setText("Student score");
    int rowIndex = 3;
    int columnIndex = 1;
    int columnIndex2 = 2;
    scoreMap.forEach((key, value) {
      sheet.getRangeByIndex(rowIndex, columnIndex).setText(key);
      sheet.getRangeByIndex(rowIndex, columnIndex2).setText(value.toString());
      rowIndex++;
    });

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();


    //Save and launch the file.
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
      Platform.isWindows ? '$path\\Output.xlsx' : '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      print(fileName);
      OpenFile.open(fileName);
    }
}

