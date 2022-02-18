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
