import 'package:cash_in/src/screen/authentication_screen.dart';
import 'package:cash_in/src/screen/bisnis_screen.dart';
import 'package:cash_in/src/screen/map_screen.dart';
import 'package:cash_in/src/screen/opening_animation.dart';
import 'package:cash_in/src/screen/security_code_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // Lock the orientation to portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MainApp());
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      home: OpeningAnimation(),
    );
  }
}
