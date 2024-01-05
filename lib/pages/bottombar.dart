import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qb_scanner/pages/navbar_page/code_generator.dart';
import 'package:qb_scanner/pages/navbar_page/history.dart';
import 'package:qb_scanner/pages/navbar_page/scanner.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var _currentIndex = 0;
  final pages = [const ScannerPage(),const CodeCreatePage(), const HistoryPage(), ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FloatingNavbar(
        elevation: 0,
        backgroundColor: Colors.white,
        selectedBackgroundColor: Colors.blue,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.white,
        margin: EdgeInsets.only(bottom: 0.h),
        padding: EdgeInsets.only(bottom: 0.h),
        iconSize: 20.sp,
        fontSize: 16.sp,
        

        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: [
          FloatingNavbarItem(icon: Icons.qr_code_scanner, title: 'Scanner'),
          FloatingNavbarItem(icon: Icons.create, title: 'Create'),
          FloatingNavbarItem(icon: Icons.history, title: 'History'),
        ],
      ),
      body: pages[_currentIndex],
    );
  }
}
