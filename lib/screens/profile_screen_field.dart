import 'package:flutter/material.dart';


class ProfileScreenField extends StatelessWidget {
  const ProfileScreenField({
    super.key,
    required this.screenWidth,
    required this.label, required this.title,
  });

  final double screenWidth;
  final String label;
  final String title;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(color: Colors.black87),
          ),
        ),
        Container(
          height: kToolbarHeight,
          width: screenWidth,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.black54)),
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            margin: const EdgeInsets.only(bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: const TextStyle(
                    color: Colors.black54, fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
