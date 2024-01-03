import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:qb_scanner/pages/code_scanner/barcod_scanned.dart';
import 'package:qb_scanner/pages/code_scanner/qr_scanned.dart';

// ignore: must_be_immutable
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  var historyBox = Hive.box("History");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                historyBox.clear();
              },
              icon: const Icon(Icons.delete))
        ],
        title: const Text("History"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        child: ValueListenableBuilder(
            valueListenable: historyBox.listenable(),
            builder: (context, box, _) {
              final data = historyBox.values.toList();
              return historyBox.isEmpty
                  ? Expanded(
                      child: Column(
                      children: [
                        Lottie.asset("images/empty.json"),
                        Text(
                          "Empty",
                          style:
                              TextStyle(fontSize: 25.sp, color: Colors.black),
                        )
                      ],
                    ))
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6.w, vertical: 5.h),
                              child: ListTile(
                                // ignore: prefer_const_constructors
                                leading: Icon(
                                  Icons.history,
                                  color: Colors.purple,
                                  size: 25.sp,
                                ),
                                title: Text(
                                    "Link : ${data[index].title.toString()}"),
                                subtitle: Text(
                                    "Date :${data[index].date.toString()}"),
                                onTap: () {
                                  if (data[index]
                                      .title
                                      .toString()
                                      .startsWith("https")) {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return ResultPage(
                                          qrResult: data[index].title);
                                    }));
                                  } else {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return BarcodeResult(
                                          barCode: data[index].title);
                                    }));
                                  }
                                },
                              )),
                        );
                      });
            }),
      ),
    );
  }
}
