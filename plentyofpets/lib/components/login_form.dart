import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plentyofpets/theme.dart';

import '../main.dart';

class AuthenticationHandler extends StatefulWidget {
  const AuthenticationHandler({Key? key}) : super(key: key);

  @override
  State<AuthenticationHandler> createState() {
    return AuthenticationHandlerState();
  }
}

class AuthenticationHandlerState extends State<AuthenticationHandler> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final controller = TextEditingController();

  bool showLoginForm = false;
  String? email;
  String? password;

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
        key: _formKey,
        child: Column(
          children: [
            emailField(),
            passwordField(),
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
                        onPressed: submitCredentials,
                        child: Text('login',
                            style: Theme.of(context).textTheme.button))),
                const Flexible(flex: 1, fit: FlexFit.tight, child: SizedBox())
              ],
            )
          ],
        ));
  }

  Widget emailField() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          decoration: const InputDecoration(
              errorStyle: PlentyOfPetsTheme.formErrorText,
              border: UnderlineInputBorder(),
              labelText: 'Email'),
          onSaved: (value) => email = value,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter an email address';
            }
            return null;
          },
        ));
  }

  Widget passwordField() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          obscureText: true,
          enableSuggestions: false,
          decoration: const InputDecoration(
              errorStyle: PlentyOfPetsTheme.formErrorText,
              border: UnderlineInputBorder(),
              labelText: 'Password'),
          onSaved: (value) => password = value,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a password';
            }
            return null;
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: 0.8,
        child: showLoginForm ? loginForm() : authenticationButtons());
  }

  void submitCredentials() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    try {
      await auth.signInWithEmailAndPassword(email: email!, password: password!);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
        case "wrong-password":
        case "invalid-email":
          showLoginErrorDialog('Invalid email address or password provided.');
          break;
        default:
          showLoginErrorDialog('An unknown error occured. Please try again.');
      }
      return;
    }

    Navigator.pushNamed(context, MyApp.homeRoute);
  }

  void showLoginErrorDialog(String errorMsg) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text(
                "Error Logging In",
                textAlign: TextAlign.center,
              ),
              content: Text(errorMsg),
            ));
  }
}
