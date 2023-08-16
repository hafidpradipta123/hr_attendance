import 'package:flutter/material.dart';


class ProfileTextField extends StatelessWidget {
  const ProfileTextField({
    super.key, required this.label, required this.title, required this.controller,
  });

  final String label;
  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black87
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: TextFormField(
            controller: controller,
            decoration:  InputDecoration(
                hintText: label,
                hintStyle: const TextStyle(
                    color: Colors.black54
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black54
                    )
                ),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black54
                    )
                )
            ),
          ),
        ),
      ],
    );
  }
}
