import 'package:flutter/material.dart';

class PawPrint extends StatelessWidget {
  final double angle;
  const PawPrint({required this.angle, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: angle,
        child: Image.asset(
          'assets/images/paw.png',
          width: MediaQuery.of(context).size.width * 0.1,
          color: Colors.brown.shade100,
        ));
  }
}
