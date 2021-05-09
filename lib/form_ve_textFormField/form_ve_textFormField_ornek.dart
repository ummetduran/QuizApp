import 'package:flutter/material.dart';

class FormvetextFormField extends StatefulWidget {
  @override
  _FormvetextFormFieldState createState() => _FormvetextFormFieldState();
}

class _FormvetextFormFieldState extends State<FormvetextFormField> {
  String _adSoyad, _sifre, _email;
  bool otomatikKontrol = false;
  final formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          accentColor: Colors.green,
          hintColor: Colors.indigo,
          errorColor: Colors.red,
          primaryColor: Colors.teal),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.save),
        ),
        appBar: AppBar(

          title: Text("Form ve TextFormField"),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: formKey,
            // ignore: deprecated_member_use
            autovalidate: otomatikKontrol,
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.account_circle,
                      color: Colors.pink,
                    ),
                    hintText: "Adınız ve Soyadınız",
                    labelText: "Ad Soyad",
                    border: OutlineInputBorder(),
                  ),
                  validator: _isimControl,
                  onSaved: (deger)=> _adSoyad = deger,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "Email Adresiniz",
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2)),
                    //focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.purple, width: 2)),
                  ),
                  validator: _emailControl,
                  onSaved: (deger)=> _email = deger,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Şifreniz",
                    labelText: "Şifre",
                    border: OutlineInputBorder(),
                    //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2)),
                    //focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.purple, width: 2)),
                  ),
                  validator: (String girilemVeri){
                    if(girilemVeri.length<6)
                      return "En az 6 karakter gerekli";
                    else return null;
                  },
                  onSaved: (deger)=> _sifre = deger,
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton.icon(
                  onPressed: _girisBilgileriniOnayla,
                  icon: Icon(Icons.save),
                  label: Text("Kaydet"),
                  color: Colors.blue,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _girisBilgileriniOnayla() {

    if(formKey.currentState.validate()){
      formKey.currentState.save();
      debugPrint("Girilen mail: $_email şifre: $_sifre ad Soyad: $_adSoyad");
    }else{
      setState(() {
        otomatikKontrol =true;
      });
    }
  }

  String _emailControl(String mail) {

    Pattern pattern= r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex= new RegExp(pattern);
    if(!regex.hasMatch(mail))
      return "Geçersiz Mail";
    else return null;
  }

  String _isimControl(String isim) {
    RegExp regex= RegExp("^[a-zA-Z]+\$");
    if(!regex.hasMatch(isim))
      return "İsim numara içermemeli";
    else
      return null;
  }

}
