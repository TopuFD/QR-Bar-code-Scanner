import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qb_scanner/Utils/Reusable_Widget/toast.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class BarcodeGenerateResult extends StatefulWidget {
  String barcodeData;
  BarcodeGenerateResult({super.key, required this.barcodeData});

  @override
  State<BarcodeGenerateResult> createState() => _BarcodeGenerateResultState();
}

class _BarcodeGenerateResultState extends State<BarcodeGenerateResult> {
  ScreenshotController screenshotController = ScreenshotController();
  @override
  void initState() {
    super.initState();
    screenshotController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Generated barcode",
          style: TextStyle(
              fontSize: 25.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
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
                          color: Color.fromARGB(255, 160, 159, 159),
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                          offset: Offset.zero)
                    ]),
                child: Text(
                  widget.barcodeData,
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )),
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.h),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          padding: EdgeInsets.all(1.h),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(50)),
                          child: IconButton(
                              onPressed: () {
                                toCopy();
                              },
                              icon: Icon(
                                Icons.copy,
                                size: 20.sp,
                                color: Colors.white,
                              ))),
                      Container(
                          padding: EdgeInsets.all(1.h),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(50)),
                          child: IconButton(
                              onPressed: () {
                                captureAndDownload();
                              },
                              icon: Icon(
                                Icons.download,
                                size: 20.sp,
                                color: Colors.white,
                              ))),
                      Container(
                          padding: EdgeInsets.all(1.h),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(50)),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.share,
                                size: 20.sp,
                                color: Colors.white,
                              ))),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Screenshot(
                    controller: screenshotController,
                    child: BarcodeWidget(
                      backgroundColor: Colors.white,
                      data: widget.barcodeData,
                      barcode: Barcode.code128(),
                      width: 200.w,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all(Size(270.w, 50.h)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          elevation: MaterialStateProperty.all(3),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launcherUrl() async {
    if (await canLaunchUrl(Uri.parse(widget.barcodeData))) {
      await launchUrl(Uri.parse(widget.barcodeData));
    } else {
      CustomToast().showToast("URL Not Recogniged");
    }
  }

  Future<void> toCopy() async {
    try {
      await Clipboard.setData(ClipboardData(text: widget.barcodeData))
          .then((value) {
        CustomToast().showToast("Copyied");
      });
    } catch (e) {
      CustomToast().showToast("Faild To Copyied");
    }
  }

  Future<void> captureAndDownload() async {
    try {
      Uint8List? image = await screenshotController.capture();
      if (image != null && image.isNotEmpty) {
        await ImageGallerySaver.saveImage(image, name: "Screenshot.png");
        CustomToast().showToast("Saved Successfully");
      } else {
        CustomToast().showToast("Faild To Screenshot");
      }
    } catch (e) {
      CustomToast().showToast(e.toString());
    }
  }
}
