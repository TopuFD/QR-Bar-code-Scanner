import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:qb_scanner/Utils/Reusable_Widget/toast.dart';
import 'package:qb_scanner/admob%20ad/inteernstitial.dart';
import 'package:qb_scanner/model/data_model.dart';
import 'package:qb_scanner/pages/code_scanner/barcod_scanned.dart';
import 'package:qb_scanner/pages/code_scanner/qr_scanned.dart';
import 'package:qb_scanner/pages/favorite.dart';
import 'package:vibration/vibration.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  var historyBox = Hive.box("History");
  bool vibrate = true;
  InternstitialClass internstitialClass = InternstitialClass();

  Future<void> qrCodeScanner() async {
    internstitialClass.showInterstitialAd();
    try {
      String qrCode = await FlutterBarcodeScanner.scanBarcode(
        "#001DF7",
        "Cancel",
        true,
        ScanMode.QR,
      );

      if (qrCode != "-1" && qrCode.isNotEmpty) {
        var scanDateTime = DateTime.now();
        vibrate ? Vibration.vibrate() : Vibration.cancel();
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ResultPage(
                      qrResult: qrCode,
                      date: scanDateTime.toString(),
                    ))).then((value) {
          var qrHistory =
              DataModel(title: qrCode, date: scanDateTime.toString());
          historyBox.add(qrHistory);
          qrHistory.save();
        });
      }
    } on PlatformException {
      CustomToast().showToast("Code is not Recognize");
    }
  }

  Future<void> barCodeScanner() async {
    internstitialClass.showInterstitialAd();
    try {
      String barcode = await FlutterBarcodeScanner.scanBarcode(
        "#001DF7",
        "Cancel",
        true,
        ScanMode.BARCODE,
      );

      if (barcode != "-1" && barcode.isNotEmpty) {
        var dateTime = DateTime.now();
        vibrate ? Vibration.vibrate() : Vibration.cancel();
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => BarcodeResult(
                      barCode: barcode,
                      date: dateTime.toString(),
                    ))).then((value) {
          var barCodeHistory =
              DataModel(title: barcode, date: dateTime.toString());
          historyBox.add(barCodeHistory);
          barCodeHistory.save();
        });
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
          "Code Scanner",
          style: TextStyle(
              fontSize: 25.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                    color: Colors.white),
                child: Column(
                  children: [
                    Image.asset(
                      "images/settings.png",
                      height: 65.h,
                      width: 65.w,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "QR/Bar Code Scanner",
                      style: TextStyle(
                          fontSize: 25.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => FavoritePage()));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.favorite,
                  color: Colors.blueGrey,
                ),
                title: Text("Favorite"),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.mic,
                color: Colors.blueGrey,
              ),
              title: const Text('Beep'),
              subtitle: const Text("on"),
              trailing: Switch(
                  activeColor: Colors.white,
                  activeTrackColor: Colors.blue,
                  value: true,
                  onChanged: (value) {}),
            ),
            ListTile(
              leading: const Icon(
                Icons.vibration,
                color: Colors.blueGrey,
              ),
              title: const Text('Vibrate'),
              subtitle: vibrate ? const Text("ON") : const Text("OFF"),
              trailing: Switch(
                  activeColor: Colors.white,
                  activeTrackColor: Colors.blue,
                  value: vibrate,
                  onChanged: (value) {
                    setState(() {
                      vibrate = value;
                    });
                  }),
            ),
            ListTile(
              leading: const FaIcon(
                FontAwesomeIcons.lightbulb,
                color: Colors.blueGrey,
              ),
              title: const Text('Theme'),
              subtitle: const Text("Light"),
              trailing: Switch(
                  activeColor: Colors.white,
                  activeTrackColor: Colors.blue,
                  value: true,
                  onChanged: (value) {}),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(
                Icons.star,
                color: Colors.blueGrey,
              ),
              title: Text('Rate Us'),
            ),
            const ListTile(
              leading: Icon(
                Icons.question_mark_outlined,
                color: Colors.blueGrey,
              ),
              title: Text('Privacy Policy'),
            ),
            const ListTile(
              leading: Icon(
                Icons.feedback_outlined,
                color: Colors.blueGrey,
              ),
              title: Text('Feedback'),
            ),
            const ListTile(
              leading: Icon(
                Icons.verified,
                color: Colors.blueGrey,
              ),
              title: Text('version'),
              subtitle: Text("1.0.1"),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 5.h,
              ),
              AnimatedTextKit(repeatForever: true, animatedTexts: [
                TypewriterAnimatedText(
                    speed: const Duration(milliseconds: 120),
                    "Click The Button To Scan",
                    textStyle: TextStyle(
                        fontSize: 23.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ]),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      internstitialClass.showInterstitialAd();
                    },
                    child: Container(
                      height: 130.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(255, 160, 159, 159),
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
                      internstitialClass.showInterstitialAd();
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
                                color: Color.fromARGB(255, 160, 159, 159),
                                blurRadius: 4.0,
                                spreadRadius: 1.0,
                                offset: Offset.zero)
                          ]),
                      child: Column(
                        children: [
                          Image.asset(
                            "images/barcode.png",
                            width: 80.w,
                            height: 95.h,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text("Bar Code",
                              style: TextStyle(
                                  fontSize: 18.sp, color: Colors.black))
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
      ),
    );
  }
}
