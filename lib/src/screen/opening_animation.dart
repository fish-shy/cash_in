import 'package:cash_in/src/screen/opening_screen.dart';
import 'package:flutter/material.dart';

class OpeningAnimation extends StatefulWidget {
  const OpeningAnimation({super.key});

  @override
  State<OpeningAnimation> createState() => _HomeState();
}

class _HomeState extends State<OpeningAnimation> with TickerProviderStateMixin {
  late AnimationController _revealController;
  late AnimationController _scaleController;
  late Animation<double> _revealAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _revealAnimation2;
  
  bool _showLogo = false;

  @override
  void initState() {
    super.initState();

    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _revealAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_revealController);
    _revealAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(_revealController);

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleAnimation = Tween<double>(begin: 20.0, end: 1.0).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));
  
    _revealController.forward();
    _revealController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showLogo = true;
        });
        _scaleController.forward();
      }


    });

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OpeningScreen()));
    });
  }

  @override
  void dispose() {
    _revealController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.white,
            ),
          ),
          
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _revealAnimation,
              builder: (context, child) {
                return ClipOval(
                  clipper: CircularRevealClipper(_revealAnimation.value),
                  child: Container(
                    color: const Color.fromRGBO(55, 51, 83, 1.0),
                  ),
                );
              },
            ),
          ),

          Center(
            child: Visibility(
              visible: _showLogo,
              child: AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Image.asset(
                      'assets/images/Group 4.png',
                      width: MediaQuery.of(context).size.width*100,
                      height: MediaQuery.of(context).size.height*100,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircularRevealClipper extends CustomClipper<Rect> {
  final double revealPercent;

  CircularRevealClipper(this.revealPercent);

  @override
  Rect getClip(Size size) {
    final epicenter = Offset(size.width / 2, size.height / 2);
    final radius = size.longestSide * revealPercent;
    return Rect.fromCircle(center: epicenter, radius: radius);
  }

  @override
  bool shouldReclip(CircularRevealClipper oldClipper) {
    return oldClipper.revealPercent != revealPercent;
  }
}