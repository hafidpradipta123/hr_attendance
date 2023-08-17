import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hr_attendance/screens/profile_screen/profile_screen_field.dart';
import 'package:hr_attendance/screens/profile_screen/profile_screen_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../model/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = const Color(0xff200b72);
  String birth = "Date of birth";
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  void pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 90);

    Reference ref = FirebaseStorage.instance
        .ref()
        .child("${User.employeeId.toLowerCase()}_profilepic.jpg");
    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) async {
      setState(() {
        User.profilePicLink = value;

      });


    await FirebaseFirestore.instance.collection("Employee").doc(User.id).update(
        {
          'profilePic': value,
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SafeArea(
          child: Column(
            children: [
              GestureDetector(
                onTap:(){
                 // pickUploadProfilePic();
                  } ,
                // TODO Unhandled Exception: PlatformException(channel-error, Unable to establish connection on channel., null, null)
                child: Container(
                  margin: const EdgeInsets.only(top: 80, bottom: 24),
                  height: 120,
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: primary),
                  child: Center(
                    child: User.profilePicLink == " " ? const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 80,
                    ) : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(User.profilePicLink)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Employee ${User.employeeId}",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              User.canEdit? ProfileTextField(
                label: "First Name",
                title: "First Name",
                controller: firstNameController,
              )  :ProfileScreenField(screenWidth: screenWidth, title: "First Name", label: User.firstName,) ,
              User.canEdit? ProfileTextField(
                label: "Last Name",
                title: "Last Name",
                controller: lastNameController,
              ):ProfileScreenField(screenWidth: screenWidth, title: "Last Name", label:User.lastName ,),

              User.canEdit? GestureDetector(
                onTap: () {
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                      builder: (context, child) {
                        return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                  primary: primary,
                                  secondary: primary,
                                  onSecondary: Colors.white),
                              textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                      foregroundColor: primary)),
                            ),
                            child: child!);
                      }).then((value) {
                    setState(() {
                      birth = DateFormat("MM/dd/yyyy").format(value!);
                    });
                  });
                },
                child: ProfileScreenField(screenWidth: screenWidth,title: "Date of Birth", label: birth),
              ) :ProfileScreenField(screenWidth: screenWidth,title: "Date of Birth", label: User.birthDate) ,
             User.canEdit?  ProfileTextField(
                label: "Address",
                title: "Address",
                controller: addressController,
              ) :ProfileScreenField(screenWidth: screenWidth, title: "Address", label: User.address,) ,
             User.canEdit? GestureDetector(
                onTap: () async {
                  String firstName = firstNameController.text;
                  String lastName = lastNameController.text;
                  String address = addressController.text;
                  String birthDate = birth;

                  if (User.canEdit) {
                    if (firstName.isEmpty) {
                      showSnackBar("Please enter your first name!");
                    } else if (lastName.isEmpty) {
                      showSnackBar("Please enter your last name!");
                    } else if (birth.isEmpty) {
                      showSnackBar("Please enter your birth date!");
                    } else if (address.isEmpty) {
                      showSnackBar("Please enter your address!");
                    } else {
                      await FirebaseFirestore.instance
                          .collection("Employee")
                          .doc(User.id)
                          .update({
                        'firstName': firstName,
                        'lastName': lastName,
                        'birthDate': birthDate,
                        'address': address,
                        'canEdit': false
                      }).then((value) {
                        setState(() {
                          User.canEdit = false;
                          User.firstName = firstName;
                          User.lastName = lastName;
                          User.birthDate = birthDate;
                          User.address = address;
                        });
                      });
                    }
                  } else {
                    showSnackBar(
                        "You can not edit anymore. Please support the contact team.");
                  }
                },
                child: Container(
                  height: kToolbarHeight,
                  width: screenWidth,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: primary,
                      border: Border.all(color: Colors.black54)),
                  child: const Center(
                    child: Text(
                      "SAVE",
                      style:
                          TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ) : const SizedBox(),

              GestureDetector(
                onTap: () async {
                //  Navigator.pop(context);
                },
                child: Container(
                  height: kToolbarHeight,
                  width: screenWidth,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: primary,
                      border: Border.all(color: Colors.black54)),
                  child: const Center(
                    child: Text(
                      "LOGOUT",
                      style:
                      TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(text),
      ),
    );
  }
}

