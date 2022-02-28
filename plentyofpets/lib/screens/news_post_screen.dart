import 'package:flutter/material.dart';

import '../components/news_post.dart';

// Displays an individual news item
class NewsPostScreen extends StatelessWidget {
  const NewsPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> post =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(),
      body: NewsPost(post: post),
    );
  }
}
