import 'package:flutter/material.dart';


import 'Ders.dart';
import 'Users.dart';

class Teacher extends Users{

  List<Ders> verilenDersler;

    Teacher(int id, String name, String email) : super(id,name, email){
      verilenDersler = []; // ????
    }

  }
