import 'package:flutter/material.dart';

import 'Ders.dart';
import 'Users.dart';


class Student extends Users{

 List<Ders> alinanDersler;
 Student(String id, String name, String email) : super(id,name, email){
  alinanDersler = []; // ????
 }
}