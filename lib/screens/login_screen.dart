import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hr_attendance/components/custom_field.dart';
import 'package:hr_attendance/components/field_text.dart';
import 'package:hr_attendance/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = const Color(0xff200b72);
  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          isKeyboardVisible
              ? SizedBox(
                  height: screenHeight / 16,
                )
              : Container(
                  height: screenHeight / 3,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(40))),
                  child: Center(
                    child: Icon(Icons.person,
                        color: Colors.white, size: screenWidth / 5),
                  ),
                ),
          Container(
            margin: EdgeInsets.only(
                top: screenHeight / 15, bottom: screenHeight / 20),
            child: Text(
              "Login",
              style: TextStyle(fontSize: screenWidth / 15),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: screenWidth / 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FieldText(label: "Employee ID", screenWidth: screenWidth),
                CustomField(
                  controller: idController,
                  hintTextLabel: "Enter your Employee ID",
                  screenWidth: screenWidth,
                  primary: primary,
                  screenHeight: screenHeight,
                  obscureText: false,
                ),
                FieldText(screenWidth: screenWidth, label: "Password"),
                CustomField(
                  screenWidth: screenWidth,
                  primary: primary,
                  screenHeight: screenHeight,
                  hintTextLabel: "Enter your Password",
                  controller: passwordController,
                  obscureText: true,
                ),
                GestureDetector(
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    String id = idController.text.trim();
                    String password = passwordController.text.trim();

                    QuerySnapshot snap = await FirebaseFirestore.instance
                        .collection("Employee")
                        .where('id', isEqualTo: id)
                        .get();
                    // print(snap.docs[0]['id']);

                    if (id.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Employee id is still empty!"),
                        ),
                      );
                    } else if (password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Password is still empty!"),
                        ),
                      );
                    } else {
                      QuerySnapshot snap = await FirebaseFirestore.instance
                          .collection("Employee")
                          .where('password', isEqualTo: password)
                          .get();
                      //print(snap.docs[0]['password']);
                    }

                    try {
                      if (password == snap.docs[0]['password']) {
                        sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.setString('employeeId', id).then((_) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        });
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Password is not correct!"),
                        ));
                      }
                    } catch (e) {
                      String error = " ";

                      if (e.toString() ==
                          "RangeError (index): Invalid value: Valid value range is empty: 0") {
                        setState(() {
                          error = "Employee ID does not exist";
                        });
                      } else {
                        setState(() {
                          error = "Error occurred!";
                        });
                      }
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(error),
                      ));
                    }
                  },
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.only(top: screenHeight / 40),
                    width: screenWidth,
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25))),
                    child: Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: screenWidth / 26,
                            color: Colors.white,
                            letterSpacing: 2),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
