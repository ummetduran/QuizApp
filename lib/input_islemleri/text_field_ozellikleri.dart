import 'package:flutter/material.dart';

class TextFieldIslemleri extends StatefulWidget {
  @override
  _TextFieldIslemleriState createState() => _TextFieldIslemleriState();
}

class _TextFieldIslemleriState extends State<TextFieldIslemleri> {
  String girilenMetin = "";
  FocusNode _fnode;
  int maxLine = 1;
  TextEditingController textController1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fnode = FocusNode();
    textController1 = TextEditingController(text: "varsayılan");

    _fnode.addListener(() {
      setState(() {
        if (_fnode.hasFocus) {
          maxLine = 3;
        } else {
          maxLine = 1;
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fnode.dispose();
    textController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Input Işlemleri"),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget> [
            Container(
              width: 24,
              height: 24,
              child: FloatingActionButton(
                heroTag: "cc",
                onPressed: () {
                  FocusScope.of(context).requestFocus(_fnode);
                },
                child: Icon(Icons.edit, size: 12,),
                backgroundColor: Colors.cyan,
              ),
            ),
            SizedBox(height: 10,),
            FloatingActionButton(
              heroTag: "bb",
              onPressed: () {
                textController1.text="Butondan geldim";
              },
              child: Icon(Icons.edit),
              mini: true,

              backgroundColor: Colors.yellow,
            ),
            SizedBox(height: 10,),


            FloatingActionButton(
              heroTag: "aa",
              onPressed: () {
                debugPrint(textController1.text);

              },
              child: Icon(Icons.edit),
              backgroundColor: Colors.purple,
            ),
            SizedBox(height: 10,)
          ],
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              autofocus: false,
              maxLines: maxLine,
              controller: textController1,
              maxLength: 20,
              focusNode: _fnode,
              decoration: InputDecoration(
                hintText: "Metni Buraya Yazın",
                labelText: "Başlık",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                icon: Icon(Icons.edit),
                prefixIcon: Icon(Icons.done),
                suffixIcon: Icon(Icons.add),
                filled: true,
                fillColor: Colors.red.shade50,
              ),
              maxLengthEnforced: true,
              onChanged: (s) => debugPrint("On Change: $s"),
              onSubmitted: (s) {
                debugPrint("On Submit: $s");
                girilenMetin = s;
              },
              cursorColor: Colors.yellow,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              autofocus: false,
              maxLines: 1,
              maxLength: 20,
              decoration: InputDecoration(
                hintText: "Metni Buraya Yazın",
                labelText: "Başlık",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                icon: Icon(Icons.edit),
                prefixIcon: Icon(Icons.done),
                suffixIcon: Icon(Icons.add),
                filled: true,
                fillColor: Colors.red.shade50,
              ),
              maxLengthEnforced: true,
              onChanged: (s) => debugPrint("On Change: $s"),
              onSubmitted: (s) {
                debugPrint("On Submit: $s");
                girilenMetin = s;
              },
              cursorColor: Colors.yellow,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            height: 200,
            color: Colors.teal.shade400,
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  girilenMetin,
                  style: TextStyle(color: Colors.red),
                )),
          ),
        ]));
  }
}
