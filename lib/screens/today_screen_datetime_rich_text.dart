import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeRichText extends StatelessWidget {
  const DateTimeRichText({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
              text: DateTime.now().day.toString(),
              style: TextStyle(
                color: Colors.red,
                fontSize: screenWidth / 18,
              ),
              children: [
                TextSpan(
                  text: DateFormat(' MMMM yyyy')
                      .format(DateTime.now()),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth / 20,
                  ),
                )
              ]),
        ));
  }
}
