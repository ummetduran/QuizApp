import 'package:flutter/cupertino.dart';
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
                    child: TextFormField(validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Lütfen soruyu yazmayı unutmayınız!";
                      }
                      return null;
                    },

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

               Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                    SizedBox(
                      width: 250,
                      height: 100,
                      child:  _image ==null ? Text("") : (Image.file(_image, fit: BoxFit.fill,)),
                    ),
                     Container(

                       child: FloatingActionButton(onPressed: getImage,
                        child: Icon(Icons.add_a_photo),

                       ),
                     ),
                   ],
                 ),
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
}
