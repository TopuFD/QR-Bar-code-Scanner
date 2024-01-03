import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qb_scanner/Utils/Reusable_Widget/toast.dart';
import 'package:qb_scanner/pages/code_generator/qrcode_result.dart';

class TwitterPage extends StatelessWidget {
  const TwitterPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Twitter"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Container(
          height: 250.h,
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
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
              AnimatedTextKit(repeatForever: true, animatedTexts: [
                TypewriterAnimatedText(
                    speed: const Duration(milliseconds: 120),
                    "Enter Twitter Link :",
                    textStyle: TextStyle(
                        fontSize: 23.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ]),
              SizedBox(
                height: 15.h,
              ),
              TextFormField(
                maxLines: 3,
                controller: textEditingController,
                decoration: InputDecoration(
                    labelText: "Twitter",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20.sp),
                    hintText: "Write Twitter Link here...",
                    border: const OutlineInputBorder()),
              ),
              SizedBox(
                height: 15.h,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(315.w, 50.h)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                      elevation: MaterialStateProperty.all(3),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    if (textEditingController.text.isNotEmpty) {
                      RegExp twitterRegExp =
                          RegExp(r'^https:\/\/twitter\.com\/[a-zA-Z0-9_]+$');
                      if (twitterRegExp.hasMatch(textEditingController.text)) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => QrGenerateResult(
                                    qrData: textEditingController.text)));
                      } else {
                        CustomToast().showToast("Enter the Right url");
                      }
                    } else {
                      CustomToast().showToast("Enter you Link");
                    }
                  },
                  child: Text(
                    "QR Code Generate",
                    style: TextStyle(fontSize: 18.sp, color: Colors.black),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
