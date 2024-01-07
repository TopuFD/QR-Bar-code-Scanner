import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InternstitialClass{
  
  InterstitialAd? _interstitialAd;
  static String interstitialId = "ca-app-pub-3940256099942544/1033173712";
  bool _adShownRecently = false;
  void myInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: interstitialId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint("ad is loaded");
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint("A error");
        },
      ),
    );
  }

  showInterstitialAd() {
    if (!_adShownRecently) {
      if (_interstitialAd != null) {
        _interstitialAd?.fullScreenContentCallback =
            FullScreenContentCallback(
          onAdShowedFullScreenContent: (ad) {
            _adShownRecently = true;
          },
          onAdDismissedFullScreenContent: (ad) {
            myInterstitialAd();
          },
          onAdFailedToShowFullScreenContent: (ad, error) {
            myInterstitialAd();
          },
        );

        _interstitialAd?.show();
      } else {
        debugPrint("ad is not ready");
      }

      Timer(const  Duration(seconds: 5), () {
        _adShownRecently = false;
      });
    } else {
      debugPrint("Ad was shown recently, wait for the cooldown period");
    }
  }

  void dispose() {}
}