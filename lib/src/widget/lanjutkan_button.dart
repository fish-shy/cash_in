import 'package:flutter/material.dart';

Container LanjutkanButton({required double width, required double height,  required BuildContext context,required VoidCallback onCPressed}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(0, 15, 0, 25),
    width: width * 0.8,
    height: height * 0.066,
    child: ElevatedButton(
      onPressed: onCPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 1,
        side: const BorderSide(color: Colors.white, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        'Lanjutkan',
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
