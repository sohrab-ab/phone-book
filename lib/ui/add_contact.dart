// Built-in package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

// Additional package
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// User-defined package
import 'package:phone_book_app/constant_attribute_value/color.dart';
import 'package:phone_book_app/data_model/contact_model.dart';
import 'package:phone_book_app/database_controller/contact_database.dart';
import 'package:phone_book_app/ui/home_page.dart';

class AddContact extends StatefulWidget {
  final String? appTitle;
  final int? updateId;
  final String? updateName;
  final String? updatePhoneNumber;
  final String? updateEmail;
  final String? updateHomeAddress;
  final String? updateDescription;
  final String? updateImage;

  AddContact(
      {required this.appTitle,
      this.updateId,
      this.updateName,
      this.updatePhoneNumber,
      this.updateEmail,
      this.updateHomeAddress,
      this.updateDescription,
      this.updateImage});

  @override
  AddContactState createState() => AddContactState();
}

class AddContactState extends State<AddContact> {
  var formKey = GlobalKey<FormState>();


  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController homeAddressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController.text = widget.updateName ?? "";
    phoneNumberController.text = widget.updatePhoneNumber ?? "";
    emailController.text = widget.updateEmail ?? "";
    homeAddressController.text = widget.updateHomeAddress ?? "";
    descriptionController.text = widget.updateDescription ?? "";
    imageController.text = widget.updateImage ?? "";

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        throw Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (__) => HomePage()));
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.baseColor,
          elevation: 1,
          title: Center(
            child: Text(
              widget.appTitle!,
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                textFormField(
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    labelText: "Name",
                    hintText: "Enter name",
                    controller: nameController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please, enter the contact name.";
                      } else if (value.length > 50) {
                        return "Sorry, you have exceeded the 50 characters limit.";
                      }
                    }),
                SizedBox(
                  height: 8,
                ),
                textFormField(
                    keyboardType: TextInputType.phone,
                    textCapitalization: TextCapitalization.none,
                    labelText: "Mobile Number",
                    hintText: "Enter mobile number",
                    controller: phoneNumberController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please, enter the valid phone number.";
                      } else if (value.length >= 12 || value.length <= 10) {
                        var length = value.length;
                        return "Sorry, you have pressed $length digits.";
                      } else {
                        String pattern = r"^[0][1][1-9][0-9]{8}$";
                        RegExp regExp = RegExp(pattern);
                        if (!regExp.hasMatch(value)) {
                          return "Sorry, your mobile number is not valid.";
                        }
                      }
                    }),
                SizedBox(
                  height: 8,
                ),
                textFormField(
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.emailAddress,
                    labelText: "Email address",
                    hintText: "Enter email address",
                    controller: emailController,
                    validator: (String? value) {
                      if (value!.isNotEmpty && value.length <= 60) {
                        String pattern =
                            r"^([a-zA-Z0-9\.-]+)@([a-z0-9]{1,15})\.([a-z]{1,15})(.[a-z]{1,10})?$";
                        RegExp regExp = RegExp(pattern);
                        if (!regExp.hasMatch(value)) {
                          return "Please, enter a valid email address.";
                        }
                      } else if (value.length > 60) {
                        return "Sorry, you have exceeded the limit of 60 characters.";
                      }
                    }),
                SizedBox(
                  height: 8,
                ),
                textFormField(
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    labelText: "Home address",
                    hintText: "Enter home address",
                    controller: homeAddressController,
                    validator: (String? value) {
                      if (value!.length > 200) {
                        return "Sorry, you have exceeded the limit of 200 letters.";
                      }
                    }),
                SizedBox(
                  height: 8,
                ),
                textFormField(
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    labelText: "Description",
                    hintText: "Enter description",
                    controller: descriptionController,
                    validator: (String? value) {
                      if (value!.length > 300) {
                        return "Sorry, you have exceeded the limit of 300 letters.";
                      }
                    }),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: textFormField(
                          keyboardType: TextInputType.none,
                          textCapitalization: TextCapitalization.none,
                          labelText: "Image",
                          hintText: "Enter image",
                          controller: imageController,
                          validator: (String? value) {
                             if(value!.length>400){
                              return "Sorry, you have exceeded the limit of 300 letters.";
                             }
                          }),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 5),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        height: 62,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.purple.shade800, width: 1.5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade700,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Icon(
                                    Icons.source,
                                    color: Colors.white,
                                    size: 20,
                                  )),
                              onTap: () async{
                                /*await pickImage(source: ImageSource.gallery).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      imageController.text = value;
                                    });
                                  }
                                });*/
                              },
                            ),
                            InkWell(
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade700,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Icon(
                                    Icons.camera,
                                    color: Colors.white,
                                    size: 20,
                                  )),
                              onTap: () async {
                                await pickImage(source: ImageSource.camera).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      imageController.text = value;
                                    });
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      widget.updateId == null ? "Save" : "Update",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.purple.shade900,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (widget.updateId == null) {
                        ContactDatabase().insertNewContactInDatabase(ContactModel(
                          name: nameController.text,
                          phoneNumber: phoneNumberController.text,
                          email: emailController.text,
                          homeAddress: homeAddressController.text,
                          description: descriptionController.text,
                          image: imageController.text,
                          date: DateFormat("dd-MM-yyyy")
                              .format(DateTime.now())
                              .toString(),
                          time: DateFormat("hh:mm a")
                              .format(DateTime.now())
                              .toString(),
                        ));
                      } else {
                        ContactDatabase().updateContactInDatabase(
                            widget.updateId!,
                            ContactModel(
                              id: widget.updateId,
                              name: nameController.text,
                              phoneNumber: phoneNumberController.text,
                              email: emailController.text,
                              homeAddress: homeAddressController.text,
                              description: descriptionController.text,
                              image: imageController.text,
                              date: DateFormat("dd-MM-yyyy")
                                  .format(DateTime.now())
                                  .toString(),
                              time: DateFormat("hh:mm a")
                                  .format(DateTime.now())
                                  .toString(),
                            ));
                      }

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (__) => HomePage()));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> pickImage({source}) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        return pickedImage.path;
      }
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Widget textFormField({
    keyboardType,
    labelText,
    hintText,
    textCapitalization,
    controller,
    validator,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      controller: controller,
      cursorHeight: 25,
      cursorWidth: 1.5,
      cursorColor: Colors.blueGrey,
      style: TextStyle(color: Colors.indigoAccent.shade700, fontSize: 20),
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.blueGrey,
            fontSize: 16,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.purple.shade800, width: 1.5)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.green, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red, width: 1.5),
          )),
      validator: validator,
    );
  }
}
