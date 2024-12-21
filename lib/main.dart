import 'package:cash_in/src/screen/bisnis_screen.dart';
import 'package:cash_in/src/screen/map_screen.dart';
import 'package:cash_in/src/screen/opening_animation.dart';

import 'package:flutter/material.dart';
void main() {
  runApp( const MainApp());
}   

class MainApp extends StatelessWidget { 
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {  
    
    return  MaterialApp(
      theme: ThemeData(
    fontFamily: 'Montserrat', 
  ),
      home: OpeningAnimation(),);      
  }
} 

