// Built-in package
import 'package:flutter/material.dart';
import 'dart:io';
// User-defined package
import 'package:phone_book_app/constant_attribute_value/color.dart';
import 'home_page.dart';

class ContactDetails extends StatefulWidget {

  String ? name;
  String ? phoneNumber;
  String ? email;
  String ? homeAddress;
  String ? description;
  String ? image;

  ContactDetails({this.name, this.phoneNumber, this.email, this.homeAddress, this.description, this.image});

  @override
  ContactDetailsState createState() => ContactDetailsState();
}

class ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        throw Navigator.pushReplacement(context, MaterialPageRoute(builder: (__)=>HomePage()));
      },
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColor.baseColor,
            elevation: 1,
            title: Center(
              child: Text(
                "Contact details",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            )
        ),
        body: ListView(
          children: [

            widget.image!.isEmpty ? Container(
              height: 220,
              color: Colors.grey.shade400,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircleAvatar(
                  backgroundColor: Colors.blueGrey.shade300,
                  radius: 90,
                  child: Text(
                    "Add a image",
                    style: TextStyle(color: Colors.grey.shade400),
                  )),
              ),
            ):
            Container(
              height: 220,
                color: Colors.grey.shade400,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircleAvatar(backgroundImage: FileImage(File(widget.image!), scale: 10),radius: 90,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300,width: 2)
                    ),
                  ),
                  ),
                )),
            cardDetails(
              icon: Icon(Icons.person, color: Colors.white, size: 16,),
              text: widget.name,
              color: AppColor.textColor,
              fontSize: widget.name!.isEmpty ? 16 : 20,
            ),
            cardDetails(
              icon: Icon(Icons.phone, color: Colors.white, size: 16,),
              text: widget.phoneNumber,
              color: AppColor.textColor,
              fontSize: widget.phoneNumber!.isEmpty ? 16 : 20,
            ),
            cardDetails(
              icon: Icon(Icons.email, color: Colors.white, size: 16,),
              text: widget.email!.isEmpty ? "Please, add a email address." : widget.email,
              color: widget.email!.isEmpty ? AppColor.missingTextColor : AppColor.textColor,
              fontSize: widget.email!.isEmpty ? 16 : 20,
            ),
            cardDetails(
              icon: Icon(Icons.home, color: Colors.white, size: 16,),
              text: widget.homeAddress!.isEmpty ? "Please, add a address." : widget.homeAddress,
              color: widget.homeAddress!.isEmpty ? AppColor.missingTextColor : AppColor.textColor,
              fontSize: widget.homeAddress!.isEmpty ? 16 : 20,
            ),
            cardDetails(
              icon: Icon(Icons.description, color: Colors.white, size: 16,),
              text: widget.description!.isEmpty ? "Please, add a description." : widget.description,
              color: widget.description!.isEmpty ? AppColor.missingTextColor : AppColor.textColor,
              fontSize: widget.description!.isEmpty ? 16 : 20,
            ),
          ],
        ),
      ),
    );
  }
  Widget cardDetails({icon, text, color, required double fontSize}){
    return Card(
      elevation: 0.8,
      shadowColor: Colors.purple,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColor.baseColor,
          child: icon,
        ),
        title: Text(text, style: TextStyle(color: color, fontSize: fontSize,))


      ),
    );
  }
}

