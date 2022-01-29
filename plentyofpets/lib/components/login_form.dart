import 'package:flutter/material.dart';

import '../main.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Password'),
            )),
        Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyApp.homeRoute);
                },
                child:
                    Text('Login!', style: Theme.of(context).textTheme.button)))
      ],
    ));
  }
}
