
import 'package:flutter/material.dart';
import 'package:untitled1/navigator_push/navigasyon_islemleri.dart';
import 'package:untitled1/input_islemleri/text_field_ozellikleri.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/textFieldIslemleri',
    title: "Flutter Dersleri",
    routes: {
      '/': (context) => NavigasyonIslemleri(),
      '/textFieldIslemleri' : (context) => TextFieldIslemleri(),
      '/CPage': (context) => CSayfasi(),
      '/DPage': (context) => DSayfasi(),
      '/GPage': (context) => CSayfasi(),
      '/FPage': (context) => FSayfasi(),
      'CPage/DPAge': (context) => DSayfasi(),
      'CPage/DPAge/FPage': (context) => FSayfasi(),
      '/listeSayfasi': (context) => ListeSayfasi(),
    },

    onGenerateRoute: (RouteSettings settings) {
      List<String> pathElemanlari = settings.name.split("/"); //detay/$index

      if (pathElemanlari[1] == 'detay') {
        return MaterialPageRoute(
            builder: (context) => ListeDetay(int.parse(pathElemanlari[2])));
      }
    },

    onUnknownRoute: (RouteSettings settings) =>
        MaterialPageRoute(builder: (context) => NavigasyonIslemleri()),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.orange,
    ),
    //home: NavigasyonIslemleri(),
  ));
}
