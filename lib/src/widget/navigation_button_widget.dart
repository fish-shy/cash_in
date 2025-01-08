import 'package:cash_in/src/screen/bisnis_screen.dart';
import 'package:cash_in/src/screen/home_screen.dart';
import 'package:flutter/material.dart';

class NavigationButtonWidget extends StatefulWidget {
  final bool home;

  const NavigationButtonWidget({super.key, required this.home});

  @override
  State<NavigationButtonWidget> createState() => _NavigationButtonWidgetState();
}

class _NavigationButtonWidgetState extends State<NavigationButtonWidget> {
  late bool isHome;

  @override
  void initState() {
    super.initState();
    isHome = widget.home;
  }

  void _switchTab(bool home) {
    setState(() {
      isHome = home;
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => home ? const HomeScreen() : const BisnisScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.5,
      height: height * 0.038,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFBC79EF),
            Color(0xFFFA92DF),
          ],
          stops: [0.0, 1.0],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal:  width*0.01),
            child: AnimatedAlign(
              
              alignment: isHome ? Alignment.centerLeft : Alignment.centerRight,
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: width * 0.24,
                height: height * 0.03,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF34005B),
                      Color(0xFF6E01C1),
                    ],
                    stops: [0.0, 1.0],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(7.0),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => _switchTab(true),
                child: Container(
                  width: width * 0.24,
                  height: height * 0.03,
                  color: Colors.transparent, // Transparent clickable area
                  child:  const Center(
                    child: Text(
                      "Personal",
                      style: TextStyle(
                        color: Colors.white ,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _switchTab(false),
                child: Center(
                  child: Container(
                    width: width * 0.24,
                    height: height * 0.03,
                    color: Colors.transparent, // Transparent clickable area
                    child: const Center(
                      child: Text(
                        "Bisnis",
                        style: TextStyle(
                          color: Colors.white ,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
