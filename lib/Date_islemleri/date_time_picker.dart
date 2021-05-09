import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
class TarihSaatOrnekState extends StatefulWidget {
  @override
  _TarihSaatOrnekStateState createState() => _TarihSaatOrnekStateState();
}

class _TarihSaatOrnekStateState extends State<TarihSaatOrnekState> {
  @override
  Widget build(BuildContext context) {
    DateTime suan= DateTime.now();
    DateTime ucAyOnce= DateTime(2021, suan.month-3);
    DateTime yirmiGunSonra= DateTime(2021,suan.month,suan.day+20);

    TimeOfDay suankiSaat = TimeOfDay.now();
    return Scaffold(
      appBar: AppBar(
        title: Text("Date Time Picker"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(child: Text("Tarih seç"), color: Colors.green,onPressed: (){
              showDatePicker(context: context, initialDate: suan, firstDate: ucAyOnce, lastDate: yirmiGunSonra).
              then((secilenTarih){
                debugPrint(secilenTarih.toString());
                debugPrint(secilenTarih.toIso8601String());
                debugPrint(secilenTarih.microsecondsSinceEpoch.toString());
                debugPrint(secilenTarih.toUtc().toIso8601String());

                print(formatDate(secilenTarih, [yyyy, '-', mm, '-', dd]));
                print(formatDate(secilenTarih, [dd, '-', mm, '-', yyyy]));
              });
            }),
            RaisedButton(child: Text("Saat Seç"),color:Colors.blue,onPressed: (){
              showTimePicker(context: context, initialTime: suankiSaat).then((secilenSaat){
                debugPrint(secilenSaat.format(context));
              });
            })
          ],
        ),
      ),
    );
  }
}
