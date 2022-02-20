import 'dart:math';

import 'package:flutter/material.dart';
import 'package:plentyofpets/components/title.dart';

import '../components/decorations.dart';
import '../components/login_form.dart';
import '../components/logo_carousel.dart';

class LandingScreen extends StatelessWidget {
  final String title = 'Plenty of Pets';
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SafeArea(
            child: ListView(children: [
      Stack(
          clipBehavior: Clip.none,
          children: pawPrintBackground(deviceHeight, deviceWidth) +
              [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: TitleText(text: title),
                    ),
                    LogoCarousel(),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "We're pawsitive you'll find\n your purrfect friend!",
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    percentHeightContainer(deviceHeight, 3),
                    const AuthenticationHandler(),
                  ],
                )
              ])
    ])));
  }

  Container percentHeightContainer(double deviceHeight, int percent) {
    return Container(height: deviceHeight * 0.01 * percent);
  }

  List<Widget> pawPrintBackground(double deviceHeight, double deviceWidth) {
    return [
      Positioned(
          top: deviceHeight * 0.65,
          left: deviceWidth * 0.1,
          child: const PawPrint(angle: pi / 4)),
      Positioned(
          top: deviceHeight * 0.75,
          left: deviceWidth * 0.55,
          child: const PawPrint(
            angle: -pi / 4.5,
          )),
      Positioned(
          top: deviceHeight * 0.3,
          left: deviceWidth * 0.9,
          child: const PawPrint(
            angle: pi / 8,
          )),
      Positioned(
        top: deviceHeight * 0.55,
        left: deviceWidth * 0.7,
        child: const PawPrint(
          angle: pi / 16,
        ),
      ),
      Positioned(
        top: deviceHeight * 0.4,
        left: deviceWidth * 0.05,
        child: const PawPrint(
          angle: -pi / 16,
        ),
      ),
      Positioned(
        top: deviceHeight * 0.9,
        left: deviceWidth * 0.25,
        child: const PawPrint(
          angle: 0,
        ),
      ),
      Positioned(
        top: deviceHeight * 0.85,
        left: deviceWidth * 0.8,
        child: const PawPrint(
          angle: -pi / 14,
        ),
      )
    ];
  }
}
