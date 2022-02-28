import 'package:flutter/material.dart';
import 'package:plentyofpets/components/home_filter_form.dart';

class HomeFilterScreen extends StatelessWidget {
  const HomeFilterScreen({Key? key}) : super(key: key);

  static const routeName = '/homeFilterScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Pet List'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: HomeFilterForm(),
      ),
    );
  }
}
