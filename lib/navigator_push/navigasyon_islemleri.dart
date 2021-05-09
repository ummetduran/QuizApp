import 'package:flutter/material.dart';

class NavigasyonIslemleri extends StatelessWidget {
  String baslik = "B SAYFASI";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "Navigasyon İşlemleri",
          style: TextStyle(color: Colors.white),
        )),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    child: Text(
                      "A Sayfasına Git",
                      style: TextStyle(color: Colors.red),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ASayfasi()));
                    }),
                RaisedButton(
                    child: Text(
                      "B Sayfasına Git",
                      style: TextStyle(color: Colors.blue),
                    ),
                    color: Colors.red,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BSayfasi(baslik)));
                    }),
                RaisedButton(
                    child: Text(
                      "C Sayfasına Git ve Geri Gel",
                      style: TextStyle(color: Colors.yellow),
                    ),
                    color: Colors.purple,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CSayfasi()));
                    }),
                RaisedButton(
                    child: Text(
                      "D Sayfasına Git ve Gelirken Veri Getir",
                      style: TextStyle(color: Colors.yellow),
                    ),
                    color: Colors.pink,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DSayfasi()),
                      ).then((popdanSonraGelenDeger) {
                        debugPrint(
                            "Pop işlemminden sonra gelen değer $popdanSonraGelenDeger");
                      });
                    }),
                RaisedButton(
                    child: Text(
                      "E Sayfasına Git ",
                      style: TextStyle(color: Colors.yellow),
                    ),
                    color: Colors.pink,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ESayfasi()));
                    }),
                RaisedButton(
                    child: Text(
                      "Liste Sayfasına Git ",
                      style: TextStyle(color: Colors.yellow),
                    ),
                    color: Colors.green,
                    onPressed: () {
                      Navigator.pushNamed(context, "/listeSayfasi");
                    }),

                RaisedButton(
                    child: Text(
                      "Liste Sayfasına Git ",
                      style: TextStyle(color: Colors.yellow),
                    ),
                    color: Colors.yellowAccent.shade100,
                    onPressed: () {
                      Navigator.pushNamed(context, "/textFieldIslemleri");
                    }),
              ],
            ),
          ),
        ));
  }
}


class ListeSayfasi extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Liste Sayfası",
              style: TextStyle(color: Colors.white),
            )),
        body: ListView.builder(itemBuilder: (BuildContext context, int index){
          return
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, "/detay/$index");
              },
              child: Center(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Liste elemanı $index"),
              ))
            );

    }, itemCount: 60,)
    );
  }

}

class ListeDetay extends StatelessWidget {
  int tiklanilanIndex=0;
  ListeDetay(this.tiklanilanIndex);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Liste Detay Sayfası",
              style: TextStyle(color: Colors.white),
            )),
        body: Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Liste elemanı $tiklanilanIndex tıklanıldı"),
          ))
    );
  }
}


class GSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "G Sayfası",
          style: TextStyle(color: Colors.white),
        )),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "G SAYFASI",
                style: TextStyle(color: Colors.red, fontSize: 24),
              )
            ],
          ),
        ));
  }
}

class FSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "F Sayfası",
          style: TextStyle(color: Colors.white),
        )),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "F SAYFASI",
                style: TextStyle(color: Colors.red, fontSize: 24),
              ),
              RaisedButton(child: Text("G sayfasına git"), onPressed: (){
                Navigator.pushReplacementNamed(context,"/GPageb");
              } )
            ],
          ),
        ));
  }
}

class ASayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "A Sayfası",
          style: TextStyle(color: Colors.white),
        )),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "A SAYFASI",
                style: TextStyle(color: Colors.red, fontSize: 24),
              )
            ],
          ),
        ));
  }
}

class BSayfasi extends StatelessWidget {
  String gelenBaslikVerisi;

  BSayfasi(this.gelenBaslikVerisi);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: Text(
          gelenBaslikVerisi,
          style: TextStyle(color: Colors.white),
        )),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                gelenBaslikVerisi,
                style: TextStyle(color: Colors.red, fontSize: 24),
              )
            ],
          ),
        ));
  }
}

class CSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "C Sayfası",
          style: TextStyle(color: Colors.white),
        )),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "C SAYFASI",
                style: TextStyle(color: Colors.red, fontSize: 24),
              ),
              RaisedButton(
                  color: Colors.purple,
                  child: Text("Geri Dön"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              RaisedButton(
                  color: Colors.purple,
                  child: Text("A Sayfasına Git"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ASayfasi()));
                  }),
              RaisedButton(
                  color: Colors.purple,
                  child: Text("D Sayfasına Git ve gelirken veri getir"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DSayfasi()));
                  })
            ],
          ),
        ));
  }
}

class DSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: () {
          debugPrint("On will pop çalıştı");
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
            appBar: AppBar(
                title: Text(
              "D Sayfası",
              style: TextStyle(color: Colors.white),
            )),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "D SAYFASI",
                    style: TextStyle(color: Colors.red, fontSize: 24),
                  ),
                  RaisedButton(
                      color: Colors.pink,
                      child: Text("Geri Dön ve veri gönder"),
                      onPressed: () {
                        Navigator.pop(
                            context, 50); // true demek ürün silindi demektir
                        // false ürüm silinemedi kullanıcı vazgeçti
                      }),
                ],
              ),
            )));
  }
}

class ESayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "E Sayfası",
          style: TextStyle(color: Colors.white),
        )),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "E SAYFASI",
                style: TextStyle(color: Colors.red, fontSize: 24),
              ),
              RaisedButton(child: Text("F sayfasına git"), onPressed: (){
                Navigator.pushNamed(context, '/FPage');
              } )
            ],
          ),
        ));
  }
}
