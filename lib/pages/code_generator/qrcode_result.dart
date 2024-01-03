import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qb_scanner/Utils/Reusable_Widget/toast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class QrGenerateResult extends StatefulWidget {
  String qrData;
  QrGenerateResult({super.key, required this.qrData});

  @override
  State<QrGenerateResult> createState() => _QrGenerateResultState();
}

class _QrGenerateResultState extends State<QrGenerateResult> {
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
        title: const Text("Generated Code"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Link Here :",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
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
                    ],
                  ),
                  SelectableText(
                    widget.qrData,
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
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
                        color: Color.fromARGB(255, 160, 159, 159),
                        blurRadius: 4.0,
                        spreadRadius: 1.0,
                        offset: Offset.zero)
                  ]),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 18.h),
                child: Column(
                  children: [
                    Text(
                      "Qr Code Here :",
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Screenshot(
                      controller: screenshotController,
                      child: QrImageView(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10.w),
                        backgroundColor: Colors.white,
                        data: widget.qrData,
                        size: 140.h,
                        version: QrVersions.auto,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
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
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite,
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
                                onPressed: () {
                                  toShare();
                                },
                                icon: Icon(
                                  Icons.share,
                                  size: 20.sp,
                                  color: Colors.white,
                                ))),
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

  //This is copy method
  Future<void> toCopy() async {
    try {
      await Clipboard.setData(ClipboardData(text: widget.qrData)).then((value) {
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

  //here is share method
  Future<void> toShare() async {
    try {
      Uint8List? imageBytes = await screenshotController.capture();
      if (imageBytes != null) {
        // Save the image bytes to a file
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/widget_image.png');
        await file.writeAsBytes(imageBytes);
        await Share.shareXFiles(
          [XFile(file.path)],
        );
      }
    } catch (e) {
      CustomToast().showToast(e.toString());
    }
  }
}
