

import 'package:flutter/material.dart';

Widget BuildGradientText(String text, VoidCallback onTap) {
    return GestureDetector
    (
      onTap: onTap ,
      child: ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          Color(0xFFA770EF),
          Color(0xFFF992F1),
          Color(0xFFFF926E),
        ],
        stops: [0.0, 0.49, 1.0],
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
      ).createShader(bounds),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    ));
  }
