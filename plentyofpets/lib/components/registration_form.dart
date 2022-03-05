import 'package:flutter/material.dart';
import 'package:plentyofpets/components/form_fields.dart';
import 'package:plentyofpets/components/title.dart';
import 'package:plentyofpets/utils/firebase_auth_util.dart';
import 'package:plentyofpets/utils/user_model.dart';

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
  static const double fieldPadding = 5;
  static const String titleText = 'Registration';

  NewUserBuilder builder = NewUserBuilder();

  String? emailConfirmation;
  String? passwordConfirmation;

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
                  children:
                      builder.organization ? adminForm() : regularForm())))
    ]);
  }

  List<Widget> regularForm() {
    return nameFields() +
        locationFields() +
        emailFields() +
        passwordFields() +
        organizationSwitch() +
        submitButton();
  }

  List<Widget> adminForm() {
    return nameFields() +
        locationFields() +
        emailFields() +
        passwordFields() +
        organizationSwitch() +
        adminFields() +
        submitButton();
  }

  /// Returns the title for the Registration page
  Widget title(BuildContext context) {
    return const Align(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, fieldPadding),
            child: TitleText(text: titleText)));
  }

  /// Returns the TextFormFields for First Name and Last Name
  List<Widget> nameFields() {
    return [
      standardTextFormField('First Name', (value) => builder.firstName = value,
          notNullOrEmpty('Please enter a First Name')),
      standardTextFormField('Last Name', (value) => builder.lastName = value,
          notNullOrEmpty('Please enter a Last Name.'))
    ];
  }

  /// Returns the city, state, and zip code form fields
  List<Widget> locationFields() {
    return [
      standardTextFormField('City', (value) => builder.city = value,
          notNullOrEmpty('Please enter a City.')),
      standardTextFormField('State', (value) => builder.state = value,
          notNullOrEmpty('Please enter a State.')),
      standardTextFormField('Zip Code', (value) => builder.zipCode = value,
          notNullOrEmpty('Please enter a Zip Code.'))
    ];
  }

  /// Returns the email and email confirmation form fields.
  List<Widget> emailFields() {
    return [
      standardTextFormField('Email Address', (value) => builder.email = value,
          notNullOrEmpty('Please enter an Email Address.')),
      standardTextFormField(
          'Confirm Your Email Address', (value) => emailConfirmation = value,
          (value) {
        if (value != builder.email) {
          return 'Emails do not match.';
        }
        return null;
      }),
    ];
  }

  /// Returns the password and password confirmation form fields
  List<Widget> passwordFields() {
    return [
      Padding(
          padding: const EdgeInsets.all(fieldPadding),
          child: PasswordFormField(
            labelText: 'Password',
            onSaved: (value) => builder.password = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password.';
              }
              // This guards against a weak-password exception from Firebase
              if (value.length < 6) {
                return 'Password must be at least 6 characters long.';
              }
              return null;
            },
          )),
      Padding(
          padding: const EdgeInsets.all(fieldPadding),
          child: PasswordFormField(
            labelText: 'Confirm Your Password',
            onSaved: (value) => passwordConfirmation = value,
            validator: (value) {
              if (value != builder.password) {
                return 'Passwords do not match.';
              }
              return null;
            },
          ))
    ];
  }

  /// Returns a SwitchListTile for users to indicate if they are representing
  /// and organization or not.
  List<Widget> organizationSwitch() {
    return [
      Padding(
          padding: const EdgeInsets.all(fieldPadding),
          child: SwitchListTile(
              title: const Text('Are you representing a pet shelter?'),
              value: builder.organization,
              onChanged: (value) {
                setState(() {
                  builder.organization = value;
                  if (!value) {
                    builder
                      ..organizationName = null
                      ..organizationUrl = null;
                  }
                });
              }))
    ];
  }

  /// Returns a list of Form Fields only used for registering admins.
  List<Widget> adminFields() {
    return [
      standardTextFormField(
          'Shelter Name',
          (value) => builder.organizationName = value,
          notNullOrEmpty('Please enter a Shelter Name.')),
      standardTextFormField(
          'Shelter Website', (value) => builder.organizationUrl = value,
          (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a website.';
        }
        if (!Uri.parse(value).isAbsolute) {
          return 'Please enter a valid URL.';
        }
        return null;
      }),
    ];
  }

  /// Returns the submit button for the form.
  List<Widget> submitButton() {
    return [
      Padding(
          padding: const EdgeInsets.all(fieldPadding),
          child: OutlinedButton(
              onPressed: register,
              child:
                  Text('sign up', style: Theme.of(context).textTheme.button)))
    ];
  }

  /// Validates the registration form and creates the user in Firebase.
  void register() async {
    // Save form values to builder and validate
    _formKey.currentState!.save();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Register & Sign In User
    if (!await FirebaseAuthUtil.register(context, builder.build())) {
      return;
    }

    if (builder.organization) {
      Navigator.pushNamedAndRemoveUntil(
          context, MyApp.adminRoute, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, MyApp.homeRoute, (route) => false);
    }
  }
}
