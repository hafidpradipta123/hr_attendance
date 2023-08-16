import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hr_attendance/screens/profile_screen_text_field.dart';
import 'package:intl/intl.dart';

import '../model/user.dart';

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

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 80, bottom: 24),
                height: 120,
                width: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: primary),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Employee ${User.employeeId}",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ProfileTextField(
                label: "First Name",
                title: "First Name",
                controller: firstNameController,
              ),
              ProfileTextField(
                label: "Last Name",
                title: "Last Name",
                controller: lastNameController,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Date of Birth",
                  style: const TextStyle(color: Colors.black87),
                ),
              ),
              GestureDetector(
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
                child: Container(
                  height: kToolbarHeight,
                  width: screenWidth,
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.black54)),
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    margin: EdgeInsets.only(bottom: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        birth,
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              ProfileTextField(
                label: "Address",
                title: "Address",
                controller: addressController,
              ),
              GestureDetector(
                onTap: () async {
                  String firstName = firstNameController.text;
                  String lastName = lastNameController.text;
                  String address = addressController.text;
                  String birthdate = birth;

                  if(User.canEdit){
                    if (firstName.isEmpty) {
                      showSnackBar("Please enter your first name!");
                    } else if (lastName.isEmpty) {
                      showSnackBar("Please enter your last name!");
                    } else if (birth.isEmpty) {
                      showSnackBar("Please enter your birth date!");
                    } else if (address.isEmpty) {
                      showSnackBar("Please enter your address!");
                    } else {
                      await FirebaseFirestore.instance.collection("Employee").doc(User.id)
                          .update({
                        'firstName': firstName,
                        'lastName' : lastName,
                        'birthDate': birthdate,
                        'address' : address,
                        'canEdit' : false
                          });

                    }
                  } else {
                    showSnackBar("You can not edit anymore. Please support the contact team.");
                  }


                },
                child: Container(
                  height: kToolbarHeight,
                  width: screenWidth,
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: primary,
                      border: Border.all(color: Colors.black54)),
                  child: Container(
                    child: Center(
                      child: Text(
                        "SAVE",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
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
