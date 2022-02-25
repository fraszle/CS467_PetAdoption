import 'package:flutter/material.dart';
import 'package:plentyofpets/components/news_form.dart';

class AddNewsScreen extends StatelessWidget {
  const AddNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add a News Article'),
      ),
      body: const NewsForm(),
    );
  }
}
