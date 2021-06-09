import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagebutton/imagebutton.dart';
import 'dart:io';

import 'package:untitled1/quiz_app/backend/Question.dart';
import 'package:untitled1/quiz_app/backend/Quiz.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class QuizEkle extends StatefulWidget {
  @override
  _QuizEkleState createState() => _QuizEkleState();
}

class _QuizEkleState extends State<QuizEkle> {
  final formKey = GlobalKey<FormState>();
  File _image;
  String dropDownValue = 'Çoktan Seçmeli';
  Quiz quiz = new Quiz();
  Question question;
  String answer;
  int radioGroupValue=0;

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
                  child: Container(
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
                      onSaved: (questionText) =>
                          question.question = questionText,
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
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                              });
                            }
                          },
                        ),
                      ]),
                ),
                Container(
                  child: questionType(), // SORU TİPİNE GÖRE WİDGET GELCEK
                ),
                RaisedButton(
                  onPressed: kaydet,
                  child: Text("Kaydet"),
                )
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
      return Container(
        child: Column(
          children: [
            RadioListTile(
                value: 0 ,
                title: TextFormField(
                  decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: "Option 1",
                      labelStyle:
                      TextStyle(color: Colors.indigo, fontSize: 18),
                      hintStyle:
                      TextStyle(color: Colors.indigo, fontSize: 18)),
                  onSaved: (value) {
                    question.options.add(value);
                  },
                ),
                groupValue: radioGroupValue, onChanged: (value){
                  setState(() {
                    radioGroupValue = value;
                    question.answer = value.toString();

                  });
            }),

            RadioListTile(
                value: 1 ,
                title: TextFormField(
                  decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: "Option 2",
                      labelStyle:
                      TextStyle(color: Colors.indigo, fontSize: 18),
                      hintStyle:
                      TextStyle(color: Colors.indigo, fontSize: 18)),
                  onSaved: (value) {
                    question.options.add(value);

                  },
                ),
                groupValue: radioGroupValue, onChanged: (value){
              setState(() {
                radioGroupValue = value;
                question.answer = answer;

              });
            }),
            RadioListTile(
                value: 2 ,
                title: TextFormField(
                  decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: "Option 3",
                      labelStyle:
                      TextStyle(color: Colors.indigo, fontSize: 18),
                      hintStyle:
                      TextStyle(color: Colors.indigo, fontSize: 18)),
                  onSaved: (value) {
                    question.options.add(value);

                  },
                ),
                groupValue: radioGroupValue, onChanged: (value){
              setState(() {
                radioGroupValue = value;
                question.answer = answer;

              });
            }),

          ],
        ),
      );
    }
  }

  Future kaydet() async {}

  void deneme(int value) {}
}
