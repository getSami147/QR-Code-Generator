import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRScannerResult extends StatefulWidget {
  final String code;
  final Function() closeScreen;
  const QRScannerResult(
      {required this.code, required this.closeScreen, super.key});

  @override
  State<QRScannerResult> createState() => _QRScannerResultState();
}

class _QRScannerResultState extends State<QRScannerResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('QR Scanner'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(data: widget.code,
            size: 200,
            ),
                 const Text(
              "Scanned Result",
              style: TextStyle(fontWeight: FontWeight.w500, letterSpacing: 1),
            ),   const SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
              height: 10,
            ),
            Expanded(child: Center(child: Text(widget.code))),
                IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: widget.code)).then(
                          (value) => Fluttertoast.showToast(
                              msg: "Copied",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0));
                    },
                    icon: const Icon(Icons.copy)),
                
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
