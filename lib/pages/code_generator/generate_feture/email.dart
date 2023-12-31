import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qb_scanner/Utils/Reusable_Widget/toast.dart';
import 'package:qb_scanner/pages/code_generator/barcode_result.dart';
import 'package:qb_scanner/pages/code_generator/qrcode_result.dart';

class EmailPage extends StatelessWidget {
  const EmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Column(
          children: [
            Text(
              "Enter Email Link :",
              style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextFormField(
              controller: textEditingController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (textEditingController.text.isNotEmpty) {
                       RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
                        if (emailRegExp.hasMatch(textEditingController.text)) {
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
                    child: Text("QR Generate",style: TextStyle(fontSize: 15.sp,color: Colors.black),)),
                ElevatedButton(
                    onPressed: () {
                      if (textEditingController.text.isNotEmpty) {
                        RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
                        if (emailRegExp.hasMatch(textEditingController.text)) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BarcodeGenerateResult(
                                        barcodeData: textEditingController.text,
                                      )));
                        } else {
                          CustomToast().showToast("Enter the Right url");
                        }
                      } else {
                        CustomToast().showToast("Enter you Link");
                      }
                    },
                    child: Text("Barcode Generate",style: TextStyle(fontSize: 15.sp,color: Colors.black),)),
              ],
            )
          ],
        ),
      ),
    );
    
  }
}
