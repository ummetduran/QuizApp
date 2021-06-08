import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagebutton/imagebutton.dart';
import 'dart:io';

class QuizEkle extends StatefulWidget {
  @override
  _QuizEkleState createState() => _QuizEkleState();
}

class _QuizEkleState extends State<QuizEkle> {
  final formKey = GlobalKey<FormState>();
  File _image;

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
                                TextStyle(color: Colors.indigo, fontSize: 18))),
                  ),
                ),
                /*   Container(
                  child: _image == null ? new Text(""): new Container(height:250,child: Image.file(_image))),
                ElevatedButton(onPressed: getImage,child: Text("Bas"),)*/
           /*     RaisedButton(onPressed: getImage,
                child: Image(
                  width: 250,
                    height: 100,
                  image: _image as ImageProvider,

                ),
                ),*/
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: GestureDetector(
                    child: Container(
                      width: 270,
                        height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/images/addImage.jpg"),
                        fit: BoxFit.fill
                        )
                      ),
                    ),
                    onTap: getImage,


                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }
}
