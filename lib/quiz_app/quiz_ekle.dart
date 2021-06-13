import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:untitled1/quiz_app/backend/MultipleChoiceQuestion.dart';
import 'package:untitled1/quiz_app/backend/OpenEndQuestion.dart';
import 'dart:io';

import 'package:untitled1/quiz_app/backend/Question.dart';
import 'package:untitled1/quiz_app/backend/Quiz.dart';
import 'package:untitled1/quiz_app/backend/TrueFalseQuestion.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class QuizEkle extends StatefulWidget {
  @override
  _QuizEkleState createState() => _QuizEkleState();
}

class _QuizEkleState extends State<QuizEkle> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listele();
  }
  final formKey = GlobalKey<FormState>();
  File _image;
  String dropDownValue = 'Çoktan Seçmeli';
  Quiz quiz = new Quiz();
  Question question = new Question();
  //List<String> options;
  bool checked = false;
  int _radioValue = -1;
  String correctAnswer;

  var numberPickerValue=5;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: "Quiz Adı",
                        labelStyle:
                        TextStyle(color: Colors.indigo, fontSize: 18),
                        hintStyle:
                        TextStyle(color: Colors.indigo, fontSize: 18)),
                    onSaved: (name) => quiz.quizName = name,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  child: DateTimePicker(
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'd MMM, yyyy',
                    initialValue: DateTime.now().toString(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event),
                    dateLabelText: 'Gün',
                    timeLabelText: "Saat",
                    selectableDayPredicate: (date) {
                      // Disable weekend days to select from the calendar
                      if (date.weekday == 6 || date.weekday == 7) {
                        return false;
                      }

                      return true;
                    },
                    onChanged: (val) => print(val),
                    validator: (val) {
                      print(val);
                      return null;
                    },
                    onSaved: (val) => print(val),
                  ),
                ),
                Divider(
                  height: 20,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Container(
                    height: 100,
                    child: TextFormField(
                      maxLines: 12,
                      decoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          labelText: "Soruyu yazınız.",
                          labelStyle:
                          TextStyle(color: Colors.indigo, fontSize: 18),
                          hintStyle:
                          TextStyle(color: Colors.indigo, fontSize: 18)),
                      onChanged: (questionText) {
                        setState(() {
                          question.question = questionText;
                        });


                      }
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 250,
                        height: 100,
                        child: _image == null
                            ? Text("")
                            : (Image.file(
                          _image,
                          fit: BoxFit.fill,
                        )),
                      ),
                      Container(
                        child: FloatingActionButton(
                          onPressed: getImage,
                          backgroundColor: Colors.grey.shade200,
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.indigo,
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 135, bottom: 25),
                  child: Row(
                     // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton<String>(
                          icon: Icon(Icons.arrow_downward_sharp),
                          iconSize: 20,
                          elevation: 16,
                          value: dropDownValue,
                          items: <String>[
                            'Çoktan Seçmeli',
                            'Doğru-Yanlış',
                            'Boşluk Doldurma'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.indigo),
                                ));
                          }).toList(),
                          onChanged: (newValue) {
                            {
                              setState(() {
                                this.dropDownValue = newValue;
                               /* if(dropDownValue =="Çoktan Seçmeli")
                                  question = new MultipleChoiceQuestion();
                                else if(dropDownValue == "Doğru-Yanlış")
                                  question = new TrueFalseQuestion();
                                else
                                  question = new OpenEndQuestion();*/
                              });
                            }
                          },
                        ),


                      ]),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: questionType(), // SORU TİPİNE GÖRE WİDGET GELCEK
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: Text("Point", style: TextStyle(fontSize: 24,color: Colors.indigo),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Icon(Icons.arrow_circle_down_outlined, size: 30,color: Colors.indigo,),
                      )
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(bottom: 35),
                  child: NumberPicker(haptics:false, itemCount:7, axis: Axis.horizontal,itemWidth: 50, step:5, minValue: 5, maxValue: 100, value: numberPickerValue, onChanged: (value){
                    setState(() {
                      numberPickerValue = value;
                      question.point = value;
                    });

                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: RaisedButton(
                    onPressed: kaydet,
                    child: Text("Kaydet"),
                  ),
                ),

                Container(
                  child: listele(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<File> getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Widget questionType() {


    if (dropDownValue == 'Çoktan Seçmeli') {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
            children: [
              Radio(value: 0, groupValue: _radioValue, onChanged: radioChanged),
              SizedBox(
                width: 300,
                child: TextFormField(
                  maxLines: 2,
                  decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: "Options 1",
                      labelStyle:
                      TextStyle(color: Colors.indigo, fontSize: 18),
                      hintStyle:
                      TextStyle(color: Colors.indigo, fontSize: 18)),
                  onChanged: (option1) {
              setState(() {
                question.options[0] = option1;
              });
                  }
                ),
              ),
            ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Radio(value: 1, groupValue: _radioValue, onChanged: radioChanged),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    maxLines: 2,
                    decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: "Options 2",
                        labelStyle:
                        TextStyle(color: Colors.indigo, fontSize: 18),
                        hintStyle:
                        TextStyle(color: Colors.indigo, fontSize: 18)),
                      onChanged: (option2) {
                        setState(() {
                          question.options[1] = option2;
                        });
                      }
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Radio(value: 2, groupValue: _radioValue, onChanged: radioChanged),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    maxLines: 2,
                    decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: "Options 3",
                        labelStyle:
                        TextStyle(color: Colors.indigo, fontSize: 18),
                        hintStyle:
                        TextStyle(color: Colors.indigo, fontSize: 18)),
                      onChanged: (option3) {
                        setState(() {
                          question.options[2] = option3;
                        });
                      }
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Radio(value: 3, groupValue: _radioValue, onChanged:(value){
                  debugPrint(value);
                }),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                      maxLines: 2,
                    decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: "Options 4",
                        labelStyle:
                        TextStyle(color: Colors.indigo, fontSize: 18),
                        hintStyle:
                        TextStyle(color: Colors.indigo, fontSize: 18)),
                      onChanged: (option4) {
                        setState(() {
                          question.options[3] = option4;

                        });
                      }
                  ),
                ),
              ],
            ),
          ),




        ],
      );
  }
    else if(dropDownValue == "Doğru-Yanlış"){
      List<String> labels =["True", "False"];
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ToggleSwitch(
            labels: ["True", "False"],
            onToggle: (index) => correctAnswer = labels[index],

          ),
          ]
        ),
      );
    }
  }

  void kaydet() {

    quiz.addElement(question);
    debugPrint("${quiz.questions[0].question}");
    debugPrint("${quiz.questions[0].answer}");
    debugPrint("${quiz.questions[0].options[1]}");

  }

  Widget listele(){

  }

  void radioChanged(int value) {
    setState(() {
      _radioValue = value;
      question.answer = question.options[_radioValue];
      correctAnswer = question.options[_radioValue];
    });


  }
}
