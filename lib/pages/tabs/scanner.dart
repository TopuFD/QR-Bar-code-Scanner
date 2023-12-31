import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qb_scanner/Utils/Reusable_Widget/toast.dart';
import 'package:qb_scanner/pages/code_scanner/barcod_scanned.dart';
import 'package:qb_scanner/pages/code_scanner/qr_scanned.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String qrResult = "";

  Future<void> qrCodeScanner() async {
    try {
      String qrCode = await FlutterBarcodeScanner.scanBarcode(
        "#001DF7",
        "Cancel",
        true,
        ScanMode.QR,
      );

      if (qrCode != "-1" && qrCode.isNotEmpty) {
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ResultPage(
                      qrResult: qrCode,
                    )));
      }
    } on PlatformException {
      CustomToast().showToast("Code is not Recognize");
    }
  }

  Future<void> barCodeScanner() async {
    try {
      String qrCode = await FlutterBarcodeScanner.scanBarcode(
        "#001DF7",
        "Cancel",
        true,
        ScanMode.BARCODE,
      );

      if (qrCode != "-1" && qrCode.isNotEmpty) {
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => BarcodeResult(
                      barCode: qrCode,
                    )));
      }
    } on PlatformException {
      CustomToast().showToast("Code is not Recognize");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "QR Scanner",
          style: TextStyle(
              fontSize: 25.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              size: 30.h,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          children: <Widget>[
            Text(
              "Click The Button To Scan",
              style: TextStyle(
                  fontSize: 23.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    qrCodeScanner();
                    // if (qrResult.isNotEmpty) {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (_) => ResultPage(
                    //                 qrResult: qrResult,
                    //               )));
                    // }
                  },
                  child: Container(
                    height: 130.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(165, 0, 0, 0),
                              blurRadius: 4.0,
                              spreadRadius: 1.0,
                              offset: Offset.zero)
                        ]),
                    child: Column(
                      children: [
                        Image.asset(
                          "images/qrcode.png",
                          height: 100.h,
                          width: 100.w,
                        ),
                        Text(
                          "QR Code",
                          style:
                              TextStyle(fontSize: 18.sp, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    barCodeScanner();
                  },
                  child: Container(
                    height: 130.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(165, 0, 0, 0),
                              blurRadius: 4.0,
                              spreadRadius: 1.0,
                              offset: Offset.zero)
                        ]),
                    child: Column(
                      children: [
                        Image.asset(
                          "images/barcode.png",
                          width: 80.w,
                          height: 90.h,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text("Bar Code",
                            style:
                                TextStyle(fontSize: 18.sp, color: Colors.black))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              height: 250.h,
              color: Colors.blueGrey,
            )
          ],
        ),
      ),
    );
  }
}
