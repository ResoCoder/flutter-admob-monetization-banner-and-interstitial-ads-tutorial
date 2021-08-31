class NewsArticle {
  static final List<NewsArticle> articles = [
    NewsArticle(
      headline:
          'World\'s spiciest donut will literally make you breathe fire!!!',
      asset: 'assets/donuts-min.jpg',
    ),
    NewsArticle(
      headline:
          'An absolute masterpiece! Painting of an invisible avocado sells for \$1 billion.',
      asset: 'assets/canvas-min.jpg',
    ),
    NewsArticle(
      headline:
          'Remarkable! A cross between a dollar bill and a houseplant proves money really does grow on trees.',
      asset: 'assets/money-tree-min.jpg',
    ),
    NewsArticle(
      headline:
          'Young app developer wins coffee drinking contest after consuming 4 buckets of coffee in 2 hours.',
      asset: 'assets/coffee-min.jpg',
    ),
    NewsArticle(
      headline:
          'In a groundbreaking discovery researchers find that fruits and vegetables are good for you. ',
      asset: 'assets/fruits-min.jpg',
    ),
    NewsArticle(
      headline:
          'Breaking News: Giant raccoon invades the city, destroying everything in sight!',
      asset: 'assets/raccoon-min.jpg',
    ),
    NewsArticle(
      headline:
          'Life Tips: Become more productive by becoming more productive!',
      asset: 'assets/productivity-min.jpg',
    ),
    NewsArticle(
      headline: 'Talking cow speaks out, predicts the future of humanity.',
      asset: 'assets/cow-min.jpg',
    ),
  ];
  final String headline;
  final String asset;
  NewsArticle({
    required this.headline,
    required this.asset,
  });
}
