import 'package:flutter/material.dart';
class FieldText extends StatelessWidget {
  final String label;

  const FieldText({
    super.key,
    required this.screenWidth, required this.label,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Text(label,
        style: TextStyle(fontSize: screenWidth/26),),
    );
  }
}