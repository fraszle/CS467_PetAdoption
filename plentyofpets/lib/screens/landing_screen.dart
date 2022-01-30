import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/login_form.dart';
import '../components/signup_link.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
            alignment: Alignment.center,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Placeholder(),
              ),
            )),
        percentHeightContainer(context, 3),
        const Align(
            alignment: Alignment.center,
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: LoginForm(),
            )),
        percentHeightContainer(context, 10),
        const SignupLink(),
        const Test()
      ],
    ));
  }

  Container percentHeightContainer(BuildContext context, int percent) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.01 * percent);
  }
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var users = FirebaseFirestore.instance.collection('/users');

    return FutureBuilder(
        future: users.doc('admin').get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text(
                "Firestore request failed. Check console output.");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text("Email from DB: ${data['email']}");
          }

          return const Text("loading");
        });
  }
}
