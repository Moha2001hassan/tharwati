import 'package:flutter/material.dart';

import '../../shared_widgets/basic_appbar.dart';

class BannerAdsScreen extends StatelessWidget {
  const BannerAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BasicAppBar(title: "Banner Ads"),
    );
  }
}
