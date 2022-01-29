import 'package:flutter/material.dart';

import '../main.dart';

class SignupLink extends StatelessWidget {
  const SignupLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'New User?',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SignupButton()
      ],
    ));
  }
}

class SignupButton extends StatelessWidget {
  const SignupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, MyApp.signupRoute);
        },
        child: Text(
          'Signup!',
          style: Theme.of(context).textTheme.button,
        ));
  }
}
