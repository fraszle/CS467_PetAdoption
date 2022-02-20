import 'package:flutter/material.dart';

import '../theme.dart';

/// Stylized text for displaying Titles
class TitleText extends StatelessWidget {
  final String text;

  const TitleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Text(
        text,
        style: Theme.of(context).textTheme.headline3,
      ),
      Text(
        text,
        style: PlentyOfPetsTheme.headlineTextOutline,
      )
    ]);
  }
}
