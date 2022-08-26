// Built-in package
import 'package:flutter/material.dart';
import 'dart:async';
// User-defined package
import 'package:phone_book_app/constant_attribute_value/color.dart';
import 'home_page.dart';

class SplashScreenPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return SplashScreenPageState();
  }

}
class SplashScreenPageState extends State<SplashScreenPage>{
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (__)=>HomePage())),);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.baseColor,
      body: Container(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "PhoneBook",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3,),
                  Container(
                    width: 150,
                    color: Colors.white,
                    child: LinearProgressIndicator(
                        minHeight: 5,
                        backgroundColor: Colors.white,
                        color: Colors.pinkAccent,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: RichText(
                  text: TextSpan(
                      text: "Developed by ",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15
                      ),
                      children: [
                        TextSpan(
                            text: "BoldTech",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            )
                        )
                      ]
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }

}



