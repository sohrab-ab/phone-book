// Built-in package
import 'package:flutter/material.dart';
import 'dart:io';

class ContactModel{

  int ? id;
  String ? name;
  String ? phoneNumber;
  String ? email;
  String ? homeAddress;
  String ? description;
  String ? image;
  String ? date;
  String ? time;
  // String ? photo;

  ContactModel({this.id, this.name, this.phoneNumber, this.email, this.homeAddress, this.description, this.image, this.date, this.time});

  Map<String, dynamic> userToDatabase(){

    var map = Map<String, dynamic>();

    map["id"] = id;
    map["name"] = name;
    map["phoneNumber"] = phoneNumber;
    map["email"] = email;
    map["homeAddress"] = homeAddress;
    map["description"] = description;
    map["image"] = image;
    map["date"] = date;
    map["time"] = time;

    return map;
  }


  ContactModel.databaseToUser(Map<String, dynamic> map){

    id = map["id"];
    name = map["name"];
    phoneNumber = map["phoneNumber"];
    email = map["email"];
    homeAddress = map["homeAddress"];
    description = map["description"];
    image = map["image"];
    date = map["date"];
    time = map["time"];


  }

}
