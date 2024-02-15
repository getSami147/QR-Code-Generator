
import 'package:flutter/material.dart';
import 'package:flutter_tut/player.dart';
import 'package:flutter_tut/qrScanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final globalKey= GlobalKey();
  String qrdata="";
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('QR Generater'),
        actions: [
          IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const QRScanner(),));
        }, icon: const Icon(Icons.qr_code))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           RepaintBoundary(
            key: globalKey,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              
            ),
            child: Center(
              child: qrdata.isEmpty?const SizedBox()
              :QrImageView(data: qrdata,
              version: QrVersions.auto,
              size: 200,
              ),
            ),
          ),
           ),
           const SizedBox(height: 30,),
           SizedBox(width: MediaQuery.sizeOf(context).width*.9,
           child: TextFormField(
            decoration: const InputDecoration(
              hintText: "Enter Data to Generate the QR Code",
              border: OutlineInputBorder()
              
              ),
              onChanged: (value) {
                qrdata=value;
                setState(() {
                  
                });
              },
           ),
           ),
          ],
        ),
      ),
    );
  }
}

