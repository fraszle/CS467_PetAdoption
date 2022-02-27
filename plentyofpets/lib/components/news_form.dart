import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plentyofpets/utils/firebase_auth_util.dart';

import '../services/pet_database.dart';
import '../theme.dart';
import 'form_fields.dart';

class NewsForm extends StatefulWidget {
  const NewsForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NewsFormState();
  }
}

class _NewsFormState extends State<NewsForm> {
  final _formKey = GlobalKey<FormState>();
  String? title;
  String? article;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      FractionallySizedBox(
          widthFactor: 0.7,
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  titleFormField(),
                  Padding(
                      padding: const EdgeInsets.all(5),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          isDense: true,
                          contentPadding: EdgeInsets.only(bottom: 10),
                          errorStyle: PlentyOfPetsTheme.formErrorText,
                          border: OutlineInputBorder(),
                          label: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Write Something Here For Others To See...',
                                textAlign: TextAlign.center,
                              )),
                        ),
                        minLines: 8,
                        maxLines: 8,
                        onSaved: (value) => article = value,
                        validator:
                            notNullOrEmpty('Please enter some text here.'),
                      )),
                  submitButton()
                ],
              )))
    ]);
  }

  Widget titleFormField() {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: TextFormField(
          decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.only(bottom: 10),
              errorStyle: PlentyOfPetsTheme.formErrorText,
              border: UnderlineInputBorder(),
              labelText: 'Title'),
          onSaved: (value) => title = value,
          validator: notNullOrEmpty('Please enter a Title'),
          maxLength: 25,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
        ));
  }

  /// Returns the submit button for the form.
  Widget submitButton() {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: OutlinedButton(
            onPressed: submitNews,
            child: Text('post', style: Theme.of(context).textTheme.button)));
  }

  /// Validates the registration form and submits the news. Returns user
  /// to previous page.
  void submitNews() async {
    // Save form values and validate
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    try {
      DatabaseService.addNews(
          title!, article!, FirebaseAuthUtil.getCurrentlySignedInUser()!.uid);
    } on FirebaseException {
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                title: Text(
                  'Error Posting News Article',
                  textAlign: TextAlign.center,
                ),
                content: Text(
                    'Something went wrong trying to post your article. Please try again later.'),
              ));
      return;
    }

    Navigator.pop(context);
  }
}
