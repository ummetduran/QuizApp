import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:untitled1/quiz_app/model/Question.dart';
import 'package:untitled1/quiz_app/model/Quiz.dart';


import 'model/Ders.dart';
import 'model/Teacher.dart';
import 'ders_page.dart';


FirebaseStorage storage = FirebaseStorage.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class QuizEkle extends StatefulWidget {
  final Teacher teacher;
  final Ders ders;

  const QuizEkle({Key key, this.teacher, this.ders}) : super(key: key);

  @override
  _QuizEkleState createState() => _QuizEkleState();
}

class _QuizEkleState extends State<QuizEkle> {
  String _uplodedFileURL;
  List<Color> list = new List();
  @override
  void initState() {
    // TODO: implement initState
    // ignore: unnecessary_statements
    listele;
    super.initState();

  }
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final imageKey = GlobalKey<FormState>();
  PickedFile _image;
  String dropDownValue = 'Çoktan Seçmeli';
  Quiz quiz = new Quiz();
  Question question;
  //List<String> options;
  bool checked = false;
  int _radioValue = -1;
  //String correctAnswer;
  var colorList = List<Color>();

  @override
  Widget build(BuildContext context) {
    list.add(Colors.amber);
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              Form(
                key: formKey1,
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
                            TextStyle(color: Colors.cyan.shade600, fontSize: 18),
                            hintStyle:
                            TextStyle(color: Colors.cyan.shade600, fontSize: 18)),
                        onChanged: (name) {
                          setState(() {
                            quiz.quizName = name;
                          });
                        },
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
                  /*selectableDayPredicate: (date) {
                    // Disable weekend days to select from the calendar
                    if (date.weekday == 6 || date.weekday == 7) {
                      return false;
                    }

                    return true;
                  },*/
                  onChanged: (startDate) {
                    setState(() {
                      quiz.startDate= startDate;
                      debugPrint("Start Date: "+ startDate);
                    });
                  },
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  onSaved:(startDate) {
                    setState(() {
                      quiz.startDate= startDate;
                      debugPrint("Start Date: "+ startDate);
                    });
                  }
                ),
              ),

              Container(
                width: 150,
                height: 50,
                child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: "Time",
                        labelStyle:
                        TextStyle(color: Colors.cyan.shade600, fontSize: 18),
                        hintStyle:
                        TextStyle(color: Colors.cyan.shade600, fontSize: 18)),
                    onChanged:(quizTime) {
                      setState(() {
                        quiz.time= int.parse(quizTime);
                      });
                    }
                ),
              ),
                  ],
                ),
              ),
              Divider(
                height: 20,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              Form(
                key: formKey2,
                child: Column(
                  children: [
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
                              TextStyle(color: Colors.cyan.shade600, fontSize: 18),
                              hintStyle:
                              TextStyle(color: Colors.cyan.shade600, fontSize: 18)),
                          onChanged: (questionText) {
                            setState(() {
                              question = new Question();
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

                        File(_image.path),
                      //  key: imageKey,
                        fit: BoxFit.fill,
                      )),
                    ),
                    Container(
                      child: FloatingActionButton(
                        onPressed: getImage,
                        backgroundColor: Colors.grey.shade200,
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.cyan.shade600,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  fontSize: 18, color: Colors.cyan.shade600),
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
                    Container(
                      width: 150,
                      height: 50,
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              labelText: "Point",
                              labelStyle:
                              TextStyle(color: Colors.cyan.shade600, fontSize: 18),
                              hintStyle:
                              TextStyle(color: Colors.cyan.shade600, fontSize: 18)),
                          onChanged:(point) {
                            setState(() {
                              question.point = int.parse(point);
                            });
                          }
                      ),
                    )
                  ]),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: questionType(), // SORU TİPİNE GÖRE WİDGET GELCEK
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: RaisedButton(
                  color: Colors.cyan.shade600,
                  onPressed: addQuestion,
                  child: Text("Add Question",style: TextStyle(color: Colors.white),),
                ),
              ),

              Container(
                child: ListView.builder(itemBuilder: listele,
                shrinkWrap: true,
                itemCount: quiz.questions.length,),
              ),

              RaisedButton(onPressed: saveQuiz, child: Text("Save"),)

            ],
          ),
        ),
      ]
    )
    )
    )
    );
  }

  Future<File> getImage() async {
    var image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });

    Reference reference = storage.ref().child(widget.ders.name)
        .child(quiz.quizName)
        .child(question.question)
        .child(_image.path);
   UploadTask uploadTask = reference.putFile(File(_image.path));
   await uploadTask.whenComplete((){
     print("resim eklendi");
   });
   reference.getDownloadURL().then((fileURL) =>{
   setState(() {
   _uplodedFileURL = fileURL;
   print(_uplodedFileURL);
   })
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
                      TextStyle(color: Colors.cyan.shade600, fontSize: 18),
                      hintStyle:
                      TextStyle(color: Colors.cyan.shade600, fontSize: 18)),
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
                        TextStyle(color: Colors.cyan.shade600, fontSize: 18),
                        hintStyle:
                        TextStyle(color: Colors.cyan.shade600, fontSize: 18)),
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
                        TextStyle(color: Colors.cyan.shade600, fontSize: 18),
                        hintStyle:
                        TextStyle(color: Colors.cyan.shade600, fontSize: 18)),
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
                Radio(value: 3, groupValue: _radioValue, onChanged: radioChanged,),
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
                        TextStyle(color: Colors.cyan.shade600, fontSize: 18),
                        hintStyle:
                        TextStyle(color: Colors.cyan.shade600, fontSize: 18)),
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
setState(() {

  question.options.clear();
  question.options.add("True");
  question.options.add("False");
});

      return Padding(
        padding: const EdgeInsets.only(bottom: 20,left: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ToggleSwitch(
            //activeBgColor: [Colors.green],
            labels: ["True", "False"],
            onToggle: (index) {
              question.answer = labels[index];

            }
          ),
          ]
        ),
      );
    }
  }

  Future addQuestion() async {

    Map<String, dynamic> addQuiz = Map();
    addQuiz["zaman"] = quiz.time;
    addQuiz["startDate"] = quiz.startDate;
    await _fireStore.collection("Users").doc("${widget.teacher.id}").collection("dersler")
        .doc(widget.ders.name).collection("quizler").doc("${quiz.quizName}").set(addQuiz);
    Map<String, dynamic> addQuestion = Map();
    addQuestion["question"] = question.question;
    addQuestion["cevaplar"] = question.options;
    addQuestion["point"] = question.point;
    addQuestion["dogruCevap"] = question.answer;
    addQuestion["imagePath"] = _uplodedFileURL;
    await _fireStore.collection("Users").doc("${widget.teacher.id}").collection("dersler")
        .doc(widget.ders.name).collection("quizler").doc("${quiz.quizName}").collection("sorular").doc().set(addQuestion);


    setState(() {
      quiz.questions.add(question);
      formKey2.currentState.reset();
      //   imageKey.currentState.reset();
      _image = null;
      _uplodedFileURL = "";
      _radioValue = -1;
    });
  }

  void saveQuiz(){
    // setState(() {
    // ders.quizList.add(quiz);
    // });
    Navigator.push(
          context, MaterialPageRoute( builder: (context) => DersPage(ders: widget.ders)));

  }


 Widget listele(BuildContext context, int index){

    return Dismissible (
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,

   /*   onDismissed: (direction) async{
       await  _fireStore.collection("Users").doc("${widget.teacher.id}").collection("dersler")
            .doc(widget.ders.getName()).collection("quizler").doc("${quiz.quizName}").collection("sorular").

        setState(() {
          quiz.questions.removeAt(index);
        });
      },*/
      child: Container(
          child: Container(

            decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.all(5),
            child: ListTile(
              onTap: (){
                debugPrint("${quiz.questions[index].question} Basıldı");
                // Navigator.push(
                //     context, MaterialPageRoute( builder: (context) => DersPage(ders: widget.teacher.verilenDersler[index])));
              },
              leading: Icon(
                Icons.done,
                size: 36,

              ),
              title: Text(quiz.questions[index].question),
              trailing: Icon(
                Icons.keyboard_arrow_right,

              ),
            ),
          )
      ),
    );

 }

  void radioChanged(int value) {
    setState(() {
      _radioValue = value;
      question.answer = question.options[_radioValue];
      //correctAnswer = question.options[_radioValue];
    });
    
  }
  
  void getQuestionsFromDB() async{
    var fireUser = _auth.currentUser;
    await _fireStore.collection("Users").doc("${widget.teacher.id}").collection("dersler").
    doc("${widget.ders.name}").collection("quizler").doc("${quiz.quizName}").collection("sorular").get().then((value){
      setState(() {
        value.docs.forEach((element) {
          Question questionFromDB = new Question();
          questionFromDB.question=element.data()["question"];
          questionFromDB.answer= element.data()["dogruCevap"];
          questionFromDB.point = element.data()["point"];
          quiz.questions.add(questionFromDB);


        });

        debugPrint("${quiz.questions[0].question}");

      });
    });
    
  }


  

}
