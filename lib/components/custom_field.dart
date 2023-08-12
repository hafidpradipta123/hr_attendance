import 'package:flutter/material.dart';


class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    required this.screenWidth,
    required this.primary,
    required this.screenHeight,
    required this.hintTextLabel, required this.controller, required this.obscureText,
  });

  final double screenWidth;
  final Color primary;
  final double screenHeight;
  final String hintTextLabel;
  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(2,2)

            )
          ]
      ),
      child: Row(
        children: [
          Container(
            width: screenWidth/8,
            child: Icon(
              Icons.person,
              color: primary,
              size: screenWidth/15,
            ),
          ),
          Expanded(child: Padding(
            padding:  EdgeInsets.only(right: screenWidth/12),
            child: TextFormField(
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: screenHeight/35
                  ),
                  border: InputBorder.none,
                  hintText: hintTextLabel
              ),
              maxLines: 1,
              obscureText: obscureText,
            ),
          ))
        ],
      ),
    );
  }
}