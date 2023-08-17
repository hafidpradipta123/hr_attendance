import 'package:flutter/material.dart';

class MonthDisplay extends StatelessWidget {
  const MonthDisplay({
    super.key,
    required String month,
    required this.screenWidth,
  }) : _month = month;

  final String _month;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 32),
      child: Text(
       _month,
        style: TextStyle(fontSize: screenWidth / 18),
      ),
    );
  }
}