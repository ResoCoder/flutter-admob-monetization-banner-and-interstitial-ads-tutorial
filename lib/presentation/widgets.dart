import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.article_outlined),
        Text('Latest News'),
      ],
    );
  }
}

class ArticleTile extends StatelessWidget {
  final article;
  const ArticleTile({
    Key? key,
    this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo[600],
      elevation: 4,
      child: Column(
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(article.asset),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 6.0,
              vertical: 10,
            ),
            child: Column(
              children: [
                Text(
                  article.headline,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  style: TextStyle(
                    color: Colors.indigo[50],
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.share,
                      color: Colors.yellowAccent[700],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.favorite_outline_rounded,
                      color: Colors.pink[200],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
