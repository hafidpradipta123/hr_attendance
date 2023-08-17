import 'package:flutter/material.dart';


class FixedText extends StatelessWidget {
  const FixedText({
    super.key,
    required this.screenWidth, required this.label, required this.fontSize, required this.fontWeight,
  });

  final double screenWidth;
  final String label;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: TextStyle(
            color: Colors.black54, fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }
}