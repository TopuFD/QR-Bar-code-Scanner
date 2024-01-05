import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:qb_scanner/pages/code_scanner/barcod_scanned.dart';
import 'package:qb_scanner/pages/code_scanner/qr_scanned.dart';

// ignore: must_be_immutable
class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});

  var favoriteBox = Hive.box("Favorite");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              favoriteBox.clear();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              child: Text(
                "Delete All",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
        title: const Text("History"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        child: ValueListenableBuilder(
            valueListenable: favoriteBox.listenable(),
            builder: (context, box, _) {
              final data = favoriteBox.values.toList();
              return favoriteBox.isEmpty
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
                                  horizontal: 0.w, vertical: 5.h),
                              child: ListTile(
                                trailing: IconButton(
                                    onPressed: () {
                                      favoriteBox.deleteAt(index);
                                    },
                                    icon: const Icon(Icons.delete)),
                                leading: Icon(
                                  Icons.favorite,
                                  color:
                                      const Color.fromARGB(255, 253, 105, 94),
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
                                        qrResult: data[index].title,
                                        date: data[index].date,
                                      );
                                    }));
                                  } else {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return BarcodeResult(
                                        barCode: data[index].title,
                                        date: data[index].date,
                                      );
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
