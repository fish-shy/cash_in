import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCode extends StatefulWidget {
  const ScanCode({super.key});

  @override
  State<ScanCode> createState() => _ScanCodeState();
}

class _ScanCodeState extends State<ScanCode> {
  late BarcodeCapture capture;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QRCode"),
      ),

      body: MobileScanner(
        controller: MobileScannerController(
          
        ),
        onDetect: (capture){
          
        },
      ),
    );
  }
}