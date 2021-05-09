import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "MaterialApp Title",
      theme: ThemeData(
          /*textTheme: TextTheme(
            display2: TextStyle(fontSize: 12),
          ),*/
          primarySwatch: Colors.blue),
      home: MyHomePage(title: "My Home page"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String title;
  int sayac = 0;

  MyHomePage({this.title}) {
    debugPrint("MyHomePage Statefull Widget constructor.");
  }

  @override
  State<StatefulWidget> createState() {
    debugPrint("MyHomePage crate state tetiklendi.");
    // TODO: implement createState
    return _MyHomePageState();
  }
}

// _ metodu private yapar !!*
class _MyHomePageState extends State<MyHomePage> {
  MyHomePageState() {
    debugPrint("MyHomePage constructor tetiklendi.");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("MyHomePage build methodu tetiklendi.");
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Arttır"),
              color: Colors.green,
              onPressed: () {
                _sayaciArttir();
              },
            ),
            Text("${widget.sayac}",
                style: Theme.of(context).textTheme.display2.copyWith(
                  color: widget.sayac <=0 ? Colors.red : Colors.green
                )),
            RaisedButton(
              child: Text("Azalt"),
              color: Colors.red,
              onPressed: () {
                _sayaciAzalt();
              },
            )
          ],
        ),
      ),
    );
  }

  void _sayaciArttir() {
    setState(() {
      widget.sayac++;
      debugPrint("Sayac değeri :  ${widget.sayac}");
    });

  }

  void _sayaciAzalt() {
    setState(() {
      widget.sayac--;
      debugPrint("Sayac değeri :  ${widget.sayac}");
    });

  }
}
