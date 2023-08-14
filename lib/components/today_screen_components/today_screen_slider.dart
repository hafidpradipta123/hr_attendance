import 'package:flutter/material.dart';


class SliderButton extends StatelessWidget {
  const SliderButton({
    super.key,
    required this.checkIn,
    required this.screenWidth,
  });

  final String checkIn;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
          ),
        ],
      ),
      child: Center(
        child: Text(
          checkIn == "--/--"
              ? "Slide to Check In"
              : "Slide to Check Out",
          style: TextStyle(
              color: Colors.black54,
              fontSize: screenWidth / 20,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
