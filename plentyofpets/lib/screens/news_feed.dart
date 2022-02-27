import 'package:flutter/material.dart';

import '../components/news_feed.dart';

// Displays News Feed (stretch goal)
class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NewsFeed(),
    );
  }
}
