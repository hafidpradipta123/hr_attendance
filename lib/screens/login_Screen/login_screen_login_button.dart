import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.primary,
  });

  final double screenHeight;
  final double screenWidth;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
