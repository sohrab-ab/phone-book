// Built-in package
import 'package:flutter/material.dart';
import 'dart:io';

// Additional package
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
// User-defined package
import 'package:phone_book_app/data_model/contact_model.dart';


class ContactDatabase{

  String dbName = "contactContainer.db";
  Database ? database;

  Future<List<ContactModel>?> getAllContact()async{
    Database db = await checkDatabase();
    var result = await db.query("ContactModel");

    return result.isNotEmpty ? result.map((value) => ContactModel.databaseToUser(value)).toList(): null;
  }




  Future<Database> checkDatabase()async{
    if(database != null){
      return database!;
    }
    else{
      database = await initDatabase();
      return database!;
    }

  }


  Future<Database> initDatabase()async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);

    return await openDatabase(path, version: 1, onOpen: (db){}, onCreate: (Database db, int version)async{
      await db.execute("CREATE TABLE if not exists ContactModel ("
          "id INTEGER PRIMARY KEY autoincrement,"
          "name TEXT,"
          "phoneNumber TEXT,"
          "email TEXT,"
          "homeAddress TEXT,"
          "description TEXT,"
          "image TEXT,"
          "date TEXT,"
          "time TEXT )");
    });

  }

  insertNewContactInDatabase(ContactModel newContact)async{
    Database db = await checkDatabase();
    var result = await db.insert("ContactModel", newContact.userToDatabase());
    //insert into ContactModel (id, name, time) values (1, 'Kabir', "12:00:00")

    return result;
  }

  ///query value is like -> Map<String, dynamic> data
  ///

  Future<int> updateContactInDatabase(int id, ContactModel updateContact)async{
    Database db = await checkDatabase();
    var result = db.update("ContactModel", updateContact.userToDatabase(), where: "id = ?", whereArgs: [updateContact.id]);
    // await db.update("ContactModel", updateContact.userToDatabase(), where: "id = ${updateContact.id} and name = 'Khan'",);
    return result;
  }

  Future<int> deleteContact(int id)async{
    Database db = await checkDatabase();
    var result = db.delete("ContactModel", where: "id = ?", whereArgs: [id]);
    return result;
  }

/*
  Future<List<ContactModel>> searchContact(searchText)async{
    Database db = await checkDatabase();
    // var result = await db.query("ContactModel", where: " name like '$searchText%'");

    var result = await db.rawQuery("""
    select * from ContactModel
    where name like '$searchText%'
    order by case
    when name like '$searchText' then 0
    when name like '$searchText%' then 1
    else 2
    end asc
    """);
    return result.isNotEmpty ? result.map((value) => ContactModel.databaseToUser(value)).toList(): [];
  }
    ///Map<String,dynamic> data
  ///{id:1, name: Khan,}
  ///{id:2}
  ///List<ContactModel>

*/


}