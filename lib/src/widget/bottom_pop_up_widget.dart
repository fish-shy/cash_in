import 'package:cash_in/src/screen/login_screen.dart';
import 'package:cash_in/src/settings/permission_handler.dart';
import 'package:flutter/material.dart';

void showBottomPopup(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  
  showModalBottomSheet(
    sheetAnimationStyle: AnimationStyle(curve: Curves.easeIn, duration: const Duration(milliseconds: 600)),
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
          width: width,
          height: height * 0.63,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/WAVE 3.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: _dalamBorder(width, context, height));
    },
  );
}

Column _dalamBorder(double width, BuildContext context, double height) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(height: height * 0.15),
      Image.asset('assets/images/Moneyverse Standing.png'),
      const SizedBox(height: 15),
      Text(
        "Izin Akses Data Perangkat",
        style: TextStyle(fontSize: width * 0.05, color: Colors.white),
      ),
      const SizedBox(height: 10),
      Text(
        'Demi meningkatkan layanan aplikasi. kami memperbarui\nkebijakan Privasi dan memerlukan izin kamu untuk akses\ndata perangkat ini',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.027,
            color: Colors.white),
      ),
      const SizedBox(height: 25),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _batalButton(context, height, width),
          const SizedBox(width: 20),
          _lanjutkanButton(context, height, width),
        ],
      )
    ],
  );
}

SizedBox _lanjutkanButton(BuildContext context, double height, double width) {
  return SizedBox(
    width: MediaQuery.of(context).size.width / 2.7,
    height: height * 0.07,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color.fromARGB(255, 71, 54, 140),
        shadowColor: Colors.transparent,
        elevation: 0,
        side: const BorderSide(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: () async {
        await PermissionHandler.cameraPermission();
        
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      },
      child: Text(
        "Setuju",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.04),
      ),
    ),
  );
}

SizedBox _batalButton(BuildContext context, double height, double width) {
  return SizedBox(
    width: MediaQuery.of(context).size.width / 2.7,
    height: height * 0.07,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color.fromARGB(255, 62, 47, 122),
        shadowColor: Colors.transparent,
        elevation: 0,
        side: const BorderSide(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(
        "Batal",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.04),
      ),
    ),
  );
}
