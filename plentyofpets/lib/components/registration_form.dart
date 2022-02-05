import 'package:flutter/material.dart';
import 'package:plentyofpets/theme.dart';

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

  String? email;
  String? emailConfirmation;
  String? password;
  String? passwordConfirmation;
  bool organization = false;
  String? organizationName;
  String? organizationUrl;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: organization ? adminForm() : regularForm()));
  }

  List<Widget> regularForm() {
    return title() +
        emailFields() +
        passwordFields() +
        organizationSwitch() +
        submitButton();
  }

  List<Widget> adminForm() {
    return title() +
        emailFields() +
        passwordFields() +
        organizationSwitch() +
        adminFields() +
        submitButton();
  }

  List<Widget> title() {
    return [
      Padding(
          padding: EdgeInsets.fromLTRB(0, 40, 0, fieldPadding),
          child: const Text('Registration'))
    ];
  }

  List<Widget> emailFields() {
    return [
      Padding(
          padding: EdgeInsets.all(fieldPadding),
          child: TextFormField(
            decoration: const InputDecoration(
                errorStyle: PlentyOfPetsTheme.formErrorText,
                border: UnderlineInputBorder(),
                labelText: 'Email Address'),
            onSaved: (value) => email = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email address';
              }
              return null;
            },
          )),
      Padding(
          padding: EdgeInsets.all(fieldPadding),
          child: TextFormField(
            decoration: const InputDecoration(
                errorStyle: PlentyOfPetsTheme.formErrorText,
                border: UnderlineInputBorder(),
                labelText: 'Confirm Your Email Address'),
            onSaved: (value) => emailConfirmation = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email address';
              }
              return null;
            },
          ))
    ];
  }

  List<Widget> passwordFields() {
    return [
      Padding(
          padding: EdgeInsets.all(fieldPadding),
          child: TextFormField(
            decoration: const InputDecoration(
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
            decoration: const InputDecoration(
                errorStyle: PlentyOfPetsTheme.formErrorText,
                border: UnderlineInputBorder(),
                labelText: 'Confirm Your Password'),
            onSaved: (value) => passwordConfirmation = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
          ))
    ];
  }

  List<Widget> organizationSwitch() {
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
    return [
      Padding(
          padding: EdgeInsets.all(fieldPadding),
          child: TextFormField(
            decoration: const InputDecoration(
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
                errorStyle: PlentyOfPetsTheme.formErrorText,
                border: UnderlineInputBorder(),
                labelText: 'Shelter Website'),
            onSaved: (value) => organizationUrl = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a website.';
              }
              return null;
            },
          ))
    ];
  }

  List<Widget> submitButton() {
    return [
      Padding(
          padding: EdgeInsets.all(fieldPadding),
          child: OutlinedButton(
              onPressed: () {},
              child:
                  Text('sign up', style: Theme.of(context).textTheme.button)))
    ];
  }
}
