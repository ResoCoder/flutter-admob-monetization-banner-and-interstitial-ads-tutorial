import 'package:flutter/material.dart';
import 'package:flutter_admob_monetization_banner_and_interstitial_ads_tutorial/presentation/home_page.dart';

void main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admob Monetization - Banner & Interstitial Ads',
      home: HomePage(),
    );
  }
}
