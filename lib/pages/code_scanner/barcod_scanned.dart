import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qb_scanner/Utils/Reusable_Widget/toast.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class BarcodeResult extends StatefulWidget {
  String barCode;
  BarcodeResult({super.key, required this.barCode});

  @override
  State<BarcodeResult> createState() => _BarcodeResultState();
}

class _BarcodeResultState extends State<BarcodeResult> {
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
                        color: Color.fromARGB(165, 0, 0, 0),
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
                      data: widget.barCode,
                      barcode: Barcode.code128(),
                      width: 250.w,
                    ),
                    SizedBox(
                      height: 30.h,
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
                        ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(5),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            onPressed: () {
                              try {
                                Clipboard.setData(
                                        ClipboardData(text: widget.barCode))
                                    .then((value) {
                                  CustomToast().showToast("Copyied");
                                });
                              } catch (e) {
                                CustomToast().showToast("Failed To Copyied");
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 15),
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
            )
          ],
        ),
      ),
    );
  }
}
