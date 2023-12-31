import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qb_scanner/Utils/Reusable_Widget/toast.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class BarcodeGenerateResult extends StatelessWidget {
  String barcodeData;
  BarcodeGenerateResult({super.key, required this.barcodeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generated barcode",
          style: TextStyle(
              fontSize: 25.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
                width: double.infinity,
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
                child: Text(
                  barcodeData,
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )),
            SizedBox(
              height: 20.h,
            ),
            Container(
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
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Column(
                  children: [
                    BarcodeWidget(
                      data: barcodeData,
                      barcode: Barcode.code128(),
                      width: 250,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(5),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            onPressed: () {
                              _launcherUrl();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              child: const Text(
                                "Visit Website",
                                style: TextStyle(color: Colors.black),
                              ),
                            )),
                        ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(5),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            onPressed: () {
                              try {
                                Clipboard.setData(
                                        ClipboardData(text: barcodeData))
                                    .then((value) {
                                  CustomToast().showToast("Copyied");
                                });
                              } catch (e) {
                                CustomToast().showToast("Faild To Copyied");
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 15.h),
                              child: const Text(
                                "Copy Code",
                                style: TextStyle(color: Colors.black),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launcherUrl() async {
    if (await canLaunchUrl(Uri.parse(barcodeData))) {
      await launchUrl(Uri.parse(barcodeData));
    } else {
      CustomToast().showToast("URL Not Recogniged");
    }
  }
}
