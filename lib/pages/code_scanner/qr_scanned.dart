import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qb_scanner/Utils/Reusable_Widget/toast.dart';
import 'package:qb_scanner/model/data_model.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ResultPage extends StatefulWidget {
  String qrResult;
  String date;
  ResultPage({super.key, required this.qrResult, required this.date});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  ScreenshotController screenshotController = ScreenshotController();
  var favoriteBox = Hive.box("Favorite");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("The Result"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  widget.qrResult = "";
                });
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
                size: 30.sp,
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        "Link Hare :",
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
                    widget.qrResult,
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
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Column(
                  children: [
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
                                  favorite();
                                },
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
                    SizedBox(
                      height: 15.h,
                    ),
                    Screenshot(
                      controller: screenshotController,
                      child: QrImageView(
                        backgroundColor: Colors.white,
                        data: widget.qrResult,
                        version: QrVersions.auto,
                        size: 140.h,
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
            ),
          ],
        ),
      ),
    );
  }

  //add to favorite
  Future<void> favorite() async {
    try {
      var qrCodeFavorite = DataModel(title: widget.qrResult, date: widget.date);
      await favoriteBox.add(qrCodeFavorite);
      await qrCodeFavorite.save().then((value) {
        CustomToast().showToast("Add Favorite");
      });
    } catch (e) {
      CustomToast().showToast("Error");
    }
  }

  // launched to url
  Future<void> _launcherUrl() async {
    if (await canLaunchUrl(Uri.parse(widget.qrResult))) {
      await launchUrl(Uri.parse(widget.qrResult));
    } else {
      CustomToast().showToast("URL Not Recogniged");
    }
  }

  //This is copy method
  Future<void> toCopy() async {
    try {
      await Clipboard.setData(ClipboardData(text: widget.qrResult))
          .then((value) {
        CustomToast().showToast("Copyied");
      });
    } catch (e) {
      CustomToast().showToast("Faild To Copyied");
    }
  }
// code capture and download method
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
