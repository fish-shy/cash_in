import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCode extends StatefulWidget {
  const ScanCode({super.key});

  @override
  State<ScanCode> createState() => _ScanCodeState();
}

class _ScanCodeState extends State<ScanCode> {
  final MobileScannerController _controller = MobileScannerController();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QRCode"),
      ),
      body: MobileScanner(
        controller: _controller,
        onDetect: (BarcodeCapture capture) {
          for (final barcode in capture.barcodes) {
            if (barcode.rawValue != null) {
              final String code = barcode.rawValue!;
          
              break;
            }
          }
        },
      ),
    );
  }
}
