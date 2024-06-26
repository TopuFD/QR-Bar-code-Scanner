import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qb_scanner/admob%20ad/banner_ad.dart';
import 'package:qb_scanner/pages/code_generator/generate_feture/email.dart';
import 'package:qb_scanner/pages/code_generator/generate_feture/facebook.dart';
import 'package:qb_scanner/pages/code_generator/generate_feture/instaggam.dart';
import 'package:qb_scanner/pages/code_generator/generate_feture/text.dart';
import 'package:qb_scanner/pages/code_generator/generate_feture/twitter.dart';
import 'package:qb_scanner/pages/code_generator/generate_feture/website.dart';
import 'package:qb_scanner/pages/code_generator/generate_feture/whatsapp.dart';
import 'package:qb_scanner/pages/code_generator/generate_feture/youtube.dart';

class CodeCreatePage extends StatefulWidget {
  const CodeCreatePage({super.key});

  @override
  State<CodeCreatePage> createState() => _CodeCreatePageState();
}

class _CodeCreatePageState extends State<CodeCreatePage> {
  BannerClass bannerClass = BannerClass();
  bool isBannerAd = false;
  @override
  void initState() {
    super.initState();
    bannerClass.bannerAd.load().then((value) {
      Timer(const Duration(milliseconds: 1200), () {
        setState(() {
          isBannerAd = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var adWidget = AdWidget(ad: bannerClass.bannerAd);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Code Creator",
          style: TextStyle(
              fontSize: 25.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: EdgeInsets.only(top: isBannerAd ? 50.h : 0.h),
            child: SizedBox(
              height: double.maxFinite,
              child: GridView.count(
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.h,
                crossAxisCount: 3,
                children: [
                  _customButton(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FacebookPage()));
                  },
                      const Icon(
                        Icons.facebook,
                        color: Colors.blue,
                      ),
                      "Facebook"),
                  _customButton(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const EmailPage()));
                  },
                      const Icon(
                        Icons.email,
                        color: Colors.blue,
                      ),
                      "Email"),
                  _customButton(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const YoutubePage()));
                  },
                      const FaIcon(
                        FontAwesomeIcons.youtube,
                        color: Colors.red,
                      ),
                      "YouTube"),
                  _customButton(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const WhatsappPage()));
                  },
                      const FaIcon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.green,
                      ),
                      "WhatsApp"),
                  _customButton(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const TwitterPage()));
                  },
                      const FaIcon(
                        FontAwesomeIcons.twitter,
                        color: Colors.blue,
                      ),
                      "Twitter"),
                  _customButton(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const InstagramPage()));
                  },
                      const FaIcon(
                        FontAwesomeIcons.instagram,
                        color: Color(0xFF8800FF),
                      ),
                      "Instagram"),
                  _customButton(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const WebsitePage()));
                  },
                      const FaIcon(
                        FontAwesomeIcons.globe,
                        color: Colors.blueGrey,
                      ),
                      "Website"),
                  // _customButton(
                  //     () {},
                  //     const Icon(
                  //       Icons.contact_page,
                  //       color: Colors.blue,
                  //     ),
                  //     "Contact"),
                  // _customButton(
                  //     () {},
                  //     const Icon(
                  //       Icons.wifi,
                  //       color: Colors.blue,
                  //     ),
                  //     "Wi-Fi"),
                  // _customButton(
                  //     () {},
                  //     const Icon(
                  //       Icons.location_on,
                  //       color: Colors.blue,
                  //     ),
                  //     "Location"),
                  // _customButton(
                  //     () {},
                  //     const FaIcon(
                  //       FontAwesomeIcons.calendar,
                  //       color: Colors.purple,
                  //     ),
                  //     "Calendar"),
                  // _customButton(
                  //     () {},
                  //     const Icon(
                  //       Icons.apps,
                  //       color: Colors.blue,
                  //     ),
                  //     "Apps"),
                  _customButton(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const TextPage()));
                  },
                      const Icon(
                        Icons.text_fields,
                        color: Colors.blue,
                      ),
                      "Text"),
                ],
              ),
            ),
          ),
          Positioned(
            top: 4.0,
            left: 0.0,
            right: 0.0,
            child: SizedBox(
              height: 50,
              child: adWidget,
            ),
          ),
        ],
      ),
    );
  }
  // this is custom Button method
  _customButton(ontap, icon, String text) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: icon,
                ),
              ),
              Text(
                text,
                style: const TextStyle(fontSize: 17, color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
