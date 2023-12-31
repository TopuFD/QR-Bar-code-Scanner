import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qb_scanner/Utils/Reusable_Widget/toast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ResultPage extends StatelessWidget {
  String qrResult;
  ResultPage({super.key, required this.qrResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("The Result"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
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
                "http:// $qrResult",
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
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
                    QrImageView(
                      data: qrResult,
                      version: QrVersions.auto,
                      size: 200.h,
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
                                Clipboard.setData(ClipboardData(text: qrResult))
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
    if (await canLaunchUrl(Uri.parse(qrResult))) {
      await launchUrl(Uri.parse(qrResult));
    } else {
      CustomToast().showToast("URL Not Recogniged");
    }
  }
}
