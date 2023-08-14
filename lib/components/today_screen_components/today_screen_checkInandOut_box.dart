
import 'package:flutter/material.dart';

class CheckInOutBox extends StatelessWidget {
  const CheckInOutBox({
    super.key,
    required this.screenWidth,
    required this.checkIn,
    required this.checkOut,
  });

  final double screenWidth;
  final String checkIn;
  final String checkOut;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 32),
      height: 150,
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(2, 2))
          ],
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Check In",
                  style: TextStyle(
                      fontSize: screenWidth / 20,
                      color: Colors.black54),
                ),
                Text(
                  checkIn,
                  style: TextStyle(
                      fontSize: screenWidth / 18,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Check Out",
                  style: TextStyle(
                      fontSize: screenWidth / 20,
                      color: Colors.black54),
                ),
                Text(
                  checkOut,
                  style: TextStyle(
                      fontSize: screenWidth / 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
