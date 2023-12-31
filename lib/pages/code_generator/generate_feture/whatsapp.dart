import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qb_scanner/Utils/Reusable_Widget/toast.dart';
import 'package:qb_scanner/pages/code_generator/barcode_result.dart';
import 'package:qb_scanner/pages/code_generator/qrcode_result.dart';

class WhatsappPage extends StatelessWidget {
  const WhatsappPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("WhatsApp"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Column(
          children: [
            Text(
              "Enter WhatsApp Link :",
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
                        RegExp whatsAppRegExp = RegExp(r'^https:\/\/wa\.me\/[0-9]+$');
                        if (whatsAppRegExp.hasMatch(textEditingController.text)) {
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
                    child: const Text("QR Generate")),
                ElevatedButton(
                    onPressed: () {
                      if (textEditingController.text.isNotEmpty) {
                        RegExp whatsAppRegExp = RegExp(r'^https:\/\/wa\.me\/[0-9]+$');
                        if (whatsAppRegExp.hasMatch(textEditingController.text)) {
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
                    child: const Text("Barcode Generate")),
              ],
            )
          ],
        ),
      ),
    );
  }
}