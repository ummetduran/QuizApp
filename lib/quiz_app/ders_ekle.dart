import 'package:flutter/material.dart';

import 'backend/Ders.dart';


class DersEkle extends StatefulWidget {
  @override
  _DersEkleState createState() => _DersEkleState();
}

class _DersEkleState extends State<DersEkle> {
  final formKey = GlobalKey<FormState>();
  Ders ders;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Color.fromARGB(230, 11, 65, 150),
        centerTitle: true,
        title: Text("Ders Ekle", style: TextStyle(color: Colors.white),),
      ),
      body: Form(
        child: SingleChildScrollView(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.book_outlined,
                      color: Colors.indigo,
                    ),
                    labelText: "Ders Adı",
                    hintText: "Ders Adını Giriniz",
                    labelStyle: TextStyle(color: Colors.indigo, fontSize: 18),
                    hintStyle: TextStyle(color: Colors.indigo, fontSize: 18),
                    //suffixStyle: TextStyle(color: Colors.white)

                  ),
                  onChanged: (name){
                    ders.name= name;
                  },

                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(onPressed: (){

                      },
                        child: Text("Kaydet"),

                      ),
                      SizedBox(width: 15,),
                      RaisedButton(onPressed: (){

                      },
                        child: Text("İptal"),
                      )
                    ],
                  ),
                )
              ],
            )

        ),
      ),
    );
  }


}