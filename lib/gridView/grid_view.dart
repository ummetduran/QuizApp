import 'package:flutter/material.dart';
class GridViewOrnek extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.builder(itemCount: 100,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2 ),
      itemBuilder: (BuildContext context, int index){
      return GestureDetector(
        child: Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 10),
                //borderRadius: new BorderRadius.all(new Radius.circular(20)),
                boxShadow: [
                  new BoxShadow(
                      color: Colors.blue,
                      offset: new Offset(10.0, 5.0),
                      blurRadius: 20.0
                  )
                ],
                shape: BoxShape.circle,
                color:  Colors.teal[100 * ((index+1) % 8)],
                gradient: LinearGradient(colors: [Colors.blue, Colors.green], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                image:  DecorationImage(
                    image: AssetImage("assets/images/pacman.jpg"),
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter
                )
            ),
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Merhaba Flutter $index",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color:  Colors.white),
              ),
            )


        ),
        onTap: () => debugPrint("Merhaba Flutter $index tıklanıldı"),
        onDoubleTap:() =>  debugPrint("Merhaba Flutter $index çift tıklanıldı"),
        onLongPress: () =>  debugPrint("Merhaba Flutter $index uzun basıldı"),
        onHorizontalDragStart: (e) =>  debugPrint("Merhaba Flutter $index uzun basıldı $e"),
      );
      },
    );


  }
}

/*
return GridView.extent(
      //crossAxisCount: 3, // bir satırdak, eleman sayısı
      maxCrossAxisExtent: 200,
      scrollDirection: Axis.vertical, //scrol yönü default y ekseni
      primary: false,
      padding: EdgeInsets.all(10),
      crossAxisSpacing: 20, // sütunlar arası bosluk
      mainAxisSpacing: 40, // satır arası bosluk
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          color: Colors.teal.shade300,
            child: Text("Merhaba Flutter", textAlign:  TextAlign.center,)
        ),
        Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("Merhaba Flutter", textAlign:  TextAlign.center,)
        ),
        Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("Merhaba Flutter", textAlign:  TextAlign.center,)
        ),
        Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("Merhaba Flutter", textAlign:  TextAlign.center,)
        ),
        Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("Merhaba Flutter", textAlign:  TextAlign.center,)
        ),
        Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("Merhaba Flutter", textAlign:  TextAlign.center,)
        ),
        Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("Merhaba Flutter", textAlign:  TextAlign.center,)
        ),
        Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("Merhaba Flutter", textAlign:  TextAlign.center,)
        ),
        Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("Merhaba Flutter", textAlign:  TextAlign.center,)
        ),
        Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("Merhaba Flutter", textAlign:  TextAlign.center,)
        ),
        Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("Merhaba Flutter", textAlign:  TextAlign.center,)
        ),
        Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("Merhaba Flutter", textAlign:  TextAlign.center,)
        ),
        Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("Merhaba Flutter", textAlign:  TextAlign.center,)
        ),
        Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("Merhaba Flutter", textAlign:  TextAlign.center,)
        ),
        Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("Merhaba Flutter", textAlign:  TextAlign.center,)
        ),
        Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("Merhaba Flutter", textAlign:  TextAlign.center,)
        ),
        Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("Merhaba Flutter", textAlign:  TextAlign.center,)
        ),
        Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("Merhaba Flutter", textAlign:  TextAlign.center,)
        ),
        Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("Merhaba Flutter", textAlign:  TextAlign.center,)
        ),
            ],
    );
 */