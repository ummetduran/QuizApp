import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResimveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Resim ve Buton Türleri",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          IntrinsicHeight(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(4),
                        color: Colors.red.shade200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceEvenly,
                          children: <Widget>[
                            Image.asset("assets/images/lena.jpg"),
                            Text("Asset Image")
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.red.shade200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceEvenly,
                          children: <Widget>[
                            FadeInImage.assetNetwork(
                                placeholder: "assets/images/loading.gif",
                                image:
                                "https://bringatrailer.com/wp-content/uploads/2020/01/2012_mercedes-benz_s350_bluetech_diesel_4matic_1577906060cd20849fullsizeoutput_8000-e1578096621274.jpeg?fit=940%2C628"),
                            Text("Network Image")
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                          color: Colors.red.shade200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceEvenly,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://emrealtunbilek.com/wp-content/uploads/2016/10/apple-icon-72x72.png"),
                                backgroundColor: Colors.purple,
                                foregroundColor: Colors.green.shade200,
                                radius: 30,
                              ),
                              Text("Circle Avatar")
                            ],
                          ),
                        )),
                  ])),
          IntrinsicHeight(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(4),
                      color: Colors.red.shade200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              child: Placeholder(
                                color: Colors.red,
                                strokeWidth: 2,
                              )),
                          Text("Placeholder Widget")
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(4),
                      color: Colors.red.shade200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: <Widget>[
                          FlutterLogo(
                            size: 60,
                            textColor: Colors.black,
                            style: FlutterLogoStyle.horizontal,
                          ),
                          Text("Flutter Logo")
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Deneme"),
                    color: Colors.orange,
                    onPressed: () => debugPrint("Fat arrow fonksiyon"),
                  ),
                  RaisedButton(
                      child: Text("Flutter Dersleri"),
                      elevation: 12,
                      textColor: Colors.red.shade100,
                      onPressed: () {
                        debugPrint("Normal lambda expression");
                        debugPrint("2. Satır");
                      },
                      color: Colors.purple.shade300),
                  RaisedButton(
                      child: Text("Hızla Devam Ediyor"),
                      elevation: 12,
                      textColor: Colors.black,
                      onPressed: () {
                        uzunMethod();
                      },
                      color: Colors.red.shade300),
                  IconButton(icon: Icon(Icons.ac_unit_sharp, size: 32,),
                      onPressed: () {}),
                  FlatButton(onPressed: () {},
                      child: Text(
                        "Flat Button", style: TextStyle(fontSize: 24),))
                ],
              ))
        ]);
  }

}
void uzunMethod() {
  debugPrint("Çok uzun içerikli method");
}
