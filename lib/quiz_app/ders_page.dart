import 'package:flutter/material.dart';

import 'backend/Ders.dart';

class DersPage extends StatefulWidget {
  final Ders ders;

  const DersPage({Key key, this.ders}) : super(key: key);

  @override
  _DersPageState createState() => _DersPageState();
}
//ahmet
class _DersPageState extends State<DersPage> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Text("${widget.ders.getName()}"),
    );
  }
}
