import 'package:flutter/material.dart';

import '../theme.dart';

class PasswordFormField extends StatefulWidget {
  final String labelText;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  const PasswordFormField(
      {Key? key,
      required this.labelText,
      required this.onSaved,
      required this.validator})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PasswordFormFieldState();
  }
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      enableSuggestions: false,
      decoration: InputDecoration(
        isDense: true,
        errorStyle: PlentyOfPetsTheme.formErrorText,
        border: const UnderlineInputBorder(),
        labelText: widget.labelText,
        suffixIcon: obscureTextToggle(),
        contentPadding: const EdgeInsets.only(bottom: 0),
      ),
      onSaved: widget.onSaved,
      validator: widget.validator,
    );
  }

  Widget obscureTextToggle() {
    return GestureDetector(
      child: const Icon(Icons.remove_red_eye),
      onTap: () {
        setState(() {
          if (obscureText) {
            obscureText = false;
          } else {
            obscureText = true;
          }
        });
      },
    );
  }
}

// A plain text form field in the registration form
Widget standardTextFormField(String labelText, void Function(String?)? onSaved,
    String? Function(String?)? validator) {
  return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.only(bottom: 10),
            errorStyle: PlentyOfPetsTheme.formErrorText,
            border: const UnderlineInputBorder(),
            labelText: labelText),
        onSaved: onSaved,
        validator: validator,
      ));
}

// Returns a validation function that checks if the value in a text form field
// is null or empty and returns a msg if so
String? Function(String?) notNullOrEmpty(String errMsg) {
  return (value) {
    if (value == null || value.isEmpty) {
      return errMsg;
    }
    return null;
  };
}
