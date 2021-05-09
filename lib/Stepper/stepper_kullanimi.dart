import 'package:flutter/material.dart';

class StepperOrnek extends StatefulWidget {
  @override
  _StepperOrnekState createState() => _StepperOrnekState();
}

class _StepperOrnekState extends State<StepperOrnek> {

  int _aktifStep=0;
  String isim, mail, sifre;
  List<Step> tumStepler;
  bool hata=false;
  var key0=GlobalKey<FormFieldState>();
  var key1=GlobalKey<FormFieldState>();
  var key2=GlobalKey<FormFieldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    tumStepler=_tumStepler();
    return Scaffold(
      appBar: AppBar(
        title: Text('Stepper Örnek'),
      ),
      body: SingleChildScrollView(
        child: Stepper(
          steps: tumStepler,
          currentStep: _aktifStep,
          /*onStepTapped: (tiklanilanStep){
            setState(() {
              _aktifStep = tiklanilanStep;
            });
          },*/
          onStepContinue: (){
            setState(() {
              _ileriButonControl();
            });
      },
          onStepCancel: (){
              setState(() {
                if(_aktifStep>0)
                  _aktifStep--;
                else
                  _aktifStep=0;
              });
          },
        ),
      ),
    );
  }

  List<Step> _tumStepler() {
    List<Step> stepler = [
      Step(
          title: Text("Username başlık: "),
          subtitle: Text("Username Altbaşlık"),
          state: _stateAyarla(0),
          isActive: true,
          content: TextFormField(
            key: key0,
            decoration: InputDecoration(
                labelText: "Usernamelabel",
                hintText: "UsernameHint",
                border: OutlineInputBorder(),
            ),
            validator: (girilenDeger){
              if(girilenDeger.length<6)
                return "En az 6 karakter girin.";
            },
            onSaved: (girilenDeger){
              isim=girilenDeger;
            },
          )),

      Step(
          title: Text("Mail başlık: "),
          subtitle: Text("Mail Altbaşlık"),
          state: _stateAyarla(1),
          isActive: true,
          content: TextFormField(
            key: key1,
            decoration: InputDecoration(
                labelText: "MailLabel",
                hintText: "MailHint",
                border: OutlineInputBorder()
            ),
            validator: (girilenDeger){
              if(girilenDeger.length<6 || !girilenDeger.contains("@"))
                return "Geçerli mail adresi girin.";
            },
            onSaved: (girilenDeger){
              mail=girilenDeger;
            },
          )),

      Step(
          title: Text("Şifre başlık: "),
          subtitle: Text("Şifre Altbaşlık"),
          state: _stateAyarla(2),
          isActive: true,
          content: TextFormField(
            key: key2,
            decoration: InputDecoration(
                labelText: "Sifrelabel",
                hintText: "SifreHint",
                border: OutlineInputBorder()
            ),
            validator: (girilenDeger){
              if(girilenDeger.length<6)
                return "Şifre en az 6 karakter olmalı.";
            },
            onSaved: (girilenDeger){
              sifre=girilenDeger;
            },
          ))
    ];
    return stepler;
  }

  StepState _stateAyarla(int oAnkiStep) {
    if(_aktifStep ==oAnkiStep){
      if(hata){
        return StepState.error;
      }else{
        return StepState.editing;
      }
    }else{
      return StepState.complete;
    }
  }

  void _ileriButonControl() {

    switch(_aktifStep){
      case 0:
        if(key0.currentState.validate()) {
          key0.currentState.save();
          hata=false;
          _aktifStep++;
        }else{
          hata=true;
        }
        break;
      case 1:
        if(key1.currentState.validate()) {
          key1.currentState.save();
          hata=false;
          _aktifStep++;
        }else{
          hata=true;
        }
        break;

      case 2:
        if(key2.currentState.validate()) {
          key2.currentState.save();
          hata=false;
          _aktifStep=2;
          formTamam();

        }else{
          hata=true;
        }
        break;
    }
  }

  void formTamam() {
    debugPrint("Girilen Değerler : isim => $isim mail => $mail şifre => $sifre ");
  }
}
