// Built-in package
import 'package:flutter/material.dart';
import 'dart:io';
// Additional package
import 'package:fluttertoast/fluttertoast.dart';
// User-defined package
import 'package:phone_book_app/constant_attribute_value/color.dart';
import 'add_contact.dart';
import 'details_contact.dart';
import 'package:phone_book_app/data_model/contact_model.dart';
import 'package:phone_book_app/database_controller/contact_database.dart';

class HomePage extends StatefulWidget {

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  List<ContactModel> data = [];
  List<ContactModel> sortedData = [];

  List<ContactModel> filterData = [];
  List<String> unFilterName = [];
  List<String> filterName = [];


  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData()async{
      await ContactDatabase().getAllContact().then((value){

        setState(() {
          if(value != null){
            sortedData = sortData(value);
            data = sortedData;
          }else{
            data = [];
          }
        });
      });
  }

  List<ContactModel> sortData(List<ContactModel> value){

    for(var i=0; i<value.length; i++){
      unFilterName.add(value[i].name!);
    }
    filterName = unFilterName..sort((item1, item2)=>item1.compareTo(item2));

    for(var j=0; j<filterName.length; j++){
      for(var k=0; k<value.length; k++){
        if(filterName[j].contains(value[k].name!)){
          filterData.add(value[k]);
        }
      }
    }
    return filterData;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.baseColor,
        elevation: 0,
        title: Center(
          child: Text(
            "Contact list",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey.shade800,
        elevation: 1,
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (__)=>AddContact(appTitle: "Store information")));
        },
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top:13, bottom: 13, left: 40, right: 40),
            height: 75,
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(100),
              ),
              child: TextField(
                controller: searchController,
                textCapitalization: TextCapitalization.words,
                  cursorColor: Colors.grey,
                  cursorHeight: 22,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                    color: Colors.indigoAccent.shade700,
                    fontSize: 18
                  ),
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                    ),
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: Colors.purple, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: Colors.purple, width: 1.5),
                    )
                  ),
                onChanged: (str) {

                  List<ContactModel> searchData = [];
                  String matchName = "";
                  data = sortedData;

                  if(str.isNotEmpty) {
                    for (var i = 0; i < data.length; i++) {
                     for(var j=0; j<str.length; j++){
                       matchName += data[i].name![j];

                     }
                     if (matchName.toUpperCase().contains(str.toUpperCase())) {
                      searchData.add(data[i]);
                      matchName = "";

                      }
                    }
                    setState(() async {
                      data = sortedData;
                      searchData = [];
                     // data = await ContactDatabase().searchContact(str);

                    });

                  }else{
                    setState(() {
                      data = sortedData;
                    });
                   }
                }
                ),
              ),
            ),

          Expanded(
            child: data.isEmpty ? Container() : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index){
                return Card(
                  elevation: 0.8,
                  shadowColor: Colors.purple,
                  child: ListTile(
                    horizontalTitleGap: 12,
                    minVerticalPadding: 10,
                    contentPadding: EdgeInsets.all(2),
                    leading: CircleAvatar(
                      backgroundColor: AppColor.baseColor,
                      child: data[index].image!.isEmpty ? Text(
                       data[index].name![0],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                        ),
                      ):CircleAvatar(backgroundImage: FileImage(File(data[index].image!)),)
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        data[index].name!,
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 3, bottom: 3),
                          child: Text(
                            data[index].date!,
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Text(
                            data[index].time!,
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 14,
                            ),
                          ),
                        )
                      ],
                    ),
                    trailing: SizedBox(
                      width: 84,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(Icons.update, color: Colors.indigoAccent,)),
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (__)=>AddContact(appTitle: "Update information",
                                updateId: data[index].id!, updateName: data[index].name!, updatePhoneNumber: data[index].phoneNumber!,
                                updateEmail: data[index].email!, updateHomeAddress: data[index].homeAddress!,
                                updateDescription: data[index].description!, updateImage: data[index].image,)));
                            },
                          ),
                          InkWell(
                            child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(Icons.delete, color: Colors.orange.shade300,)),
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (context){
                                    return AlertDialog(
                                      title: Text(
                                          "Delete contact!",
                                          style: TextStyle(
                                            color: Colors.red,
                                          )
                                      ),
                                      content: Text(
                                        "Are you sure, you want to delete this entry?",
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      actions: [
                                        InkWell(
                                            child: Container(
                                              height: 25,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                color: Colors.lightGreen.shade600,
                                                borderRadius: BorderRadius.circular(10),
                                              ),

                                              child: Center(
                                                child: Text(
                                                  "No",
                                                  style: TextStyle(
                                                      color: Colors.white
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onTap: (){
                                              Navigator.of(context).pop();
                                            }
                                        ),
                                        InkWell(
                                          child: Container(
                                            height: 25,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.red.shade900,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Yes",
                                                style: TextStyle(
                                                    color: Colors.white
                                                ),
                                              ),
                                            ),
                                          ),
                                          onTap: ()async{
                                            ContactDatabase().deleteContact(data[index].id!);
                                            setState(() {
                                              data.removeAt(index);
                                            });
                                            await Fluttertoast.showToast(
                                              msg: "You have successfully deleted.",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              fontSize: 16,
                                            );
                                            Navigator.of(context).pop();

                                          },
                                        ),
                                      ],
                                    );
                                  }
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    onTap: (){

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (__)=>ContactDetails(
                        name: data[index].name!, phoneNumber: data[index].phoneNumber, email: data[index].email,
                        homeAddress: data[index].homeAddress, description: data[index].description, image: data[index].image,
                      )));

                    },
                  ),
                );
              },
            ),
          ),

        ],
      )



    );

  }
}
