import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qb_scanner/Utils/Reusable_Widget/toast.dart';
import 'package:qb_scanner/pages/code_generator/barcode_result.dart';
import 'package:qb_scanner/pages/code_generator/qrcode_result.dart';

class FacebookPage extends StatelessWidget {
  const FacebookPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Facebook",
          style: TextStyle(
              fontSize: 25.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Column(
          children: [
            Text(
              "Enter Facebook Link :",
              style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextFormField(
              controller: controller,
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
                      if (controller.text.isNotEmpty) {
                        RegExp facebookDomains = RegExp(
                            r"(facebook\.com|Facebook\.com|fb\.com|Fb\.com|messenger\.com|Messenger\.com)");
                        if (facebookDomains.hasMatch(controller.text)) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => QrGenerateResult(
                                      qrData: controller.text)));
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
                      if (controller.text.isNotEmpty) {
                        RegExp facebookDomains = RegExp(
                            r"(facebook\.com|Facebook\.com|fb\.com|Fb\.com|messenger\.com|Messenger\.com)");
                        if (facebookDomains.hasMatch(controller.text)) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BarcodeGenerateResult(
                                        barcodeData: controller.text,
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
