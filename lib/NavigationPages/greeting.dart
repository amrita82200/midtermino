import 'package:flutter/material.dart';
import 'package:chat_midterm/app_theme.dart';
import 'package:chat_midterm/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GreetingPage extends StatefulWidget {
  late BannerAd _bannerAd;

  // COMPLETE: Add _isBannerAdReady
  bool _isBannerAdReady = false;

  // COMPLETE: Add _interstitialAd
  InterstitialAd? _interstitialAd;

  // COMPLETE: Add _isInterstitialAdReady
  bool _isInterstitialAdReady = false;

  // COMPLETE: Add _rewardedAd
  RewardedAd? _rewardedAd;

  // COMPLETE: Add _isRewardedAdReady
  bool _isRewardedAdReady = false;

  void initState() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();

    // COMPLETE: Load a Rewarded Ad
    _loadRewardedAd();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
              if(_isBannerAdReady)
                Align(
                  alignment:Alignment.topCenter,
                  child: Container(
                    width: _bannerAd.size.width.toDouble(),
                    height: _bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd),
                    ),
      ),//align
      ))
    );
  }//wigit

  // COMPLETE: Implement _loadInterstitialAd()
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              _moveToHome();
            },
          );

          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  // COMPLETE: Implement _loadRewardedAd()
  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          this._rewardedAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                _isRewardedAdReady = false;
              });
              _loadRewardedAd();
            },
          );

          setState(() {
            _isRewardedAdReady = true;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
          setState(() {
            _isRewardedAdReady = false;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    // COMPLETE: Dispose a BannerAd object
    _bannerAd.dispose();

    // COMPLETE: Dispose an InterstitialAd object
    _interstitialAd?.dispose();

    // COMPLETE: Dispose a RewardedAd object
    _rewardedAd?.dispose();

    super.dispose();
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
