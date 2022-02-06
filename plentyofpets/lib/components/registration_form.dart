import 'package:flutter/material.dart';
import 'package:plentyofpets/theme.dart';

import '../main.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RegistrationFormState();
  }
}

class RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final double fieldPadding = 5;
  final String titleText = 'Registration';

  String? email;
  String? emailConfirmation;
  String? password;
  String? passwordConfirmation;
  bool organization = false;
  String? organizationName;
  String? organizationUrl;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      title(context),
      FractionallySizedBox(
          widthFactor: 0.7,
          child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: organization ? adminForm() : regularForm())))
    ]);
  }

  List<Widget> regularForm() {
    return emailFields() +
        passwordFields() +
        organizationSwitch() +
        submitButton();
  }

  List<Widget> adminForm() {
    return emailFields() +
        passwordFields() +
        organizationSwitch() +
        adminFields() +
        submitButton();
  }

  Widget title(BuildContext context) {
    /**
     * Returns the title for the Registration page
     */
    return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, fieldPadding),
            child: Stack(children: [
              Text(
                titleText,
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                titleText,
                style: PlentyOfPetsTheme.headlineTextOutline,
              )
            ])));
  }

  List<Widget> emailFields() {
    /**
     * Returns the email and email confirmation form fields.
     */
    return [
      Padding(
          padding: EdgeInsets.all(fieldPadding),
          child: TextFormField(
            decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(0),
                errorStyle: PlentyOfPetsTheme.formErrorText,
                border: UnderlineInputBorder(),
                labelText: 'Email Address'),
            onSaved: (value) => email = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email address.';
              }
              return null;
            },
          )),
      Padding(
          padding: EdgeInsets.all(fieldPadding),
          child: TextFormField(
            decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(0),
                errorStyle: PlentyOfPetsTheme.formErrorText,
                border: UnderlineInputBorder(),
                labelText: 'Confirm Your Email Address'),
            onSaved: (value) => emailConfirmation = value,
            validator: (value) {
              if (value != email) {
                return 'Emails do not match.';
              }
              return null;
            },
          ))
    ];
  }

  List<Widget> passwordFields() {
    /**
     * Returns the password and password confirmation form fields
     */
    return [
      Padding(
          padding: EdgeInsets.all(fieldPadding),
          child: TextFormField(
            obscureText: true,
            enableSuggestions: false,
            decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(0),
                errorStyle: PlentyOfPetsTheme.formErrorText,
                border: UnderlineInputBorder(),
                labelText: 'Password'),
            onSaved: (value) => password = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password.';
              }
              return null;
            },
          )),
      Padding(
          padding: EdgeInsets.all(fieldPadding),
          child: TextFormField(
            obscureText: true,
            enableSuggestions: false,
            decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(0),
                errorStyle: PlentyOfPetsTheme.formErrorText,
                border: UnderlineInputBorder(),
                labelText: 'Confirm Your Password'),
            onSaved: (value) => passwordConfirmation = value,
            validator: (value) {
              if (value != password) {
                return 'Passwords do not match.';
              }
              return null;
            },
          ))
    ];
  }

  List<Widget> organizationSwitch() {
    /**
     * Returns a SwitchListTile for users to indicate if they are representing
     * and organization or not.
     */
    return [
      Padding(
          padding: EdgeInsets.all(fieldPadding),
          child: SwitchListTile(
              title: const Text('Are you representing a pet shelter?'),
              value: organization,
              onChanged: (value) {
                setState(() {
                  organization = value;
                });
              }))
    ];
  }

  List<Widget> adminFields() {
    /**
     * Returns a list of Form Fields only used for registering admins.
     */
    return [
      Padding(
          padding: EdgeInsets.all(fieldPadding),
          child: TextFormField(
            decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(0),
                errorStyle: PlentyOfPetsTheme.formErrorText,
                border: UnderlineInputBorder(),
                labelText: 'Shelter Name'),
            onSaved: (value) => organizationName = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a shelter name.';
              }
              return null;
            },
          )),
      Padding(
          padding: EdgeInsets.all(fieldPadding),
          child: TextFormField(
            decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(0),
                errorStyle: PlentyOfPetsTheme.formErrorText,
                border: UnderlineInputBorder(),
                labelText: 'Shelter Website'),
            onSaved: (value) => organizationUrl = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a website.';
              }
              if (!Uri.parse(value).isAbsolute) {
                return 'Please enter a valid URL.';
              }
              return null;
            },
          ))
    ];
  }

  List<Widget> submitButton() {
    /**
     * Returns the submit button for the form.
     */
    return [
      Padding(
          padding: EdgeInsets.all(fieldPadding),
          child: OutlinedButton(
              onPressed: register,
              child:
                  Text('sign up', style: Theme.of(context).textTheme.button)))
    ];
  }

  void register() {
    /**
     * Validates the registration form and creates the user in Firebase.
     */
    _formKey.currentState!.save();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // TODO: Add calls to Firebase Auth and Firestore to create user

    Navigator.pushNamed(context, MyApp.homeRoute);
  }
}
