import 'dart:math' as math;
import 'package:flutter/material.dart';

class CollapsableToolBarOrnek extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.red,
          expandedHeight: 300,
          floating: true,
          pinned: true,
          snap: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Sliver App Bar"),
            centerTitle: true,
            background:
                Image.asset("assets/images/lena.jpg", fit: BoxFit.cover),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(4),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              sabitListeElemanlari(),
            ),
          ),
        ),
        SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate(_dinamikElemanUret,
                    childCount: 6))),
        // SABİT ELEMANLARLA BİR SATIRDA KAÇ ELEMAN OLACAĞINI SÖYLEDİĞİMİZ GRİD TÜRÜ
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          delegate: SliverChildListDelegate(sabitListeElemanlari()),
        ),

        // DİNAMİK (BUİLDER İLE ÜRETİLEN) ELEMANLARLA BİR SATIRDA KAÇ ELEMAN OLACAĞINI SÖYLEDİĞİMİZ GRİD TÜRÜ
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          delegate: SliverChildBuilderDelegate(_dinamikElemanUret, childCount: 6),
        ),

        // DİNAMİK (BUİLDER İLE ÜRETİLEN) ELEMANLARLA BİR SATIRDAki bir ELEMANın MAX GENİŞLİĞİNİ  SÖYLEDİĞİMİZ GRİD TÜRÜ
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 100),
          delegate: SliverChildBuilderDelegate(_dinamikElemanUret, childCount: 6),
        ),

        SliverFixedExtentList(
            delegate: SliverChildListDelegate(
              sabitListeElemanlari(),
            ),
            itemExtent: 100),

        SliverFixedExtentList(delegate: SliverChildBuilderDelegate(_dinamikElemanUret, childCount: 6), itemExtent: 50),
        /*SliverList(),

        SliverFixedExtentList(),
        SliverGrid(),
        SliverGrid.count(crossAxisCount: 2),
        SliverGrid.extent(maxCrossAxisExtent: 200)
*/
      ],
    );
  }

  List<Widget> sabitListeElemanlari() {
    return [
      Container(
        height: 100,
        color: Colors.amber,
        alignment: Alignment.center,
        child: Text(
          "Sabit Liste Elamanı 1",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 100,
        color: Colors.teal,
        alignment: Alignment.center,
        child: Text(
          "Sabit Liste Elamanı 2",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 100,
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text(
          "Sabit Liste Elamanı 3",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 100,
        color: Colors.purple,
        alignment: Alignment.center,
        child: Text(
          "Sabit Liste Elamanı 4",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 100,
        color: Colors.cyan,
        alignment: Alignment.center,
        child: Text(
          "Sabit Liste Elamanı 5",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 100,
        color: Colors.amber,
        alignment: Alignment.center,
        child: Text(
          "Sabit Liste Elamanı 6",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    ];
  }

  Widget _dinamikElemanUret(BuildContext context, int index) {
    return Container(
      height: 100,
      color: _rastgeleRenkUret(),
      alignment: Alignment.center,
      child: Text(
        "Dinamik Liste Elamanı ${index + 1}",
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }

  Color _rastgeleRenkUret() {
    return Color.fromARGB(
        math.Random().nextInt(255),
        math.Random().nextInt(255),
        math.Random().nextInt(255),
        math.Random().nextInt(255));
  }
}
