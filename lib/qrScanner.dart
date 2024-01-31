import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_tut/qrScannerResult.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isScanCompleted = false;
  bool isFlashOn = false;
  bool isFrontCamra = false;
  MobileScannerController mobileScannerController = MobileScannerController();
  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('QR Scanner'),
        centerTitle: true,
        actions: [
          
          // Flash....
          IconButton(
              onPressed: () {
                isFlashOn = !isFlashOn;
                setState(() {});
                mobileScannerController.toggleTorch();
                
              },
              icon:  Icon(
                Icons.flash_on,
                color:isFlashOn? Colors.blue:Colors.grey,
              )),

            // Swith camra....
          IconButton(
              padding: const EdgeInsets.only(right: 15),
              onPressed: () {
                isFrontCamra = !isFrontCamra;
                setState(() {});
                mobileScannerController.switchCamera();
              },
              icon:isFrontCamra? const Icon(
                Icons.switch_camera_outlined,
                color: Colors.blue,
              ):const Icon(
                Icons.camera_alt,
                color: Colors.blue,
              ))
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            const Expanded(
                child: Column(
              children: [
                Text(
                  "Place the QR Code in The Area",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      letterSpacing: 1),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Scanning will the Start Automatically"),
              ],
            )),
            Expanded(
                flex: 4,
                child: Container(
                  color: Colors.red,
                  child: Stack(
                    children: [
                      MobileScanner(
                        controller: mobileScannerController,
                        onDetect: (barcodes) {
                          if (!isScanCompleted) {
                            var code =
                                barcodes.raw[0]['rawValue'].toString() ?? '...';
                            print("Code: ${code}");

                            isScanCompleted = true;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QRScannerResult(
                                      code: code, closeScreen: closeScreen),
                                ));
                          } else {
                            print("else");
                          }
                        },
                      ),
                      QRScannerOverlay(
                        overlayColor: Colors.white,
                        borderColor: Colors.blue,
                      )
                    ],
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            const Expanded(child: Text("Develped by Sami Ullah")),
          ],
        ),
      ),
    );
  }
}
