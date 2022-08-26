// Built-in package
import 'package:flutter/material.dart';
// User-defined package
import 'package:phone_book_app/ui/splash_screen_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: SplashScreenPage(),
    );
  }
}


