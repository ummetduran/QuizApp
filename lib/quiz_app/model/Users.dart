import 'package:flutter/material.dart';

class Users{
  String id;
  String name;
  String email;


  Users.empty();

  Users(this.id, this.name, this.email);

  @override
  String toString() {
    return 'Users{id: $id, name: $name, email: $email}';
  }
}