import 'package:flutter/material.dart';
import 'package:flutter_admob_monetization_banner_and_interstitial_ads_tutorial/data/ad_helper.dart';
import 'package:flutter_admob_monetization_banner_and_interstitial_ads_tutorial/data/news_article.dart';
import 'package:flutter_admob_monetization_banner_and_interstitial_ads_tutorial/presentation/news_article_page.dart';
import 'package:flutter_admob_monetization_banner_and_interstitial_ads_tutorial/presentation/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const int maxFailedLoadAttempts = 3;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _inlineAdIndex = 3;

  int _interstitialLoadAttempts = 0;

  late BannerAd _bottomBannerAd;
  late BannerAd _inlineBannerAd;
  InterstitialAd? _interstitialAd;

  bool _isBottomBannerAdLoaded = false;
  bool _isInlineBannerAdLoaded = false;

  int _getListViewItemIndex(int index) {
    if (index >= _inlineAdIndex && _isInlineBannerAdLoaded) {
      return index - 1;
    }
    return index;
  }

  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(onAdLoaded: (_) {
        setState(() {
          _isBottomBannerAdLoaded = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        ad.dispose();
      }),
    );
    _bottomBannerAd.load();
  }

  void _createInlineBannerAd() {
    _inlineBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.mediumRectangle,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isInlineBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _inlineBannerAd.load();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback:
            InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialLoadAttempts = 0;
        }, onAdFailedToLoad: (LoadAdError error) {
          _interstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_interstitialLoadAttempts <= maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        }));
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        _createInterstitialAd();
      }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        _createInterstitialAd();
      });
      _interstitialAd!.show();
    }
  }

  @override
  void initState() {
    super.initState();
    _createBottomBannerAd();
    _createInlineBannerAd();
    _createInterstitialAd();
  }

  @override
  void dispose() {
    super.dispose();
    _bottomBannerAd.dispose();
    _inlineBannerAd.dispose();
    _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _isBottomBannerAdLoaded
          ? Container(
              height: _bottomBannerAd.size.height.toDouble(),
              width: _bottomBannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bottomBannerAd),
            )
          : null,
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: AppBarTitle(),
        backgroundColor: Colors.indigo[800],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount:
            NewsArticle.articles.length + (_isInlineBannerAdLoaded ? 1 : 0),
        itemBuilder: (context, index) {
          if (_isInlineBannerAdLoaded && index == _inlineAdIndex) {
            return Container(
              padding: EdgeInsets.only(
                bottom: 10,
              ),
              width: _inlineBannerAd.size.width.toDouble(),
              height: _inlineBannerAd.size.height.toDouble(),
              child: AdWidget(ad: _inlineBannerAd),
            );
          } else {
            final article = NewsArticle.articles[_getListViewItemIndex(index)];
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: GestureDetector(
                onTap: () {
                  _showInterstitialAd();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NewsArticlePage(
                        title: article.headline,
                        imagePath: article.asset,
                      ),
                    ),
                  );
                },
                child: ArticleTile(
                  article: article,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
