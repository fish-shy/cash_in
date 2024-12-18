import 'package:flutter/material.dart';

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  final Color colors;

  const OtpInput({
    required this.controller,
    required this.colors,
    required this.autoFocus,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 48,
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          fillColor: colors.withOpacity(0.2), // Lightened background color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colors),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colors, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colors, width: 1),
          ),
          counterText: '',
          hintStyle: TextStyle(
            color: colors.withOpacity(0.6), // Lighter color for hint text
            fontSize: 20.0,
            fontWeight: FontWeight.bold, // Bold hint text
          ),
        ),
        style: TextStyle(
          color: colors, // Color for the input text
          fontSize: 20.0,
          fontWeight: FontWeight.bold, // Bold input text
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
