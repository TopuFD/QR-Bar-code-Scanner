import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qb_scanner/Utils/Reusable_Widget/toast.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class BarcodeResult extends StatefulWidget {
  String barCode;
  BarcodeResult({super.key, required this.barCode});

  @override
  State<BarcodeResult> createState() => _BarcodeResultState();
}

class _BarcodeResultState extends State<BarcodeResult> {
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Barcode Result"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  widget.barCode = "";
                });
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
                size: 35.sp,
              ))
        ],
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
                        color: Color.fromARGB(255, 160, 159, 159),
                        blurRadius: 4.0,
                        spreadRadius: 1.0,
                        offset: Offset.zero)
                  ]),
              child: Text(
                "Barcode : ${widget.barCode}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.sp,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
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
                        data: widget.barCode,
                        barcode: Barcode.code128(),
                        width: 200.w,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                                Size(270.w, 50.h)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            elevation: MaterialStateProperty.all(3),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        onPressed: () {
                          launchUrl(Uri.parse(
                              "https://www.google.com/search?q=${widget.barCode}"));
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
            )
          ],
        ),
      ),
    );
  }

  //This is copy method
  Future<void> toCopy() async {
    try {
      await Clipboard.setData(ClipboardData(text: widget.barCode))
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
