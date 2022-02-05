import 'package:flutter/material.dart';

// Displays News Feed (stretch goal)
class NewsFeed extends StatelessWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Feed!'),
      ),
      body: Center(
        child: Placeholder(),
      ),
    );
  }
}
