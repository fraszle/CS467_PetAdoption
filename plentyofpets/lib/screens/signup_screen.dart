import 'package:flutter/material.dart';
import 'package:plentyofpets/components/registration_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
      child: Align(alignment: Alignment.center, child: RegistrationForm()),
    ));
  }
}
