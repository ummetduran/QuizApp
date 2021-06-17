import 'package:flutter/material.dart';


import 'Ders.dart';
import 'Users.dart';

class Teacher extends Users{

  List<Ders> _verilenDersler;

  Teacher(String id, String name, String email) : super(id,name, email){
    _verilenDersler = []; // ????
  }

Teacher.empty() : super.empty();

  List<Ders> get verilenDersler => _verilenDersler;

  set verilenDersler(List<Ders> value) {
    _verilenDersler = value;
  }
}