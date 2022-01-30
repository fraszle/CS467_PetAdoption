import 'package:flutter/material.dart';

import '../main.dart';

class AuthenticationHandler extends StatefulWidget {
  const AuthenticationHandler({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AuthenticationHandlerState();
  }
}

class AuthenticationHandlerState extends State<AuthenticationHandler> {
  final controller = TextEditingController();
  bool showLoginForm = false;

  Widget authenticationButtons() {
    /**
     * Widget that lets the user choose to signup or login
     */
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(10),
            child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    showLoginForm = true;
                  });
                },
                child:
                    Text('login', style: Theme.of(context).textTheme.button))),
        Padding(
            padding: const EdgeInsets.all(10),
            child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyApp.homeRoute);
                },
                child:
                    Text('signup', style: Theme.of(context).textTheme.button)))
      ],
    );
  }

  Widget loginForm() {
    /**
     * Form that lets the user login.
     */
    return Form(
        child: Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Username'),
            )),
        Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              obscureText: true,
              enableSuggestions: false,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Password'),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showLoginForm = false;
                    });
                  },
                  child: const Icon(Icons.arrow_back),
                )),
            Flexible(
                flex: 2,
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MyApp.homeRoute);
                    },
                    child: Text('login',
                        style: Theme.of(context).textTheme.button))),
            const Flexible(flex: 1, fit: FlexFit.tight, child: SizedBox())
          ],
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: 0.8,
        child: showLoginForm ? loginForm() : authenticationButtons());
  }
}
