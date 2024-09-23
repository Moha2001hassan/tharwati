// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class BannerAds extends StatefulWidget {
//   const BannerAds({super.key});
//
//   @override
//   State<BannerAds> createState() => _BannerAdsState();
// }
//
// class _BannerAdsState extends State<BannerAds> {
//   BannerAd? bannerAd;
//   bool isBannerAdLoaded = false;
//
//   void load() {
//     bannerAd = BannerAd(
//       size: AdSize.banner,
//       adUnitId: AdManager.bannerHome,
//       listener: BannerAdListener(onAdLoaded: (ad) {
//         setState(() => isBannerAdLoaded = true);
//       }, onAdFailedToLoad: (ad, error) {
//         print('Banner Ad failed to load: $error');
//         ad.dispose();
//       }),
//       request: const AdRequest(),
//     )..load();
//   }
//
//   @override
//   void initState() {
//     load();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     if (isBannerAdLoaded) {
//       bannerAd!.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Center(
//           child: isBannerAdLoaded
//               ? SizedBox(
//                   width: bannerAd!.size.width.toDouble(),
//                   height: bannerAd!.size.height.toDouble(),
//                   child: AdWidget(ad: bannerAd!),
//                 )
//               : const CircularProgressIndicator(),
//         )
//       ],
//     );
//   }
// }
