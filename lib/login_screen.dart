import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = const Color(0xffeef444c);

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: screenHeight / 3,
            width: screenWidth,
            decoration: BoxDecoration(
                color: primary,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(40))),
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
            margin: EdgeInsets.symmetric(horizontal: screenWidth/12),
            child: Column(
              children: [
                Text("Employee ID",
                style: TextStyle(fontSize: screenWidth/26),),
                Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: screenWidth/15,
                      )
                    ],
                  ),
                )
                Text("Employee ID",
                  style: TextStyle(fontSize: screenWidth/26),),

              ],
            ),
          )
        ],
      ),
    );
  }
}
