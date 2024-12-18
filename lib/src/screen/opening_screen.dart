import 'package:flutter/material.dart';
import 'package:cash_in/src/widget/bottom_pop_up_widget.dart';

class OpeningScreen extends StatefulWidget {
  const OpeningScreen({super.key});

  @override
  _OpeningScreenState createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {
  bool _animateWave = false; 

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _animateWave = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: height * 0.035),
              child: const Center(
                child: Image(
                  image: AssetImage('assets/images/Group 2.png'),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 2, 20, 10),
              child: Text(
                'Selamat Datang!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.08,
                  color: const Color.fromARGB(255, 71, 54, 140),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 5, 15, 20),
              child: Text(
                "Masuk sekarang untuk mendapatkan informasi terbaru\n"
                "tentang lokasi penukaran uang tunai di sektor anda",
                style: TextStyle(
                  fontSize: width * 0.03,
                  color: const Color.fromARGB(255, 71, 54, 140),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                        colors: [
                          Colors.white,
                          Color.fromARGB(255, 191, 151, 255),
                        ],
                      ),
                    ),
                  ),
                  const Column(
                    children: [
                      Image(
                        image: AssetImage('assets/images/Moneyverse Buy Online.png'),
                      ),
                    ],
                  ),
                  _animasiWave(height),
                  _layananText(height, width, context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedPositioned _animasiWave(double height) {
    return AnimatedPositioned(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeInOut,
                  bottom: _animateWave ? 0 : -height * 0.4, 
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    width: double.infinity,
                    height: height * 0.43,
                    child: Image.asset(
                      "assets/images/WAVE 3.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                );
  }

  Positioned _layananText(double height, double width, BuildContext context) {
    return Positioned(
      bottom: height / 40,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Layanan Penukaran Uang!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: width * 0.05,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Nikmati kemudahan akses ke berbagai tempat\n'
            'penukaran uang yang terpercaya dan aman',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: width * 0.03,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          _lanjutkanButton(width, height, context),
        ],
      ),
    );
  }

  Container _lanjutkanButton(
      double width, double height, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: width / 1.45,
      height: height * 0.066,
      child: ElevatedButton(
        onPressed: () => showBottomPopup(context),
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
}
